load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "C",
    srcs = glob( ["C*.swift"] ),
)

swift_library(
    name = "B",
    srcs = glob( ["B*.swift"] ),
    deps = [":C"],
)

swift_library(
    name = "A",
    srcs = glob( ["A*.swift"] ),
    deps = [":B"],
)
