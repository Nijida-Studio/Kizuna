import KizunaCore

struct TablePrinter {

    func printIssues(_ issues: [KizunaIssue]) {
        for issue in issues {
            print("\(issue.id)  \(issue.status.rawValue)  \(issue.assigned ?? "-")  \(issue.title)")
        }
    }
}
