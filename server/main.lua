if not TSBridgeGuard.Await() then return end
print('[TroyScripts] [ts_antipunch] ' .. TSL('started', GetResourceMetadata(GetCurrentResourceName(), 'version', 0)))
if Config.UpdateCheck.Enabled then
    exports.ts_bridge:CheckForUpdates({
        Enabled = true, Repository = Config.UpdateCheck.Repository,
        Branch = Config.UpdateCheck.Branch, File = 'version.txt'
    })
end
