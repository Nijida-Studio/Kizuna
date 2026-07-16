import Foundation

public struct GitHubRepository: Codable, Equatable, Sendable {
    public let owner: String
    public let name: String

    public var fullName: String {
        "\(owner)/\(name)"
    }

    public init(owner: String, name: String) {
        self.owner = owner
        self.name = name
    }

    public init(_ fullName: String) throws {
        let parts = fullName.split(separator: "/", omittingEmptySubsequences: false)

        guard parts.count == 2,
              !parts[0].isEmpty,
              !parts[1].isEmpty else {
            throw GitHubRepositoryError.invalidFullName(fullName)
        }

        self.init(owner: String(parts[0]), name: String(parts[1]))
    }
}

public enum GitHubRepositoryError: LocalizedError, Equatable {
    case invalidFullName(String)

    public var errorDescription: String? {
        switch self {
        case .invalidFullName(let value):
            return "Invalid GitHub repository '\(value)'. Expected OWNER/REPOSITORY."
        }
    }
}
