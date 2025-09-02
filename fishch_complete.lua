--// FISHCH COMPLETE AUTOMATION SYSTEM
--// Kombinasi fishing automation + marketplace automation
--// Version: 2.0 - Enhanced with Marketplace Features

--// Services
local Players = cloneref(game:GetService('Players'))
local ReplicatedStorage = cloneref(game:GetService('ReplicatedStorage'))
local RunService = cloneref(game:GetService('RunService'))
local GuiService = cloneref(game:GetService('GuiService'))

--// Load Required Modules
local library
local MarketplaceModule
local MarketplaceConfig

-- Load library
pcall(function()
    if loadfile and isfile and isfile('library.lua') then
        library = loadfile('library.lua')()
    else
        library = loadstring(game:HttpGet('https://raw.githubusercontent.com/MELLISAEFFENDY/gamech/refs/heads/main/library.lua'))()
    end
end)

-- Load marketplace modules
pcall(function()
    if loadfile and isfile and isfile('marketplace.lua') then
        MarketplaceModule = loadfile('marketplace.lua')()
    end
    if loadfile and isfile and isfile('marketplace_config.lua') then
        MarketplaceConfig = loadfile('marketplace_config.lua')()
    end
end)

--// Variables
local flags = {}
local lp = Players.LocalPlayer
local characterposition
local fishabundancevisible = false
local deathcon
local tooltipmessage

