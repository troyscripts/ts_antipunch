-- Simuleert één melee-episode zonder FiveM.
local frames, handlers, secondary, immediate, melee = {}, {}, 0, 0, true
local ped = 17
Config = {Debug=false, ForceFirstPerson=false, AimControl=25,
    BlockShootingWithoutAim=true, BlockMeleeWithoutAim=true,
    DisableWeaponMelee=true, BlockExtraMeleeControls=true,
    CancelForcedMelee=true, RespectCombatContexts=true, MeleeCancelMode='secondary'}
TSBridgeGuard={Await=function() return true end, IsReady=function() return true end}
exports = {ts_bridge={
    GetCombatContext=function() return {} end, IsDead=function() return false end
}}
function AddEventHandler(name,fn) handlers[name]=fn end
function CreateThread(fn) frames[#frames+1]=fn end
function GetResourceState() return 'started' end
function GetCurrentResourceName() return 'ts_antipunch' end
function PlayerId() return 1 end
function PlayerPedId() return ped end
function DoesEntityExist() return true end
function IsPedInAnyVehicle() return false end
function IsControlPressed() return false end
function IsDisabledControlPressed() return false end
function IsPedArmed(_,flag) return flag==4 end
function IsPedInMeleeCombat() return melee end
function DisablePlayerFiring() end
local controls={}
function DisableControlAction(_,id) controls[id]=true end
function ClearPedSecondaryTask() secondary=secondary+1 end
function ClearPedTasksImmediately() immediate=immediate+1 end
function TSL(v) return v end
function Wait() coroutine.yield() end
dofile('client/main.lua')
assert(#frames==1)
local co=coroutine.create(frames[1])
local function frame() assert(coroutine.resume(co));assert(coroutine.resume(co)) end
frame()
assert(secondary==1 and immediate==0 and controls[140] and controls[141], 'secondary should cancel once and block attacks')
frame();frame()
assert(secondary==1, 'should not repeatedly clear tasks in same episode')
melee=false;frame()
melee=true;frame()
assert(secondary==2, 'new melee episode should cancel again')
handlers['ts_bridge:combatContextChanged']({suspendMeleeCancel=true})
melee=false;frame()
melee=true;frame()
assert(secondary==2, 'context should suspend cancellation')
handlers['ts_bridge:combatContextChanged']({})
frame()
assert(secondary==3, 'after context release cancellation should resume')
Config.MeleeCancelMode='immediate'
melee=false;frame();melee=true;frame()
assert(immediate==1, 'legacy mode should still be available')
assert(not controls[45], 'reload must remain free')
print('PASS melee cancellation, context suspension and reload')
