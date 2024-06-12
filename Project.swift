import ProjectDescription

let project = Project(
    name: "AlamofirePractice",
    targets: [
        .target(
            name: "AlamofirePractice",
            destinations: .iOS,
            product: .app,
            bundleId: "io.tuist.AlamofirePractice",
            infoPlist: .extendingDefault(
                with: [
                    "UILaunchStoryboardName": "LaunchScreen.storyboard",
                ]
            ),
            sources: ["AlamofirePractice/Sources/**"],
            resources: ["AlamofirePractice/Resources/**"],
            dependencies: [
                .external(name: "Alamofire"),
                .external(name: "Then"),
                .external(name: "SnapKit"),
                .external(name: "CombineExt"),
                .external(name: "CombineCocoa")
            ]
        ),
        .target(
            name: "AlamofirePracticeTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "io.tuist.AlamofirePracticeTests",
            infoPlist: .default,
            sources: ["AlamofirePractice/Tests/**"],
            resources: [],
            dependencies: [.target(name: "AlamofirePractice")]
        ),
    ]
)
