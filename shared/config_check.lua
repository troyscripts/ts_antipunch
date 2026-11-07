local defaults = {
    Version = '1.8.2', Locale = 'nl', Debug = false, ForceFirstPerson = true,
    FirstPersonOnlyFirearms = false, RestoreCamera = true, DefaultCamera = 1,
    CameraRestoreDelay = 50, BlockShootingWithoutAim = true, BlockMeleeWithoutAim = true,
    DisableWeaponMelee = true, BlockExtraMeleeControls = true, CancelForcedMelee = true,
    RespectCombatContexts = true, AimControl = 25
}
if type(Config) ~= 'table' then Config = {} end
local originalVersion = Config.Version
for key, default in pairs(defaults) do
    local value = Config[key]
    local valid = type(value) == type(default)
    if type(default) == 'number' then
        valid = valid and value == value and value % 1 == 0
        if key == 'DefaultCamera' then valid = valid and (value == 0 or value == 1 or value == 2 or value == 4)
        elseif key == 'AimControl' then valid = valid and value >= 0 and value <= 360
        else valid = valid and value >= 0 and value <= 60000 end
    elseif type(default) == 'string' then valid = valid and value ~= '' end
    if not valid then
        Config[key] = default
        if IsDuplicityVersion() then print(TSL('config_invalid', key, tostring(default))) end
    end
end
local updates = Config.UpdateCheck
if type(updates) ~= 'table' or type(updates.Enabled) ~= 'boolean'
    or (updates.Enabled and (type(updates.Repository) ~= 'string' or type(updates.Branch) ~= 'string')) then
    Config.UpdateCheck = { Enabled = false }
    if IsDuplicityVersion() then print(TSL('update_invalid')) end
end
if TSBridgeGuard.Await() then exports.ts_bridge:CheckConfigVersion(originalVersion, '1.8.2') end
