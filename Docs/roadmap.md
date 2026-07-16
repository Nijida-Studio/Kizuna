# Kizuna Development Roadmap

## Mock 1 – GitHub Reading

Test authenticated GitHub issue reading and local JSON export.

Status: Complete.

## Mock 2 – Local Architecture

Establish the reusable Swift Package structure, separate the CLI from
`KizunaCore`, load local JSON data, and filter issues.

Status: Complete.

## Mock 3 – GitHub Writing

Select a repository and test creating and changing GitHub issues in the
dedicated `Kizuna-Issue-test-Repo`.

Status: Current.

## Mock 4 – Calendar and Reminder Reading

Read Apple Calendar and Reminders data and test mapping it into Kizuna's
models without adding synchronization yet.

Status: Planned.

## Mock 5 – Calendar and Reminder Writing

Create and change Apple Calendar and Reminders data and establish the write
boundaries needed for later synchronization.

Status: Planned.

## Mock 6 – Foundation and Workspace Integration

Create the Xcode workspace for Kizuna and Dokoni Foundation, review the code
produced by the previous mocks, and reuse or relocate it where the established
ownership boundaries justify doing so.

Mock 6 is the final structural validation mock. Its accepted result becomes
the starting point for main development rather than being discarded and
rebuilt.

Status: Planned.

## Main Development

Main development begins from the structure validated by Mock 6. Further work
uses the shared workspace while keeping Kizuna product workflows separate from
the reusable, UI-independent capabilities in Dokoni Foundation.
