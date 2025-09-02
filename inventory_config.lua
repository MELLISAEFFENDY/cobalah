--// Advanced Inventory Exploits Configuration File
--// Customize all settings here before running the exploits

local InventoryConfig = {}

--// ═══════════════════════════════════════════════════════════════
--// 🔧 GENERAL SETTINGS
--// ═══════════════════════════════════════════════════════════════

InventoryConfig.General = {
    -- Enable/Disable logging
    LogActivity = true,
    
    -- Auto-start features on load
    AutoStartOnLoad = false,
    
    -- Safe mode (adds extra delays to avoid detection)
    SafeMode = true,
    
    -- Maximum operations per second (safety limiter)
    MaxOperationsPerSecond = 10
}

--// ═══════════════════════════════════════════════════════════════
--// 💎 INVENTORY DUPLICATOR SETTINGS
--// ═══════════════════════════════════════════════════════════════

InventoryConfig.Duplicator = {
    -- Enable duplicator on load
    AutoStart = false,
    
    -- Maximum items to duplicate per item type
    MaxDuplicates = 99,
    
    -- Delay between duplicate attempts (seconds)
    DuplicateDelay = 1.0,
    
    -- Items to prioritize for duplication
    PriorityItems = {
        "Heaven Rod",
        "Kings Rod",
        "Summit Rod",
        "Mythic",
        "Legendary",
        "Divine",
        "Ancient",
        "Abyssal",
        "Crystal",
        "Gem",
        "Treasure",
        "Coin"
    },
    
    -- Items to never duplicate
    BlacklistedItems = {
        "Flimsy Rod",
        "Plastic Rod",
        "Training Rod"
    },
    
    -- Minimum rarity to duplicate
    MinimumRarity = "rare", -- common, uncommon, rare, epic, legendary, mythic, divine
    
    -- Duplication methods to try (in order)
    Methods = {
        "BackpackClone",
        "RemoteEquip",
        "ItemCollector"
    }
}

--// ═══════════════════════════════════════════════════════════════
--// 🔍 AUTO ITEM COLLECTOR SETTINGS
--// ═══════════════════════════════════════════════════════════════

InventoryConfig.Collector = {
    -- Enable collector on load
    AutoStart = false,
    
    -- Delay between collection attempts (seconds)
    CollectDelay = 0.5,
    
    -- Maximum distance to collect items from
    TeleportRadius = 1000,
    
    -- Items to always collect
    AlwaysCollect = {
        "treasure",
        "coin",
        "gem",
        "crystal",
        "fish",
        "rod",
        "bait",
        "bobber"
    },
    
    -- Items to never collect
    NeverCollect = {
        "trash",
        "debris",
        "seaweed"
    },
    
    -- Collection methods to use
    Methods = {
        NearbyItems = true,
        WorldItems = true,
        SpawnedItems = true,
        RemoteCollection = true
    },
    
    -- Areas to scan for items
    ScanAreas = {
        "fishing",
        "treasure",
        "special",
        "underwater",
        "caves"
    },
    
    -- Auto-organize inventory after collecting
    AutoOrganize = true
}

--// ═══════════════════════════════════════════════════════════════
--// 🎨 SKIN UNLOCKER SETTINGS
--// ═══════════════════════════════════════════════════════════════

InventoryConfig.SkinUnlocker = {
    -- Skin types to unlock
    SkinTypes = {
        Rod = true,
        Boat = true,
        Bobber = true,
        Equipment = true,
        Title = true,
        Lantern = true
    },
    
    -- Number of skins to attempt per type
    MaxSkinsPerType = 50,
    
    -- Delay between unlock attempts
    UnlockDelay = 0.1,
    
    -- Specific skins to prioritize
    PrioritySkins = {
        -- Rod Skins
        "Abyssal Rod",
        "Divine Rod",
        "Celestial Rod",
        "Ancient Rod",
        "Mythic Rod",
        "Legendary Rod",
        
        -- Boat Skins
        "Kraken of the Void",
        "Guardian of Atlantis",
        "King of the Kraken",
        "Cthulhu Boat",
        
        -- Special Skins
        "Divine Bobber",
        "Celestial Lantern",
        "Abyssal Title"
    },
    
    -- Unlock methods to try
    Methods = {
        SkinCrates = true,
        DirectUnlock = true,
        RemoteExploit = true
    }
}

