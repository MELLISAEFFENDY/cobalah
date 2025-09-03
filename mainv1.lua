--// Services
local Players = cloneref(game:GetService('Players'))
local ReplicatedStorage = cloneref(game:GetService('ReplicatedStorage'))
local RunService = cloneref(game:GetService('RunService'))
local GuiService = cloneref(game:GetService('GuiService'))

print("ðŸ”¥ Fisch Cheat Hub v2 - Starting Load Process...")
print("ðŸ“ Script Location: GitHub Raw URL")
print("â° Loading Time: " .. os.date("%H:%M:%S"))

--// Variables
local lp = Players.LocalPlayer
local fishabundancevisible = false
local deathcon
local tooltipmessage
local characterposition

print("âœ… Variables initialized successfully!")

--// Functions (moved up to fix scope issues)
FindChildOfClass = function(parent, classname)
    return parent:FindFirstChildOfClass(classname)
end
FindChild = function(parent, child)
    return parent:FindFirstChild(child)
end
FindChildOfType = function(parent, childname, classname)
    local child = parent:FindFirstChild(childname)
    if child and child.ClassName == classname then
        return child
    end
end
CheckFunc = function(func)
    return typeof(func) == 'function'
end

print("ðŸ”§ Helper functions loaded successfully!")

--// Error Suppression for UI Library
local originalError = error
local originalWarn = warn

-- Suppress specific InputObject errors from Rayfield
warn = function(message, ...)
    if typeof(message) == "string" and (
        string.find(message, "Target is not a valid member of InputObject") or
        string.find(message, "InputObject") or
        string.find(message, "UserInputService") or
        string.find(message, "Dropdown") or
        string.find(message, "Refresh")
    ) then
        -- Suppress these specific warnings
        return
    end
    return originalWarn(message, ...)
end

error = function(message, ...)
    if typeof(message) == "string" and (
        string.find(message, "Target is not a valid member of InputObject") or
        string.find(message, "InputObject") or
        string.find(message, "Dropdown") or
        string.find(message, "Refresh")
    ) then
        -- Convert error to warning for these specific cases
        return originalWarn("âš ï¸ UI Warning: " .. message, ...)
    end
    return originalError(message, ...)
end

print("ðŸ”‡ Error suppression for UI library activated!")

--// Load Teleport System V2 from GitHub
print("ðŸ“¡ Loading Teleport System V2 from GitHub...")
local TeleportSystemV2
local teleportURL = "https://raw.githubusercontent.com/MELLISAEFFENDY/cobalah/main/teleport-v2.lua"

-- Load from GitHub only
local success, result = pcall(function()
    return loadstring(game:HttpGet(teleportURL))()
end)

if success and result then
    TeleportSystemV2 = result
    print("âœ… Teleport System V2 loaded from GitHub successfully!")
else
    print("âŒ Failed to load Teleport System V2 from GitHub. Error: " .. tostring(result))
    print("âš ï¸ Continuing without Advanced Teleport features...")
    TeleportSystemV2 = nil
end

-- Initialize the teleport system only if loaded successfully
if TeleportSystemV2 then
    TeleportSystemV2 = TeleportSystemV2.init()
end

local RodColors = {}
local RodMaterials = {}

--// Custom Functions
getchar = function()
    return lp.Character or lp.CharacterAdded:Wait()
end
gethrp = function()
    return getchar():WaitForChild('HumanoidRootPart')
end
gethum = function()
    return getchar():WaitForChild('Humanoid')
end
FindRod = function()
    if FindChildOfClass(getchar(), 'Tool') and FindChild(FindChildOfClass(getchar(), 'Tool'), 'values') then
        return FindChildOfClass(getchar(), 'Tool')
    else
        return nil
    end
end
message = function(text, time)
    local success, result = pcall(function()
        if tooltipmessage then tooltipmessage:Remove() end
        
        -- Try to get GeneralUIModule safely
        local playerGui = lp.PlayerGui
        local generalUIModule = playerGui:FindFirstChild("GeneralUIModule")
        
        if generalUIModule then
            tooltipmessage = require(generalUIModule):GiveToolTip(lp, text)
            task.spawn(function()
                task.wait(time or 2)
                if tooltipmessage then 
                    tooltipmessage:Remove()
                    tooltipmessage = nil 
                end
            end)
        else
            -- Fallback: print to console if GeneralUIModule not available
            print("ðŸ’¬ Message:", text)
        end
    end)
    
    if not success then
        -- Fallback if anything fails
        print("ðŸ’¬ Message:", text)
    end
end

--// Load Rayfield UI V2 from GitHub (Full Source)
print("ðŸŽ¨ Loading Rayfield UI V2 from GitHub...")
local Rayfield

-- Load from GitHub rayfieldv2.lua (full source from sirius.menu/rayfield)
local success, result = pcall(function()
    print("ï¿½ Loading from GitHub rayfieldv2.lua file...")
    return loadstring(game:HttpGet("https://raw.githubusercontent.com/MELLISAEFFENDY/cobalah/main/rayfieldv2.lua"))()
end)

if success and result then
    Rayfield = result
    print("âœ… Rayfield UI V2 loaded from GitHub successfully!")
else
    print("âŒ Failed to load Rayfield V2 from GitHub. Error:", result)
    print("ðŸ“¦ Trying fallback to original Rayfield source...")
    
    -- Fallback to original Rayfield source
    local success2, result2 = pcall(function()
        return loadstring(game:HttpGet("https://sirius.menu/rayfield"))()
    end)
    
    if success2 and result2 then
        Rayfield = result2
        print("âœ… Rayfield UI loaded from original source fallback!")
    else
        error("âŒ Cannot load Rayfield UI from any source!")
    end
end

--// Load Advanced Inventory Exploits from GitHub
print("ðŸ“¦ Loading Advanced Inventory Exploits from GitHub...")
local InventoryExploits
local inventoryURL = "https://raw.githubusercontent.com/MELLISAEFFENDY/cobalah/main/advanced_inventory_exploits_simple.lua"

