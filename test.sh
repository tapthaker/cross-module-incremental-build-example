#!/bin/bash

USE_INCREMENTAL=${USE_INCREMENTAL:-0}
USE_STABLE_API=${USE_STABLE_API:-0}
USE_BAZEL=${USE_BAZEL:-0}

if [ -z "$TEST_NAME" ]; then
  echo "\$TEST_NAME undefined"
  exit 1
fi

swift --version
echo

if [[ "${USE_BAZEL:0}" -eq 1 ]]; then
  temp_dir="/tmp/bazel-cross-module-incremental-build"
  rm -rf "$temp_dir"
  mkdir "$temp_dir"
else
  temp_dir=$(mktemp -d)
fi
echo "temp_dir: $temp_dir"

cp -r . "$temp_dir"
pushd "$temp_dir"

if [[ "${USE_BAZEL:0}" -eq 1 ]]; then
  # Remove only test module output, to be on par with non-Bazel builds
  rm -rf "$(bazel info output_path)/darwin-fastbuild"
fi

function wait_for_key_press {
  printf "\nPress any key to continue"
  while [ true ] ; do
    read -t 3 -n 1
    if [ $? = 0 ] ; then
      break;
    fi
  done
}

for i in 1 2; do
  printf "\nRunning $i"

  wait_for_key_press

  echo
  echo "* Changing source files *"
  for f in $TEST_NAME/$i/*; do
    filename=$(basename $f)
    echo "Modifying $filename"
    cp "$f" "$filename"
  done

  if [ "${USE_BAZEL:-0}" -eq 1 ]; then
    extra_flags=( --xcode_version=12.5.0.12E262 --swiftcopt=-driver-show-incremental --swiftcopt=-driver-show-job-lifecycle )
    if [ "${USE_INCREMENTAL:-0}" -ne 1 ]; then
      extra_flags+=( --swiftcopt=-whole-module-optimization )
    fi
    if [ "${USE_STABLE_API:-0}" -eq 1 ]; then
      extra_flags+=( --swiftcopt=-enable-incremental-imports )
    else
      extra_flags+=( --swiftcopt=-enable-experimental-cross-module-incremental-build  )
    fi

    echo
    echo "* Compiling *"
    bazel build --verbose_failures ${extra_flags[@]} -- //:A
  else
    extra_flags=( -driver-show-incremental -driver-show-job-lifecycle )
    if [ "${USE_INCREMENTAL:-0}" -eq 1 ]; then
      extra_flags+=( -incremental )
    fi
    if [[ "${USE_STABLE_API:-0}" -eq 1 ]]; then
      extra_flags+=( -enable-incremental-imports )
    else
      extra_flags+=( -enable-experimental-cross-module-incremental-build  )
    fi

    echo
    echo "* Compiling C *"
    /usr/bin/swiftc -c -emit-module -emit-module-path "$temp_dir/C.swiftmodule" \
      -module-name C -I "$temp_dir" -output-file-map "$temp_dir/C.json" -working-directory "$temp_dir"  \
      ${extra_flags[@]} C*.swift

    echo
    echo "* Compiling B *"
    /usr/bin/swiftc -c -emit-module -emit-module-path "$temp_dir/B.swiftmodule" \
      -module-name B -I "$temp_dir" -output-file-map "$temp_dir/B.json" -working-directory "$temp_dir"  \
       ${extra_flags[@]} B*.swift

    echo
    echo "* Compiling A *"
    /usr/bin/swiftc -c -emit-module -emit-module-path "$temp_dir/A.swiftmodule" \
      -module-name A -I "$temp_dir" -output-file-map "$temp_dir/A.json" -working-directory "$temp_dir"  \
      ${extra_flags[@]}  A*.swift
  fi
done


printf "\nCleaning"
wait_for_key_press

popd
rm -rf "$temp_dir"
