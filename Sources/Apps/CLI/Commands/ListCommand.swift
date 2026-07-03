import ArgumentParser
import Foundation
import KizunaCore

struct ListCommand: ParsableCommand {
    static let configuration = CommandConfiguration(
        commandName: "list",
        abstract: "List Kizuna issues"
    )

    @Argument(help: "Issue type, for example: epic, requirement, task")
    var issueType: String

    @Option(help: "Filter by status")
    var status: String?

    @Option(help: "Filter by assignee")
    var assigned: String?

    @Option(help: "Filter by subtype")
    var subtype: String?

    func run() throws {
        let environment = try AppEnvironment.default()

        let issueFile = environment.directories.applicationSupport
            .appending(path: "mock2")
            .appending(path: "issues.json")

        let issues = try JSONIssueLoader().load(from: issueFile)

        let filteredIssues = IssueFilter().apply(
            to: issues,
            options: IssueFilterOptions(
                type: IssueType(rawValue: issueType),
                status: status.flatMap(IssueStatus.init(rawValue:)),
                assigned: assigned,
                subtype: subtype.flatMap(IssueSubtype.init(rawValue:))
            )
        )

        TablePrinter().printIssues(filteredIssues)
    }
}
