# Troy Scripts — ts_antipunch

**Versie: 1.8.0** · FiveM · Standalone

Blokkeert schieten en melee zonder de richtknop vast te houden. Slaan met een
vuurwapen wordt ook tijdens richten geblokkeerd. Tijdens richten te voet kan
het script first person afdwingen en daarna de vorige camerastand herstellen.
Geen ESX, QBCore, database of andere resources nodig.

## Installatie / bijwerken

1. Bewaar een backup van je bestaande resource en instellingen.
2. Stop de bestaande resource met `stop ts_antipunch`.
3. Vervang de map `ts_antipunch` volledig door de map uit deze zip.
4. Neem eventuele eigen instellingen over in de **nieuwe** `config.lua`.
5. Zorg dat in `server.cfg` het volgende staat:

```cfg
ensure ts_antipunch
```

Start de resource met `ensure ts_antipunch`. Start geen tweede kopie daarnaast.
Bij overstappen vanaf 1.7.1 tijdens het richten kan de oude versie de camera
achterlaten in first person. Kies dan zelf eenmaal je gewenste camerastand.

## Instellingen

| Instelling | Standaard | Werking |
| --- | --- | --- |
| `Debug` | `false` | Meldingen bij statuswisselingen in F8. |
| `ForceFirstPerson` | `true` | First person tijdens richten te voet. |
| `RestoreCamera` | `true` | Herstel de door dit script gewijzigde camera na richten. |
| `DefaultCamera` | `1` | Terugvalstand: 0 dichtbij, 1 gemiddeld, 2 ver, 4 first person. |
| `CameraRestoreDelay` | `50` | Cameravertraging in ms, getal vanaf 0. |
| `BlockShootingWithoutAim` | `true` | Blokkeer schieten zonder richtknop. |
| `BlockMeleeWithoutAim` | `true` | Blokkeer melee zonder richtknop. |
| `DisableWeaponMelee` | `true` | Blokkeer melee met vuurwapens, ook tijdens richten. |
| `BlockExtraMeleeControls` | `true` | Pas extra melee-controls 143, 263 en 264 toe. |
| `CancelForcedMelee` | `true` | Annuleer toch gestarte vuurwapen-melee door ped-taken direct te stoppen. |
| `AimControl` | `25` | GTA-richtcontrol; standaard rechtermuisknop / LT. |

`MainLoopWait` en `CameraCheckWait` zijn vervallen. De blokkeringen worden elke
frame toegepast; er is geen algemene failsafe meer die eigen first person wegdrukt.
De oude README gebruikte ten onrechte `DisableWeaponWhip`: de juiste naam is
`DisableWeaponMelee`.

## Gedrag en grenzen

- Normaal herladen (control 45) wordt niet geblokkeerd.
- Wie al in first person speelt, blijft daarin na het richten.
- De resource herstelt alleen een camera die hij zelf heeft veranderd. Bij stoppen,
  overlijden of een andere player-ped wordt een nog actieve eigen camerawijziging
  opgeruimd. Dit gebeurt bij deze lifecycle-wisselingen ook met `RestoreCamera = false`.
- Bij opnieuw richten binnen de herstelvertraging wordt het herstel geannuleerd.
- De camera in voertuigen wordt niet geforceerd. Voor de schietblokkering tellen
  in voertuigen ook richtcontrols 68 en 91 mee. Voertuigaanvalscontrols worden
  uitsluitend door `BlockShootingWithoutAim` geblokkeerd, niet door anti-melee.
- Richten betekent hier de richtknop ingedrukt houden; er is geen minimale richttijd.
- Vuisten en echte melee-wapens vallen onder `BlockMeleeWithoutAim`; de permanente
  wapenmelee-blokkering gebruikt de GTA-detectie voor vuurwapens.
- `CancelForcedMelee` is een noodrem die ped-taken onderbreekt. Test dit met je
  animatiescripts; zet deze optie uit als de noodrem conflicten veroorzaakt.
- Andere scripts die tegelijk camera of controls afdwingen kunnen blijven botsen.
  Dit is client-side spelbesturing, geen server-side anticheat.

## Changelog — 1.8.0

- Door de gebruiker goedgekeurde beta uitgebracht als versie 1.8.0.
- Melee via de primaire aanvalsknop wordt nu ook geblokkeerd wanneer
  `BlockShootingWithoutAim = false` en `BlockMeleeWithoutAim = true`.
  Dit geldt te voet met vuisten of een melee-wapen, zonder richten.
- Bestaande standaardinstellingen behouden.
- Manifest, broncode en handleiding bijgewerkt.

## Changelog — 1.7.5beta

- Herlaadcontrol 45 verwijderd uit de blokkeringen.
- Vuurwapen-melee ook tijdens richten geblokkeerd.
- Voertuigcontrols gescheiden van de melee-instellingen.
- `BlockExtraMeleeControls` daadwerkelijk aangesloten op de logica.
- Cameraherstel beperkt tot eigen wijzigingen; vrijwillige first person behouden.
- Blokkerende `Wait(50)` vervangen door een timer; combat blijft elke frame actief.
- Opruimen van camerastatus bij resource-stop, overlijden en pedwissel.
- Tweede cameraloop verwijderd; timinginstellingen aangepast.
- Manifest, versie en Nederlandse documentatie bijgewerkt; standalone aangeduid.

De aangeleverde vorige versie was 1.7.1; voor 1.7.2 t/m 1.7.4 zijn geen releases
in dit pakket opgenomen.

## Controle in FiveM

Versie 1.8.0 is lokaal gecontroleerd op Lua-syntaxis en met gesimuleerde
FiveM-functies getest op combat- en cameragedrag. De beta is door de gebruiker
goedgekeurd. De aangepaste versie is hier niet op een live FiveM-server getest.
Controleer na het bijwerken:

1. Herladen met een vuurwapen zonder en met richten.
2. Schieten zonder richten (geblokkeerd) en tijdens richten (toegestaan).
3. Slaan met een vuurwapen dicht bij een andere speler, ook tijdens richten.
4. Vuisten en een mes met en zonder richten.
5. Vanuit elke camerastand richten en loslaten; eigen first person blijft behouden.
6. Snel loslaten en opnieuw richten, overlijden en `restart ts_antipunch` tijdens richten.
7. Richten en schieten als bestuurder/passagier, en je gebruikte voertuigwapens.
8. Controllerbediening en combinatie met je HUD, inventory en animatiescripts.

Wapendetectie: [officiële IsPedArmed-documentatie](https://github.com/citizenfx/natives/blob/master/WEAPON/IsPedArmed.md).

Controlnamen: [officiële FiveM-controls](https://docs.fivem.net/docs/game-references/controls/).

https://discord.gg/nTzVy5uMWX

Ontwikkeld door **Troy Scripts**.
