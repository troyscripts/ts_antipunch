# Troy Scripts — ts_antipunch

**Scriptversie 1.8.4** · **configschema 1.8.3** · FiveM · vereist `ts_bridge` (API 1, versie minimaal 0.0.5). De bridge vereist `ox_lib`.

Deze resource blokkeert ongewenst schieten/melee zonder richten, verhindert vuurwapen-melee ook tijdens richten, en dwingt naar wens first person af tijdens richten te voet. Combat- en camerabeheer blijven via `ts_bridge` geïntegreerd.

## Installatie en mappen

Dit is een **volledige** resource, geen patch. Plaats de gehele map als `resources/[local]/ts_antipunch`. Bewaar eerst eventuele eigen instellingen en vervang de oude map in zijn geheel; kopieer niet over de oude structuur heen.

De configuratie staat voortaan in **`config/config.lua`**. De eigen vertalingen blijven in `locales/nl.lua`. `fxmanifest.lua` laadt alle nieuwe paden in de bestaande volgorde. Zie [docs/INSTALLATIE.md](docs/INSTALLATIE.md) en [docs/STRUCTUUR.md](docs/STRUCTUUR.md).

```cfg
ensure ox_lib
ensure ts_bridge
ensure ts_antipunch
# Eventuele afhankelijke scripts daarna starten, bijvoorbeeld ts_hostage.
```

| Onderdeel | Locatie |
| --- | --- |
| Config en gameplay-instellingen | `config/config.lua` |
| Bridgecheck, configcheck en locale-helper | `shared/` |
| Client-combat- en cameracontrole | `client/main.lua` |
| Serverstart en updatecontrole | `server/main.lua` |
| Nederlandse teksten | `locales/nl.lua` |
| Installatie, structuur en historie | `docs/` |
| Lokale distributiecontrole | `tests/check_package.py` |

## Instellingen

De bestaande instellingen en **waarden** zijn niet veranderd. `Config.Version` blijft **'1.8.2'**, omdat deze onderhoudsrelease geen nieuw configuratieschema introduceert.

| Instelling | Standaard | Betekenis |
| --- | --- | --- |
| `ForceFirstPerson` | `true` | Dwingt first person tijdens richten te voet af. |
| `FirstPersonOnlyFirearms` | `false` | Indien `true` alleen bij vuurwapens. |
| `RestoreCamera` | `true` | Camera herstellen nadat de laatste bridge-aanvraag stopt. |
| `DefaultCamera` | `1` | Camera om naar terug te keren (0, 1, 2 of 4). |
| `CameraRestoreDelay` | `50` | Vertraging van cameraterugkeer in milliseconden. |
| `BlockShootingWithoutAim` | `true` | Blokkeert schieten zonder richtknop. |
| `BlockMeleeWithoutAim` | `true` | Blokkeert melee zonder richten. |
| `DisableWeaponMelee` | `true` | Blokkeert slaan met vuurwapens, ook tijdens richten. |
| `BlockExtraMeleeControls` | `true` | Extra melee-knoppen blokkeren. |
| `CancelForcedMelee` | `true` | Onderbreekt gestarte vuurwapen-melee eenmaal per melee-episode. |
| `MeleeCancelMode` | `'secondary'` | Minder ingrijpende annulering; kies `'immediate'` voor de oude directe noodrem. |
| `RespectCombatContexts` | `true` | Respecteert camera-/melee-pauzes van andere scripts via `ts_bridge`. |
| `AimControl` | `25` | Richtcontrol, rechtermuisknop/LT. |
| `UpdateCheck.Enabled` | `true` | Controleert op een nieuwe versie via bridge, installeert niets. |
| `Debug` | `false` | Uitgebreide statusmeldingen in F8. |
| `Locale` | `'nl'` | Nederlandse meldingen en fallback. |

## Melee-afhandeling vanaf 1.8.4

Melee-aanvalsknoppen worden nog steeds iedere frame geblokkeerd; herladen (control 45) blijft mogelijk. Voor toch gestarte vuurwapen-melee voert de noodrem nu **maximaal één annulering per melee-episode** uit. De standaard `MeleeCancelMode='secondary'` beperkt de annulering tot secundaire taken. Als een andere serverresource toch primaire vuurwapen-melee start, kun je bewust `'immediate'` instellen voor het eerdere gedrag. Test die optie met `ts_hostage` en animatiescripts op de testserver.

Omdat `MeleeCancelMode` nieuw is, is het configschema verhoogd naar `1.8.3`. Neem deze instelling over voordat je `Config.Version` wijzigt.

## Compatibiliteit

Er zijn **geen** nieuwe exports, events, cameraregels of databasewijzigingen toegevoegd. Alleen de configurabele melee-noodrem is verfijnd. De FiveM-resource blijft `ts_antipunch` heten. De bridge-API, `Config`-velden, updatechecker naar `version.txt`, en bestaande afstemming met `ts_hostage` zijn behouden.

Dit is clientbesturing, geen server-side anticheat. Reloadcontrol 45 blijft vrij. De cameraverzoeken van `ts_hostage` en `ts_antipunch` kunnen gelijktijdig bestaan; de bridge herstelt de camera na de laatste vrijgave. Scripts die rechtstreeks de native camera overschrijven kunnen nog conflicteren.

## Controleren

GitHub Actions controleert het manifest, de mapstructuur, de versies en de Lua 5.4-syntax en bouwt één volledig ZIP-pakket. Dat vervangt geen gameplaytest: controleer op een testserver richten, schieten, melee, herladen, first-person herstel, gijzelen/loslaten, voertuiggedrag, pedwissel, overlijden en resourceherstarts.

Zie [docs/CHANGELOG.md](docs/CHANGELOG.md) voor de versiegeschiedenis. Historische 1.8.2-updatebestanden zijn als archief in `docs/historie/` behouden en **zijn niet** de instructies voor deze volledige release.
