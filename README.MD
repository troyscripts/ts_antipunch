# Troy Scripts — ts_antipunch

**Versie: 1.8.1** · FiveM · Standalone

Met de standaardinstellingen blokkeert de resource schieten en melee zonder de richtknop vast te houden. Slaan met een
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



Repository: [troyscripts/ts_antipunch](https://github.com/troyscripts/ts_antipunch).
Deze handleiding wijzigen publiceert of installeert geen scriptbestanden.
Gebruik je een andere accountnaam of branch? Pas `Repository` en `Branch` in `Config.UpdateCheck` aan.
Een GitHub-token is niet nodig voor een openbare repository.

### Updatecontrole

Neem dit blok op in `config.lua`:

```lua
Config.UpdateCheck = {
    Enabled = true,
    Repository = 'troyscripts/ts_antipunch',
    Branch = 'main'
}
```

Ontbreekt `Config.UpdateCheck` in een oude config, dan wordt de controle niet
uitgevoerd. Een bestaande verwijzing naar de oude GitHub-accountnaam moet je
zelf aanpassen. `troyscripts` is de accountnaam en `main` is de branch.

De updatecontrole vereist ook `server.lua` en de bijbehorende vermelding in
`fxmanifest.lua`. Neem bij installatie of bijwerken alle meegeleverde
resourcebestanden over.


Als de controle is ingeschakeld en de configuratie geldig is, leest de server bij elke start één keer `version.txt` van de ingestelde GitHub-branch.
De lokale versie komt uit `fxmanifest.lua`. Voor deze release bevatten het manifest
en `version.txt` beide versie `1.8.1`. Een GitHub-release of tag is niet vereist
voor de controle: de versie wordt uit `version.txt` gelezen. Bij een nieuwere versie verschijnt bijvoorbeeld:

```text
[TroyScripts] [ts_antipunch] Nieuwe versie beschikbaar: 1.8.2 (geinstalleerd: 1.8.1).
[TroyScripts] [ts_antipunch] Download: https://github.com/troyscripts/ts_antipunch
```

Er verschijnt ook een melding wanneer de versie gelijk is aan die op GitHub,
wanneer je lokale versie nieuwer is of wanneer de controle mislukt.
Zolang de repository of `version.txt` ontbreekt, kan de controle een HTTP 404 melden.
Bij netwerkproblemen blijft de resource normaal werken. Na 15 seconden wordt een
ontbrekend antwoord gemeld; er zijn geen automatische herhaalverzoeken.
Uitschakelen kan met `Config.UpdateCheck.Enabled = false`.
De controle installeert niets en voert geen gedownloade code uit.

Bij toekomstige updates: werk eerst alle gewijzigde bestanden en het changelog bij,
verhoog `version` in `fxmanifest.lua` en zet dezelfde versie in `version.txt`.
Publiceer alles samen in één commit. Gebruik drie getallen, bijvoorbeeld `1.8.2`;
`version.txt` is bedoeld voor stabiele versies, niet voor beta-aanduidingen.

De HTTP-controle gebruikt de officiële FiveM-functie
[PerformHttpRequest](https://docs.fivem.net/docs/scripting-reference/runtimes/lua/functions/PerformHttpRequest/).

## Instellingen

Alle onderstaande instellingen staan onder `Config` in `config.lua`.

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
| `UpdateCheck.Enabled` | `true` | Controleer bij starten op een nieuwere versie. |
| `UpdateCheck.Repository` | `'troyscripts/ts_antipunch'` | GitHub-account en repository. |
| `UpdateCheck.Branch` | `'main'` | Branch waaruit version.txt wordt gelezen. |

`MainLoopWait` en `CameraCheckWait` zijn vervallen. De blokkeringen worden elk
frame toegepast; er is geen algemene failsafe meer die eigen first person wegdrukt.
De oude README gebruikte ten onrechte `DisableWeaponWhip`: de juiste naam is
`DisableWeaponMelee`.

## Gedrag en grenzen

- Normaal herladen (control 45) wordt niet geblokkeerd.
- Wie al in first person speelt, blijft daarin na het richten.
- De resource bewaart de vorige camerastand wanneer hij zelf naar first person
  schakelt. Bij herstel wijzigt hij de camera alleen als die nog in first person
  staat; een inmiddels gekozen andere stand wordt niet overschreven.
- Met `RestoreCamera = false` blijft de geforceerde first person na het loslaten
  behouden en wordt de opgeslagen camerastatus vrijgegeven. Bij stoppen, overlijden
  of een pedwissel wordt alleen een **nog actieve** eigen camerawijziging hersteld.
  Dit is dus geen garantie dat first person later alsnog wordt teruggezet wanneer
  de opgeslagen status al is vrijgegeven.
- Bij opnieuw richten binnen de herstelvertraging wordt het herstel geannuleerd.
- De camera in voertuigen wordt niet geforceerd. Voor de schietblokkering tellen
  in voertuigen ook richtcontrols 68 en 91 mee. Voertuigaanvalscontrols worden
  uitsluitend door `BlockShootingWithoutAim` geblokkeerd, niet door anti-melee.
- Richten betekent hier de richtknop ingedrukt houden; er is geen minimale richttijd.
- Vuisten en echte melee-wapens vallen onder `BlockMeleeWithoutAim`; de permanente
  wapenmelee-blokkering gebruikt de GTA-detectie voor vuurwapens.
- `BlockShootingWithoutAim` blokkeert ook de primaire aanvalsknoppen zonder richten.
  Daardoor kan deze instelling vuist- en mesaanvallen via die knoppen eveneens
  verhinderen, ook als `BlockMeleeWithoutAim = false` staat.
- `BlockExtraMeleeControls` werkt alleen wanneer de melee-blokkering actief is.
  `CancelForcedMelee` grijpt alleen in als vuurwapen-melee wordt geblokkeerd en
  de speler volgens de game daadwerkelijk in een meleegevecht zit.
- `CancelForcedMelee` is een noodrem die ped-taken onderbreekt. Test dit met je
  animatiescripts; zet deze optie uit als de noodrem conflicten veroorzaakt.
- Andere scripts die tegelijk camera of controls afdwingen kunnen blijven botsen.
  Dit is client-side spelbesturing, geen server-side anticheat.

## Changelog — 1.8.1

- Versie verhoogd naar 1.8.1.
- Eenmalige server-side updatecontrole via GitHub toegevoegd, met downloadlink bij een nieuwere versie.
- Repository en branch instelbaar via `Config.UpdateCheck`; controle is uit te schakelen.
- Duidelijke meldingen bij onbereikbare of ongeldige versiegegevens.
- `version.txt`, `.gitignore`, `.gitattributes` en GitHub-instructies toegevoegd.
- Combat- en cameragedrag van 1.8.0 behouden.

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

Versie 1.8.1: alle Lua-bestanden zijn op syntaxis gecontroleerd. De updatecontrole
is met gesimuleerde FiveM-functies getest op versievergelijking, HTTP-fouten,
ongeldige gegevens, time-out en uitschakelen. De clientlogica is ongewijzigd.
Deze versie is hier niet op een live FiveM-server getest.


De eerdere releasebeschrijving van 1.8.0 vermeldt Lua-syntaxcontroles en tests
met gesimuleerde FiveM-functies voor combat- en cameragedrag. De beta is eerder
door de gebruiker goedgekeurd. Deze README is vergeleken met de lokaal
beschikbare 1.8.1-code; bij de herschrijving is geen nieuwe live FiveM-test uitgevoerd.
Controleer na het bijwerken:

1. Herladen met een vuurwapen zonder en met richten.
2. Schieten zonder richten (geblokkeerd) en tijdens richten (toegestaan).
3. Slaan met een vuurwapen dicht bij een andere speler, ook tijdens richten.
4. Vuisten en een mes met en zonder richten.
5. Vanuit elke camerastand richten en loslaten; eigen first person blijft behouden.
6. Snel loslaten en opnieuw richten, overlijden en `restart ts_antipunch` tijdens richten.
7. Richten en schieten als bestuurder/passagier, en je gebruikte voertuigwapens.
8. Controllerbediening en combinatie met je HUD, inventory en animatiescripts.
9. De opstartmelding voor 1.8.1 en het resultaat van de GitHub-updatecontrole.

Deze controles gaan uit van de standaardinstellingen. Test bij eigen instellingen
ook de combinaties van schietblokkering, melee-blokkering en cameraherstel.

Wapendetectie: [officiële IsPedArmed-documentatie](https://github.com/citizenfx/natives/blob/master/WEAPON/IsPedArmed.md).

Controlnamen: [officiële FiveM-controls](https://docs.fivem.net/docs/game-references/controls/).

Ontwikkeld door **Troy Scripts**.
