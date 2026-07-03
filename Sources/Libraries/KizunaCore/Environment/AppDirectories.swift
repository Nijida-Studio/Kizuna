import Foundation

public struct AppDirectories: Sendable {
    public let applicationSupport: URL
    public let caches: URL
    public let temporary: URL

    public init(
        applicationSupport: URL,
        caches: URL,
        temporary: URL
    ) {
        self.applicationSupport = applicationSupport
        self.caches = caches
        self.temporary = temporary
    }
}
