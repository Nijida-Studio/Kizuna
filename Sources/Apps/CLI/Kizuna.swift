import ArgumentParser
import KizunaCore

@main
struct KizunaCLI: ParsableCommand {

    static let configuration = CommandConfiguration(
        commandName: "kizuna",
        abstract: "Kizuna command line interface",
        subcommands: [
            ListCommand.self
        ]
    )

    mutating func run() throws {

        let environment = try AppEnvironment.default()

        print("Application Support:")
        print(environment.directories.applicationSupport.path)

        print("Caches:")
        print(environment.directories.caches.path)
    }

}
