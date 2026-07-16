import Foundation
import Testing
@testable import KizunaCore

@Test func githubIssueDecoderMapsIssueTypesAndExcludesPullRequests() throws {
    let data = Data(
        #"""
        [
          {
            "number": 1,
            "title": "[Epic] Build Kizuna",
            "state": "open",
            "body": "### Epic Type\n\nUserStory",
            "type": { "name": "Epic" },
            "labels": [],
            "assignees": [{ "login": "mei" }]
          },
          {
            "number": 2,
            "title": "[Item] Load issues",
            "state": "closed",
            "body": "### Item Type\n\nFeature",
            "type": null,
            "labels": [],
            "assignees": []
          },
          {
            "number": 3,
            "title": "Update implementation",
            "state": "open",
            "body": null,
            "type": "Task",
            "labels": [],
            "assignees": [],
            "pull_request": { "url": "https://api.github.com/pulls/3" }
          }
        ]
        """#.utf8
    )

    let decoder = GitHubIssueDecoder()
    let page = try decoder.decodePage(data)
    let issues = page.issues

    #expect(page.itemCount == 3)
    #expect(issues.count == 2)
    #expect(issues[0].id == "#1")
    #expect(issues[0].type == .epic)
    #expect(issues[0].subtype == .userStory)
    #expect(issues[0].assigned == "mei")
    #expect(issues[1].type == .item)
    #expect(issues[1].subtype?.rawValue == "feature")
    #expect(issues[1].status == .closed)
}

@Test func githubIssueDecoderKeepsUnknownIssuesInUnifiedList() throws {
    let data = Data(
        #"""
        [
          {
            "number": 7,
            "title": "Unclassified issue",
            "state": "open",
            "body": null,
            "type": null,
            "labels": [],
            "assignees": []
          }
        ]
        """#.utf8
    )

    let issues = try GitHubIssueDecoder().decode(data)

    #expect(issues.count == 1)
    #expect(issues[0].type == .unknown)
}
