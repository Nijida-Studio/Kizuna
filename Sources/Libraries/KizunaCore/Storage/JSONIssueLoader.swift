import Foundation

public struct JSONIssueLoader: Sendable {

    public init() {
    }

    public func load(from url: URL) throws -> [KizunaIssue] {
        let data = try Data(contentsOf: url)

        let decoder = JSONDecoder()

        return try decoder.decode(
            [KizunaIssue].self,
            from: data
        )
    }
}
