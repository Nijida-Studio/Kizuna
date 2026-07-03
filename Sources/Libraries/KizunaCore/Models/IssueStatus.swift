public enum IssueStatus: String, Codable, Sendable {
    case open
    case inProgress = "in_progress"
    case closed
}