--// ═══════════════════════════════════════════════════════════════
--// ⚙️ AUTO EQUIPMENT OPTIMIZER SETTINGS
--// ═══════════════════════════════════════════════════════════════

InventoryConfig.AutoEquipper = {
    -- Enable auto equipping on load
    AutoStart = false,
    
    -- Check for better equipment every X seconds
    CheckInterval = 5,
    
    -- Equipment optimization priorities
    Priorities = {
        Luck = 10,      -- Highest priority
        Power = 8,
        Speed = 6,
        Resilience = 4,
        Special = 2     -- Lowest priority
    },
    
    -- Auto-equip settings for each type
    Equipment = {
        Rod = {
            AutoEquip = true,
            PreferredTypes = {"Heaven", "Kings", "Summit", "Mythic", "Divine"},
            MinimumRarity = "epic"
        },
        
        Bait = {
            AutoEquip = true,
            PreferredTypes = {"Super", "Mega", "Ultra", "Divine"},
            AutoSwitchByZone = true
        },
        
        Bobber = {
            AutoEquip = true,
            PreferredTypes = {"Luck", "Speed", "Special"},
            MinimumRarity = "rare"
        },
        
        Lantern = {
            AutoEquip = true,
            PreferredTypes = {"Celestial", "Divine", "Abyssal"},
            MinimumRarity = "epic"
        },
        
        Title = {
            AutoEquip = true,
            PreferredTypes = {"Master", "Legend", "Divine"},
            ShowOff = true -- Equip flashy titles
        }
    },
    
    -- Zone-specific equipment preferences
    ZoneOptimization = {
        ["Depths"] = {
            Rod = "Abyssal",
            Lantern = "Divine",
            Bait = "Deep Sea"
        },
        
        ["Ancient Isle"] = {
            Rod = "Ancient",
            Bait = "Mythic",
            Bobber = "Luck"
        },
        
        ["Snowcap Island"] = {
            Rod = "Frost",
            Equipment = "Winter"
        }
    }
}

--// ═══════════════════════════════════════════════════════════════
--// 📦 ITEM TELEPORTER SETTINGS
--// ═══════════════════════════════════════════════════════════════

InventoryConfig.ItemTeleporter = {
    -- Enable teleporter on load
    AutoStart = false,
    
    -- Maximum distance to teleport items from
    TeleportRadius = 1000,
    
    -- Items to teleport
    TeleportItems = {
        "treasure",
        "coin",
        "gem",
        "crystal",
        "fish",
        "rare",
        "epic",
        "legendary",
        "mythic",
        "divine"
    },
    
    -- Teleport methods
    Methods = {
        DirectTeleport = true,
        BackpackTeleport = true,
        RemoteTeleport = true
    },
    
    -- Safety settings
    SafetyLimits = {
        MaxItemsPerSecond = 5,
        MinDistanceFromPlayer = 5,
        MaxDistanceFromPlayer = 1000
    },
    
    -- Teleport positioning
    TeleportPosition = {
        UseRandomOffset = true,
        MaxOffset = 3,
        HeightOffset = 1
    }
}

--// ═══════════════════════════════════════════════════════════════
--// 🎯 ITEM RATING SYSTEM
--// ═══════════════════════════════════════════════════════════════

InventoryConfig.ItemRating = {
    -- Rarity multipliers for item rating
    RarityMultipliers = {
        common = 1,
        uncommon = 2,
        rare = 3,
        epic = 4,
        legendary = 5,
        mythic = 6,
        divine = 7,
        celestial = 8,
        abyssal = 9,
        ancient = 10
    },
    
    -- Stat weights for item rating
    StatWeights = {
        Power = 1.0,
        Luck = 2.0,
        Speed = 1.5,
        Resilience = 0.8,
        Special = 1.2
    },
    
    -- Bonus points for special items
    SpecialBonuses = {
        ["Heaven Rod"] = 100,
        ["Kings Rod"] = 90,
        ["Summit Rod"] = 85,
        ["Divine"] = 50,
        ["Mythic"] = 40,
        ["Ancient"] = 45
    }
}

