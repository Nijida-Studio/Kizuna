import Foundation

@main
struct Kizuna {

    static func main() async throws {

        guard let token = ProcessInfo.processInfo.environment["GITHUB_TOKEN"],
              !token.isEmpty else {
            print("Error: GITHUB_TOKEN is not set.")
            return
        }

        let url = URL(
            string: "https://api.github.com/repos/Nijida-Studio/Nijida-Masterplan-Japan/issues?state=all&per_page=100"
        )!

        var request = URLRequest(url: url)
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.setValue("application/vnd.github+json", forHTTPHeaderField: "Accept")
        request.setValue("Kizuna-Mock1", forHTTPHeaderField: "User-Agent")

        let (data, response) = try await URLSession.shared.data(for: request)

        guard let http = response as? HTTPURLResponse else {
            print("No HTTP response.")
            return
        }

        print("HTTP Status: \(http.statusCode)")

        guard http.statusCode == 200 else {
            if let text = String(data: data, encoding: .utf8) {
                print(text)
            }
            return
        }

        let json = try JSONSerialization.jsonObject(with: data)

        let prettyData = try JSONSerialization.data(
            withJSONObject: json,
            options: [
                .prettyPrinted,
                .sortedKeys
            ]
        )

        let directory = URL(fileURLWithPath: "mock-data/github")
        try FileManager.default.createDirectory(
            at: directory,
            withIntermediateDirectories: true
        )

        let file = directory.appendingPathComponent("issues-masterplan.json")

        try prettyData.write(to: file)

        print("Saved \(prettyData.count) bytes")
        print(file.path)

        if let prettyString = String(data: prettyData, encoding: .utf8) {
            print(prettyString)
        }
    }
} 
