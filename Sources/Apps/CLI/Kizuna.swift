import ArgumentParser
import KizunaCore

@main
struct KizunaCLI: AsyncParsableCommand {

    static let configuration = CommandConfiguration(
        commandName: "kizuna",
        abstract: "Kizuna command line interface",
        subcommands: [
            LoadCommand.self,
            ListCommand.self
        ]
    )

    mutating func run() async throws {

        let environment = try AppEnvironment.default()

        print("Application Support:")
        print(environment.directories.applicationSupport.path)

        print("Caches:")
        print(environment.directories.caches.path)
    }

}
