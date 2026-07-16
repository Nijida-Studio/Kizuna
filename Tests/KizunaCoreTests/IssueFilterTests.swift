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

@Test func issueFilterKeepsAllIssuesWithoutTypeFilter() async throws {
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
            id: "ITEM-1",
            type: .item,
            subtype: IssueSubtype(rawValue: "feature"),
            status: .open,
            assigned: nil,
            title: "Load GitHub issues"
        )
    ]

    let result = IssueFilter().apply(
        to: issues,
        options: IssueFilterOptions()
    )

    #expect(result.count == 2)
}
