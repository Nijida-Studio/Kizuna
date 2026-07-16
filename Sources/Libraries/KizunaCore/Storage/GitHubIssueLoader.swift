import Foundation

public struct GitHubIssueLoader: Sendable {
    private let session: URLSession
    private let decoder: GitHubIssueDecoder

    public init(
        session: URLSession = .shared,
        decoder: GitHubIssueDecoder = GitHubIssueDecoder()
    ) {
        self.session = session
        self.decoder = decoder
    }

    public func load(
        from repository: GitHubRepository,
        token: String? = nil
    ) async throws -> [KizunaIssue] {
        var page = 1
        var issues: [KizunaIssue] = []

        while true {
            let loadedPage = try await loadPage(
                page,
                from: repository,
                token: token
            )

            issues.append(contentsOf: loadedPage.issues)

            guard loadedPage.itemCount == 100 else {
                break
            }

            page += 1
        }

        return issues.sorted { ($0.number ?? 0) < ($1.number ?? 0) }
    }

    private func loadPage(
        _ page: Int,
        from repository: GitHubRepository,
        token: String?
    ) async throws -> GitHubIssuePage {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.github.com"
        components.path = "/repos/\(repository.owner)/\(repository.name)/issues"
        components.queryItems = [
            URLQueryItem(name: "state", value: "all"),
            URLQueryItem(name: "per_page", value: "100"),
            URLQueryItem(name: "page", value: String(page))
        ]

        guard let url = components.url else {
            throw GitHubIssueLoaderError.invalidURL(repository.fullName)
        }

        var request = URLRequest(url: url)
        request.setValue("application/vnd.github+json", forHTTPHeaderField: "Accept")
        request.setValue("2026-03-10", forHTTPHeaderField: "X-GitHub-Api-Version")
        request.setValue("Kizuna-Mock3", forHTTPHeaderField: "User-Agent")

        if let token, !token.isEmpty {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }

        let (data, response) = try await session.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw GitHubIssueLoaderError.invalidResponse
        }

        guard httpResponse.statusCode == 200 else {
            throw GitHubIssueLoaderError.httpError(
                statusCode: httpResponse.statusCode,
                message: GitHubErrorMessage.decode(from: data)
            )
        }

        return try decoder.decodePage(data)
    }
}

public enum GitHubIssueLoaderError: LocalizedError {
    case invalidURL(String)
    case invalidResponse
    case httpError(statusCode: Int, message: String?)

    public var errorDescription: String? {
        switch self {
        case .invalidURL(let repository):
            return "Could not create a GitHub URL for \(repository)."
        case .invalidResponse:
            return "GitHub returned an invalid response."
        case .httpError(let statusCode, let message):
            if let message {
                return "GitHub request failed with HTTP \(statusCode): \(message)"
            }
            return "GitHub request failed with HTTP \(statusCode)."
        }
    }
}

private struct GitHubErrorMessage: Decodable {
    let message: String

    static func decode(from data: Data) -> String? {
        try? JSONDecoder().decode(Self.self, from: data).message
    }
}
