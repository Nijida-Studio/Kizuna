public struct KizunaIssue: Codable, Sendable, Identifiable {
    public let id: String
    public let number: Int?
    public let type: IssueType
    public let subtype: IssueSubtype?
    public let status: IssueStatus
    public let assigned: String?
    public let title: String

    public init(
        id: String,
        number: Int? = nil,
        type: IssueType,
        subtype: IssueSubtype?,
        status: IssueStatus,
        assigned: String?,
        title: String
    ) {
        self.id = id
        self.number = number
        self.type = type
        self.subtype = subtype
        self.status = status
        self.assigned = assigned
        self.title = title
    }
}
