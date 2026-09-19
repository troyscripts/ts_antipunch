# Changelog

## 1.8.2 — Bridge en gedeeld camerabeheer

- Vereist ts_bridge 0.0.5; client/server controleren versie, API, functies en status.
- GitHub-updatecontrole via de bridge; repository gecorrigeerd naar troyscripts/ts_antipunch.
- Gedeeld camerabeheer voorkomt voortijdig herstel bij overlappende aanvragen.
- First person standaard verplicht; optionele beperking tot vuurwapens in config.
- Overlijdenscontrole via de bridge; eigen combatblokkeringen blijven elke frame actief.
- Gerichte pauzes voor camera/noodrem via bridgecontexten; hostage pauzeert alleen de noodrem.
- Configwaarden valideren, configversiecheck en aanpasbare Nederlandse locales.
- Documentatie, installatiehandleiding, manifest en version.txt bijgewerkt.
- Lokaal gesimuleerd getest; geen live FiveM-test.

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

