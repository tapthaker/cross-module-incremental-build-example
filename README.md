# Cross Module Incremental Build Example

Test out the new `-enable-experimental-cross-module-incremental-build`and simulate a change where transitive module changes are not going to be rebuilt by Swift.

## Usage:
```
TEST_NAME=test-skip-transitive-recompilation ./test.sh
```

Available Tests:

- test-add-private-function
- test-skip-transitive-recompilation
- test-skip-unused-structs

Available environment variables:

- `USE_INCREMENTAL=1`: Uses the `-incremental` flag. This is of course required for cross module incremental builds.
- `USE_STABLE_API=0`: Uses `-enable-experimental-cross-module-incremental-build` instead of  `-enable-incremental-imports`, which is the flag that is used before Swift 5.5.
- `USE_BAZEL=1`: Uses `bazel` to build instead of invoking `swiftc` directly.

## Results:
```
swift-driver version: 1.26.9 Apple Swift version 5.5 (swiftlang-1300.0.31.1 clang-1300.0.29.1)
Target: arm64-apple-macosx11.0

temp_dir: /var/folders/dk/shrv9_1j25q9yt_77ty61qv00000gp/T/tmp.skSGvTE4
/var/folders/dk/shrv9_1j25q9yt_77ty61qv00000gp/T/tmp.skSGvTE4 ~/cross-module-incremental-build-example

Running 1
Press any key to continue

* Changing source files *
Modifying A.json
Modifying A.swift
Modifying B.json
Modifying B.swift
Modifying C.json
Modifying C.swift

* Compiling C *
remark: Incremental compilation: Incremental compilation could not read build record at  '/var/folders/dk/shrv9_1j25q9yt_77ty61qv00000gp/T/tmp.skSGvTE4/C~buildrecord.swiftdeps'
remark: Incremental compilation: Disabling incremental build: could not read build record
remark: Incremental compilation: Enabling incremental cross-module building
remark: Starting Compiling C.swift
remark: Finished Compiling C.swift
remark: Incremental compilation: Reading dependencies from C~partial.swiftdeps
remark: Incremental compilation: Scheduling all post-compile jobs because something was compiled
remark: Starting Merging module C
remark: Finished Merging module C

* Compiling B *
remark: Incremental compilation: Incremental compilation could not read build record at  '/var/folders/dk/shrv9_1j25q9yt_77ty61qv00000gp/T/tmp.skSGvTE4/B~buildrecord.swiftdeps'
remark: Incremental compilation: Disabling incremental build: could not read build record
remark: Incremental compilation: Enabling incremental cross-module building
remark: Starting Compiling B.swift
remark: Finished Compiling B.swift
remark: Incremental compilation: Reading dependencies from B~partial.swiftdeps
remark: Incremental compilation: Reading dependencies from tmp.skSGvTE4
remark: Incremental compilation: Scheduling all post-compile jobs because something was compiled
remark: Starting Merging module B
remark: Finished Merging module B

* Compiling A *
remark: Incremental compilation: Incremental compilation could not read build record at  '/var/folders/dk/shrv9_1j25q9yt_77ty61qv00000gp/T/tmp.skSGvTE4/A~buildrecord.swiftdeps'
remark: Incremental compilation: Disabling incremental build: could not read build record
remark: Incremental compilation: Enabling incremental cross-module building
remark: Starting Compiling A.swift
remark: Finished Compiling A.swift
remark: Incremental compilation: Reading dependencies from A~partial.swiftdeps
remark: Incremental compilation: Reading dependencies from tmp.skSGvTE4
remark: Incremental compilation: Reading dependencies from tmp.skSGvTE4
remark: Incremental compilation: Scheduling all post-compile jobs because something was compiled
remark: Starting Merging module A
remark: Finished Merging module A

Running 2
Press any key to continue

* Changing source files *
Modifying C.swift

* Compiling C *
remark: Incremental compilation: Read dependency graph '/var/folders/dk/shrv9_1j25q9yt_77ty61qv00000gp/T/tmp.skSGvTE4/C~buildrecord.priors'
remark: Incremental compilation: Enabling incremental cross-module building
remark: Incremental compilation: Scheduing changed input  {compile: C.o <= C.swift}
remark: Incremental compilation: Queuing (initial):  {compile: C.o <= C.swift}
remark: Incremental compilation: not scheduling dependents of C.swift; unknown changes
remark: Starting Compiling C.swift
remark: Finished Compiling C.swift
remark: Incremental compilation: Reading dependencies from C~partial.swiftdeps
remark: Incremental compilation: Fingerprint changed for interface of source file C~partial.swiftdeps in C~partial.swiftdeps
remark: Incremental compilation: Fingerprint changed for implementation of source file C~partial.swiftdeps in C~partial.swiftdeps
remark: Incremental compilation: New definition: interface of top-level name 'FooBar' in C~partial.swiftdeps
remark: Incremental compilation: New definition: implementation of top-level name 'FooBar' in C~partial.swiftdeps
remark: Incremental compilation: New definition: interface of type '1C6FooBarV' in C~partial.swiftdeps
remark: Incremental compilation: New definition: implementation of type '1C6FooBarV' in C~partial.swiftdeps
remark: Incremental compilation: New definition: interface of potential members of '1C6FooBarV' in C~partial.swiftdeps
remark: Incremental compilation: New definition: implementation of potential members of '1C6FooBarV' in C~partial.swiftdeps
remark: Incremental compilation: Scheduling all post-compile jobs because something was compiled
remark: Starting Merging module C
remark: Finished Merging module C

* Compiling B *
remark: Incremental compilation: Read dependency graph '/var/folders/dk/shrv9_1j25q9yt_77ty61qv00000gp/T/tmp.skSGvTE4/B~buildrecord.priors'
remark: Incremental compilation: Reading dependencies from tmp.skSGvTE4
remark: Incremental compilation: Fingerprint changed for interface of source file C in tmp.skSGvTE4
remark: Incremental compilation: Fingerprint changed for implementation of source file C in tmp.skSGvTE4
remark: Incremental compilation: New definition: interface of top-level name 'FooBar' in tmp.skSGvTE4
remark: Incremental compilation: New definition: implementation of top-level name 'FooBar' in tmp.skSGvTE4
remark: Incremental compilation: New definition: interface of type '1C6FooBarV' in tmp.skSGvTE4
remark: Incremental compilation: New definition: implementation of type '1C6FooBarV' in tmp.skSGvTE4
remark: Incremental compilation: New definition: interface of potential members of '1C6FooBarV' in tmp.skSGvTE4
remark: Incremental compilation: New definition: implementation of potential members of '1C6FooBarV' in tmp.skSGvTE4
remark: Incremental compilation: Changed: tmp.skSGvTE4 -> interface of top-level name 'FooBar' in tmp.skSGvTE4
remark: Incremental compilation: Changed: tmp.skSGvTE4 -> interface of source file C in tmp.skSGvTE4
remark: Incremental compilation: Changed: tmp.skSGvTE4 -> implementation of top-level name 'FooBar' in tmp.skSGvTE4
remark: Incremental compilation: Changed: tmp.skSGvTE4 -> interface of potential members of '1C6FooBarV' in tmp.skSGvTE4
remark: Incremental compilation: Changed: tmp.skSGvTE4 -> implementation of potential members of '1C6FooBarV' in tmp.skSGvTE4
remark: Incremental compilation: Changed: tmp.skSGvTE4 -> implementation of source file C in tmp.skSGvTE4
remark: Incremental compilation: Changed: tmp.skSGvTE4 -> interface of type '1C6FooBarV' in tmp.skSGvTE4
remark: Incremental compilation: Changed: tmp.skSGvTE4 -> implementation of type '1C6FooBarV' in tmp.skSGvTE4
remark: Incremental compilation: Traced: interface of source file C -> interface of top-level name 'fromC' -> implementation of source file B~partial.swiftdeps in B.swift
remark: Incremental compilation: Enabling incremental cross-module building
remark: Incremental compilation: May skip current input:  {compile: B.o <= B.swift}
remark: Incremental compilation: Invalidated externally; will queue  {compile: B.o <= B.swift}
remark: Incremental compilation: Queuing (initial):  {compile: B.o <= B.swift}
remark: Starting Compiling B.swift
remark: Finished Compiling B.swift
remark: Incremental compilation: Reading dependencies from B~partial.swiftdeps
remark: Incremental compilation: Scheduling all post-compile jobs because something was compiled
remark: Starting Merging module B
remark: Finished Merging module B

* Compiling A *
remark: Incremental compilation: Read dependency graph '/var/folders/dk/shrv9_1j25q9yt_77ty61qv00000gp/T/tmp.skSGvTE4/A~buildrecord.priors'
remark: Incremental compilation: Reading dependencies from tmp.skSGvTE4
remark: Incremental compilation: Fingerprint changed for interface of source file C in tmp.skSGvTE4
remark: Incremental compilation: Fingerprint changed for implementation of source file C in tmp.skSGvTE4
remark: Incremental compilation: New definition: interface of top-level name 'FooBar' in tmp.skSGvTE4
remark: Incremental compilation: New definition: implementation of top-level name 'FooBar' in tmp.skSGvTE4
remark: Incremental compilation: New definition: interface of type '1C6FooBarV' in tmp.skSGvTE4
remark: Incremental compilation: New definition: implementation of type '1C6FooBarV' in tmp.skSGvTE4
remark: Incremental compilation: New definition: interface of potential members of '1C6FooBarV' in tmp.skSGvTE4
remark: Incremental compilation: New definition: implementation of potential members of '1C6FooBarV' in tmp.skSGvTE4
remark: Incremental compilation: Changed: tmp.skSGvTE4 -> interface of type '1C6FooBarV' in tmp.skSGvTE4
remark: Incremental compilation: Changed: tmp.skSGvTE4 -> implementation of source file C in tmp.skSGvTE4
remark: Incremental compilation: Changed: tmp.skSGvTE4 -> interface of potential members of '1C6FooBarV' in tmp.skSGvTE4
remark: Incremental compilation: Changed: tmp.skSGvTE4 -> interface of top-level name 'FooBar' in tmp.skSGvTE4
remark: Incremental compilation: Changed: tmp.skSGvTE4 -> implementation of type '1C6FooBarV' in tmp.skSGvTE4
remark: Incremental compilation: Changed: tmp.skSGvTE4 -> implementation of top-level name 'FooBar' in tmp.skSGvTE4
remark: Incremental compilation: Changed: tmp.skSGvTE4 -> implementation of potential members of '1C6FooBarV' in tmp.skSGvTE4
remark: Incremental compilation: Changed: tmp.skSGvTE4 -> interface of source file C in tmp.skSGvTE4
remark: Incremental compilation: Enabling incremental cross-module building
remark: Incremental compilation: May skip current input:  {compile: A.o <= A.swift}
remark: Incremental compilation: Skipping input:  {compile: A.o <= A.swift}
remark: Incremental compilation: Skipping job: Merging module A; oldest output is current '/var/folders/dk/shrv9_1j25q9yt_77ty61qv00000gp/T/tmp.skSGvTE4/A.swiftmodule'
remark: Skipped Compiling A.swift

Cleaning
Press any key to continue
~/cross-module-incremental-build-example
```
