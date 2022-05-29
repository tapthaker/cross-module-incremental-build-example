load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

http_archive(
    name = "build_bazel_apple_support",
    sha256 = "76df040ade90836ff5543888d64616e7ba6c3a7b33b916aa3a4b68f342d1b447",
    url = "https://github.com/bazelbuild/apple_support/archive/0.11.0.tar.gz",
)

http_archive(
    name = "build_bazel_rules_apple",
    sha256 = "0052d452af7742c8f3a4e0929763388a66403de363775db7e90adecb2ba4944b",
    url = "https://github.com/bazelbuild/rules_apple/archive/0.31.3.tar.gz",
)

http_archive(
    name = "build_bazel_rules_swift",
    sha256 = "f3aecff3ef9c21da0283d61c0643357c82128c8b333d29bc5463bb549baab79d",
    strip_prefix = "rules_swift-c3bf28c3a94d26442da824aa5b4a0c4ff4128e33",
    url = "https://github.com/bazelbuild/rules_swift/archive/c3bf28c3a94d26442da824aa5b4a0c4ff4128e33.tar.gz",
)

load("@build_bazel_rules_swift//swift:repositories.bzl", "swift_rules_dependencies")

swift_rules_dependencies()

load("@build_bazel_rules_swift//swift:extras.bzl", "swift_rules_extra_dependencies")

swift_rules_extra_dependencies()

load("@build_bazel_rules_apple//apple:repositories.bzl", "apple_rules_dependencies")

apple_rules_dependencies(ignore_version_differences = True)