--// ═══════════════════════════════════════════════════════════════
--// 🛡️ SAFETY & ANTI-DETECTION SETTINGS
--// ═══════════════════════════════════════════════════════════════

InventoryConfig.Safety = {
    -- Enable anti-detection measures
    AntiDetection = true,
    
    -- Random delays to make actions look human
    RandomDelays = {
        Enabled = true,
        MinDelay = 0.1,
        MaxDelay = 0.5
    },
    
    -- Limits to prevent server overload
    RateLimits = {
        MaxActionsPerSecond = 10,
        MaxRemoteCallsPerSecond = 5,
        CooldownBetweenBursts = 2
    },
    
    -- Emergency stop triggers
    EmergencyStop = {
        OnHighPing = true,
        PingThreshold = 500,
        OnLowFPS = true,
        FPSThreshold = 20,
        OnErrorCount = true,
        MaxErrors = 10
    },
    
    -- Stealth mode settings
    StealthMode = {
        Enabled = false,
        HideFromLeaderboard = true,
        DisableNotifications = true,
        LowerOperationSpeed = true
    }
}

--// ═══════════════════════════════════════════════════════════════
--// 🔄 AUTO-RECOVERY SETTINGS
--// ═══════════════════════════════════════════════════════════════

InventoryConfig.Recovery = {
    -- Auto-restart failed systems
    AutoRestart = true,
    
    -- Maximum restart attempts
    MaxRestartAttempts = 3,
    
    -- Delay between restart attempts
    RestartDelay = 5,
    
    -- Systems to auto-recover
    RecoverySystems = {
        Duplicator = true,
        Collector = true,
        AutoEquipper = true,
        ItemTeleporter = true
    }
}

--// ═══════════════════════════════════════════════════════════════
--// 📊 LOGGING & STATISTICS SETTINGS
--// ═══════════════════════════════════════════════════════════════

InventoryConfig.Logging = {
    -- Log levels: "none", "error", "warning", "info", "debug"
    LogLevel = "info",
    
    -- What to log
    LogTypes = {
        Operations = true,
        Errors = true,
        Statistics = true,
        Performance = true
    },
    
    -- Statistics tracking
    Statistics = {
        TrackItemsCollected = true,
        TrackItemsDuplicated = true,
        TrackSkinsUnlocked = true,
        TrackEquipmentChanges = true,
        TrackPerformance = true
    },
    
    -- Performance monitoring
    Performance = {
        MonitorFPS = true,
        MonitorPing = true,
        MonitorMemory = true,
        LogPerformanceIssues = true
    }
}

--// ═══════════════════════════════════════════════════════════════
--// 🎮 KEYBIND SETTINGS
--// ═══════════════════════════════════════════════════════════════

InventoryConfig.Keybinds = {
    -- Enable keybinds
    Enabled = true,
    
    -- Keybind mappings
    Keys = {
        ToggleDuplicator = Enum.KeyCode.F1,
        ToggleCollector = Enum.KeyCode.F2,
        UnlockAllSkins = Enum.KeyCode.F3,
        ToggleAutoEquipper = Enum.KeyCode.F4,
        ToggleItemTeleporter = Enum.KeyCode.F5,
        StartAllSystems = Enum.KeyCode.F9,
        EmergencyStop = Enum.KeyCode.F10,
        ShowStatus = Enum.KeyCode.F12
    },
    
    -- Require key combinations for safety
    RequireModifiers = {
        EmergencyStop = false, -- No modifier required for emergency stop
        StartAllSystems = true, -- Require Ctrl+F9 for starting all systems
        UnlockAllSkins = true   -- Require Ctrl+F3 for unlocking all skins
    }
}

--// ═══════════════════════════════════════════════════════════════
--// 🔧 ADVANCED SETTINGS
--// ═══════════════════════════════════════════════════════════════

