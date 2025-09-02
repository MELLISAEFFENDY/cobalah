--// Advanced Inventory Exploits Usage Example
--// How to implement and use the Advanced Inventory Exploits module

local Players = cloneref(game:GetService('Players'))
local lp = Players.LocalPlayer

--// Load the Advanced Inventory Exploits Module
local InventoryExploits
local success, result = pcall(function()
    if loadfile and isfile and isfile('advanced_inventory_exploits.lua') then
        InventoryExploits = loadfile('advanced_inventory_exploits.lua')()
    elseif readfile and isfile and isfile('advanced_inventory_exploits.lua') then
        InventoryExploits = loadstring(readfile('advanced_inventory_exploits.lua'))()
    end
end)

if success and InventoryExploits then
    print("✅ Advanced Inventory Exploits Module loaded successfully!")
else
    warn("❌ Failed to load Advanced Inventory Exploits Module")
    return
end

--// Initialize the module
InventoryExploits:Initialize()

--// UI Integration Example (for integration with existing UI)
local function createInventoryExploitsUI()
    -- This function shows how to integrate with your existing UI system
    
    --// Example with basic flags system
    local flags = {}
    
    -- Create UI sections (adapt this to your UI library)
    -- InventoryTab:Section('Advanced Inventory Exploits')
    
    -- 1. Inventory Duplicator Controls
    -- InventoryTab:Toggle('Inventory Duplicator', {location = flags, flag = 'inventoryduplicator'})
    -- InventoryTab:Slider('Max Duplicates', {location = flags, flag = 'maxduplicates', min = 1, max = 999, default = 99})
    -- InventoryTab:Slider('Duplicate Delay', {location = flags, flag = 'duplicatedelay', min = 0.1, max = 5, default = 1})
    
    -- 2. Auto Item Collector Controls
    -- InventoryTab:Toggle('Auto Item Collector', {location = flags, flag = 'autoitemcollector'})
    -- InventoryTab:Slider('Collect Delay', {location = flags, flag = 'collectdelay', min = 0.1, max = 2, default = 0.5})
    -- InventoryTab:Slider('Teleport Radius', {location = flags, flag = 'teleportradius', min = 100, max = 5000, default = 1000})
    
    -- 3. Skin Unlocker Controls
    -- InventoryTab:Button('Unlock All Skins', function() InventoryExploits:StartSkinUnlocker() end)
    -- InventoryTab:Button('Unlock Rod Skins Only', function() InventoryExploits:UnlockSkinType("Rod") end)
    
    -- 4. Auto Equipment Optimizer Controls
    -- InventoryTab:Toggle('Auto Equipment Optimizer', {location = flags, flag = 'autoequipper'})
    -- InventoryTab:Toggle('Auto Equip Best Gear', {location = flags, flag = 'autoequipbestgear'})
    
    -- 5. Item Teleporter Controls
    -- InventoryTab:Toggle('Item Teleporter', {location = flags, flag = 'itemteleporter'})
    
    -- Control Buttons
    -- InventoryTab:Button('Start All Systems', function() InventoryExploits:StartAllSystems() end)
    -- InventoryTab:Button('Stop All Systems', function() InventoryExploits:StopAllSystems() end)
    -- InventoryTab:Button('Emergency Stop', function() InventoryExploits:EmergencyStop() end)
    
    -- Status Display
    -- InventoryTab:Button('Show Status', function() 
    --     local status = InventoryExploits:GetStatus()
    --     print("Inventory Exploits Status:")
    --     for key, value in pairs(status) do
    --         print("  " .. key .. ": " .. tostring(value))
    --     end
    -- end)
    
    return flags
end