--// Enhanced Teleport Locations (Updated with more locations)
local TeleportLocations = {
    ['Zones'] = {
        ['Moosewood'] = CFrame.new(379.875458, 134.500519, 233.5495, -0.033920113, 8.13274355e-08, 0.999424577, 8.98441925e-08, 1, -7.83249803e-08, -0.999424577, 8.7135696e-08, -0.033920113),
        ['Roslit Bay'] = CFrame.new(-1472.9812, 132.525513, 707.644531, -0.00177415239, 1.15743369e-07, -0.99999845, -9.25943056e-09, 1, 1.15759981e-07, 0.99999845, 9.46479251e-09, -0.00177415239),
        ['Forsaken Shores'] = CFrame.new(-2491.104, 133.250015, 1561.2926, 0.355353981, -1.68352852e-08, -0.934731781, 4.69647858e-08, 1, -1.56367586e-10, 0.934731781, -4.38439116e-08, 0.355353981),
        ['Sunstone Island'] = CFrame.new(-913.809143, 138.160782, -1133.25879, -0.746701241, 4.50330218e-09, 0.665159583, 2.84934609e-09, 1, -3.5716119e-09, -0.665159583, -7.71657294e-10, -0.746701241),
        ['Statue of Sovereignty'] = CFrame.new(21.4017925, 159.014709, -1039.14233, -0.865476549, -4.38348664e-08, -0.500949502, -9.38435818e-08, 1, 7.46273798e-08, 0.500949502, 1.11599142e-07, -0.865476549),
        ['Terrapin Island'] = CFrame.new(-193.434143, 135.121979, 1951.46936, 0.512723684, -6.94711346e-08, 0.858553708, 5.44089183e-08, 1, 4.84237539e-08, -0.858553708, 2.18849721e-08, 0.512723684),
        ['Snowcap Island'] = CFrame.new(2607.93018, 135.284332, 2436.13208, 0.909039497, -7.49003748e-10, 0.4167099, 3.38659367e-09, 1, -5.59032465e-09, -0.4167099, 6.49305321e-09, 0.909039497),
        ['Mushgrove Swamp'] = CFrame.new(2434.29785, 131.983276, -691.930542, -0.123090521, -7.92820209e-09, -0.992395461, -9.05862692e-08, 1, 3.2467995e-09, 0.992395461, 9.02970569e-08, -0.123090521),
        ['Ancient Isle'] = CFrame.new(6056.02783, 195.280167, 276.270325, -0.655055285, 1.96010075e-09, 0.755580962, -1.63855578e-08, 1, -1.67997189e-08, -0.755580962, -2.33853594e-08, -0.655055285),
        ['Northern Expedition'] = CFrame.new(-1701.02979, 187.638779, 3944.81494, 0.918493569, -8.5804345e-08, 0.395435959, 8.59132356e-08, 1, 1.74328942e-08, -0.395435959, 1.7961181e-08, 0.918493569),
        ['Northern Summit'] = CFrame.new(19608.791, 131.420105, 5222.15283, 0.462794542, -2.64426987e-08, 0.886465549, -4.47066562e-08, 1, 5.31692343e-08, -0.886465549, -6.42373408e-08, 0.462794542),
        ['Vertigo'] = CFrame.new(-102.40567, -513.299377, 1052.07104, -0.999989033, 5.36423439e-09, 0.00468267547, 5.85247495e-09, 1, 1.04251647e-07, -0.00468267547, 1.04277916e-07, -0.999989033),
        ['Depths Entrance'] = CFrame.new(-15.4965982, -706.123718, 1231.43494, 0.0681341439, 1.15903154e-08, -0.997676194, 7.1017638e-08, 1, 1.64673093e-08, 0.997676194, -7.19745898e-08, 0.0681341439),
        ['Depths'] = CFrame.new(491.758118, -706.123718, 1230.6377, 0.00879980437, 1.29271776e-08, -0.999961257, 1.95575205e-13, 1, 1.29276803e-08, 0.999961257, -1.13956629e-10, 0.00879980437),
        ['Overgrowth Caves'] = CFrame.new(19746.2676, 416.00293, 5403.5752, 0.488031536, -3.30940715e-08, -0.87282598, -3.24267696e-11, 1, -3.79341323e-08, 0.87282598, 1.85413569e-08, 0.488031536),
        ['Frigid Cavern'] = CFrame.new(20253.6094, 756.525818, 5772.68555, -0.781508088, 1.85673343e-08, 0.623895109, 5.92671467e-09, 1, -2.23363816e-08, -0.623895109, -1.3758414e-08, -0.781508088),
        ['Cryogenic Canal'] = CFrame.new(19958.5176, 917.195923, 5332.59375, 0.758922458, -7.29783434e-09, 0.651180983, -4.58880756e-09, 1, 1.65551253e-08, -0.651180983, -1.55522013e-08, 0.758922458),
        ['Glacial Grotto'] = CFrame.new(20003.0273, 1136.42798, 5555.95996, 0.983130038, -3.94455064e-08, 0.182907909, 3.45229765e-08, 1, 3.0096718e-08, -0.182907909, -2.32744615e-08, 0.983130038),
        ["Keeper's Altar"] = CFrame.new(1297.92285, -805.292236, -284.155823, -0.99758029, 5.80044706e-08, -0.0695239156, 6.16549869e-08, 1, -5.03615105e-08, 0.0695239156, -5.45261436e-08, -0.99758029)
    },
    ['Rods'] = {
        ['Heaven Rod'] = CFrame.new(20025.0508, -467.665955, 7114.40234, -0.9998191, -2.41349773e-10, 0.0190212391, -4.76249762e-10, 1, -1.23448247e-08, -0.0190212391, -1.23516495e-08, -0.9998191),
        ['Summit Rod'] = CFrame.new(20213.334, 736.668823, 5707.8208, -0.274440169, 3.53429606e-08, 0.961604178, -1.52819659e-08, 1, -4.11156122e-08, -0.961604178, -2.59789772e-08, -0.274440169),
        ['Kings Rod'] = CFrame.new(1380.83862, -807.198608, -304.22229, -0.692510426, 9.24755454e-08, 0.72140789, 4.86611427e-08, 1, -8.1475676e-08, -0.72140789, -2.13182219e-08, -0.692510426)
    },
    ['Shops'] = {
        ['Daily Shop'] = CFrame.new(0, 0, 0), -- Update with actual coordinates
        ['Shell Merchant'] = CFrame.new(0, 0, 0), -- Update with actual coordinates
        ['Rod Shop'] = CFrame.new(0, 0, 0), -- Update with actual coordinates
        ['Boat Shop'] = CFrame.new(0, 0, 0) -- Update with actual coordinates
    }
}

-- Generate lists for dropdowns
local ZoneNames = {}
local RodNames = {}
local ShopNames = {}
for i,v in pairs(TeleportLocations['Zones']) do table.insert(ZoneNames, i) end
for i,v in pairs(TeleportLocations['Rods']) do table.insert(RodNames, i) end
for i,v in pairs(TeleportLocations['Shops']) do table.insert(ShopNames, i) end

