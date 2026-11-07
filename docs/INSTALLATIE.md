# Installatie — ts_antipunch 1.8.4

Deze release is een **volledige resource**, niet de oude gedeeltelijke 1.8.2-update.

1. Maak een back-up van je geïnstalleerde `ts_antipunch` en in het bijzonder je eigen `config.lua` (of `config/config.lua`).
2. Stop `ts_antipunch` en scripts die gezamenlijk gebruikmaken van bridgecamera en -combatcontext. Wijzigingen aan de bridge zelf zijn hiervoor niet nodig.
3. Verwijder de **oude** `ts_antipunch`-resourcefolder na de back-up, zodat oude rootbestanden niet blijven staan.
4. Pak het complete ZIP-pakket uit naar je FiveM-`resources`-map. Zorg dat de resourcemap exact `ts_antipunch` heet (dus niet `ts_antipunch-main`).
5. Neem je aangepaste instellingen over in de nieuwe `config/config.lua`. Het configuratieschema blijft `Config.Version = '1.8.3'` en de bridge-exportcontrole blijft ongewijzigd. Eigen vertalingen staan in `locales/nl.lua`.
6. Start `ox_lib`, daarna `ts_bridge`, vervolgens `ts_antipunch`. Start `ts_hostage` en overige afhankelijke resources daarna.
7. Controleer de console op de bridgecheck, `ts_antipunch`-startmelding en configuratieversie. Test op een testserver met minimaal twee spelers: richten, melee, herladen, cameraherstel, gijzelen/loslaten, doodgaan en herstarten.

```cfg
ensure ox_lib
ensure ts_bridge
ensure ts_antipunch
ensure ts_hostage  # alleen indien geïnstalleerd
```

## Geen nieuwe dependencies

Het script heeft geen eigen ESX-, ox_inventory-, ox_target- of SQL-afhankelijkheid. De bridge kan voor eigen functies wel aanvullende providers nodig hebben. `ts_bridge` moet een werkende GetStatus-API 1 en de vereiste camerafuncties bieden.

## Geen nieuwe schema-instellingen

Scriptversie **1.8.3** staat in `fxmanifest.lua` en `version.txt`. De configuratie blijft **1.8.2** en de controle in `shared/config_check.lua` blijft daarop gericht. **Wijzig Config.Version niet naar 1.8.3.**

## Terugzetten

Stop de resource, verwijder de nieuw geplaatste map, zet de back-up als `ts_antipunch` terug en start de afhankelijke resources in de juiste volgorde.

Zie [STRUCTUUR.md](STRUCTUUR.md) voor de nieuwe paden en [CHANGELOG.md](CHANGELOG.md) voor het onderhoud.

## Melee-noodrem 1.8.4

Neem `Config.MeleeCancelMode = 'secondary'` over in `config/config.lua`. Deze modus gebruikt voor vuurwapen-melee de secundaire taak-annulering en herhaalt die niet iedere frame. Als een server primaire melee-taken toch laat doorlopen, kun je `'immediate'` instellen voor het vorige gedrag. Verhoog pas daarna `Config.Version` naar `1.8.3`; de scriptversie is `1.8.4`.
