-- Troy Scripts | ts_antipunch 1.8.2 | vereist ts_bridge 0.0.5 en ox_lib
Config = {}
Config.Version = '1.8.2' -- configschema; pas eigen waarden in deze nieuwe config aan
Config.Locale = 'nl'
Config.Debug = false

-- Op jouw server blijft first person tijdens richten standaard VERPLICHT.
Config.ForceFirstPerson = true
-- false = bij elke richtknop te voet, inclusief vuisten/messen (bestaand gedrag).
-- true = uitsluitend als een vuurwapen wordt vastgehouden.
Config.FirstPersonOnlyFirearms = false
Config.RestoreCamera = true
Config.DefaultCamera = 1 -- 0 = dichtbij, 1 = gemiddeld, 2 = ver, 4 = first person
Config.CameraRestoreDelay = 50 -- 0 t/m 60000 ms; combat blijft elk frame actief

Config.BlockShootingWithoutAim = true
Config.BlockMeleeWithoutAim = true
Config.DisableWeaponMelee = true -- ook tijdens richten; herladen blijft vrij
Config.BlockExtraMeleeControls = true
Config.CancelForcedMelee = true -- noodrem: onderbreekt actieve ped-taken
-- Respecteer gerichte camerapauses/noodrempauses van andere scripts via ts_bridge.
-- ts_hostage pauzeert alleen de noodrem; first person blijft daarbij verplicht.
Config.RespectCombatContexts = true
Config.AimControl = 25 -- rechtermuisknop / LT; 0 t/m 360

Config.UpdateCheck = {
    Enabled = true,
    Repository = 'troyscripts/ts_antipunch',
    Branch = 'main'
}