-- Load from GitHub only
local success2, result2 = pcall(function()
    local code = game:HttpGet(inventoryURL)
    print("ðŸ“„ Inventory code length:", #code, "characters")
    return loadstring(code)()
end)

if success2 and result2 then
    InventoryExploits = result2
    print("ðŸ“¦ Inventory module type:", typeof(InventoryExploits))
    if InventoryExploits and typeof(InventoryExploits) == "table" then
        if InventoryExploits.Initialize then
            local initSuccess, initError = pcall(function()
                InventoryExploits:Initialize()
            end)
            if initSuccess then
                print("âœ… Advanced Inventory Exploits loaded from GitHub successfully!")
            else
                print("âš ï¸ Inventory Exploits loaded but failed to initialize:", initError)
                print("âš ï¸ Will continue with limited inventory features...")
                -- Don't set to nil, keep the module but with limited functionality
            end
        else
            print("âš ï¸ Inventory module loaded but missing Initialize function")
        end
    else
        print("âš ï¸ Inventory Exploits loaded but is not a valid module")
        print("âš ï¸ Module type:", typeof(InventoryExploits))
        InventoryExploits = nil
    end
else
    print("âŒ Failed to load Advanced Inventory Exploits from GitHub. Error: " .. tostring(result2))
    print("âš ï¸ Continuing without Advanced Inventory features...")
    InventoryExploits = nil
end

--// Load Economy & Marketplace Exploits from GitHub
print("ðŸ’° Loading Economy & Marketplace Exploits from GitHub...")
local EconomyExploits
local economyURL = "https://raw.githubusercontent.com/MELLISAEFFENDY/cobalah/main/economy_marketplace_exploits_simple.lua"

-- Try to load from GitHub first, fallback gracefully
local success3, result3 = pcall(function()
    local code = game:HttpGet(economyURL)
    print("ðŸ“„ Economy code length:", #code, "characters")
    return loadstring(code)()
end)

if success3 and result3 then
    EconomyExploits = result3
    print("ðŸ’° Economy module type:", typeof(EconomyExploits))
    if EconomyExploits and typeof(EconomyExploits) == "table" then
        if EconomyExploits.Initialize then
            local initSuccess, initError = pcall(function()
                EconomyExploits:Initialize()
            end)
            if initSuccess then
                print("âœ… Economy & Marketplace Exploits loaded from GitHub successfully!")
            else
                print("âš ï¸ Economy Exploits loaded but failed to initialize:", initError)
                print("âš ï¸ Will continue with limited economy features...")
                -- Don't set to nil, keep the module but with limited functionality
            end
        else
            print("âš ï¸ Economy module loaded but missing Initialize function")
        end
    else
        print("âš ï¸ Economy Exploits loaded but is not a valid module")
        print("âš ï¸ Module type:", typeof(EconomyExploits))
        EconomyExploits = nil
    end
else
    print("âš ï¸ Failed to load Economy Exploits from GitHub")
    print("âš ï¸ Error:", result3 or "Unknown error")
    -- Set EconomyExploits to nil so we can handle it gracefully in UI
    EconomyExploits = nil
end

--// Create UI
print("ðŸš€ Creating Rayfield UI Window...")
local windowSuccess, Window = pcall(function()
    return Rayfield:CreateWindow({
        Name = "Fisch Cheat Hub v2",
        LoadingTitle = "Fisch Advanced Exploits Loading...",
        LoadingSubtitle = "by YourName - Now with Inventory System",
        ConfigurationSaving = {
            Enabled = false,
            FolderName = nil,
            FileName = "FischHub"
        },
        Discord = {
            Enabled = false,
            Invite = "noinvitelink",
            RememberJoins = true
        },
        KeySystem = false
    })
end)

if windowSuccess and Window then
    print("âœ… UI Window created successfully!")
else
    print("âŒ Failed to create UI Window:", tostring(Window))
    return
end

--// Create Tabs
print("ðŸ“‚ Creating UI Tabs...")
local AutomationTab, ModificationsTab, TeleportsTab, VisualsTab, InventoryTab, EconomyTab

local tabSuccess, tabError = pcall(function()
    AutomationTab = Window:CreateTab("Automation", 4483362458) -- Name, Image
    ModificationsTab = Window:CreateTab("Modifications", 4483362458)
    TeleportsTab = Window:CreateTab("Teleports", 4483362458)
    VisualsTab = Window:CreateTab("Visuals", 4483362458)
    InventoryTab = Window:CreateTab("Inventory", 4483362458)
    EconomyTab = Window:CreateTab("Economy", 4483362458)
end)

if tabSuccess then
    print("âœ… UI Tabs created successfully!")
else
    print("âŒ Failed to create UI Tabs:", tostring(tabError))
    return
end

print("âœ… All tabs created successfully!")

--// Create UI Content with Error Handling
print("ðŸŽ¨ Creating UI Content...")

-- State tracking variables for main loop
local freezeCharEnabled = false
local freezeCharMode = "Toggled"
local autoCastEnabled = false
local autoShakeEnabled = false
local autoReelEnabled = false

local contentSuccess, contentError = pcall(function()

--// Automation Tab
AutomationTab:CreateSection("Autofarm")

local FreezeCharToggle = AutomationTab:CreateToggle({
    Name = "Freeze Character",
    CurrentValue = false,
    Flag = "freezechar",
    Callback = function(Value)
        freezeCharEnabled = Value
        if Value then
            message("ðŸ§Š Character Freeze: ENABLED", 2)
        else
            message("ðŸ§Š Character Freeze: DISABLED", 2)
            characterposition = nil -- Clear saved position
        end
    end,
})

local FreezeCharModeDropdown = AutomationTab:CreateDropdown({
    Name = "Freeze Character Mode",
    Options = {'Rod Equipped', 'Toggled'},
    CurrentOption = 'Rod Equipped',
    Flag = "freezecharmode",
    Callback = function(Option)
        local optionStr = tostring(Option or "Rod Equipped")
        freezeCharMode = optionStr
        print("ðŸ”„ Freeze mode changed to:", optionStr)
    end,
})

local AutoCastToggle = AutomationTab:CreateToggle({
    Name = "Auto Cast",
    CurrentValue = false,
    Flag = "autocast",
    Callback = function(Value)
        autoCastEnabled = Value
        if Value then
            message("ðŸŽ£ Auto Cast: ENABLED", 2)
        else
            message("ðŸŽ£ Auto Cast: DISABLED", 2)
        end
    end,
})

local AutoShakeToggle = AutomationTab:CreateToggle({
    Name = "Auto Shake",
    CurrentValue = false,
    Flag = "autoshake",
    Callback = function(Value)
        autoShakeEnabled = Value
        if Value then
            message("ðŸŽ¯ Auto Shake: ENABLED", 2)
        else
            message("ðŸŽ¯ Auto Shake: DISABLED", 2)
        end
    end,
})

local AutoReelToggle = AutomationTab:CreateToggle({
    Name = "Auto Reel",
    CurrentValue = false,
    Flag = "autoreel",
    Callback = function(Value)
        autoReelEnabled = Value
        if Value then
            message("ðŸŽ£ Auto Reel: ENABLED", 2)
        else
            message("ðŸŽ£ Auto Reel: DISABLED", 2)
        end
    end,
})

--// Modifications Tab
if CheckFunc(hookmetamethod) then
    ModificationsTab:CreateSection("Hooks")
    
    local NoAFKToggle = ModificationsTab:CreateToggle({
        Name = "No AFK Text",
        CurrentValue = false,
        Flag = "noafk",
        Callback = function(Value)
            -- Callback handled in hooks
        end,
    })

    local PerfectCastToggle = ModificationsTab:CreateToggle({
        Name = "Perfect Cast",
        CurrentValue = false,
        Flag = "perfectcast",
        Callback = function(Value)
            -- Callback handled in hooks
        end,
    })

    local AlwaysCatchToggle = ModificationsTab:CreateToggle({
        Name = "Always Catch",
        CurrentValue = false,
        Flag = "alwayscatch",
        Callback = function(Value)
            -- Callback handled in hooks
        end,
    })
end

ModificationsTab:CreateSection("Client")

local InfOxygenToggle = ModificationsTab:CreateToggle({
    Name = "Infinite Oxygen",
    CurrentValue = false,
    Flag = "infoxygen",
    Callback = function(Value)
        -- Callback handled in main loop
    end,
})

local NoPeaksSystemsToggle = ModificationsTab:CreateToggle({
    Name = "No Temp & Oxygen",
    CurrentValue = false,
    Flag = "nopeakssystems",
    Callback = function(Value)
        -- Callback handled in main loop
    end,
})

--// Teleports Tab
-- GPS SYSTEM V2 WITH SEPARATE DROPDOWNS FOR EACH CATEGORY
-- This solves the problem of GPS locations not updating correctly

--// Teleports Tab
TeleportsTab:CreateSection("GPS System V2 - All Categories")

-- Check if TeleportSystemV2 is available before creating GPS components
if TeleportSystemV2 and TeleportSystemV2.getCategoryNames then
    local GPSCategories = TeleportSystemV2.getCategoryNames()
    local selectedGPSLocation = ""
    local selectedGPSCategory = ""
    
    print("ðŸ—ºï¸ Creating GPS system with", #GPSCategories, "categories")
    
    -- Variables to track selections
    local categoryDropdowns = {}
    local selectedTeleportMethod = "CFrame"
    
    -- Create teleport method dropdown first
    local TeleportMethodDropdown = TeleportsTab:CreateDropdown({
        Name = "Teleport Method",
        Options = {"CFrame", "TweenService", "RequestTeleportCFrame", "TeleportService"},
        CurrentOption = selectedTeleportMethod,
        Flag = "teleportmethod",
        Callback = function(Option)
            local optionStr = tostring(Option or "CFrame")
            selectedTeleportMethod = optionStr
            print("ðŸ”„ Teleport method changed to:", optionStr)
        end,
    })
    
    -- Create separate dropdown for each category
    for categoryIndex, categoryName in pairs(GPSCategories) do
        local categoryStr = tostring(categoryName)
        local locations = {}
        
        -- Get locations for this category safely
        local success, err = pcall(function()
            if TeleportSystemV2.getLocationNames and type(TeleportSystemV2.getLocationNames) == "function" then
                local locs = TeleportSystemV2.getLocationNames(categoryStr)
                if type(locs) == "table" and #locs > 0 then
                    locations = locs
                    print("ðŸ“ Category '" .. categoryStr .. "' loaded", #locs, "locations via getLocationNames")
                end
            end
            
            -- Fallback to getLocationsByCategory if first method fails
            if #locations == 0 and TeleportSystemV2.getLocationsByCategory and type(TeleportSystemV2.getLocationsByCategory) == "function" then
                local locationData = TeleportSystemV2.getLocationsByCategory(categoryStr)
                if type(locationData) == "table" then
                    for _, loc in pairs(locationData) do
                        if type(loc) == "table" and loc.name then
                            table.insert(locations, tostring(loc.name))
                        end
                    end
                    print("ðŸ“ Category '" .. categoryStr .. "' loaded", #locations, "locations via getLocationsByCategory")
                end
            end
        end)
        
        if not success then
            print("âŒ Error loading locations for", categoryStr, ":", tostring(err))
            locations = {"Error loading locations"}
        elseif #locations == 0 then
            locations = {"No locations available"}
        end
        
        -- Create section header for category
        local sectionName = categoryStr .. " (" .. (#locations > 0 and #locations or 0) .. " locations)"
        TeleportsTab:CreateSection(sectionName)
        
        -- Create dropdown for this category
        local dropdown = TeleportsTab:CreateDropdown({
            Name = "ðŸ“ " .. categoryStr,
            Options = locations,
            CurrentOption = locations[1] or "No locations",
            Flag = "gps_cat_" .. categoryIndex,
            Callback = function(Option)
                local success2, err2 = pcall(function()
                    local optionStr = tostring(Option or "Unknown")
                    selectedGPSLocation = optionStr
                    selectedGPSCategory = categoryStr
                    print("âœ… Selected:", optionStr, "from", categoryStr)
                    message("ðŸ“ " .. categoryStr .. ": " .. optionStr, 2)
                end)
                
                if not success2 then
                    print("âŒ Callback error for", categoryStr, ":", tostring(err2))
                end
            end,
        })
        
        -- Store dropdown reference
        categoryDropdowns[categoryStr] = dropdown
        
        -- Create teleport button for this category
        local teleportButton = TeleportsTab:CreateButton({
            Name = "ðŸš€ Teleport to " .. categoryStr,
            Callback = function()
                if selectedGPSLocation and selectedGPSLocation ~= "" and selectedGPSCategory == categoryStr then
                    if TeleportSystemV2.teleportToLocation then
                        local success3, msg = pcall(function()
                            return TeleportSystemV2.teleportToLocation(selectedGPSLocation, selectedGPSCategory, selectedTeleportMethod)
                        end)
                        
                        if success3 and msg then
                            message("âœ… Teleported to " .. selectedGPSLocation, 3)
                        else
                            message("âŒ Teleport failed: " .. tostring(msg), 3)
                        end
                    else
                        message("âŒ Teleport function not available", 3)
                    end
                else
                    message("âŒ Please select a location from " .. categoryStr .. " first", 3)
                end
            end,
        })
    end
    
    -- Add global controls section
    TeleportsTab:CreateSection("Global GPS Controls")
    
    local GPSTeleportButton = TeleportsTab:CreateButton({
        Name = "ðŸŒ Quick Teleport (Last Selected)",
        Callback = function()
            if selectedGPSLocation and selectedGPSLocation ~= "" and selectedGPSCategory and selectedGPSCategory ~= "" then
                if TeleportSystemV2.teleportToLocation then
                    local success, msg = pcall(function()
                        return TeleportSystemV2.teleportToLocation(selectedGPSLocation, selectedGPSCategory, selectedTeleportMethod)
                    end)
                    
                    if success and msg then
                        message("âœ… Quick teleport to " .. selectedGPSLocation, 3)
                    else
                        message("âŒ Quick teleport failed: " .. tostring(msg), 3)
                    end
                else
                    message("âŒ Teleport function not available", 3)
                end
            else
                message("âŒ No location selected! Use category dropdowns above.", 3)
            end
        end,
    })
    
    local StatsButton = TeleportsTab:CreateButton({
        Name = "ðŸ“Š Show GPS Statistics",
        Callback = function()
            local totalLocations = 0
            local msg = "ðŸ“Š GPS System V2 Statistics:\n\n"
            
            for _, categoryName in pairs(GPSCategories) do
                local success, count = pcall(function()
                    local locs = TeleportSystemV2.getLocationsByCategory(categoryName)
                    return #locs
                end)
                
                if success then
                    totalLocations = totalLocations + count
                    msg = msg .. string.format("ðŸ“ %s: %d locations\n", categoryName, count)
                else
                    msg = msg .. string.format("ðŸ“ %s: Error loading\n", categoryName)
                end
            end
            
            msg = msg .. string.format("\nðŸŒ Total Locations: %d\n", totalLocations)
            msg = msg .. "ðŸš€ Current Method: " .. selectedTeleportMethod
            
            message(msg, 15)
        end,
    })

else
    -- TeleportSystemV2 not available, show error message
    TeleportsTab:CreateSection("GPS System V2 - Error")
    
    local GPSErrorButton = TeleportsTab:CreateButton({
        Name = "âŒ GPS System Failed to Load",
        Callback = function()
            message("âŒ TeleportSystemV2 failed to load from GitHub.\nUsing legacy teleport system only.", 5)
        end,
    })
    
    local RetryGPSButton = TeleportsTab:CreateButton({
        Name = "ðŸ”„ Retry Loading GPS System",
        Callback = function()
            message("ðŸ”„ Please restart the script to retry loading GPS system.", 3)
        end,
    })
end
--// Visuals Tab
VisualsTab:CreateSection("Rod")

local BodyRodChamsToggle = VisualsTab:CreateToggle({
    Name = "Body Rod Chams",
    CurrentValue = false,
    Flag = "bodyrodchams",
    Callback = function(Value)
        -- Callback handled in main loop
    end,
})

local RodChamsToggle = VisualsTab:CreateToggle({
    Name = "Rod Chams",
    CurrentValue = false,
    Flag = "rodchams",
    Callback = function(Value)
        -- Callback handled in main loop
    end,
})

local MaterialDropdown = VisualsTab:CreateDropdown({
    Name = "Material",
    Options = {'ForceField', 'Neon'},
    CurrentOption = 'ForceField',
    Flag = "rodmaterial",
    Callback = function(Option)
        -- Callback handled in main loop
    end,
})

VisualsTab:CreateSection("Fish Abundance")

local FishAbundanceToggle = VisualsTab:CreateToggle({
    Name = "Free Fish Radar",
    CurrentValue = false,
    Flag = "fishabundance",
    Callback = function(Value)
        -- Callback handled in main loop
    end,
})

--// Inventory Tab
if InventoryExploits then
    InventoryTab:CreateSection("Item Collection")

    local AutoCollectorToggle = InventoryTab:CreateToggle({
        Name = "Auto Item Collector",
        CurrentValue = false,
        Flag = "autocollector",
        Callback = function(Value)
            if Value then
                InventoryExploits:StartAutoItemCollector()
                message("âœ… Auto Item Collector Started", 3)
            else
                InventoryExploits:StopAutoItemCollector()
                message("â›” Auto Item Collector Stopped", 3)
            end
        end,
    })

    local ItemTeleporterToggle = InventoryTab:CreateToggle({
        Name = "Item Teleporter",
        CurrentValue = false,
        Flag = "itemteleporter",
        Callback = function(Value)
            if Value then
                InventoryExploits:StartItemTeleporter()
                message("âœ… Item Teleporter Started", 3)
            else
                InventoryExploits:StopItemTeleporter()
                message("â›” Item Teleporter Stopped", 3)
            end
        end,
    })

    local CollectDelaySlider = InventoryTab:CreateDropdown({
        Name = "Collection Delay",
        Options = {"0.1", "0.5", "1.0", "2.0", "5.0"},
        CurrentOption = "0.5",
        Flag = "collectdelay",
        Callback = function(Option)
            InventoryExploits:SetCollectDelay(tonumber(Option))
            message("ðŸ• Collection delay set to " .. Option .. "s", 2)
        end,
    })

    local TeleportRadiusDropdown = InventoryTab:CreateDropdown({
        Name = "Teleport Radius",
        Options = {"100", "500", "1000", "2000", "5000"},
        CurrentOption = "1000",
        Flag = "teleportradius", 
        Callback = function(Option)
            InventoryExploits:SetTeleportRadius(tonumber(Option))
            message("ðŸ“¡ Teleport radius set to " .. Option .. " studs", 2)
        end,
    })

    InventoryTab:CreateSection("Item Duplication")

    local InventoryDuplicatorToggle = InventoryTab:CreateToggle({
        Name = "Inventory Duplicator",
        CurrentValue = false,
        Flag = "inventoryduplicator",
        Callback = function(Value)
            if Value then
                InventoryExploits:StartInventoryDuplicator()
                message("âœ… Inventory Duplicator Started", 3)
            else
                InventoryExploits:StopInventoryDuplicator()
                message("â›” Inventory Duplicator Stopped", 3)
            end
        end,
    })

    local MaxDuplicatesDropdown = InventoryTab:CreateDropdown({
        Name = "Max Duplicates",
        Options = {"10", "25", "50", "99", "999"},
        CurrentOption = "99",
        Flag = "maxduplicates",
        Callback = function(Option)
            InventoryExploits:SetMaxDuplicates(tonumber(Option))
            message("ðŸ”¢ Max duplicates set to " .. Option, 2)
        end,
    })

    local DuplicateDelayDropdown = InventoryTab:CreateDropdown({
        Name = "Duplicate Delay",
        Options = {"0.5", "1.0", "2.0", "3.0", "5.0"},
        CurrentOption = "1.0",
        Flag = "duplicatedelay",
        Callback = function(Option)
            InventoryExploits:SetDuplicateDelay(tonumber(Option))
            message("â±ï¸ Duplicate delay set to " .. Option .. "s", 2)
        end,
    })

    InventoryTab:CreateSection("Equipment & Skins")

    local AutoEquipperToggle = InventoryTab:CreateToggle({
        Name = "Auto Equipment Optimizer",
        CurrentValue = false,
        Flag = "autoequipper",
        Callback = function(Value)
            if Value then
                InventoryExploits:StartAutoEquipper()
                message("âœ… Auto Equipment Optimizer Started", 3)
            else
                InventoryExploits:StopAutoEquipper()
                message("â›” Auto Equipment Optimizer Stopped", 3)
            end
        end,
    })

    local SkinUnlockerButton = InventoryTab:CreateButton({
        Name = "ðŸŽ¨ Unlock All Skins",
        Callback = function()
            InventoryExploits:StartSkinUnlocker()
            message("ðŸŽ¨ Starting skin unlock process...", 3)
        end,
    })

    InventoryTab:CreateSection("Control Center")

    local StartAllButton = InventoryTab:CreateButton({
        Name = "ðŸš€ Start All Systems",
        Callback = function()
            InventoryExploits:StartAllSystems()
            message("ðŸš€ All inventory systems started!", 3)
            
            -- Update UI toggles
            Rayfield.Flags["autocollector"] = true
            Rayfield.Flags["itemteleporter"] = true
            Rayfield.Flags["inventoryduplicator"] = true
            Rayfield.Flags["autoequipper"] = true
        end,
    })

    local StopAllButton = InventoryTab:CreateButton({
        Name = "â›” Stop All Systems",
        Callback = function()
            InventoryExploits:StopAllSystems()
            message("â›” All inventory systems stopped!", 3)
            
            -- Update UI toggles
            Rayfield.Flags["autocollector"] = false
            Rayfield.Flags["itemteleporter"] = false
            Rayfield.Flags["inventoryduplicator"] = false
            Rayfield.Flags["autoequipper"] = false
        end,
    })

    local StatusButton = InventoryTab:CreateButton({
        Name = "ðŸ“Š Show Status",
        Callback = function()
            local status = InventoryExploits:GetStatus()
            local msg = "ðŸ“Š Inventory Status:\n\n"
            msg = msg .. "ðŸ”„ Auto Collector: " .. (status.AutoItemCollector and "ON" or "OFF") .. "\n"
            msg = msg .. "ðŸ“¦ Duplicator: " .. (status.InventoryDuplicator and "ON" or "OFF") .. "\n"
            msg = msg .. "ðŸŽ¨ Skin Unlocker: " .. (status.SkinUnlocker and "ON" or "OFF") .. "\n"
            msg = msg .. "âš¡ Auto Equipper: " .. (status.AutoEquipper and "ON" or "OFF") .. "\n"
            msg = msg .. "ðŸ“¡ Item Teleporter: " .. (status.ItemTeleporter and "ON" or "OFF") .. "\n\n"
            msg = msg .. "ðŸ“ˆ Items Collected: " .. (status.CollectedItems or 0) .. "\n"
            msg = msg .. "ðŸ“‹ Items Duplicated: " .. (status.DuplicatedItems or 0)
            message(msg, 10)
        end,
    })

    local EmergencyStopButton = InventoryTab:CreateButton({
        Name = "ðŸš¨ EMERGENCY STOP",
        Callback = function()
            InventoryExploits:EmergencyStop()
            message("ðŸš¨ EMERGENCY STOP ACTIVATED!", 5)
            
            -- Reset all UI toggles
            Rayfield.Flags["autocollector"] = false
            Rayfield.Flags["itemteleporter"] = false
            Rayfield.Flags["inventoryduplicator"] = false
            Rayfield.Flags["autoequipper"] = false
        end,
    })

    InventoryTab:CreateSection("Advanced Options")

    local ClearDataButton = InventoryTab:CreateButton({
        Name = "ðŸ—‘ï¸ Clear Duplicate Data",
        Callback = function()
            InventoryExploits:ClearDuplicatedItems()
            message("ðŸ—‘ï¸ Duplicated items data cleared", 3)
        end,
    })

    local ResetConfigButton = InventoryTab:CreateButton({
        Name = "ðŸ”„ Reset Configuration",
        Callback = function()
            InventoryExploits:ResetConfiguration()
            message("ðŸ”„ Configuration reset to defaults", 3)
        end,
    })
else
    InventoryTab:CreateSection("Error")
    
    local ErrorLabel = InventoryTab:CreateButton({
        Name = "âŒ Inventory Module Failed to Load",
        Callback = function()
            message("âŒ Advanced Inventory Exploits module failed to load from GitHub", 5)
        end,
    })
end

--// Economy Tab
EconomyTab:CreateSection("Economy & Marketplace")

if EconomyExploits then
    -- Full Economy Features Available
    EconomyTab:CreateSection("Market Operations")

    local MarketPriceManipulatorToggle = EconomyTab:CreateToggle({
        Name = "Market Price Manipulator",
        CurrentValue = false,
        Flag = "marketpricemanipulator",
        Callback = function(Value)
            if Value then
                EconomyExploits:StartMarketPriceManipulator()
                message("ðŸ’° Market Price Manipulator Started", 3)
            else
                EconomyExploits:StopMarketPriceManipulator()
                message("â›” Market Price Manipulator Stopped", 3)
            end
        end,
    })

    local ShopRefreshToggle = EconomyTab:CreateToggle({
        Name = "Unlimited Shop Refresh",
        CurrentValue = false,
        Flag = "shoprefresh",
        Callback = function(Value)
            if Value then
                EconomyExploits:StartUnlimitedShopRefresh()
                message("ðŸ”„ Unlimited Shop Refresh Started", 3)
            else
                EconomyExploits:StopUnlimitedShopRefresh()
                message("â›” Shop Refresh Stopped", 3)
            end
        end,
    })

    local FreePurchaseToggle = EconomyTab:CreateToggle({
        Name = "Free Purchase Exploit",
        CurrentValue = false,
        Flag = "freepurchase",
        Callback = function(Value)
            if Value then
                EconomyExploits:StartFreePurchaseExploit()
                message("ðŸ’¸ Free Purchase Exploit Started", 3)
            else
                EconomyExploits:StopFreePurchaseExploit()
                message("â›” Free Purchase Stopped", 3)
            end
        end,
    })

    EconomyTab:CreateSection("Trading & Marketplace")

    local ItemFlipperToggle = EconomyTab:CreateToggle({
        Name = "Auto Item Flipper",
        CurrentValue = false,
        Flag = "itemflipper",
        Callback = function(Value)
            if Value then
                EconomyExploits:StartAutoItemFlipper()
                message("ðŸ“ˆ Auto Item Flipper Started", 3)
            else
                EconomyExploits:StopAutoItemFlipper()
                message("â›” Item Flipper Stopped", 3)
            end
        end,
    })

    local ShopScannerToggle = EconomyTab:CreateToggle({
        Name = "Shop Inventory Scanner",
        CurrentValue = false,
        Flag = "shopscanner",
        Callback = function(Value)
            if Value then
                EconomyExploits:StartShopInventoryScanner()
                message("ðŸ” Shop Scanner Started", 3)
            else
                EconomyExploits:StopShopInventoryScanner()
                message("â›” Shop Scanner Stopped", 3)
            end
        end,
    })

    EconomyTab:CreateSection("Configuration")

    local MaxSpendDropdown = EconomyTab:CreateDropdown({
        Name = "Max Spend Amount",
        Options = {"10000", "50000", "100000", "500000", "1000000"},
        CurrentOption = "100000",
        Flag = "maxspend",
        Callback = function(Option)
            EconomyExploits.Config.MaxSpendAmount = tonumber(Option)
            message("ðŸ’° Max spend set to $" .. Option, 2)
        end,
    })

    local ProfitMarginDropdown = EconomyTab:CreateDropdown({
        Name = "Min Profit Margin",
        Options = {"10%", "20%", "30%", "50%", "100%"},
        CurrentOption = "20%",
        Flag = "profitmargin",
        Callback = function(Option)
            local margin = tonumber(Option:gsub("%%", "")) / 100
            EconomyExploits.Config.MinProfitMargin = margin
            message("ðŸ“Š Min profit margin set to " .. Option, 2)
        end,
    })

    local RefreshDelayDropdown = EconomyTab:CreateDropdown({
        Name = "Refresh Delay",
        Options = {"0.1", "0.5", "1.0", "2.0", "5.0"},
        CurrentOption = "0.1",
        Flag = "refreshdelay",
        Callback = function(Option)
            EconomyExploits.Config.RefreshDelay = tonumber(Option)
            message("â±ï¸ Refresh delay set to " .. Option .. "s", 2)
        end,
    })

    EconomyTab:CreateSection("Quick Actions")

    local RefreshAllShopsButton = EconomyTab:CreateButton({
        Name = "ðŸ”„ Refresh All Shops",
        Callback = function()
            EconomyExploits:RefreshAllShops()
            message("ðŸ”„ All shops refreshed!", 3)
        end,
    })

    local ScanForDealsButton = EconomyTab:CreateButton({
        Name = "ðŸ” Scan for Deals",
        Callback = function()
            EconomyExploits:ScanForFlipOpportunities()
            message("ðŸ” Scanning for profitable deals...", 3)
        end,
    })

    local AttemptFreePurchasesButton = EconomyTab:CreateButton({
        Name = "ðŸ’¸ Attempt Free Purchases",
        Callback = function()
            EconomyExploits:AttemptFreePurchases()
            message("ðŸ’¸ Attempting free purchases...", 3)
        end,
    })

    local ManipulatePricesButton = EconomyTab:CreateButton({
        Name = "ðŸ’° Manipulate Prices",
        Callback = function()
            EconomyExploits:ManipulateMarketPrices()
            message("ðŸ’° Attempting price manipulation...", 3)
        end,
    })

    EconomyTab:CreateSection("Control Center")

    local StartAllEconomyButton = EconomyTab:CreateButton({
        Name = "ðŸš€ Start All Economy Systems",
        Callback = function()
            EconomyExploits:StartAllSystems()
            message("ðŸš€ All economy systems started!", 3)
            
            -- Update UI toggles
            Rayfield.Flags["marketpricemanipulator"] = true
            Rayfield.Flags["shoprefresh"] = true
            Rayfield.Flags["freepurchase"] = true
            Rayfield.Flags["itemflipper"] = true
            Rayfield.Flags["shopscanner"] = true
        end,
    })

    local StopAllEconomyButton = EconomyTab:CreateButton({
        Name = "â›” Stop All Economy Systems",
        Callback = function()
            EconomyExploits:StopAllSystems()
            message("â›” All economy systems stopped!", 3)
            
            -- Update UI toggles
            Rayfield.Flags["marketpricemanipulator"] = false
            Rayfield.Flags["shoprefresh"] = false
            Rayfield.Flags["freepurchase"] = false
            Rayfield.Flags["itemflipper"] = false
            Rayfield.Flags["shopscanner"] = false
        end,
    })

    local EconomyStatusButton = EconomyTab:CreateButton({
        Name = "ðŸ“Š Show Economy Status",
        Callback = function()
            local status = EconomyExploits:GetStatus()
            local msg = "ðŸ“Š Economy Status:\n\n"
            msg = msg .. "ðŸ’° Price Manipulator: " .. (status.MarketPriceManipulator and "ON" or "OFF") .. "\n"
            msg = msg .. "ðŸ”„ Shop Refresh: " .. (status.UnlimitedShopRefresh and "ON" or "OFF") .. "\n"
            msg = msg .. "ðŸ“ˆ Item Flipper: " .. (status.AutoItemFlipper and "ON" or "OFF") .. "\n"
            msg = msg .. "ðŸ’¸ Free Purchase: " .. (status.FreePurchaseExploit and "ON" or "OFF") .. "\n"
            msg = msg .. "ðŸ” Shop Scanner: " .. (status.ShopInventoryScanner and "ON" or "OFF") .. "\n\n"
            msg = msg .. "ðŸ’µ Max Spend: $" .. (EconomyExploits.Config.MaxSpendAmount or 0) .. "\n"
            msg = msg .. "ðŸ“Š Min Profit: " .. string.format("%.0f%%", (EconomyExploits.Config.MinProfitMargin or 0) * 100)
            message(msg, 10)
        end,
    })

    local MarketReportButton = EconomyTab:CreateButton({
        Name = "ðŸ“ˆ Generate Market Report",
        Callback = function()
            EconomyExploits:PrintMarketReport()
            message("ðŸ“ˆ Market report generated in console", 5)
        end,
    })

    local EmergencyEconomyStopButton = EconomyTab:CreateButton({
        Name = "ðŸš¨ EMERGENCY STOP",
        Callback = function()
            EconomyExploits:EmergencyStop()
            message("ðŸš¨ ECONOMY EMERGENCY STOP ACTIVATED!", 5)
            
            -- Reset all UI toggles
            Rayfield.Flags["marketpricemanipulator"] = false
            Rayfield.Flags["shoprefresh"] = false
            Rayfield.Flags["freepurchase"] = false
            Rayfield.Flags["itemflipper"] = false
            Rayfield.Flags["shopscanner"] = false
        end,
    })
else
    -- Basic Economy Features (Fallback)
    EconomyTab:CreateSection("Basic Economy Tools")
    
    local BasicMarketButton = EconomyTab:CreateButton({
        Name = "ðŸª Open Merchant",
        Callback = function()
            -- Basic merchant teleport
            local success, error = pcall(function()
                local merchantLocations = {
                    CFrame.new(-1472.7, 149.4, -3014.5), -- Moosewood Merchant
                    CFrame.new(475.9, 150.2, 346.8),     -- Mushgrove Merchant
                    CFrame.new(-1795.8, 137.5, -3302.1)  -- Terrapin Island Merchant
                }
                local randomLocation = merchantLocations[math.random(1, #merchantLocations)]
                gethrp().CFrame = randomLocation
                message("ðŸª Teleported to Merchant!", 3)
            end)
            if not success then
                message("âŒ Failed to teleport to merchant", 3)
            end
        end,
    })
    
    local BasicShopButton = EconomyTab:CreateButton({
        Name = "ðŸ›’ Find Rod Shop",
        Callback = function()
            local success, error = pcall(function()
                -- Teleport to rod shop in Moosewood
                gethrp().CFrame = CFrame.new(-1472.7, 149.4, -3014.5)
                message("ðŸŽ£ Teleported to Rod Shop!", 3)
            end)
            if not success then
                message("âŒ Failed to teleport to shop", 3)
            end
        end,
    })
    
    local EconomyErrorLabel = EconomyTab:CreateButton({
        Name = "â„¹ï¸ Advanced Features Unavailable",
        Callback = function()
            message("â„¹ï¸ Advanced Economy & Marketplace features require additional modules.\n\nðŸ”§ Basic economy tools are available above.", 5)
        end,
    })
end

--// Main Loop
RunService.Heartbeat:Connect(function()
    -- Autofarm
    if freezeCharEnabled then
        if freezeCharMode == 'Toggled' then
            if characterposition == nil then
                characterposition = gethrp().CFrame
            else
                gethrp().CFrame = characterposition
            end
        elseif freezeCharMode == 'Rod Equipped' then
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
    
    if autoShakeEnabled then
        if FindChild(lp.PlayerGui, 'shakeui') and FindChild(lp.PlayerGui['shakeui'], 'safezone') and FindChild(lp.PlayerGui['shakeui']['safezone'], 'button') then
            GuiService.SelectedObject = lp.PlayerGui['shakeui']['safezone']['button']
            if GuiService.SelectedObject == lp.PlayerGui['shakeui']['safezone']['button'] then
                game:GetService('VirtualInputManager'):SendKeyEvent(true, Enum.KeyCode.Return, false, game)
                game:GetService('VirtualInputManager'):SendKeyEvent(false, Enum.KeyCode.Return, false, game)
            end
        end
    end
    
    if autoCastEnabled then
        local rod = FindRod()
        if rod ~= nil and rod['values']['lure'].Value <= .001 and task.wait(.5) then
            rod.events.cast:FireServer(100, 1)
        end
    end
    
    if autoReelEnabled then
        local rod = FindRod()
        if rod ~= nil and rod['values']['lure'].Value == 100 and task.wait(.5) then
            ReplicatedStorage.events.reelfinished:FireServer(100, true)
        end
    end

    -- Visuals
    if Rayfield.Flags['rodchams'] then
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
                        if v.Material == Enum.Material.Neon then
                            RodMaterials[rodName][v.Name..i] = Enum.Material.Neon
                        elseif v.Material ~= Enum.Material.ForceField and v.Material ~= Enum.Material[Rayfield.Flags['rodmaterial']] then
                            RodMaterials[rodName][v.Name..i] = v.Material
                        end
                    end
                    v.Material = Enum.Material[Rayfield.Flags['rodmaterial']]
                    v.Color = Color3.fromRGB(100, 100, 255)
                end
            end
            if rod['handle'].Color ~= Color3.fromRGB(100, 100, 255) then
                RodColors[rodName]['handle'] = rod['handle'].Color
            end
            if rod['handle'].Material ~= Enum.Material.ForceField and rod['handle'].Material ~= Enum.Material.Neon and rod['handle'].Material ~= Enum.Material[Rayfield.Flags['rodmaterial']] then
                RodMaterials[rodName]['handle'] = rod['handle'].Material
            end
            rod['handle'].Material = Enum.Material[Rayfield.Flags['rodmaterial']]
            rod['handle'].Color = Color3.fromRGB(100, 100, 255)
        end
    elseif not Rayfield.Flags['rodchams'] then
        local rod = FindRod()
        if rod ~= nil and FindChild(rod, 'Details') then
            local rodName = tostring(rod)
            if RodColors[rodName] and RodMaterials[rodName] then
                for i,v in rod['Details']:GetDescendants() do
                    if v:IsA('BasePart') or v:IsA('MeshPart') then
                        if RodMaterials[rodName][v.Name..i] and RodColors[rodName][v.Name..i] then
                            v.Material = RodMaterials[rodName][v.Name..i]
                            v.Color = RodColors[rodName][v.Name..i]
                        end
                    end
                end
                if RodMaterials[rodName]['handle'] and RodColors[rodName]['handle'] then
                    rod['handle'].Material = RodMaterials[rodName]['handle']
                    rod['handle'].Color = RodColors[rodName]['handle']
                end
            end
        end
    end
    
    if Rayfield.Flags['bodyrodchams'] then
        local rod = getchar():FindFirstChild('RodBodyModel')
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
                        if v.Material == Enum.Material.Neon then
                            RodMaterials[rodName][v.Name..i] = Enum.Material.Neon
                        elseif v.Material ~= Enum.Material.ForceField and v.Material ~= Enum.Material[Rayfield.Flags['rodmaterial']] then
                            RodMaterials[rodName][v.Name..i] = v.Material
                        end
                    end
                    v.Material = Enum.Material[Rayfield.Flags['rodmaterial']]
                    v.Color = Color3.fromRGB(100, 100, 255)
                end
            end
            if rod['handle'].Color ~= Color3.fromRGB(100, 100, 255) then
                RodColors[rodName]['handle'] = rod['handle'].Color
            end
            if rod['handle'].Material ~= Enum.Material.ForceField and rod['handle'].Material ~= Enum.Material.Neon and rod['handle'].Material ~= Enum.Material[Rayfield.Flags['rodmaterial']] then
                RodMaterials[rodName]['handle'] = rod['handle'].Material
            end
            rod['handle'].Material = Enum.Material[Rayfield.Flags['rodmaterial']]
            rod['handle'].Color = Color3.fromRGB(100, 100, 255)
        end
    elseif not Rayfield.Flags['bodyrodchams'] then
        local rod = getchar():FindFirstChild('RodBodyModel')
        if rod ~= nil and FindChild(rod, 'Details') then
            local rodName = tostring(rod)
            if RodColors[rodName] and RodMaterials[rodName] then
                for i,v in rod['Details']:GetDescendants() do
                    if v:IsA('BasePart') or v:IsA('MeshPart') then
                        if RodMaterials[rodName][v.Name..i] and RodColors[rodName][v.Name..i] then
                            v.Material = RodMaterials[rodName][v.Name..i]
                            v.Color = RodColors[rodName][v.Name..i]
                        end
                    end
                end
                if RodMaterials[rodName]['handle'] and RodColors[rodName]['handle'] then
                    rod['handle'].Material = RodMaterials[rodName]['handle']
                    rod['handle'].Color = RodColors[rodName]['handle']
                end
            end
        end
    end
    
    if Rayfield.Flags['fishabundance'] then
        if not fishabundancevisible then
            message('\\<b><font color = \"#9eff80\">Fish Abundance Zones</font></b>\\ are now visible', 5)
        end
        for i,v in workspace.zones.fishing:GetChildren() do
            if FindChildOfType(v, 'Abundance', 'StringValue') and FindChildOfType(v, 'radar1', 'BillboardGui') then
                v['radar1'].Enabled = true
                v['radar2'].Enabled = true
            end
        end
        fishabundancevisible = Rayfield.Flags['fishabundance']
    else
        if fishabundancevisible then
            message('\\<b><font color = \"#9eff80\">Fish Abundance Zones</font></b>\\ are no longer visible', 5)
        end
        for i,v in workspace.zones.fishing:GetChildren() do
            if FindChildOfType(v, 'Abundance', 'StringValue') and FindChildOfType(v, 'radar1', 'BillboardGui') then
                v['radar1'].Enabled = false
                v['radar2'].Enabled = false
            end
        end
        fishabundancevisible = Rayfield.Flags['fishabundance']
    end

    -- Modifications
    if Rayfield.Flags['infoxygen'] then
        if not deathcon then
            deathcon = gethum().Died:Connect(function()
                task.delay(9, function()
                    if FindChildOfType(getchar(), 'DivingTank', 'Decal') then
                        FindChildOfType(getchar(), 'DivingTank', 'Decal'):Destroy()
                    end
                    local oxygentank = Instance.new('Decal')
                    oxygentank.Name = 'DivingTank'
                    oxygentank.Parent = workspace
                    oxygentank:SetAttribute('Tier', 1/0)
                    oxygentank.Parent = getchar()
                    deathcon = nil
                end)
            end)
        end
        if deathcon and gethum().Health > 0 then
            if not getchar():FindFirstChild('DivingTank') then
                local oxygentank = Instance.new('Decal')
                oxygentank.Name = 'DivingTank'
                oxygentank.Parent = workspace
                oxygentank:SetAttribute('Tier', 1/0)
                oxygentank.Parent = getchar()
            end
        end
    else
        if FindChildOfType(getchar(), 'DivingTank', 'Decal') then
            FindChildOfType(getchar(), 'DivingTank', 'Decal'):Destroy()
        end
    end
    
    if Rayfield.Flags['nopeakssystems'] then
        getchar():SetAttribute('WinterCloakEquipped', true)
        getchar():SetAttribute('Refill', true)
    else
        getchar():SetAttribute('WinterCloakEquipped', nil)
        getchar():SetAttribute('Refill', false)
    end
end)

end) -- End of UI Content Creation pcall

if contentSuccess then
    print("âœ… UI Content created successfully!")
else
    print("âŒ Failed to create UI Content:", tostring(contentError))
    print("âš ï¸ UI will be visible but some features may not work")
end

--// Hooks
print("ðŸ”— Setting up hooks...")
if CheckFunc(hookmetamethod) then
    local old; old = hookmetamethod(game, "__namecall", function(self, ...)
        local method, args = getnamecallmethod(), {...}
        if method == 'FireServer' and self.Name == 'afk' and Rayfield.Flags['noafk'] then
            args[1] = false
            return old(self, unpack(args))
        elseif method == 'FireServer' and self.Name == 'cast' and Rayfield.Flags['perfectcast'] then
            args[1] = 100
            return old(self, unpack(args))
        elseif method == 'FireServer' and self.Name == 'reelfinished' and Rayfield.Flags['alwayscatch'] then
            args[1] = 100
            args[2] = true
            return old(self, unpack(args))
        end
        return old(self, ...)
    end)
    print("âœ… Hooks set up successfully!")
else
    print("âš ï¸ hookmetamethod not available, hooks disabled")
end

print("ðŸŽ‰ FISCH CHEAT HUB V2 LOADED SUCCESSFULLY! ðŸŽ‰")
print("ðŸ“‹ Features Available:")
print("   ðŸ¤– Auto Fishing & Automation")
print("   ðŸš€ Advanced Teleport System (276+ locations)")
print("   ðŸŽ¨ Visual Enhancements & Rod Chams")
print("   ðŸ“¦ Inventory & Item Management")
print("   ðŸ’° Economy & Marketplace Tools")
print("ðŸŽ® UI should be visible now! Check your screen.")
print("âš¡ Ready to use - Enjoy fishing! âš¡")

--// Restore original error functions after UI is loaded
print("ðŸ”Š Restoring original error functions...")
warn = originalWarn
error = originalError
print("âœ… Error functions restored!")
