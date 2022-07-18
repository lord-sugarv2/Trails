LTrails = LTrails or {}
LTrails.Config = LTrails.Config or {}

Lords = Lords or {}
Lords.GameConfigs = Lords.GameConfigs or {}

hook.Add("PIXEL.UI.FullyLoaded", "LTrails:Loaded", function()
    PIXEL.LoadDirectoryRecursive("lords_trails")
end)