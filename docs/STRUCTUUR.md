# Mappenstructuur — ts_antipunch 1.8.3

```text
ts_antipunch/
├── fxmanifest.lua
├── version.txt
├── README.md
├── config/
│   └── config.lua
├── shared/
│   ├── locale.lua
│   ├── bridge_check.lua
│   └── config_check.lua
├── locales/
│   └── nl.lua
├── client/
│   └── main.lua
├── server/
│   └── main.lua
├── docs/
│   ├── INSTALLATIE.md
│   ├── STRUCTUUR.md
│   ├── CHANGELOG.md
│   └── historie/
│       ├── UPDATE-INSTALLATIE-1.8.2.md
│       ├── UPDATE-BESTANDEN-1.8.2.txt
│       └── TESTRESULTATEN-1.8.2.txt
├── tests/
│   └── check_package.py
└── .github/workflows/
    └── checks.yml
```

## Omgezette paden

| Oud | Nieuw |
| --- | --- |
| `config.lua` | `config/config.lua` |
| `locale.lua` | `shared/locale.lua` |
| `bridge_check.lua` | `shared/bridge_check.lua` |
| `config_check.lua` | `shared/config_check.lua` |
| `client.lua` | `client/main.lua` |
| `server.lua` | `server/main.lua` |
| `CHANGELOG.md` | `docs/CHANGELOG.md` |
| `README.MD` | `README.md` |
| `UPDATE-*.md`, `TESTRESULTATEN.txt` | `docs/historie/` |

De oorspronkelijke laadvolgorde is `locales/*.lua`, locale-helper, configuratie, bridgecheck, configcheck, clientlogica en serverlogica. De namen `ts_antipunch` en `ts_bridge` blijven gelijk; de updatechecker leest nog steeds `version.txt` uit de root.

**Belangrijk:** verwijder bij een bestaande installatie na een back-up de gehele oude resourcemap en installeer het nieuwe pakket als één geheel. Anders blijven verouderde rootbestanden achter.

Geen wijzigingen aan gameplay of configschema; `Config.Version='1.8.2'` is bewust behouden.
