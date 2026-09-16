-- Troy Scripts | ts_antipunch | v1.8.1
Config = {}

-- Debugberichten in de F8-console.
Config.Debug = false

-- First person tijdens richten te voet. De voertuigcamera blijft ongemoeid.
Config.ForceFirstPerson = true
-- Herstel alleen camerawijzigingen die deze resource zelf heeft uitgevoerd.
-- Een vooraf zelf gekozen first-personstand blijft behouden.
Config.RestoreCamera = true
-- Terugvalstand: 0 = dichtbij, 1 = gemiddeld, 2 = ver, 4 = first person.
Config.DefaultCamera = 1
-- Vertraging in milliseconden; combat blijft ondertussen elke frame beschermd.
-- Gebruik een getal >= 0. Bij opnieuw richten vervalt het geplande herstel.
Config.CameraRestoreDelay = 50

Config.BlockShootingWithoutAim = true
Config.BlockMeleeWithoutAim = true
-- Blokkeer slaan met vuurwapens, ook tijdens richten. Herladen blijft mogelijk.
Config.DisableWeaponMelee = true
-- Extra melee-controls 143, 263 en 264 blokkeren wanneer melee geblokkeerd is.
Config.BlockExtraMeleeControls = true
-- Noodrem: breek een toch gestarte melee-actie met een vuurwapen direct af.
-- Dit onderbreekt de actieve ped-taken; zet uit bij animatieconflicten.
Config.CancelForcedMelee = true

-- GTA-control 25: richten, standaard rechtermuisknop / LT op controller.
Config.AimControl = 25

-- MainLoopWait en CameraCheckWait zijn vervallen:
-- combat draait altijd met Wait(0); de algemene camera-failsafe is verwijderd.

-- Eenmalige GitHub-updatecontrole bij het starten van de resource.
-- Alleen een melding; bestanden worden niet automatisch vervangen.
Config.UpdateCheck = {
    Enabled = true,
    Repository = 'troyenrobin-source/ts_antipunch',
    Branch = 'main'
}