InventoryConfig.Advanced = {
    -- Custom remote event paths (override detected ones)
    CustomRemotes = {
        -- Leave empty to use auto-detected remotes
        -- Example: Backpack_Equip = "ReplicatedStorage.CustomPath.Equip"
    },
    
    -- Experimental features
    Experimental = {
        EnableQuantumDuplication = false,
        EnableAIDrivenCollection = false,
        EnablePredictiveEquipping = false
    },
    
    -- Developer mode
    DeveloperMode = {
        Enabled = false,
        DebugPrints = false,
        TestMode = false,
        BypassSafetyLimits = false
    }
}

--// ═══════════════════════════════════════════════════════════════
--// 📋 PRESET CONFIGURATIONS
--// ═══════════════════════════════════════════════════════════════

InventoryConfig.Presets = {
    -- Conservative preset (safe, slow)
    Conservative = function()
        InventoryConfig.Duplicator.DuplicateDelay = 2.0
        InventoryConfig.Collector.CollectDelay = 1.0
        InventoryConfig.Safety.AntiDetection = true
        InventoryConfig.Safety.RandomDelays.Enabled = true
        InventoryConfig.Safety.RateLimits.MaxActionsPerSecond = 5
    end,
    
    -- Balanced preset (moderate speed and safety)
    Balanced = function()
        InventoryConfig.Duplicator.DuplicateDelay = 1.0
        InventoryConfig.Collector.CollectDelay = 0.5
        InventoryConfig.Safety.AntiDetection = true
        InventoryConfig.Safety.RateLimits.MaxActionsPerSecond = 10
    end,
    
    -- Aggressive preset (fast, higher risk)
    Aggressive = function()
        InventoryConfig.Duplicator.DuplicateDelay = 0.3
        InventoryConfig.Collector.CollectDelay = 0.1
        InventoryConfig.Safety.AntiDetection = false
        InventoryConfig.Safety.RateLimits.MaxActionsPerSecond = 20
    end,
    
    -- Stealth preset (slow but very safe)
    Stealth = function()
        InventoryConfig.Duplicator.DuplicateDelay = 3.0
        InventoryConfig.Collector.CollectDelay = 2.0
        InventoryConfig.Safety.StealthMode.Enabled = true
        InventoryConfig.Safety.RandomDelays.MaxDelay = 2.0
        InventoryConfig.Safety.RateLimits.MaxActionsPerSecond = 3
    end
}

--// ═══════════════════════════════════════════════════════════════
--// 🚀 QUICK SETUP FUNCTIONS
--// ═══════════════════════════════════════════════════════════════

-- Apply a preset configuration
function InventoryConfig:ApplyPreset(presetName)
    if self.Presets[presetName] then
        self.Presets[presetName]()
        print("✅ Applied preset: " .. presetName)
    else
        warn("❌ Preset not found: " .. presetName)
    end
end

-- Get optimized settings for specific game mode
function InventoryConfig:GetModeSettings(mode)
    local modes = {
        farming = "Balanced",
        grinding = "Aggressive", 
        casual = "Conservative",
        safe = "Stealth"
    }
    
    return modes[mode] or "Balanced"
end

-- Validate configuration
function InventoryConfig:Validate()
    local warnings = {}
    
    -- Check for potentially dangerous settings
    if self.Duplicator.DuplicateDelay < 0.5 then
        table.insert(warnings, "⚠️ Duplicate delay is very low - may cause detection")
    end
    
    if self.Collector.CollectDelay < 0.3 then
        table.insert(warnings, "⚠️ Collect delay is very low - may cause lag")
    end
    
    if self.Safety.RateLimits.MaxActionsPerSecond > 15 then
        table.insert(warnings, "⚠️ High action rate - may cause server stress")
    end
    
    -- Print warnings
    if #warnings > 0 then
        print("🔍 Configuration Warnings:")
        for _, warning in pairs(warnings) do
            print("  " .. warning)
        end
    else
        print("✅ Configuration validated - no issues found")
    end
    
    return #warnings == 0
end

return InventoryConfig
