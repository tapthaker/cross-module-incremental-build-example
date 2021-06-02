#!/bin/bash

USE_INCREMENTAL=${USE_INCREMENTAL:-0}
if [ -z "$TEST_NAME" ]; then
  echo "\$TEST_NAME undefined"
  exit 1
fi

temp_dir=$(mktemp -d)
echo "temp_dir: $temp_dir"

cp -r * "$temp_dir"
pushd "$temp_dir"

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

  for f in $TEST_NAME/$i/*; do
    filename=$(basename $f)
    echo "Modifying $filename"
    cp "$f" "$filename"
  done

  extra_flags=( -enable-experimental-cross-module-incremental-build -driver-show-incremental -driver-show-job-lifecycle )
  if [ "${USE_INCREMENTAL:-0}" -eq 1 ]; then
    extra_flags+=( -incremental )
  fi

  /usr/bin/swiftc -c -emit-module -emit-module-path "$temp_dir/C.swiftmodule" \
    -module-name C -I "$temp_dir" -output-file-map "$temp_dir/C.json" -working-directory "$temp_dir"  \
    ${extra_flags[@]} C*.swift

  /usr/bin/swiftc -c -emit-module -emit-module-path "$temp_dir/B.swiftmodule" \
    -module-name B -I "$temp_dir" -output-file-map "$temp_dir/B.json" -working-directory "$temp_dir"  \
     ${extra_flags[@]} B*.swift

  /usr/bin/swiftc -c -emit-module -emit-module-path "$temp_dir/A.swiftmodule" \
    -module-name A -I "$temp_dir" -output-file-map "$temp_dir/A.json" -working-directory "$temp_dir"  \
    ${extra_flags[@]}  A*.swift
done


printf "\nCleaning"
wait_for_key_press

popd
rm -rf "$temp_dir"
