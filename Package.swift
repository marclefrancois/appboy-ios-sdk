// swift-tools-version:5.3

import PackageDescription

let package = Package(
  name: "Appboy_iOS_SDK",
  defaultLocalization: "en",
  platforms: [
    .iOS(.v9)
  ],
  products: [
    .library(name: "AppboyKit", type: .static, targets: ["AppboyKit"]),
    .library(name: "AppboyUI", targets: ["AppboyUI"]),
    .library(name: "AppboyPushStory", targets: ["AppboyPushStory"])
  ],
  dependencies: [
    .package(name: "SDWebImage", url: "https://github.com/SDWebImage/SDWebImage.git", from: "5.8.2")
  ],
  targets: [
    .binaryTarget(
      name: "AppboyKitLibrary",
      url: "https://github.com/Appboy/appboy-ios-sdk/releases/download/3.31.2/AppboyKitLibrary.xcframework.zip",
      checksum: "0507970ac763c35eb2653908cba1c044f7c0d46e6f18b7b1ebfdf2ae5edba35f"
    ),
    .target(
      name: "AppboyKit",
      dependencies: ["SDWebImage", "AppboyKitLibrary"],
      path: "AppboyKit",
      resources: [
        .process("Appboy.bundle"),
        .process("headers/AppboyKitLibrary/ZipArchive_LICENSE.txt")
      ],
      publicHeadersPath: "headers/AppboyKitLibrary",
      linkerSettings: [
        .linkedFramework("SystemConfiguration"),
        .linkedFramework("QuartzCore"),
        .linkedFramework("CoreImage"),
        .linkedFramework("CoreText"),
        .linkedFramework("WebKit"),
        .linkedFramework("UserNotifications"),
        .linkedFramework("StoreKit"),
        .linkedFramework("CoreTelephony", .when(platforms: [.iOS])),
        .linkedLibrary("z"),
      ]
    ),
    .target(
      name: "AppboyUI",
      dependencies: ["AppboyKit"],
      path: "AppboyUI",
      resources: [
        .process("ABKNewsFeed/Resources"),
        .process("ABKInAppMessage/Resources"),
        .process("ABKContentCards/Resources")
      ],
      publicHeadersPath: "include/AppboyUI"
    ),
    .binaryTarget(
      name: "AppboyPushStory",
      url: "https://github.com/Appboy/appboy-ios-sdk/releases/download/3.31.2/AppboyPushStory.xcframework.zip",
      checksum: "735391261e035295b5a88a26ad880c156dd8056c88a9ca1d7d9d179844c73458"
    )
  ]
)