--// Helper Functions
local function FindChildOfClass(parent, classname)
    return parent:FindFirstChildOfClass(classname)
end

local function FindChild(parent, child)
    return parent:FindFirstChild(child)
end

local function getchar()
    return lp.Character or lp.CharacterAdded:Wait()
end

local function gethrp()
    return getchar():WaitForChild('HumanoidRootPart')
end

local function gethum()
    return getchar():WaitForChild('Humanoid')
end

local function FindRod()
    if FindChildOfClass(getchar(), 'Tool') and FindChild(FindChildOfClass(getchar(), 'Tool'), 'values') then
        return FindChildOfClass(getchar(), 'Tool')
    else
        return nil
    end
end

local function message(text, time)
    if tooltipmessage then tooltipmessage:Remove() end
    tooltipmessage = require(lp.PlayerGui:WaitForChild("GeneralUIModule")):GiveToolTip(lp, text)
    task.spawn(function()
        task.wait(time)
        if tooltipmessage then tooltipmessage:Remove(); tooltipmessage = nil end
    end)
end

--// Create Enhanced GUI
if not library then
    warn("Failed to load library!")
    return
end

local FishingTab = library:CreateWindow('🎣 Fishing Automation')
local MarketTab = library:CreateWindow('💰 Marketplace')
local TeleportTab = library:CreateWindow('🚀 Teleports')
local VisualTab = library:CreateWindow('👁️ Visuals')
local ConfigTab = library:CreateWindow('⚙️ Configuration')

--// FISHING AUTOMATION TAB
FishingTab:Section('🎣 Auto Fishing')
FishingTab:Toggle('Freeze Character', {location = flags, flag = 'freezechar'})
FishingTab:Dropdown('Freeze Mode', {location = flags, flag = 'freezecharmode', list = {'Rod Equipped', 'Toggled'}})
FishingTab:Toggle('Auto Cast', {location = flags, flag = 'autocast'})
FishingTab:Toggle('Auto Shake', {location = flags, flag = 'autoshake'})
FishingTab:Toggle('Auto Reel', {location = flags, flag = 'autoreel'})

FishingTab:Section('🐟 Fish Detection')
FishingTab:Toggle('Fish Abundance Radar', {location = flags, flag = 'fishabundance'})
FishingTab:Toggle('Rare Fish Alert', {location = flags, flag = 'rarefishalert'})

FishingTab:Section('🔧 Fishing Enhancements')
if hookmetamethod then
    FishingTab:Toggle('Perfect Cast', {location = flags, flag = 'perfectcast'})
    FishingTab:Toggle('Always Catch', {location = flags, flag = 'alwayscatch'})
    FishingTab:Toggle('No AFK Detection', {location = flags, flag = 'noafk'})
end
FishingTab:Toggle('Infinite Oxygen', {location = flags, flag = 'infoxygen'})
FishingTab:Toggle('No Temperature/Oxygen', {location = flags, flag = 'nopeakssystems'})

