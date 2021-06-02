load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

http_archive(
    name = "build_bazel_apple_support",
    sha256 = "d5a1156f8d443a39b20919d972e9e840b057ea1560acddb56736fdab764a341b",
    strip_prefix = "apple_support-3c90f397de59178a110b34a4afd04d69f725f5cb",
    url = "https://github.com/bazelbuild/apple_support/archive/3c90f397de59178a110b34a4afd04d69f725f5cb.tar.gz",
)

http_archive(
    name = "build_bazel_rules_apple",
    sha256 = "a0b7066d9f4193e8a800db2a66f4fe867a7806b8cdeecc3f0b9c9b3fc415338e",
    strip_prefix = "rules_apple-709d8b12d68b571f23a1187b1cf7b10bb89fa46f",
    url = "https://github.com/bazelbuild/rules_apple/archive/709d8b12d68b571f23a1187b1cf7b10bb89fa46f.tar.gz",
)

http_archive(
    name = "build_bazel_rules_swift",
    sha256 = "7d57427bf94ac2a17799dc4475defaf4750650bbc3e8ad1173dceb481b3bc9d8",
    strip_prefix = "rules_swift-aab5e21516bf971faba6053a414dac26224e588e",
    url = "https://github.com/bazelbuild/rules_swift/archive/aab5e21516bf971faba6053a414dac26224e588e.tar.gz",
)

load("@build_bazel_rules_swift//swift:repositories.bzl", "swift_rules_dependencies")

swift_rules_dependencies()

load("@build_bazel_rules_swift//swift:extras.bzl", "swift_rules_extra_dependencies")

swift_rules_extra_dependencies()

load("@build_bazel_rules_apple//apple:repositories.bzl", "apple_rules_dependencies")

apple_rules_dependencies(ignore_version_differences = True)
