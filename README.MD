# Troy Scripts — ts_antipunch

**Versie 1.8.2** · FiveM · vereist **ts_bridge 0.0.5 of hoger** en **ox_lib**

Blokkeert schieten en melee zonder richten. Slaan met een vuurwapen wordt ook
tijdens richten geblokkeerd. First person tijdens richten te voet staat standaard aan.
De eigen combatlogica heeft geen ESX, inventory of database nodig. Deze versie
gebruikt wel verplicht ts_bridge; de bridge heeft ox_lib nodig.

## Bijwerken vanaf 1.8.1

Dit updatepakket bevat alleen gewijzigde en nieuwe bestanden. Kopieer de inhoud
van de map `ts_antipunch` over je bestaande resourcemap; verwijder die map niet.
Maak eerst een backup. Lees `UPDATE-INSTALLATIE.md` voor de gezamenlijke startvolgorde.
Neem eigen instellingen over in de nieuwe `config.lua` en eigen vertalingen in
`locales/nl.lua`. Geen oude bestanden verwijderen, geen databasewijziging.

```cfg
ensure ox_lib
ensure ts_bridge
ensure ts_antipunch
# Indien aanwezig, met de bijbehorende update:
ensure ts_hostage
```

## First person

Voor de gewenste verplichte first person op deze server:

```lua
Config.ForceFirstPerson = true
Config.FirstPersonOnlyFirearms = false
```

Dit houdt het bestaande gedrag aan: iedere richtknop te voet forceert first person,
ook met vuisten of messen. Kies `FirstPersonOnlyFirearms = true` om dit uitsluitend
bij vuurwapens te doen. `ForceFirstPerson = false` schakelt de cameraforcering van
antipunch uit. De afzonderlijke hostage-camera is instelbaar in de hostage-config.
Antipunch forceert geen voertuigcamera.

## Instellingen

| Instelling | Standaard | Werking |
| --- | --- | --- |
| `Version` | `'1.8.2'` | Configschema; neem eerst de nieuwe velden over. |
| `Locale` | `'nl'` | Aanpasbare teksten in `locales`; Nederlands is de terugvaltaal. |
| `Debug` | `false` | Statusmeldingen in F8. |
| `ForceFirstPerson` | `true` | First person tijdens richten te voet verplicht. |
| `FirstPersonOnlyFirearms` | `false` | Optioneel beperken tot vuurwapens. |
| `RestoreCamera` | `true` | Oorspronkelijke camera herstellen na de laatste aanvraag. |
| `DefaultCamera` | `1` | Terugval: 0 dichtbij, 1 gemiddeld, 2 ver, 4 first person. |
| `CameraRestoreDelay` | `50` | Herstelvertraging, 0 t/m 60000 ms. |
| `BlockShootingWithoutAim` | `true` | Schieten zonder richtknop blokkeren. |
| `BlockMeleeWithoutAim` | `true` | Melee zonder richtknop blokkeren. |
| `DisableWeaponMelee` | `true` | Vuurwapen-melee ook tijdens richten blokkeren. |
| `BlockExtraMeleeControls` | `true` | Extra melee-controls 143, 263 en 264 blokkeren. |
| `CancelForcedMelee` | `true` | Toch gestarte vuurwapen-melee afbreken door ped-taken te stoppen. |
| `RespectCombatContexts` | `true` | Gerichte pauzes van camera/noodrem via de bridge respecteren. |
| `AimControl` | `25` | Richtcontrol: rechtermuisknop / LT; geldig bereik 0 t/m 360. |
| `UpdateCheck.Enabled` | `true` | Eén centrale GitHub-check per resource-start. |
| `UpdateCheck.Repository` | `'troyscripts/ts_antipunch'` | Repository voor versie en downloadlink. |
| `UpdateCheck.Branch` | `'main'` | Branch met `version.txt`. |

Ongeldige gameplaywaarden krijgen een veilige standaard met een servermelding.
Ongeldige update-instellingen schakelen de updatecheck uit of geven een melding van
de bridge. De configversiecheck meldt een oude config; hij vervangt geen bestand.

## Samenwerking met ts_hostage 1.1.9

Beide scripts vragen first person aan bij de bridge. Wanneer één script loslaat,
blijft first person actief zolang het andere script die nog nodig heeft. De bridge
bewaart de oorspronkelijke camerastand en herstelt deze na de laatste aanvraag.
Wie vooraf zelf in first person speelde, blijft daarin.

Hostage vraagt standaard first person voor de dader aan tijdens een actieve
sessie. Via `Config.AntipunchCompatibility = true` in hostage pauzeert het tijdelijk
alleen de antipunch-noodrem die animaties kan afbreken. De normale schiet- en
slagblokkeringen blijven actief; deze koppeling schakelt first person niet uit.
Na loslaten/stoppen vervalt de pauze automatisch. Andere animatiescripts kunnen
op dezelfde manier gericht een pauze aanvragen; zie de bridgehandleiding.

De cameravertraging blokkeert de combatloop niet. Bij doodgaan, een pedwissel of
resource-stop ruimt de bridge de actieve aanvragen op. Na een volledige
bridgeherstart moeten afhankelijke scripts opnieuw worden gestart.

Bij overlappende cameraverzoeken wordt hersteld zodra de laatste loslaat als
minstens één deelnemer herstel heeft aangevraagd. Met alleen `RestoreCamera = false`
blijft first person na normale vrijgave behouden. Een actieve aanvraag wordt bij
stoppen/overlijden wel opgeruimd met herstel. Andere scripts die rechtstreeks de
camera overschrijven kunnen nog conflicten veroorzaken.

## Grenzen

- Herladen (control 45) blijft vrij.
- De richtknop bepaalt of schieten is toegestaan; er is geen minimale richttijd.
- In voertuigen tellen richtcontrols 68 en 91 ook mee.
- Schieten blokkeren blokkeert de primaire aanvalsknoppen en kan daardoor ook
  vuist- of mesaanvallen verhinderen als alleen die schietblokkering aanstaat.
- De melee-noodrem onderbreekt ped-taken. Zet `CancelForcedMelee` uit bij conflicten
  met scripts die geen combatcontext doorgeven.
- Dit is clientbesturing, geen server-anticheat.

## Updatecontrole en publicatie

De updatecontrole loopt via `ts_bridge:CheckForUpdates` en leest `version.txt`.
Bij een hogere versie volgt een downloadlink. Een mislukte netwerkcontrole
verandert niets aan de gameplay. Er wordt niets automatisch geïnstalleerd.

Repository: [troyscripts/ts_antipunch](https://github.com/troyscripts/ts_antipunch).
Upload de gewijzigde resourcebestanden, inclusief `fxmanifest.lua` en
`version.txt` met **1.8.2**, samen naar de hoofdmap van die repository.
De ZIP is geen publicatie op GitHub. Zie `CHANGELOG.md` voor alle wijzigingen.

## Controle

Lua-syntaxis, configuratievalidatie, bridgecontrole en gedeeld camera-/combatgedrag
zijn lokaal met gesimuleerde FiveM-functies getest. Geen live FiveM-test uitgevoerd.
Test op de server herladen, melee, richten met muis/controller, cameraherstel,
gijzelen en loslaten met twee spelers, voertuigcamera en een resourceherstart.
