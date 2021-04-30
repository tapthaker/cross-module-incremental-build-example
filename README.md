# Cross Module Incremental Build Example

Test out the new `-enable-experimental-cross-module-incremental-build`and simulate a change where transitive module changes are not going to be rebuilt by Swift.

Usage:
```
USE_INCREMENTAL=1 ./test.sh
```