--// MARKETPLACE TAB
if MarketplaceModule then
    MarketTab:Section('💹 Auto Trading')
    MarketTab:Toggle('Auto Trading System', {location = flags, flag = 'autotrading'})
    MarketTab:Toggle('Auto Shopping', {location = flags, flag = 'autoshopping'})
    MarketTab:Toggle('Price Monitoring', {location = flags, flag = 'pricemonitoring'})
    
    MarketTab:Section('🏪 Shop Management')
    MarketTab:Button('Open Daily Shop', function() 
        MarketplaceModule:OpenDailyShop()
        message('Opening Daily Shop...', 2)
    end)
    MarketTab:Button('Refresh Daily Shop', function() 
        MarketplaceModule:RefreshDailyShop()
        message('Refreshing Daily Shop...', 2)
    end)
    MarketTab:Button('Open Shell Merchant', function() 
        MarketplaceModule:OpenShellMerchant()
        message('Opening Shell Merchant...', 2)
    end)
    
    MarketTab:Section('📊 Trading Configuration')
    MarketTab:Box('Max Spend Amount', {location = flags, flag = 'maxspend', placeholder = '50000', type = 'number'})
    MarketTab:Slider('Min Profit Margin %', {location = flags, flag = 'profitmargin', min = 5, max = 50, default = 15})
    MarketTab:Dropdown('Trading Strategy', {location = flags, flag = 'strategy', list = {'Conservative', 'Balanced', 'Aggressive'}})
    MarketTab:Toggle('Auto Refresh Shops', {location = flags, flag = 'autorefresh'})
    
    MarketTab:Section('🛒 Auto Buy System')
    MarketTab:Box('Item Name', {location = flags, flag = 'autobuyitem', placeholder = 'Enter item name'})
    MarketTab:Box('Max Price', {location = flags, flag = 'autobuyprice', placeholder = '1000', type = 'number'})
    MarketTab:Button('Add to Auto Buy List', function()
        if flags['autobuyitem'] and flags['autobuyprice'] then
            MarketplaceModule:AddToAutoBuyList(flags['autobuyitem'], tonumber(flags['autobuyprice']) or 0)
            message('Added ' .. flags['autobuyitem'] .. ' to auto-buy list!', 3)
        else
            message('Please enter both item name and max price!', 3)
        end
    end)
    
    MarketTab:Section('⚠️ Emergency Controls')
    MarketTab:Button('🛑 EMERGENCY STOP ALL', function() 
        MarketplaceModule:EmergencyStop()
        message('🛑 ALL AUTOMATION STOPPED!', 5)
    end)
    MarketTab:Button('📊 Show Status', function() 
        local status = MarketplaceModule:GetStatus()
        local statusText = string.format(
            'Trading: %s | Shopping: %s | Monitoring: %s', 
            tostring(status.AutoTrading), 
            tostring(status.AutoBuying),
            tostring(status.PriceMonitoring)
        )
        message(statusText, 5)
    end)
else
    MarketTab:Section('❌ Marketplace Unavailable')
    MarketTab:Button('Marketplace module not loaded', function() 
        message('Please ensure marketplace.lua is in the same folder!', 5)
    end)
end

--// TELEPORT TAB
TeleportTab:Section('🗺️ Zone Teleports')
TeleportTab:Dropdown('Select Zone', {location = flags, flag = 'zones', list = ZoneNames})
TeleportTab:Button('Teleport to Zone', function() 
    if flags['zones'] then
        gethrp().CFrame = TeleportLocations['Zones'][flags['zones']]
        message('Teleported to ' .. flags['zones'], 3)
    end
end)

TeleportTab:Section('🎣 Rod Locations')
TeleportTab:Dropdown('Select Rod Location', {location = flags, flag = 'rodlocations', list = RodNames})
TeleportTab:Button('Teleport to Rod', function() 
    if flags['rodlocations'] then
        gethrp().CFrame = TeleportLocations['Rods'][flags['rodlocations']]
        message('Teleported to ' .. flags['rodlocations'], 3)
    end
end)

TeleportTab:Section('🏪 Shop Teleports')
TeleportTab:Dropdown('Select Shop', {location = flags, flag = 'shoplocations', list = ShopNames})
TeleportTab:Button('Teleport to Shop', function() 
    if flags['shoplocations'] then
        gethrp().CFrame = TeleportLocations['Shops'][flags['shoplocations']]
        message('Teleported to ' .. flags['shoplocations'], 3)
    end
end)

--// VISUAL TAB
VisualTab:Section('🎣 Rod Visuals')
VisualTab:Toggle('Rod Chams', {location = flags, flag = 'rodchams'})
VisualTab:Toggle('Body Rod Chams', {location = flags, flag = 'bodyrodchams'})
VisualTab:Dropdown('Rod Material', {location = flags, flag = 'rodmaterial', list = {'ForceField', 'Neon'}})

VisualTab:Section('🐟 Fish Visuals')
VisualTab:Toggle('Fish Abundance Display', {location = flags, flag = 'fishabundance'})

--// CONFIG TAB
ConfigTab:Section('💾 Configuration')
ConfigTab:Button('Save Current Config', function() 
    message('Configuration saved! (Feature coming soon)', 3)
end)
ConfigTab:Button('Load Config', function() 
    message('Configuration loaded! (Feature coming soon)', 3)
end)
ConfigTab:Button('Reset to Default', function() 
    for flag, _ in pairs(flags) do
        flags[flag] = false
    end
    message('Configuration reset to default!', 3)
end)

