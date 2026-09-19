-- Troy Scripts | ts_antipunch | 1.8.2
if not TSBridgeGuard.Await() then return end
local cameraRequested, lastPed, aiming = false, nil, false
local context = exports.ts_bridge:GetCombatContext()
local function DebugPrint(message)
    if Config.Debug then print(('^3[ts_antipunch DEBUG]^7 %s'):format(message)) end
end
local function ReleaseCamera(forceRestore)
    if cameraRequested and GetResourceState('ts_bridge') == 'started' then
        pcall(function() exports.ts_bridge:ReleaseFirstPerson('aim', forceRestore == true) end)
    end
    cameraRequested = false
end
local function UpdateCamera(shouldForce)
    if shouldForce and not cameraRequested then
        cameraRequested = exports.ts_bridge:RequestFirstPerson('aim', {
            scope = 'ped', restore = Config.RestoreCamera,
            restoreDelayMs = Config.CameraRestoreDelay, defaultCamera = Config.DefaultCamera
        }) == true
    elseif not shouldForce and cameraRequested then ReleaseCamera(false) end
end
AddEventHandler('ts_bridge:combatContextChanged', function(value)
    if type(value) == 'table' then context = value end
end)
local function BlockCombat(player, ped, aimPressed, inVehicle)
    if Config.BlockShootingWithoutAim and not aimPressed then
        DisablePlayerFiring(player, true)
        DisableControlAction(0, 24, true)  -- INPUT_ATTACK
        DisableControlAction(0, 257, true) -- INPUT_ATTACK2
        if inVehicle then
            -- Voertuigaanvallen horen bij de schietblokkering, niet bij melee.
            DisableControlAction(0, 69, true)
            DisableControlAction(0, 70, true)
            DisableControlAction(0, 92, true)
            DisableControlAction(0, 114, true)
        end
    end

    -- Vuisten en melee-wapens kunnen ook via INPUT_ATTACK aanvallen.
    -- Houd deze blokkering onafhankelijk van de schietinstelling.
    if Config.BlockMeleeWithoutAim and not aimPressed and not inVehicle
        and not IsPedArmed(ped, 6) then
        DisableControlAction(0, 24, true)
        DisableControlAction(0, 257, true)
    end

    local blockWeaponMelee = Config.DisableWeaponMelee and IsPedArmed(ped, 4)
    local blockMelee = blockWeaponMelee or (Config.BlockMeleeWithoutAim and not aimPressed)
    if blockMelee then
        DisableControlAction(0, 140, true) -- INPUT_MELEE_ATTACK_LIGHT
        DisableControlAction(0, 141, true) -- INPUT_MELEE_ATTACK_HEAVY
        DisableControlAction(0, 142, true) -- INPUT_MELEE_ATTACK_ALTERNATE
        if Config.BlockExtraMeleeControls then
            DisableControlAction(0, 143, true) -- INPUT_MELEE_BLOCK
            DisableControlAction(0, 263, true) -- INPUT_MELEE_ATTACK1
            DisableControlAction(0, 264, true) -- INPUT_MELEE_ATTACK2
        end
    end

    -- Control 45 (herladen) blijft vrij. Alleen daadwerkelijk gestarte
    -- vuurwapen-melee afbreken; gewone vuist-/mesgevechten niet annuleren.
    if blockWeaponMelee and Config.CancelForcedMelee and not (Config.RespectCombatContexts and context.suspendMeleeCancel)
        and IsPedInMeleeCombat(ped) then
        ClearPedTasksImmediately(ped)
        DebugPrint(TSL('melee_cancelled'))
    end
end

CreateThread(function()
    while true do
        Wait(0) -- controlblokkeringen moeten iedere frame worden toegepast
        if TSBridgeGuard.IsReady() then
            local player, ped = PlayerId(), PlayerPedId()
            if lastPed ~= ped then ReleaseCamera(true); lastPed = ped end
            if DoesEntityExist(ped) and not exports.ts_bridge:IsDead(ped) then
                local inVehicle = IsPedInAnyVehicle(ped, false)
                local aimPressed = IsControlPressed(0, Config.AimControl)
                if inVehicle then
                    aimPressed = aimPressed or IsControlPressed(0, 68) or IsControlPressed(0, 91)
                end
                if aimPressed ~= aiming then
                    aiming = aimPressed
                    DebugPrint(TSL(aiming and 'aim_started' or 'aim_stopped'))
                end
                BlockCombat(player, ped, aimPressed, inVehicle)
                local cameraAim = aimPressed
                -- Een script kan richten blokkeren tijdens een pose; gebruik de knop
                -- dan alleen voor camerakeuze, nooit om schieten vrij te geven.
                if not inVehicle then cameraAim = cameraAim or IsDisabledControlPressed(0, Config.AimControl) end
                UpdateCamera(Config.ForceFirstPerson and cameraAim and not inVehicle
                    and (not Config.FirstPersonOnlyFirearms or IsPedArmed(ped, 4))
                    and not (Config.RespectCombatContexts and context.suspendCamera))
            else
                aiming = false
                ReleaseCamera(true)
            end
        else
            ReleaseCamera(true)
        end
    end
end)
AddEventHandler('onClientResourceStop', function(name)
    if name == GetCurrentResourceName() then ReleaseCamera(true) end
end)
AddEventHandler('ts_antipunch:bridgeLost', function() ReleaseCamera(true) end)
