import Testing
@testable import KizunaCore

@Test func issueFilterFiltersByType() async throws {
    let issues = [
        KizunaIssue(
            id: "EPIC-1",
            type: .epic,
            subtype: .userStory,
            status: .open,
            assigned: "mei",
            title: "Bootstrap Kizuna"
        ),
        KizunaIssue(
            id: "TASK-1",
            type: .task,
            subtype: nil,
            status: .closed,
            assigned: nil,
            title: "Initial setup"
        )
    ]

    let result = IssueFilter().apply(
        to: issues,
        options: IssueFilterOptions(type: .epic)
    )

    #expect(result.count == 1)
    #expect(result.first?.id == "EPIC-1")
}
