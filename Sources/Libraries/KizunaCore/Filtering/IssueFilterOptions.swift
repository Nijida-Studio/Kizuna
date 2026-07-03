public struct IssueFilterOptions: Sendable {
    public let type: IssueType?
    public let status: IssueStatus?
    public let assigned: String?
    public let subtype: IssueSubtype?

    public init(
        type: IssueType? = nil,
        status: IssueStatus? = nil,
        assigned: String? = nil,
        subtype: IssueSubtype? = nil
    ) {
        self.type = type
        self.status = status
        self.assigned = assigned
        self.subtype = subtype
    }
}
