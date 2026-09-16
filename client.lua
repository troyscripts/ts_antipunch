-- Troy Scripts | ts_antipunch | v1.8.0

local cameraOwned = false
local previousViewMode = nil
local restoreAt = nil
local lastPed = nil
local aiming = false

local function DebugPrint(message)
    if Config.Debug then
        print(('^3[ts_antipunch DEBUG]^7 %s'):format(message))
    end
end

local function ReleaseCamera(forceRestore)
    -- Alleen herstellen wanneer deze resource zelf de camera heeft veranderd.
    if cameraOwned and (forceRestore or Config.RestoreCamera) then
        -- Een inmiddels gewijzigde camerastand van een ander script respecteren.
        if GetFollowPedCamViewMode() == 4 then
            SetFollowPedCamViewMode(previousViewMode or Config.DefaultCamera)
            DebugPrint('Vorige camera hersteld')
        end
    end
    cameraOwned = false
    previousViewMode = nil
    restoreAt = nil
end

local function UpdateCamera(shouldForce)
    if shouldForce then
        restoreAt = nil
        local currentView = GetFollowPedCamViewMode()
        if currentView ~= 4 then
            if not cameraOwned then
                previousViewMode = currentView
                cameraOwned = true
                DebugPrint(('Camera opgeslagen: %s'):format(currentView))
            end
            SetFollowPedCamViewMode(4)
        end
    elseif cameraOwned then
        if not Config.RestoreCamera then
            ReleaseCamera(false)
        else
            restoreAt = restoreAt or (GetGameTimer() + Config.CameraRestoreDelay)
            if GetGameTimer() >= restoreAt then
                ReleaseCamera(false)
            end
        end
    end
end

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
    if blockWeaponMelee and Config.CancelForcedMelee and IsPedInMeleeCombat(ped) then
        ClearPedTasksImmediately(ped)
        DebugPrint('Vuurwapen-melee geannuleerd')
    end
end

CreateThread(function()
    while true do
        -- Controlblokkeringen moeten elke frame opnieuw worden toegepast.
        Wait(0)
        local player = PlayerId()
        local ped = PlayerPedId()
        if lastPed ~= ped then
            ReleaseCamera(true)
            lastPed = ped
        end

        if DoesEntityExist(ped) and not IsEntityDead(ped) then
            local inVehicle = IsPedInAnyVehicle(ped, false)
            local aimPressed = IsControlPressed(0, Config.AimControl)
            if inVehicle then
                aimPressed = aimPressed or IsControlPressed(0, 68) or IsControlPressed(0, 91)
            end
            if aimPressed ~= aiming then
                aiming = aimPressed
                DebugPrint(aiming and 'Aim gestart' or 'Aim gestopt')
            end

            -- Combat blijft actief tijdens de cameravertraging.
            BlockCombat(player, ped, aimPressed, inVehicle)
            if inVehicle then
                ReleaseCamera(false)
            else
                UpdateCamera(Config.ForceFirstPerson and aimPressed)
            end
        else
            aiming = false
            ReleaseCamera(true)
        end
    end
end)

AddEventHandler('onResourceStop', function(resourceName)
    if resourceName == GetCurrentResourceName() then
        ReleaseCamera(true)
    end
end)
