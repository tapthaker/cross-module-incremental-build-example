# Cross Module Incremental Build Example

Test out the new `-enable-experimental-cross-module-incremental-build`and simulate a change where transitive module changes are not going to be rebuilt by Swift.

## Usage:
```
USE_INCREMENTAL=1 TEST_NAME=test-skip-transitive-recompilation ./test.sh
```

Available Tests:

- test-add-private-function
- test-skip-transitive-recompilation
- test-skip-unused-structs

## Results:
```
temp_dir: /var/folders/5r/ztqn6j_d32n3nnpz7wx2rgjh0000gn/T/tmp.Rl8JPaQe
/var/folders/5r/ztqn6j_d32n3nnpz7wx2rgjh0000gn/T/tmp.Rl8JPaQe ~/cross-module-incremental-build-example

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
Incremental compilation could not read build record.
Disabling incremental build: could not read build record
Blocked by: {compile: C.o <= C.swift}, now blocking jobs: [{merge-module: C.swiftmodule <= C.o}]
Adding standard job to task queue: {compile: C.o <= C.swift}
Added to TaskQueue: {compile: C.o <= C.swift}
Job finished: {compile: C.o <= C.swift}
Scheduling maybe-unblocked jobs: [{merge-module: C.swiftmodule <= C.o}]
Adding standard job to task queue: {merge-module: C.swiftmodule <= C.o}
Added to TaskQueue: {merge-module: C.swiftmodule <= C.o}
Job finished: {merge-module: C.swiftmodule <= C.o}

* Compiling B *
Incremental compilation could not read build record.
Disabling incremental build: could not read build record
Blocked by: {compile: B.o <= B.swift}, now blocking jobs: [{merge-module: B.swiftmodule <= B.o}]
Adding standard job to task queue: {compile: B.o <= B.swift}
Added to TaskQueue: {compile: B.o <= B.swift}
Job finished: {compile: B.o <= B.swift}
Scheduling maybe-unblocked jobs: [{merge-module: B.swiftmodule <= B.o}]
Adding standard job to task queue: {merge-module: B.swiftmodule <= B.o}
Added to TaskQueue: {merge-module: B.swiftmodule <= B.o}
Job finished: {merge-module: B.swiftmodule <= B.o}

* Compiling A *
Incremental compilation could not read build record.
Disabling incremental build: could not read build record
Blocked by: {compile: A.o <= A.swift}, now blocking jobs: [{merge-module: A.swiftmodule <= A.o}]
Adding standard job to task queue: {compile: A.o <= A.swift}
Added to TaskQueue: {compile: A.o <= A.swift}
Job finished: {compile: A.o <= A.swift}
Scheduling maybe-unblocked jobs: [{merge-module: A.swiftmodule <= A.o}]
Adding standard job to task queue: {merge-module: A.swiftmodule <= A.o}
Added to TaskQueue: {merge-module: A.swiftmodule <= A.o}
Job finished: {merge-module: A.swiftmodule <= A.o}

Running 2
Press any key to continue

* Changing source files *
Modifying C.swift

* Compiling C *
Queuing (initial): {compile: C.o <= C.swift}
Blocked by: {compile: C.o <= C.swift}, now blocking jobs: [{merge-module: C.swiftmodule <= C.o}]
Queuing : {merge-module: C.swiftmodule <= C.o}
Adding standard job to task queue: {compile: C.o <= C.swift}
Added to TaskQueue: {compile: C.o <= C.swift}
Job finished: {compile: C.o <= C.swift}
Scheduling maybe-unblocked jobs: [{merge-module: C.swiftmodule <= C.o}]
Already scheduled: {compile: C.o <= C.swift}
Adding standard job to task queue: {merge-module: C.swiftmodule <= C.o}
Added to TaskQueue: {merge-module: C.swiftmodule <= C.o}
Job finished: {merge-module: C.swiftmodule <= C.o}

* Compiling B *
Queuing because of incremental external dependencies: {compile: B.o <= B.swift}
	interface of top-level name 'fromC' in /var/folders/5r/ztqn6j_d32n3nnpz7wx2rgjh0000gn/T/tmp.Rl8JPaQe/C.swiftmodule -> implementation of source file B.swiftdeps
Blocked by: {compile: B.o <= B.swift}, now blocking jobs: [{merge-module: B.swiftmodule <= B.o}]
Queuing : {merge-module: B.swiftmodule <= B.o}
Adding standard job to task queue: {compile: B.o <= B.swift}
Added to TaskQueue: {compile: B.o <= B.swift}
Job finished: {compile: B.o <= B.swift}
Scheduling maybe-unblocked jobs: [{merge-module: B.swiftmodule <= B.o}]
Adding standard job to task queue: {merge-module: B.swiftmodule <= B.o}
Added to TaskQueue: {merge-module: B.swiftmodule <= B.o}
Job finished: {merge-module: B.swiftmodule <= B.o}

* Compiling A *
Job skipped: {compile: A.o <= A.swift}
Job skipped: {merge-module: A.swiftmodule <= A.o}

Cleaning
Press any key to continue
~/cross-module-incremental-build-example
```
