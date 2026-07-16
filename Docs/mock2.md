# Kizuna Mock 2

## Ziel

Mock 2 testet die lokale Grundarchitektur von Kizuna.

Im Fokus stehen:

- Trennung von Core-Library und CLI-App
- Apple-App-Verzeichnisse
- lokale JSON-Datenquelle
- einfache Issue-Modelle
- Filtern von Issues
- CLI-Ausgabe

## Struktur

```text
Sources/
├── Apps/
│   └── CLI/
│       ├── Commands/
│       ├── Output/
│       └── Kizuna.swift
└── Libraries/
    └── KizunaCore/
        ├── Environment/
        ├── Filtering/
        ├── Models/
        ├── Storage/
        └── Sync/
```

## Mock-Daten

Die Mock-Daten liegen lokal unter:

```text
~/Library/Application Support/Kizuna/mock2/issues.json
```

## CLI-Beispiele

```zsh
swift run kizuna list epic
swift run kizuna list requirement --status in_progress
swift run kizuna list epic --assigned mei --subtype userstory
```

## Erkenntnisse

- `KizunaCore` enthält keine CLI-Abhängigkeiten.
- `ArgumentParser` bleibt ausschließlich in der CLI-App.
- `AppEnvironment` verwaltet derzeit die App-spezifischen Verzeichnisse.
- Die Daten werden lokal aus einer JSON-Datei geladen.
- `IssueFilter` kapselt die Filterlogik vollständig vom CLI.
- `TablePrinter` übernimmt ausschließlich die Darstellung der Ausgabe.
- Issue-Typen und Subtypen sind derzeit noch feste Enums.
- Später sollen Typen und Subtypen dynamisch aus GitHub bzw. der Projektkonfiguration stammen.
- Eine Repository- oder Store-Schicht wurde bewusst noch nicht eingeführt.
- Für Mock 2 genügt ein einfacher `JSONIssueLoader`.
- Tests konzentrieren sich auf Verhalten statt auf triviale Datencontainer.

## Nicht Bestandteil von Mock 2

- GitHub-API
- Synchronisation
- Kalenderintegration
- Erinnerungen
- iCloud
- dynamische Projektkonfiguration
- Caching
- Logging
- Repository-/Store-Architektur

## Ergebnis

Mock 2 demonstriert erfolgreich den vollständigen lokalen Ablauf:

1. CLI starten
2. JSON-Datei laden
3. Issues filtern
4. Ausgabe formatieren
5. Ergebnisse anzeigen

Damit steht die Basisarchitektur für die weitere Entwicklung.

## Nächster Mock

Mock 3 führt den in Mock 1 getesteten GitHub-Zugriff mit der Architektur aus
Mock 2 zusammen. Reale Issues werden aus einem auswählbaren Repository geladen
und anschließend mit derselben Filter- und Ausgabelogik verarbeitet.