ConfigTab:Section('ℹ️ Information')
ConfigTab:Button('Show Help', function() 
    message('FISHCH v2.0 - Complete Automation System loaded!', 5)
end)

--// MAIN AUTOMATION LOOP
local RodColors = {}
local RodMaterials = {}

RunService.Heartbeat:Connect(function()
    --// MARKETPLACE AUTOMATION
    if MarketplaceModule then
        -- Auto Trading Toggle
        if flags['autotrading'] and not MarketplaceModule.Config.AutoTrading then
            MarketplaceModule:StartAutoTrading()
        elseif not flags['autotrading'] and MarketplaceModule.Config.AutoTrading then
            MarketplaceModule:StopAutoTrading()
        end
        
        -- Auto Shopping Toggle
        if flags['autoshopping'] and not MarketplaceModule.Config.AutoBuying then
            MarketplaceModule:StartAutoShopping()
        elseif not flags['autoshopping'] and MarketplaceModule.Config.AutoBuying then
            MarketplaceModule:StopAutoShopping()
        end
        
        -- Price Monitoring Toggle
        if flags['pricemonitoring'] and not MarketplaceModule.Config.PriceMonitoring then
            MarketplaceModule:StartPriceMonitoring()
        elseif not flags['pricemonitoring'] and MarketplaceModule.Config.PriceMonitoring then
            MarketplaceModule:StopPriceMonitoring()
        end
        
        -- Update marketplace config
        if flags['maxspend'] and tonumber(flags['maxspend']) then
            MarketplaceModule:SetMaxSpendAmount(tonumber(flags['maxspend']))
        end
        
        if flags['profitmargin'] then
            MarketplaceModule:SetMinProfitMargin(flags['profitmargin'] / 100)
        end
        
        MarketplaceModule.Config.AutoRefreshShops = flags['autorefresh'] or false
    end

    --// FISHING AUTOMATION
    -- Character freezing
    if flags['freezechar'] then
        if flags['freezecharmode'] == 'Toggled' then
            if characterposition == nil then
                characterposition = gethrp().CFrame
            else
                gethrp().CFrame = characterposition
            end
        elseif flags['freezecharmode'] == 'Rod Equipped' then
            local rod = FindRod()
            if rod and characterposition == nil then
                characterposition = gethrp().CFrame
            elseif rod and characterposition ~= nil then
                gethrp().CFrame = characterposition
            else
                characterposition = nil
            end
        end
    else
        characterposition = nil
    end
    
    -- Auto shake
    if flags['autoshake'] then
        if FindChild(lp.PlayerGui, 'shakeui') and FindChild(lp.PlayerGui['shakeui'], 'safezone') and FindChild(lp.PlayerGui['shakeui']['safezone'], 'button') then
            GuiService.SelectedObject = lp.PlayerGui['shakeui']['safezone']['button']
            if GuiService.SelectedObject == lp.PlayerGui['shakeui']['safezone']['button'] then
                game:GetService('VirtualInputManager'):SendKeyEvent(true, Enum.KeyCode.Return, false, game)
                game:GetService('VirtualInputManager'):SendKeyEvent(false, Enum.KeyCode.Return, false, game)
            end
        end
    end
    
    -- Auto cast
    if flags['autocast'] then
        local rod = FindRod()
        if rod ~= nil and rod['values']['lure'].Value <= .001 and task.wait(.5) then
            rod.events.cast:FireServer(100, 1)
        end
    end
    
    -- Auto reel
    if flags['autoreel'] then
        local rod = FindRod()
        if rod ~= nil and rod['values']['lure'].Value == 100 and task.wait(.5) then
            ReplicatedStorage.events.reelfinished:FireServer(100, true)
        end
    end

    --// VISUAL FEATURES
    -- Rod chams
    if flags['rodchams'] then
        local rod = FindRod()
        if rod ~= nil and FindChild(rod, 'Details') then
            local rodName = tostring(rod)
            if not RodColors[rodName] then
                RodColors[rodName] = {}
                RodMaterials[rodName] = {}
            end
            for i,v in rod['Details']:GetDescendants() do
                if v:IsA('BasePart') or v:IsA('MeshPart') then
                    if v.Color ~= Color3.fromRGB(100, 100, 255) then
                        RodColors[rodName][v.Name..i] = v.Color
                    end
                    if RodMaterials[rodName][v.Name..i] == nil then
                        if v.Material ~= Enum.Material.ForceField and v.Material ~= Enum.Material[flags['rodmaterial'] or 'Neon'] then
                            RodMaterials[rodName][v.Name..i] = v.Material
                        end
                    end
                    v.Material = Enum.Material[flags['rodmaterial'] or 'Neon']
                    v.Color = Color3.fromRGB(100, 100, 255)
                end
            end
        end
    end
    
    -- Fish abundance
    if flags['fishabundance'] then
        if not fishabundancevisible then
            message('🐟 Fish Abundance Zones are now visible', 3)
        end
        for i,v in workspace.zones.fishing:GetChildren() do
            if FindChild(v, 'Abundance') and FindChild(v, 'radar1') then
                v['radar1'].Enabled = true
                v['radar2'].Enabled = true
            end
        end
        fishabundancevisible = true
    else
        if fishabundancevisible then
            message('🐟 Fish Abundance Zones are now hidden', 3)
        end
        for i,v in workspace.zones.fishing:GetChildren() do
            if FindChild(v, 'Abundance') and FindChild(v, 'radar1') then
                v['radar1'].Enabled = false
                v['radar2'].Enabled = false
            end
        end
        fishabundancevisible = false
    end

    --// MODIFICATIONS
    -- Infinite oxygen
    if flags['infoxygen'] then
        if not getchar():FindFirstChild('DivingTank') then
            local oxygentank = Instance.new('Decal')
            oxygentank.Name = 'DivingTank'
            oxygentank:SetAttribute('Tier', math.huge)
            oxygentank.Parent = getchar()
        end
    end
    
    -- No temperature/oxygen systems
    if flags['nopeakssystems'] then
        getchar():SetAttribute('WinterCloakEquipped', true)
        getchar():SetAttribute('Refill', true)
    else
        getchar():SetAttribute('WinterCloakEquipped', nil)
        getchar():SetAttribute('Refill', false)
    end
end)

