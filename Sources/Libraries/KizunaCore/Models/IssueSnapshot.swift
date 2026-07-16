import Foundation

public struct IssueSnapshot: Codable, Sendable {
    public let repository: GitHubRepository
    public let loadedAt: Date
    public let issues: [KizunaIssue]

    public init(
        repository: GitHubRepository,
        loadedAt: Date,
        issues: [KizunaIssue]
    ) {
        self.repository = repository
        self.loadedAt = loadedAt
        self.issues = issues
    }
}