--// Manual Control Functions (for testing or direct usage)
local function manualControls()
    print("\n🎮 MANUAL CONTROLS AVAILABLE:")
    print("Use these functions in the console or bind them to keys")
    
    -- Inventory Duplicator
    _G.StartDuplicator = function()
        InventoryExploits:StartInventoryDuplicator()
        print("✅ Inventory Duplicator Started")
    end
    
    _G.StopDuplicator = function()
        InventoryExploits:StopInventoryDuplicator()
        print("❌ Inventory Duplicator Stopped")
    end
    
    -- Auto Item Collector
    _G.StartCollector = function()
        InventoryExploits:StartAutoItemCollector()
        print("✅ Auto Item Collector Started")
    end
    
    _G.StopCollector = function()
        InventoryExploits:StopAutoItemCollector()
        print("❌ Auto Item Collector Stopped")
    end
    
    -- Skin Unlocker
    _G.UnlockAllSkins = function()
        InventoryExploits:StartSkinUnlocker()
        print("✅ Unlocking All Skins...")
    end
    
    _G.UnlockRodSkins = function()
        InventoryExploits:UnlockSkinType("Rod")
        print("✅ Unlocking Rod Skins...")
    end
    
    -- Auto Equipment Optimizer
    _G.StartAutoEquip = function()
        InventoryExploits:StartAutoEquipper()
        print("✅ Auto Equipment Optimizer Started")
    end
    
    _G.StopAutoEquip = function()
        InventoryExploits:StopAutoEquipper()
        print("❌ Auto Equipment Optimizer Stopped")
    end
    
    -- Item Teleporter
    _G.StartTeleporter = function()
        InventoryExploits:StartItemTeleporter()
        print("✅ Item Teleporter Started")
    end
    
    _G.StopTeleporter = function()
        InventoryExploits:StopItemTeleporter()
        print("❌ Item Teleporter Stopped")
    end
    
    -- All Systems Control
    _G.StartAllInventoryExploits = function()
        InventoryExploits:StartAllSystems()
        print("✅ All Inventory Exploits Started")
    end
    
    _G.StopAllInventoryExploits = function()
        InventoryExploits:StopAllSystems()
        print("❌ All Inventory Exploits Stopped")
    end
    
    -- Emergency Stop
    _G.EmergencyStopInventory = function()
        InventoryExploits:EmergencyStop()
        print("🚨 EMERGENCY STOP - All Inventory Systems Halted")
    end
    
    -- Status Check
    _G.InventoryStatus = function()
        local status = InventoryExploits:GetStatus()
        print("\n📊 INVENTORY EXPLOITS STATUS:")
        print("├─ Inventory Duplicator: " .. (status.InventoryDuplicator and "🟢 ACTIVE" or "🔴 INACTIVE"))
        print("├─ Auto Item Collector: " .. (status.AutoItemCollector and "🟢 ACTIVE" or "🔴 INACTIVE"))
        print("├─ Skin Unlocker: " .. (status.SkinUnlocker and "🟢 ACTIVE" or "🔴 INACTIVE"))
        print("├─ Auto Equipper: " .. (status.AutoEquipper and "🟢 ACTIVE" or "🔴 INACTIVE"))
        print("├─ Item Teleporter: " .. (status.ItemTeleporter and "🟢 ACTIVE" or "🔴 INACTIVE"))
        print("├─ Collected Items: " .. status.CollectedItems)
        print("└─ Duplicated Items: " .. status.DuplicatedItems)
    end
    
    -- Configuration Functions
    _G.SetCollectDelay = function(delay)
        InventoryExploits:SetCollectDelay(delay)
        print("⚙️ Collect delay set to: " .. delay)
    end
    
    _G.SetDuplicateDelay = function(delay)
        InventoryExploits:SetDuplicateDelay(delay)
        print("⚙️ Duplicate delay set to: " .. delay)
    end
    
    _G.SetMaxDuplicates = function(max)
        InventoryExploits:SetMaxDuplicates(max)
        print("⚙️ Max duplicates set to: " .. max)
    end
    
    _G.SetTeleportRadius = function(radius)
        InventoryExploits:SetTeleportRadius(radius)
        print("⚙️ Teleport radius set to: " .. radius)
    end
    
    print("\n📋 USAGE EXAMPLES:")
    print("_G.StartAllInventoryExploits() -- Start all systems")
    print("_G.InventoryStatus() -- Check status")
    print("_G.UnlockAllSkins() -- Unlock all skins")
    print("_G.SetTeleportRadius(2000) -- Set teleport radius to 2000")
    print("_G.EmergencyStopInventory() -- Emergency stop")
end

