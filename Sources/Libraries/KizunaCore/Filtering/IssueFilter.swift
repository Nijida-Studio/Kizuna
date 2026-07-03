public struct IssueFilter: Sendable {

    public init() {
    }

    public func apply(
        to issues: [KizunaIssue],
        options: IssueFilterOptions
    ) -> [KizunaIssue] {
        issues.filter { issue in
            if let type = options.type, issue.type != type {
                return false
            }

            if let status = options.status, issue.status != status {
                return false
            }

            if let assigned = options.assigned, issue.assigned != assigned {
                return false
            }

            if let subtype = options.subtype, issue.subtype != subtype {
                return false
            }

            return true
        }
    }
}
