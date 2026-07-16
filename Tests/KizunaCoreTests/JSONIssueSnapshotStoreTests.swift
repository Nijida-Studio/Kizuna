import Foundation
import Testing
@testable import KizunaCore

@Test func issueSnapshotStoreRoundTripsLoadedIssues() throws {
    let directory = FileManager.default.temporaryDirectory
        .appending(path: UUID().uuidString)
    let file = directory.appending(path: "issues.json")

    defer {
        try? FileManager.default.removeItem(at: directory)
    }

    let snapshot = IssueSnapshot(
        repository: GitHubRepository(owner: "Nijida-Studio", name: "Kizuna-Issue-test-Repo"),
        loadedAt: Date(timeIntervalSince1970: 0),
        issues: [
            KizunaIssue(
                id: "#1",
                number: 1,
                type: .task,
                subtype: IssueSubtype(rawValue: "work"),
                status: .open,
                assigned: "mei",
                title: "Test loading"
            )
        ]
    )

    let store = JSONIssueSnapshotStore()
    try store.save(snapshot, to: file)
    let loaded = try store.load(from: file)

    #expect(loaded.repository == snapshot.repository)
    #expect(loaded.issues.count == 1)
    #expect(loaded.issues[0].number == 1)
}

@Test func githubRepositoryRequiresOwnerAndName() throws {
    #expect(throws: GitHubRepositoryError.self) {
        try GitHubRepository("Kizuna")
    }
}

@Test func issueSubtypeUsesTheMock2StringFormat() throws {
    let subtype = IssueSubtype.userStory
    let data = try JSONEncoder().encode(subtype)

    #expect(String(decoding: data, as: UTF8.self) == "\"userstory\"")
    #expect(try JSONDecoder().decode(IssueSubtype.self, from: data) == subtype)
}
