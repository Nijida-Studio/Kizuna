import Foundation

public struct JSONIssueSnapshotStore: Sendable {
    public init() {
    }

    public func load(from url: URL) throws -> IssueSnapshot {
        let data = try Data(contentsOf: url)
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return try decoder.decode(IssueSnapshot.self, from: data)
    }

    public func save(_ snapshot: IssueSnapshot, to url: URL) throws {
        try FileManager.default.createDirectory(
            at: url.deletingLastPathComponent(),
            withIntermediateDirectories: true
        )

        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        encoder.outputFormatting = [.prettyPrinted, .sortedKeys]

        let data = try encoder.encode(snapshot)
        try data.write(to: url, options: .atomic)
    }
}
