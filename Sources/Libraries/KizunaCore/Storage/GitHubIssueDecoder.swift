import Foundation

public struct GitHubIssueDecoder: Sendable {
    public init() {
    }

    public func decode(_ data: Data) throws -> [KizunaIssue] {
        try decodePage(data).issues
    }

    func decodePage(_ data: Data) throws -> GitHubIssuePage {
        let response = try JSONDecoder().decode([GitHubIssue].self, from: data)

        let issues = response
            .filter { !$0.isPullRequest }
            .map { issue in
                KizunaIssue(
                    id: "#\(issue.number)",
                    number: issue.number,
                    type: issue.kizunaType,
                    subtype: issue.kizunaSubtype,
                    status: issue.state == "closed" ? .closed : .open,
                    assigned: issue.assignees.first?.login,
                    title: issue.title
                )
            }
            .sorted { ($0.number ?? 0) < ($1.number ?? 0) }

        return GitHubIssuePage(itemCount: response.count, issues: issues)
    }
}

struct GitHubIssuePage: Sendable {
    let itemCount: Int
    let issues: [KizunaIssue]
}

private struct GitHubIssue: Decodable {
    let number: Int
    let title: String
    let state: String
    let body: String?
    let type: GitHubIssueType?
    let labels: [GitHubLabel]
    let assignees: [GitHubUser]
    let pullRequest: GitHubPullRequest?

    enum CodingKeys: String, CodingKey {
        case number
        case title
        case state
        case body
        case type
        case labels
        case assignees
        case pullRequest = "pull_request"
    }

    var isPullRequest: Bool {
        pullRequest != nil
    }

    var kizunaType: IssueType {
        let candidates = [type?.name] + labels.map(\.name)

        for candidate in candidates.compactMap({ $0 }) {
            if let value = Self.issueType(from: candidate) {
                return value
            }
        }

        for value in [IssueType.epic, .item, .task] {
            if title.lowercased().hasPrefix("[\(value.rawValue)]") {
                return value
            }
        }

        return .unknown
    }

    var kizunaSubtype: IssueSubtype? {
        let heading: String

        switch kizunaType {
        case .epic:
            heading = "Epic Type"
        case .item:
            heading = "Item Type"
        case .task:
            heading = "Task Type"
        case .unknown:
            return nil
        }

        guard let value = body.flatMap({ Self.formValue(named: heading, in: $0) }) else {
            return nil
        }

        return IssueSubtype(rawValue: Self.normalized(value))
    }

    private static func issueType(from value: String) -> IssueType? {
        switch normalized(value) {
        case "epic":
            return .epic
        case "item":
            return .item
        case "task":
            return .task
        default:
            return nil
        }
    }

    private static func formValue(named field: String, in body: String) -> String? {
        let lines = body.components(separatedBy: .newlines)
        let expectedHeading = "### \(field)".lowercased()

        guard let headingIndex = lines.firstIndex(where: {
            $0.trimmingCharacters(in: .whitespacesAndNewlines).lowercased() == expectedHeading
        }) else {
            return nil
        }

        return lines
            .dropFirst(headingIndex + 1)
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
            .first { !$0.isEmpty && !$0.hasPrefix("<!--") }
    }

    private static func normalized(_ value: String) -> String {
        value
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .lowercased()
            .filter { $0.isLetter || $0.isNumber }
    }
}

private struct GitHubIssueType: Decodable {
    let name: String

    init(from decoder: Decoder) throws {
        if let string = try? decoder.singleValueContainer().decode(String.self) {
            name = string
            return
        }

        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
    }

    private enum CodingKeys: CodingKey {
        case name
    }
}

private struct GitHubLabel: Decodable {
    let name: String
}

private struct GitHubUser: Decodable {
    let login: String
}

private struct GitHubPullRequest: Decodable {
}
