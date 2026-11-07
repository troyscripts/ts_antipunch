#!/usr/bin/env python3
"""Controleer de distributie van ts_antipunch zonder een FiveM-runtime."""
from pathlib import Path
import re

root = Path(__file__).resolve().parent.parent
manifest = (root / "fxmanifest.lua").read_text(encoding="utf-8")
version = re.search(r"^version\s+['\"]([^'\"]+)['\"]", manifest, re.M)
assert version, "Geen versie in fxmanifest.lua"
assert version.group(1) == (root / "version.txt").read_text(encoding="utf-8").strip(), "Versies verschillen"
assert version.group(1) == "1.8.3", "Onverwachte scriptversie"

scripts = re.search(r"shared_scripts\s*\{([^}]+)\}", manifest, re.S)
assert scripts, "shared_scripts ontbreekt"
shared = re.findall(r"['\"]([^'\"]+\.lua)['\"]", scripts.group(1))
expected = [
    "locales/*.lua",
    "shared/locale.lua",
    "config/config.lua",
    "shared/bridge_check.lua",
    "shared/config_check.lua",
]
assert shared == expected, f"Shared-script volgorde is gewijzigd: {shared}"
for pattern in shared:
    assert list(root.glob(pattern)), f"Niet gevonden: {pattern}"
assert re.search(r"client_script\s+['\"]client/main\.lua['\"]", manifest)
assert re.search(r"server_script\s+['\"]server/main\.lua['\"]", manifest)
assert (root / "client/main.lua").exists()
assert (root / "server/main.lua").exists()

for old in ("client.lua", "server.lua", "bridge_check.lua", "config_check.lua", "locale.lua", "config.lua", "CHANGELOG.md", "README.MD"):
    assert not (root / old).exists(), f"Oud bestand nog aanwezig: {old}"
assert "Config.Version = '1.8.2'" in (root / "config/config.lua").read_text(encoding="utf-8")
assert "originalVersion, '1.8.2'" in (root / "shared/config_check.lua").read_text(encoding="utf-8")
assert "GetCombatContext" in (root / "shared/bridge_check.lua").read_text(encoding="utf-8")
assert "CheckForUpdates" in (root / "server/main.lua").read_text(encoding="utf-8")
assert (root / "docs/INSTALLATIE.md").exists()
assert (root / "docs/STRUCTUUR.md").exists()
assert (root / "docs/CHANGELOG.md").exists()
print("PASS: ts_antipunch manifest, bestandsstructuur, schema, bridge en versie")
