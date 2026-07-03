import Foundation

public struct AppEnvironment: Sendable {

    public let directories: AppDirectories

    public init(
        directories: AppDirectories
    ) {
        self.directories = directories
    }

    public static func `default`() throws -> Self {

        let fileManager = FileManager.default

        let applicationSupport =
            try fileManager.url(
                for: .applicationSupportDirectory,
                in: .userDomainMask,
                appropriateFor: nil,
                create: true
            )
            .appending(path: "Kizuna")

        let caches =
            try fileManager.url(
                for: .cachesDirectory,
                in: .userDomainMask,
                appropriateFor: nil,
                create: true
            )
            .appending(path: "Kizuna")

        try fileManager.createDirectory(
            at: applicationSupport,
            withIntermediateDirectories: true
        )

        try fileManager.createDirectory(
            at: caches,
            withIntermediateDirectories: true
        )

        return Self(
            directories: AppDirectories(
                applicationSupport: applicationSupport,
                caches: caches,
                temporary: fileManager.temporaryDirectory
            )
        )
    }
}
