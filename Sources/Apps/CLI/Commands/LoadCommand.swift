import ArgumentParser
import Foundation
import KizunaCore

struct LoadCommand: AsyncParsableCommand {
    static let configuration = CommandConfiguration(
        commandName: "load",
        abstract: "Load issues from a GitHub repository"
    )

    @Argument(help: "GitHub repository in OWNER/REPOSITORY form")
    var repository: String

    func run() async throws {
        let repository = try GitHubRepository(repository)
        let environment = try AppEnvironment.default()
        let token = ProcessInfo.processInfo.environment["GITHUB_TOKEN"]

        let issues: [KizunaIssue]

        do {
            issues = try await GitHubIssueLoader().load(
                from: repository,
                token: token
            )
        } catch GitHubIssueLoaderError.httpError(let statusCode, _) where statusCode == 404 && token == nil {
            throw ValidationError(
                "Repository not found or private. Set GITHUB_TOKEN and run load again."
            )
        }

        let snapshot = IssueSnapshot(
            repository: repository,
            loadedAt: Date(),
            issues: issues
        )

        try JSONIssueSnapshotStore().save(
            snapshot,
            to: environment.directories.caches.appending(path: "issues.json")
        )

        print("Loaded \(issues.count) issues from \(repository.fullName).")
    }
}