--// Keybind Setup (optional)
local function setupKeybinds()
    local UserInputService = cloneref(game:GetService('UserInputService'))
    
    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if gameProcessed then return end
        
        -- Toggle Inventory Duplicator (F1)
        if input.KeyCode == Enum.KeyCode.F1 then
            if InventoryExploits.Config.InventoryDuplicator then
                InventoryExploits:StopInventoryDuplicator()
                print("❌ Inventory Duplicator: OFF")
            else
                InventoryExploits:StartInventoryDuplicator()
                print("✅ Inventory Duplicator: ON")
            end
        end
        
        -- Toggle Auto Item Collector (F2)
        if input.KeyCode == Enum.KeyCode.F2 then
            if InventoryExploits.Config.AutoCollector then
                InventoryExploits:StopAutoItemCollector()
                print("❌ Auto Item Collector: OFF")
            else
                InventoryExploits:StartAutoItemCollector()
                print("✅ Auto Item Collector: ON")
            end
        end
        
        -- Unlock All Skins (F3)
        if input.KeyCode == Enum.KeyCode.F3 then
            InventoryExploits:StartSkinUnlocker()
            print("✅ Unlocking All Skins...")
        end
        
        -- Toggle Auto Equipment Optimizer (F4)
        if input.KeyCode == Enum.KeyCode.F4 then
            if InventoryExploits.Config.AutoEquipper then
                InventoryExploits:StopAutoEquipper()
                print("❌ Auto Equipment Optimizer: OFF")
            else
                InventoryExploits:StartAutoEquipper()
                print("✅ Auto Equipment Optimizer: ON")
            end
        end
        
        -- Toggle Item Teleporter (F5)
        if input.KeyCode == Enum.KeyCode.F5 then
            if InventoryExploits.Config.ItemTeleporter then
                InventoryExploits:StopItemTeleporter()
                print("❌ Item Teleporter: OFF")
            else
                InventoryExploits:StartItemTeleporter()
                print("✅ Item Teleporter: ON")
            end
        end
        
        -- Start All Systems (F9)
        if input.KeyCode == Enum.KeyCode.F9 then
            InventoryExploits:StartAllSystems()
            print("✅ All Inventory Exploits: ON")
        end
        
        -- Emergency Stop (F10)
        if input.KeyCode == Enum.KeyCode.F10 then
            InventoryExploits:EmergencyStop()
            print("🚨 EMERGENCY STOP - All Systems: OFF")
        end
        
        -- Status Check (F12)
        if input.KeyCode == Enum.KeyCode.F12 then
            _G.InventoryStatus()
        end
    end)
    
    print("\n⌨️ KEYBINDS SETUP:")
    print("F1 - Toggle Inventory Duplicator")
    print("F2 - Toggle Auto Item Collector")
    print("F3 - Unlock All Skins")
    print("F4 - Toggle Auto Equipment Optimizer")
    print("F5 - Toggle Item Teleporter")
    print("F9 - Start All Systems")
    print("F10 - Emergency Stop")
    print("F12 - Show Status")
end

--// Integration with existing main script
local function integrateWithMainScript()
    -- This function shows how to integrate with your existing main.lua or mainv1.lua
    
    -- Add to your existing flags system
    if flags then
        flags['inventoryduplicator'] = false
        flags['autoitemcollector'] = false
        flags['autoequipper'] = false
        flags['itemteleporter'] = false
    end
    
    -- Add to your existing RunService loop
    --[[
    RunService.Heartbeat:Connect(function()
        -- Your existing code...
        
        -- Inventory Exploits Integration
        if flags and flags['inventoryduplicator'] and not InventoryExploits.Config.InventoryDuplicator then
            InventoryExploits:StartInventoryDuplicator()
        elseif flags and not flags['inventoryduplicator'] and InventoryExploits.Config.InventoryDuplicator then
            InventoryExploits:StopInventoryDuplicator()
        end
        
        if flags and flags['autoitemcollector'] and not InventoryExploits.Config.AutoCollector then
            InventoryExploits:StartAutoItemCollector()
        elseif flags and not flags['autoitemcollector'] and InventoryExploits.Config.AutoCollector then
            InventoryExploits:StopAutoItemCollector()
        end
        
        if flags and flags['autoequipper'] and not InventoryExploits.Config.AutoEquipper then
            InventoryExploits:StartAutoEquipper()
        elseif flags and not flags['autoequipper'] and InventoryExploits.Config.AutoEquipper then
            InventoryExploits:StopAutoEquipper()
        end
        
        if flags and flags['itemteleporter'] and not InventoryExploits.Config.ItemTeleporter then
            InventoryExploits:StartItemTeleporter()
        elseif flags and not flags['itemteleporter'] and InventoryExploits.Config.ItemTeleporter then
            InventoryExploits:StopItemTeleporter()
        end
    end)
    --]]
end

--// Initialize everything
print("\n🚀 ADVANCED INVENTORY EXPLOITS LOADED!")
print("═══════════════════════════════════════════")

-- Set up manual controls
manualControls()

-- Set up keybinds
setupKeybinds()

print("\n📖 QUICK START GUIDE:")
print("1. Use _G.StartAllInventoryExploits() to start everything")
print("2. Use _G.InventoryStatus() to check what's running")
print("3. Use F-keys for quick toggles")
print("4. Use _G.EmergencyStopInventory() if needed")

print("\n⚠️ SAFETY NOTES:")
print("• Start with small delays to avoid detection")
print("• Use Emergency Stop if game starts lagging")
print("• Monitor the output for any errors")
print("• Test features individually before using all together")

print("\n✨ FEATURES READY:")
print("💎 Inventory Duplicator - Duplicate valuable items")
print("🔍 Auto Item Collector - Collect all nearby items")
print("🎨 Skin Unlocker - Unlock all cosmetic skins")
print("⚙️ Auto Equipment Optimizer - Always use best gear")
print("📦 Item Teleporter - Teleport items to your location")

print("\n═══════════════════════════════════════════")