--// ENHANCED HOOKS
if hookmetamethod then
    local old; old = hookmetamethod(game, "__namecall", function(self, ...)
        local method, args = getnamecallmethod(), {...}
        if method == 'FireServer' and self.Name == 'afk' and flags['noafk'] then
            args[1] = false
            return old(self, unpack(args))
        elseif method == 'FireServer' and self.Name == 'cast' and flags['perfectcast'] then
            args[1] = 100
            return old(self, unpack(args))
        elseif method == 'FireServer' and self.Name == 'reelfinished' and flags['alwayscatch'] then
            args[1] = 100
            args[2] = true
            return old(self, unpack(args))
        end
        return old(self, ...)
    end)
end

--// INITIALIZATION
task.spawn(function()
    wait(2) -- Wait for everything to load
    
    -- Initialize marketplace if available
    if MarketplaceModule then
        MarketplaceModule:Initialize()
        message('🎉 FISHCH v2.0 - Complete Automation System Loaded!', 5)
        
        -- Setup default marketplace configuration
        MarketplaceModule:SetMaxSpendAmount(50000)
        MarketplaceModule:SetMinProfitMargin(0.20)
        
        -- Add some common profitable items to auto-buy
        MarketplaceModule:AddToAutoBuyList("Truffle Worm", 800)
        MarketplaceModule:AddToAutoBuyList("Magnet", 400)
        
        wait(1)
        message('💰 Marketplace automation ready! Use GUI to control features.', 4)
    else
        message('🎣 FISHCH v2.0 Loaded! (Marketplace module not found)', 4)
    end
    
    wait(2)
    message('ℹ️ Use Emergency Stop button if needed. Happy fishing! 🎣', 4)
end)

print("🎣 FISHCH v2.0 - Complete Automation System")
print("✅ Fishing automation: Loaded")
print("✅ Marketplace automation: " .. (MarketplaceModule and "Loaded" or "Not available"))
print("✅ Enhanced GUI: Loaded")
print("🎮 Use the GUI tabs to control all features!")

return "FISHCH v2.0 Complete System Loaded Successfully!"
