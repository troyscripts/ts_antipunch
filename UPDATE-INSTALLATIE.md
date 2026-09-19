# Update ts_antipunch 1.8.1 → 1.8.2

Deze ZIP bevat alleen de gewijzigde/nieuwe bestanden, bedoeld voor een bestaande
1.8.1-installatie. Laat alle overige bestanden staan. Geen bestanden verwijderen.

1. Maak een backup van antipunch, bridge en hostage, inclusief eigen instellingen.
2. Stop actieve gijzelingen. Stop ts_hostage, ts_antipunch en andere afhankelijke
   Troy Scripts (bijvoorbeeld ts_keycard); stop daarna ts_bridge.
3. Kopieer de bridge-update 0.0.5 over de bestaande map ts_bridge.
4. Kopieer deze map ts_antipunch over je bestaande map ts_antipunch.
5. Neem eigen instellingen over in de nieuwe config.lua. Voor verplichte first person:
   ForceFirstPerson = true; FirstPersonOnlyFirearms = false.
6. Installeer ook de hostage-update 1.1.9 wanneer je hostage gebruikt, inclusief diens
   nieuwe Config.Camera en AntipunchCompatibility. Neem eigen locales over.
7. Start ox_lib/providers indien nodig, daarna ts_bridge, ts_antipunch, ts_hostage
   en de overige eerder gestopte scripts.

Vereiste configversie antipunch: 1.8.2. Bridgeconfigschema blijft 0.0.3.
De bridge-update laat je bestaande config.lua en server_config.lua staan.

Controleer de consoleversies: bridge 0.0.5, antipunch 1.8.2, hostage 1.1.9.
Test met twee spelers richten, herladen, slaan, gijzelen en loslaten; de dader
blijft tijdens de actieve gijzeling standaard in first person. Test ook beide
volgordes: eerst richtknop loslaten en eerst gijzelaar loslaten.

Voor GitHub: upload ook de versiebestanden. De zips publiceren niets automatisch.
