import ArgumentParser
import Foundation
import KizunaCore

struct ListCommand: ParsableCommand {
    static let configuration = CommandConfiguration(
        commandName: "list",
        abstract: "List Kizuna issues"
    )

    @Argument(help: "Optional issue type: epic, item, or task")
    var issueType: String?

    @Option(help: "Filter by status")
    var status: String?

    @Option(help: "Filter by assignee")
    var assigned: String?

    @Option(help: "Filter by subtype")
    var subtype: String?

    func run() throws {
        let environment = try AppEnvironment.default()

        let snapshotFile = environment.directories.caches
            .appending(path: "issues.json")

        let snapshot: IssueSnapshot

        do {
            snapshot = try JSONIssueSnapshotStore().load(from: snapshotFile)
        } catch CocoaError.fileReadNoSuchFile {
            throw ValidationError(
                "No loaded issues found. Run 'kizuna load OWNER/REPOSITORY' first."
            )
        }

        let type = try issueType.map { value in
            guard let type = IssueType(rawValue: value), type != .unknown else {
                throw ValidationError("Unknown issue type '\(value)'. Use epic, item, or task.")
            }
            return type
        }

        let status = try status.map { value in
            guard let status = IssueStatus(rawValue: value) else {
                throw ValidationError("Unknown status '\(value)'. Use open, in_progress, or closed.")
            }
            return status
        }

        let filteredIssues = IssueFilter().apply(
            to: snapshot.issues,
            options: IssueFilterOptions(
                type: type,
                status: status,
                assigned: assigned,
                subtype: subtype.map { IssueSubtype(rawValue: $0.lowercased()) }
            )
        )

        TablePrinter().printIssues(filteredIssues)
    }
}
