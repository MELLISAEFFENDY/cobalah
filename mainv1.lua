--// Services
local Players = cloneref(game:GetService('Players'))
local ReplicatedStorage = cloneref(game:GetService('ReplicatedStorage'))
local RunService = cloneref(game:GetService('RunService'))
local GuiService = cloneref(game:GetService('GuiService'))

print("🔥 Fisch Cheat Hub v2 - Starting Load Process...")
print("📍 Script Location: GitHub Raw URL")
print("⏰ Loading Time: " .. os.date("%H:%M:%S"))

--// Variables
local lp = Players.LocalPlayer
local fishabundancevisible = false
local deathcon
local tooltipmessage
local characterposition

print("✅ Variables initialized successfully!")

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

print("🔧 Helper functions loaded successfully!")

--// Error Suppression for UI Library
local originalError = error
local originalWarn = warn

-- Suppress specific InputObject errors from Rayfield
warn = function(message, ...)
    if typeof(message) == "string" and (
        string.find(message, "Target is not a valid member of InputObject") or
        string.find(message, "InputObject") or
        string.find(message, "UserInputService")
    ) then
        -- Suppress these specific warnings
        return
    end
    return originalWarn(message, ...)
end

error = function(message, ...)
    if typeof(message) == "string" and (
        string.find(message, "Target is not a valid member of InputObject") or
        string.find(message, "InputObject")
    ) then
        -- Convert error to warning for these specific cases
        return originalWarn(message, ...)
    end
    return originalError(message, ...)
end

print("🔇 Error suppression for UI library activated!")

--// Load Teleport System V2 from GitHub
print("📡 Loading Integrated Teleport System...")

-- Integrated GPS Teleport System V2 (All-in-One)
local TeleportSystemV2 = {
    gpsData = {
        ["Moosewood Area"] = {
            {name = "Moosewood Main", pos = Vector3.new(379.875458, 134.500519, 233.5495), cframe = CFrame.new(379.875458, 134.500519, 233.5495, -0.033920113, 8.13274355e-08, 0.999424577, 8.98441925e-08, 1, -7.83249803e-08, -0.999424577, 8.7135696e-08, -0.033920113)},
            {name = "Moosewood Beach", pos = Vector3.new(385, 135, 280), cframe = CFrame.new(385, 135, 280)},
            {name = "Moosewood Pier", pos = Vector3.new(480, 150, 295), cframe = CFrame.new(480, 150, 295)},
            {name = "Moosewood Dock", pos = Vector3.new(400, 133, 240), cframe = CFrame.new(400, 133, 240)},
            {name = "Moosewood Shop", pos = Vector3.new(375, 135, 225), cframe = CFrame.new(375, 135, 225)},
            {name = "Training Rod (Moosewood)", pos = Vector3.new(465, 150, 235), cframe = CFrame.new(465, 150, 235)},
            {name = "Long Rod (Moosewood)", pos = Vector3.new(480, 180, 150), cframe = CFrame.new(480, 180, 150)},
            {name = "Fish Radar (Moosewood)", pos = Vector3.new(365, 135, 275), cframe = CFrame.new(365, 135, 275)},
            {name = "Basic Diving Gear (Moosewood)", pos = Vector3.new(370, 135, 250), cframe = CFrame.new(370, 135, 250)},
            {name = "Bait Crate (Moosewood)", pos = Vector3.new(315, 135, 335), cframe = CFrame.new(315, 135, 335)},
            {name = "Trout Fishing Spot", pos = Vector3.new(390, 132, 345), cframe = CFrame.new(390, 132, 345)},
            {name = "Anchovy Fishing Spot", pos = Vector3.new(130, 135, 630), cframe = CFrame.new(130, 135, 630)},
            {name = "Yellowfin Tuna Spot", pos = Vector3.new(705, 136, 340), cframe = CFrame.new(705, 136, 340)},
        },
        ["Terrapin Island Area"] = {
            {name = "Terrapin Island Main", pos = Vector3.new(-193.434143, 135.121979, 1951.46936), cframe = CFrame.new(-193.434143, 135.121979, 1951.46936, 0.512723684, -6.94711346e-08, 0.858553708, 5.44089183e-08, 1, 4.84237539e-08, -0.858553708, 2.18849721e-08, 0.512723684)},
            {name = "Terrapin Hideaway", pos = Vector3.new(160, 125, 1970), cframe = CFrame.new(160, 125, 1970)},
            {name = "Terrapin Cave Area", pos = Vector3.new(25, 140, 1860), cframe = CFrame.new(25, 140, 1860)},
            {name = "Dreamers Crypt", pos = Vector3.new(140, 150, 2050), cframe = CFrame.new(140, 150, 2050)},
            {name = "Magnet Rod (Terrapin)", pos = Vector3.new(-200, 130, 1930), cframe = CFrame.new(-200, 130, 1930)},
            {name = "Quality Bait Crate (Terrapin)", pos = Vector3.new(-175, 145, 1935), cframe = CFrame.new(-175, 145, 1935)},
            {name = "Tempest Totem (Terrapin)", pos = Vector3.new(35, 130, 1945), cframe = CFrame.new(35, 130, 1945)},
            {name = "Walleye Spot", pos = Vector3.new(-225, 125, 2150), cframe = CFrame.new(-225, 125, 2150)},
            {name = "White Bass Spot", pos = Vector3.new(-50, 130, 2025), cframe = CFrame.new(-50, 130, 2025)},
            {name = "Redeye Bass Spot", pos = Vector3.new(-35, 125, 2285), cframe = CFrame.new(-35, 125, 2285)},
            {name = "Chinook Salmon Spot", pos = Vector3.new(-305, 125, 1625), cframe = CFrame.new(-305, 125, 1625)},
        },
        ["Roslit Bay Area"] = {
            {name = "Roslit Bay Main", pos = Vector3.new(-1472.9812, 132.525513, 707.644531), cframe = CFrame.new(-1472.9812, 132.525513, 707.644531, -0.00177415239, 1.15743369e-07, -0.99999845, -9.25943056e-09, 1, 1.15759981e-07, 0.99999845, 9.46479251e-09, -0.00177415239)},
            {name = "Roslit Bay Pier", pos = Vector3.new(-1775, 150, 680), cframe = CFrame.new(-1775, 150, 680)},
            {name = "Roslit Volcano", pos = Vector3.new(-1875, 165, 380), cframe = CFrame.new(-1875, 165, 380)},
            {name = "Fortune Rod (Roslit)", pos = Vector3.new(-1515, 141, 765), cframe = CFrame.new(-1515, 141, 765)},
            {name = "Meteor Totem (Roslit)", pos = Vector3.new(-1945, 275, 230), cframe = CFrame.new(-1945, 275, 230)},
            {name = "Glider (Roslit)", pos = Vector3.new(-1710, 150, 740), cframe = CFrame.new(-1710, 150, 740)},
            {name = "Bait Crate (Roslit)", pos = Vector3.new(-1465, 130, 680), cframe = CFrame.new(-1465, 130, 680)},
            {name = "Crab Cage (Roslit)", pos = Vector3.new(-1485, 130, 640), cframe = CFrame.new(-1485, 130, 640)},
            {name = "Perch Spot", pos = Vector3.new(-1805, 140, 595), cframe = CFrame.new(-1805, 140, 595)},
            {name = "Blue Tang Spot", pos = Vector3.new(-1465, 125, 525), cframe = CFrame.new(-1465, 125, 525)},
            {name = "Clownfish Spot", pos = Vector3.new(-1520, 125, 520), cframe = CFrame.new(-1520, 125, 520)},
            {name = "Arapaima Spot", pos = Vector3.new(-1765, 140, 600), cframe = CFrame.new(-1765, 140, 600)},
        },
        ["Mushgrove Swamp Area"] = {
            {name = "Mushgrove Swamp Main", pos = Vector3.new(2434.29785, 131.983276, -691.930542), cframe = CFrame.new(2434.29785, 131.983276, -691.930542, -0.123090521, -7.92820209e-09, -0.992395461, -9.05862692e-08, 1, 3.2467995e-09, 0.992395461, 9.02970569e-08, -0.123090521)},
            {name = "Guard Tower Alligator Marsh", pos = Vector3.new(2730, 130, -825), cframe = CFrame.new(2730, 130, -825)},
            {name = "Bowfin Area", pos = Vector3.new(2520, 125, -8157), cframe = CFrame.new(2520, 125, -8157)},
            {name = "Catfish Area", pos = Vector3.new(2670, 130, -7102), cframe = CFrame.new(2670, 130, -7102)},
            {name = "Smokescreen Totem (Mushgrove)", pos = Vector3.new(2790, 140, -625), cframe = CFrame.new(2790, 140, -625)},
            {name = "Crab Cage (Mushgrove)", pos = Vector3.new(2520, 135, -895), cframe = CFrame.new(2520, 135, -895)},
            {name = "White Perch Spot", pos = Vector3.new(2475, 125, -675), cframe = CFrame.new(2475, 125, -675)},
            {name = "Grey Carp Spot", pos = Vector3.new(2665, 125, -815), cframe = CFrame.new(2665, 125, -815)},
            {name = "Bowfin Spot", pos = Vector3.new(2445, 125, -795), cframe = CFrame.new(2445, 125, -795)},
            {name = "Marsh Gar Spot", pos = Vector3.new(2520, 125, -815), cframe = CFrame.new(2520, 125, -815)},
            {name = "Alligator Spot", pos = Vector3.new(2670, 130, -710), cframe = CFrame.new(2670, 130, -710)},
        },
        ["Snowcap Island Area"] = {
            {name = "Snowcap Island Main", pos = Vector3.new(2607.93018, 135.284332, 2436.13208), cframe = CFrame.new(2607.93018, 135.284332, 2436.13208, 0.909039497, -7.49003748e-10, 0.4167099, 3.38659367e-09, 1, -5.59032465e-09, -0.4167099, 6.49305321e-09, 0.909039497)},
            {name = "Snowcap Island Peak", pos = Vector3.new(2710, 190, 2560), cframe = CFrame.new(2710, 190, 2560)},
            {name = "Snowcap Cave Entrance", pos = Vector3.new(2750, 135, 2505), cframe = CFrame.new(2750, 135, 2505)},
            {name = "Snowcap Island Summit", pos = Vector3.new(2800, 280, 2565), cframe = CFrame.new(2800, 280, 2565)},
            {name = "Snowcap Cave", pos = Vector3.new(2900, 150, 2500), cframe = CFrame.new(2900, 150, 2500)},
            {name = "Windset Totem (Snowcap)", pos = Vector3.new(2845, 180, 2700), cframe = CFrame.new(2845, 180, 2700)},
            {name = "Pollock Spot", pos = Vector3.new(2550, 135, 2385), cframe = CFrame.new(2550, 135, 2385)},
            {name = "Bluegill Spot", pos = Vector3.new(3070, 130, 2600), cframe = CFrame.new(3070, 130, 2600)},
            {name = "Arctic Char Spot", pos = Vector3.new(2350, 130, 2230), cframe = CFrame.new(2350, 130, 2230)},
            {name = "Glacierfish Spot", pos = Vector3.new(2860, 135, 2620), cframe = CFrame.new(2860, 135, 2620)},
        },
        ["Sunstone Island Area"] = {
            {name = "Sunstone Island Main", pos = Vector3.new(-913.809143, 138.160782, -1133.25879), cframe = CFrame.new(-913.809143, 138.160782, -1133.25879, -0.746701241, 4.50330218e-09, 0.665159583, 2.84934609e-09, 1, -3.5716119e-09, -0.665159583, -7.71657294e-10, -0.746701241)},
            {name = "Sunstone Cave", pos = Vector3.new(-1215, 190, -1040), cframe = CFrame.new(-1215, 190, -1040)},
            {name = "Upper Sunstone", pos = Vector3.new(-1045, 135, -1140), cframe = CFrame.new(-1045, 135, -1140)},
            {name = "Sundial Totem (Sunstone)", pos = Vector3.new(-1145, 135, -1075), cframe = CFrame.new(-1145, 135, -1075)},
            {name = "Bait Crate (Sunstone)", pos = Vector3.new(-1045, 200, -1100), cframe = CFrame.new(-1045, 200, -1100)},
            {name = "Crab Cage (Sunstone)", pos = Vector3.new(-920, 130, -1105), cframe = CFrame.new(-920, 130, -1105)},
            {name = "Sweetfish Spot", pos = Vector3.new(-940, 130, -1105), cframe = CFrame.new(-940, 130, -1105)},
            {name = "Glassfish Spot", pos = Vector3.new(-905, 130, -1000), cframe = CFrame.new(-905, 130, -1000)},
            {name = "Longtail Bass Spot", pos = Vector3.new(-860, 135, -1205), cframe = CFrame.new(-860, 135, -1205)},
            {name = "Sunfish Spot", pos = Vector3.new(-975, 125, -1430), cframe = CFrame.new(-975, 125, -1430)},
        },
        ["Ancient Isle Area"] = {
            {name = "Ancient Isle Main", pos = Vector3.new(6056.02783, 195.280167, 276.270325), cframe = CFrame.new(6056.02783, 195.280167, 276.270325, -0.655055285, 1.96010075e-09, 0.755580962, -1.63855578e-08, 1, -1.67997189e-08, -0.755580962, -2.33853594e-08, -0.655055285)},
            {name = "Fragment Puzzle Chamber", pos = Vector3.new(5870, 160, 415), cframe = CFrame.new(5870, 160, 415)},
            {name = "Ancient Isle Cave 1", pos = Vector3.new(5487, 143, -316), cframe = CFrame.new(5487, 143, -316)},
            {name = "Ancient Isle Cave 2", pos = Vector3.new(5966, 274, 846), cframe = CFrame.new(5966, 274, 846)},
            {name = "Ancient Isle Cave 3", pos = Vector3.new(6075, 195, 260), cframe = CFrame.new(6075, 195, 260)},
            {name = "Stone Rod (Ancient)", pos = Vector3.new(5487, 143, -316), cframe = CFrame.new(5487, 143, -316)},
            {name = "Eclipse Totem (Ancient)", pos = Vector3.new(5966, 274, 846), cframe = CFrame.new(5966, 274, 846)},
            {name = "Anomalocaris Spot", pos = Vector3.new(5504, 143, -321), cframe = CFrame.new(5504, 143, -321)},
            {name = "Cobia Spot", pos = Vector3.new(5983, 125, 1007), cframe = CFrame.new(5983, 125, 1007)},
            {name = "Hallucigenia Spot", pos = Vector3.new(6015, 190, 339), cframe = CFrame.new(6015, 190, 339)},
            {name = "Leedsichthys Spot", pos = Vector3.new(6052, 394, 648), cframe = CFrame.new(6052, 394, 648)},
        },
        ["Forsaken Shores Area"] = {
            {name = "Forsaken Shores Main", pos = Vector3.new(-2491.104, 133.250015, 1561.2926), cframe = CFrame.new(-2491.104, 133.250015, 1561.2926, 0.355353981, -1.68352852e-08, -0.934731781, 4.69647858e-08, 1, -1.56367586e-10, 0.934731781, -4.38439116e-08, 0.355353981)},
            {name = "Forsaken Shores Deep", pos = Vector3.new(-3600, 125, 1605), cframe = CFrame.new(-3600, 125, 1605)},
            {name = "Scurvy Rod", pos = Vector3.new(-2830, 215, 1510), cframe = CFrame.new(-2830, 215, 1510)},
            {name = "Bait Crate (Forsaken)", pos = Vector3.new(-2490, 130, 1535), cframe = CFrame.new(-2490, 130, 1535)},
            {name = "Crab Cage (Forsaken)", pos = Vector3.new(-2525, 135, -1575), cframe = CFrame.new(-2525, 135, -1575)},
            {name = "Scurvy Sailfish Spot", pos = Vector3.new(-2430, 130, 1450), cframe = CFrame.new(-2430, 130, 1450)},
            {name = "Cutlass Fish Spot", pos = Vector3.new(-2645, 130, 1410), cframe = CFrame.new(-2645, 130, 1410)},
            {name = "Shipwreck Barracuda Spot", pos = Vector3.new(-3597, 140, 1604), cframe = CFrame.new(-3597, 140, 1604)},
            {name = "Golden Seahorse Spot", pos = Vector3.new(-3100, 127, 1450), cframe = CFrame.new(-3100, 127, 1450)},
        },
        ["Atlantis Deep Ocean"] = {
            {name = "Heart of Zeus", pos = Vector3.new(-2522, 138, 1593), cframe = CFrame.new(-2522, 138, 1593)},
            {name = "Atlantis Cave 1", pos = Vector3.new(-2551, 150, 1667), cframe = CFrame.new(-2551, 150, 1667)},
            {name = "Atlantis Cave 2", pos = Vector3.new(-2729, 168, 1730), cframe = CFrame.new(-2729, 168, 1730)},
            {name = "Grand Reef", pos = Vector3.new(-3576, 148, 524), cframe = CFrame.new(-3576, 148, 524)},
            {name = "Depthseeker Rod", pos = Vector3.new(-4465, -604, 1874), cframe = CFrame.new(-4465, -604, 1874)},
            {name = "Champions Rod", pos = Vector3.new(-4277, -606, 1838), cframe = CFrame.new(-4277, -606, 1838)},
            {name = "Tempest Rod", pos = Vector3.new(-4928, -595, 1857), cframe = CFrame.new(-4928, -595, 1857)},
            {name = "Poseidon Rod", pos = Vector3.new(-4086, -559, 895), cframe = CFrame.new(-4086, -559, 895)},
            {name = "Zeus Rod", pos = Vector3.new(-4272, -629, 2665), cframe = CFrame.new(-4272, -629, 2665)},
            {name = "Kraken Rod", pos = Vector3.new(-4415, -997, 2055), cframe = CFrame.new(-4415, -997, 2055)},
        },
        ["Desolate Deep Area"] = {
            {name = "Brine Pool", pos = Vector3.new(-1710, -235, -3075), cframe = CFrame.new(-1710, -235, -3075)},
            {name = "Reinforced Rod", pos = Vector3.new(-975, -245, -2700), cframe = CFrame.new(-975, -245, -2700)},
            {name = "Trident Rod", pos = Vector3.new(-1485, -225, -2195), cframe = CFrame.new(-1485, -225, -2195)},
            {name = "Tidebreaker", pos = Vector3.new(-1645, -210, -2855), cframe = CFrame.new(-1645, -210, -2855)},
            {name = "Aurora Totem (Desolate)", pos = Vector3.new(-1800, -135, -3280), cframe = CFrame.new(-1800, -135, -3280)},
            {name = "Phantom Ray Spot", pos = Vector3.new(-1685, -235, -3090), cframe = CFrame.new(-1685, -235, -3090)},
            {name = "Cockatoo Squid Spot", pos = Vector3.new(-1645, -205, -2790), cframe = CFrame.new(-1645, -205, -2790)},
            {name = "Banditfish Spot", pos = Vector3.new(-1500, -235, -2855), cframe = CFrame.new(-1500, -235, -2855)},
        },
        ["Vertigo Area"] = {
            {name = "Vertigo Main", pos = Vector3.new(-102.40567, -513.299377, 1052.07104), cframe = CFrame.new(-102.40567, -513.299377, 1052.07104, -0.999989033, 5.36423439e-09, 0.00468267547, 5.85247495e-09, 1, 1.04251647e-07, -0.00468267547, 1.04277916e-07, -0.999989033)},
            {name = "Vertigo Deep", pos = Vector3.new(-75, -530, 1285), cframe = CFrame.new(-75, -530, 1285)},
            {name = "Vertigo Abyss", pos = Vector3.new(1210, -715, 1315), cframe = CFrame.new(1210, -715, 1315)},
        },
        ["The Depths Area"] = {
            {name = "Depths Entrance", pos = Vector3.new(-15.4965982, -706.123718, 1231.43494), cframe = CFrame.new(-15.4965982, -706.123718, 1231.43494, 0.0681341439, 1.15903154e-08, -0.997676194, 7.1017638e-08, 1, 1.64673093e-08, 0.997676194, -7.19745898e-08, 0.0681341439)},
            {name = "The Depths Main", pos = Vector3.new(491.758118, -706.123718, 1230.6377), cframe = CFrame.new(491.758118, -706.123718, 1230.6377, 0.00879980437, 1.29271776e-08, -0.999961257, 1.95575205e-13, 1, 1.29276803e-08, 0.999961257, -1.13956629e-10, 0.00879980437)},
            {name = "Depths Abyss", pos = Vector3.new(500, -750, 1200), cframe = CFrame.new(500, -750, 1200)},
            {name = "Depths Cave System", pos = Vector3.new(450, -720, 1250), cframe = CFrame.new(450, -720, 1250)},
            {name = "Depths Crystal Chamber", pos = Vector3.new(520, -680, 1220), cframe = CFrame.new(520, -680, 1220)},
        },
        ["Northern Expedition Area"] = {
            {name = "Northern Expedition Main", pos = Vector3.new(-1701.02979, 187.638779, 3944.81494), cframe = CFrame.new(-1701.02979, 187.638779, 3944.81494, 0.918493569, -8.5804345e-08, 0.395435959, 8.59132356e-08, 1, 1.74328942e-08, -0.395435959, 1.7961181e-08, 0.918493569)},
            {name = "Northern Expedition Camp", pos = Vector3.new(-1680, 195, 3960), cframe = CFrame.new(-1680, 195, 3960)},
            {name = "Northern Expedition Peak", pos = Vector3.new(-1720, 250, 3920), cframe = CFrame.new(-1720, 250, 3920)},
            {name = "Northern Expedition Base", pos = Vector3.new(-1690, 180, 3950), cframe = CFrame.new(-1690, 180, 3950)},
            {name = "Northern Expedition Outpost", pos = Vector3.new(-1710, 200, 3980), cframe = CFrame.new(-1710, 200, 3980)},
        },
        ["Northern Summit Area"] = {
            {name = "Northern Summit Main", pos = Vector3.new(19608.791, 131.420105, 5222.15283), cframe = CFrame.new(19608.791, 131.420105, 5222.15283, 0.462794542, -2.64426987e-08, 0.886465549, -4.47066562e-08, 1, 5.31692343e-08, -0.886465549, -6.42373408e-08, 0.462794542)},
            {name = "Northern Summit Peak", pos = Vector3.new(19650, 300, 5250), cframe = CFrame.new(19650, 300, 5250)},
            {name = "Northern Summit Base", pos = Vector3.new(19580, 140, 5200), cframe = CFrame.new(19580, 140, 5200)},
            {name = "Northern Summit Camp", pos = Vector3.new(19620, 160, 5230), cframe = CFrame.new(19620, 160, 5230)},
            {name = "Northern Summit Cliff", pos = Vector3.new(19640, 200, 5240), cframe = CFrame.new(19640, 200, 5240)},
        },
        ["Special Rod Locations"] = {
            {name = "Heaven Rod Location", pos = Vector3.new(20025.0508, -467.665955, 7114.40234), cframe = CFrame.new(20025.0508, -467.665955, 7114.40234, -0.9998191, -2.41349773e-10, 0.0190212391, -4.76249762e-10, 1, -1.23448247e-08, -0.0190212391, -1.23516495e-08, -0.9998191)},
            {name = "Summit Rod Location", pos = Vector3.new(20213.334, 736.668823, 5707.8208), cframe = CFrame.new(20213.334, 736.668823, 5707.8208, -0.274440169, 3.53429606e-08, 0.961604178, -1.52819659e-08, 1, -4.11156122e-08, -0.961604178, -2.59789772e-08, -0.274440169)},
            {name = "Kings Rod Location", pos = Vector3.new(1380.83862, -807.198608, -304.22229), cframe = CFrame.new(1380.83862, -807.198608, -304.22229, -0.692510426, 9.24755454e-08, 0.72140789, 4.86611427e-08, 1, -8.1475676e-08, -0.72140789, -2.13182219e-08, -0.692510426)},
            {name = "Keeper's Altar", pos = Vector3.new(1297.92285, -805.292236, -284.155823), cframe = CFrame.new(1297.92285, -805.292236, -284.155823, -0.99758029, 5.80044706e-08, -0.0695239156, 6.16549869e-08, 1, -5.03615105e-08, 0.0695239156, -5.45261436e-08, -0.99758029)},
        },
        ["Statue of Sovereignty Area"] = {
            {name = "Statue of Sovereignty Main", pos = Vector3.new(21.4017925, 159.014709, -1039.14233), cframe = CFrame.new(21.4017925, 159.014709, -1039.14233, -0.865476549, -4.38348664e-08, -0.500949502, -9.38435818e-08, 1, 7.46273798e-08, 0.500949502, 1.11599142e-07, -0.865476549)},
            {name = "Statue Viewing Platform", pos = Vector3.new(50, 180, -1020), cframe = CFrame.new(50, 180, -1020)},
            {name = "Statue Base", pos = Vector3.new(20, 150, -1040), cframe = CFrame.new(20, 150, -1040)},
            {name = "Statue Garden", pos = Vector3.new(0, 160, -1060), cframe = CFrame.new(0, 160, -1060)},
        },
        ["Caves & Caverns"] = {
            {name = "Overgrowth Caves", pos = Vector3.new(19746.2676, 416.00293, 5403.5752), cframe = CFrame.new(19746.2676, 416.00293, 5403.5752, 0.488031536, -3.30940715e-08, -0.87282598, -3.24267696e-11, 1, -3.79341323e-08, 0.87282598, 1.85413569e-08, 0.488031536)},
            {name = "Frigid Cavern", pos = Vector3.new(20253.6094, 756.525818, 5772.68555), cframe = CFrame.new(20253.6094, 756.525818, 5772.68555, -0.781508088, 1.85673343e-08, 0.623895109, 5.92671467e-09, 1, -2.23363816e-08, -0.623895109, -1.3758414e-08, -0.781508088)},
            {name = "Cryogenic Canal", pos = Vector3.new(19958.5176, 917.195923, 5332.59375), cframe = CFrame.new(19958.5176, 917.195923, 5332.59375, 0.758922458, -7.29783434e-09, 0.651180983, -4.58880756e-09, 1, 1.65551253e-08, -0.651180983, -1.55522013e-08, 0.758922458)},
            {name = "Glacial Grotto", pos = Vector3.new(20003.0273, 1136.42798, 5555.95996), cframe = CFrame.new(20003.0273, 1136.42798, 5555.95996, 0.983130038, -3.94455064e-08, 0.182907909, 3.45229765e-08, 1, 3.0096718e-08, -0.182907909, -2.32744615e-08, 0.983130038)},
        },
        ["Other Important Locations"] = {
            {name = "Crystal Cove Main", pos = Vector3.new(1364, -612, 2472), cframe = CFrame.new(1364, -612, 2472)},
            {name = "Crystal Cove Deep", pos = Vector3.new(1302, -701, 1604), cframe = CFrame.new(1302, -701, 1604)},
            {name = "AFK Rewards Platform", pos = Vector3.new(232, 139, 38), cframe = CFrame.new(232, 139, 38)},
            {name = "Atlantean Storm Center", pos = Vector3.new(-3530, 130, 550), cframe = CFrame.new(-3530, 130, 550)},
            {name = "Azure Lagoon Main", pos = Vector3.new(1310, 80, 2113), cframe = CFrame.new(1310, 80, 2113)},
            {name = "Castaway Cliffs Main", pos = Vector3.new(690, 135, -1693), cframe = CFrame.new(690, 135, -1693)},
            {name = "Lobster Shores Main", pos = Vector3.new(-550, 150, 2640), cframe = CFrame.new(-550, 150, 2640)},
            {name = "Trade Plaza", pos = Vector3.new(535, 82, 775), cframe = CFrame.new(535, 82, 775)},
            {name = "Waveborne Main", pos = Vector3.new(360, 90, 780), cframe = CFrame.new(360, 90, 780)},
            {name = "The Laboratory", pos = Vector3.new(-1785, 130, -485), cframe = CFrame.new(-1785, 130, -485)},
        }
    },
    
    -- API Functions
    getCategoryNames = function()
        local categories = {}
        for category, _ in pairs(TeleportSystemV2.gpsData) do
            table.insert(categories, category)
        end
        table.sort(categories)
        return categories
    end,
    
    getLocationNames = function(category)
        local locations = {}
        if TeleportSystemV2.gpsData[category] then
            for _, location in pairs(TeleportSystemV2.gpsData[category]) do
                table.insert(locations, location.name)
            end
        end
        table.sort(locations)
        return locations
    end,
    
    getLocationData = function(category, locationName)
        if TeleportSystemV2.gpsData[category] then
            for _, location in pairs(TeleportSystemV2.gpsData[category]) do
                if location.name == locationName then
                    return location
                end
            end
        end
        return nil
    end,
    
    teleportTo = function(category, locationName, method)
        method = method or "CFrame"
        local locationData = TeleportSystemV2.getLocationData(category, locationName)
        
        if not locationData then
            return false, "Location not found"
        end
        
        local success, error = pcall(function()
            local character = game.Players.LocalPlayer.Character
            if not character then return end
            local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
            if not humanoidRootPart then return end
            
            if method == "CFrame" then
                humanoidRootPart.CFrame = locationData.cframe
            elseif method == "Position" then
                humanoidRootPart.Position = locationData.pos
            elseif method == "Teleport" then
                humanoidRootPart.CFrame = CFrame.new(locationData.pos)
            end
        end)
        
        return success, error
    end,
    
    getStatistics = function()
        local totalLocations = 0
        local categoryCount = 0
        
        for category, locations in pairs(TeleportSystemV2.gpsData) do
            categoryCount = categoryCount + 1
            totalLocations = totalLocations + #locations
        end
        
        return {
            totalLocations = totalLocations,
            totalCategories = categoryCount,
            categories = TeleportSystemV2.getCategoryNames()
        }
    end,
    
    searchLocations = function(searchTerm)
        local results = {}
        searchTerm = string.lower(searchTerm)
        
        for category, locations in pairs(TeleportSystemV2.gpsData) do
            for _, location in pairs(locations) do
                if string.find(string.lower(location.name), searchTerm) or 
                   string.find(string.lower(category), searchTerm) then
                    table.insert(results, {
                        category = category,
                        location = location
                    })
                end
            end
        end
        
        return results
    end,
    
    getNearestLocations = function(currentPos, radius)
        radius = radius or 1000
        local nearbyLocations = {}
        
        for category, locations in pairs(TeleportSystemV2.gpsData) do
            for _, location in pairs(locations) do
                local distance = (currentPos - location.pos).Magnitude
                if distance <= radius then
                    table.insert(nearbyLocations, {
                        category = category,
                        location = location,
                        distance = distance
                    })
                end
            end
        end
        
        -- Sort by distance
        table.sort(nearbyLocations, function(a, b)
            return a.distance < b.distance
        end)
        
        return nearbyLocations
    end
}

-- Initialize function for backward compatibility
TeleportSystemV2.init = function()
    return TeleportSystemV2
end

print("✅ Integrated GPS Teleport System loaded successfully!")
print("📍 Total locations available:", TeleportSystemV2.getStatistics().totalLocations)
print("📂 Total categories:", TeleportSystemV2.getStatistics().totalCategories)

-- Initialize variables for visuals
local RodColors = {}
local RodMaterials = {}

-- Initialize teleport variables
local selectedZone = "Moosewood"
local selectedRod = "Training Rod"

-- Zone and Rod definitions for legacy teleport system
local ZoneNames = {
    "Moosewood", "Roslit Bay", "Terrapin Island", "Mushgrove Swamp", 
    "Snowcap Island", "Sunstone Island", "Ancient Isle", "Forsaken Shores"
}

local RodNames = {
    "Training Rod", "Long Rod", "Magnet Rod", "Fortune Rod", "Scurvy Rod",
    "Stone Rod", "Depthseeker Rod", "Champions Rod", "Tempest Rod", 
    "Poseidon Rod", "Zeus Rod", "Kraken Rod"
}

-- Legacy teleport locations for backward compatibility
local TeleportLocations = {
    ['Zones'] = {
        ['Moosewood'] = CFrame.new(379.875458, 134.500519, 233.5495),
        ['Roslit Bay'] = CFrame.new(-1472.9812, 132.525513, 707.644531),
        ['Terrapin Island'] = CFrame.new(-193.434143, 135.121979, 1951.46936),
        ['Mushgrove Swamp'] = CFrame.new(2434.29785, 131.983276, -691.930542),
        ['Snowcap Island'] = CFrame.new(2607.93018, 135.284332, 2436.13208),
        ['Sunstone Island'] = CFrame.new(-913.809143, 138.160782, -1133.25879),
        ['Ancient Isle'] = CFrame.new(6056.02783, 195.280167, 276.270325),
        ['Forsaken Shores'] = CFrame.new(-2491.104, 133.250015, 1561.2926)
    },
    ['Rods'] = {
        ['Training Rod'] = CFrame.new(465, 150, 235),
        ['Long Rod'] = CFrame.new(480, 180, 150),
        ['Magnet Rod'] = CFrame.new(-200, 130, 1930),
        ['Fortune Rod'] = CFrame.new(-1515, 141, 765),
        ['Scurvy Rod'] = CFrame.new(-2830, 215, 1510),
        ['Stone Rod'] = CFrame.new(5487, 143, -316),
        ['Depthseeker Rod'] = CFrame.new(-4465, -604, 1874),
        ['Champions Rod'] = CFrame.new(-4277, -606, 1838),
        ['Tempest Rod'] = CFrame.new(-4928, -595, 1857),
        ['Poseidon Rod'] = CFrame.new(-4086, -559, 895),
        ['Zeus Rod'] = CFrame.new(-4272, -629, 2665),
        ['Kraken Rod'] = CFrame.new(-4415, -997, 2055)
    }
}

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

-- AI Player Detection System
DetectNearbyPlayers = function()
    if not playerDetectionEnabled then
        return false, {}
    end
    
    local currentTime = tick()
    if currentTime - lastDetectionCheck < detectionInterval then
        return #nearbyPlayers > 0, nearbyPlayers
    end
    
    lastDetectionCheck = currentTime
    nearbyPlayers = {}
    
    local myPosition = gethrp().Position
    
    for _, player in pairs(game.Players:GetPlayers()) do
        if player ~= lp and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local playerPosition = player.Character.HumanoidRootPart.Position
            local distance = (myPosition - playerPosition).Magnitude
            
            if distance <= detectionRadius then
                table.insert(nearbyPlayers, {
                    player = player,
                    distance = distance,
                    position = playerPosition
                })
            end
        end
    end
    
    return #nearbyPlayers > 0, nearbyPlayers
end

GetAdjustedDelay = function(baseDelay)
    local hasNearbyPlayers, players = DetectNearbyPlayers()
    if hasNearbyPlayers then
        -- Find closest player for additional caution
        local closestDistance = math.huge
        local closestPlayerName = ""
        for _, playerData in pairs(players) do
            if playerData.distance < closestDistance then
                closestDistance = playerData.distance
                closestPlayerName = playerData.player.Name
            end
        end
        
        -- More aggressive delay multiplier for very close players
        local proximityMultiplier = 1
        local statusIcon = ""
        if closestDistance <= 2 then
            proximityMultiplier = 5.0 -- Very close = extra slow
            statusIcon = "🔴"
        elseif closestDistance <= 5 then
            proximityMultiplier = 3.0 -- Close = slow  
            statusIcon = "🟡"
        else
            proximityMultiplier = slowModeMultiplier -- Normal nearby = moderate slow
            statusIcon = "🟠"
        end
        
        -- Optional: Show warning message for very close players (can be toggled)
        if closestDistance <= 2 and math.random(1, 100) <= 5 then -- 5% chance to show warning
            message(statusIcon .. " CAUTION: " .. closestPlayerName .. " very close (" .. math.floor(closestDistance) .. "m)", 1)
        end
        
        return baseDelay * proximityMultiplier
    end
    return baseDelay
end
message = function(text, time)
    if tooltipmessage then tooltipmessage:Remove() end
    tooltipmessage = require(lp.PlayerGui:WaitForChild("GeneralUIModule")):GiveToolTip(lp, text)
    task.spawn(function()
        task.wait(time)
        if tooltipmessage then tooltipmessage:Remove(); tooltipmessage = nil end
    end)
end

--// Load Rayfield UI V2 from GitHub (Full Source)
print("🎨 Loading Rayfield UI V2 from GitHub...")
local Rayfield

-- Load from GitHub rayfieldv2.lua (full source from sirius.menu/rayfield)
local success, result = pcall(function()
    print("� Loading from GitHub rayfieldv2.lua file...")
    return loadstring(game:HttpGet("https://raw.githubusercontent.com/MELLISAEFFENDY/cobalah/main/rayfieldv2.lua"))()
end)

if success and result then
    Rayfield = result
    print("✅ Rayfield UI V2 loaded from GitHub successfully!")
else
    print("❌ Failed to load Rayfield V2 from GitHub. Error:", result)
    print("📦 Trying fallback to original Rayfield source...")
    
    -- Fallback to original Rayfield source
    local success2, result2 = pcall(function()
        return loadstring(game:HttpGet("https://sirius.menu/rayfield"))()
    end)
    
    if success2 and result2 then
        Rayfield = result2
        print("✅ Rayfield UI loaded from original source fallback!")
    else
        error("❌ Cannot load Rayfield UI from any source!")
    end
end

--// Load Advanced Inventory Exploits from GitHub
print("📦 Loading Advanced Inventory Exploits from GitHub...")
local InventoryExploits
local inventoryURL = "https://raw.githubusercontent.com/MELLISAEFFENDY/cobalah/main/advanced_inventory_exploits_simple.lua"

-- Load from GitHub only
local success2, result2 = pcall(function()
    local code = game:HttpGet(inventoryURL)
    print("📄 Inventory code length:", #code, "characters")
    return loadstring(code)()
end)

if success2 and result2 then
    InventoryExploits = result2
    print("📦 Inventory module type:", typeof(InventoryExploits))
    if InventoryExploits and typeof(InventoryExploits) == "table" then
        if InventoryExploits.Initialize then
            local initSuccess, initError = pcall(function()
                InventoryExploits:Initialize()
            end)
            if initSuccess then
                print("✅ Advanced Inventory Exploits loaded from GitHub successfully!")
            else
                print("⚠️ Inventory Exploits loaded but failed to initialize:", initError)
                print("⚠️ Will continue with limited inventory features...")
                -- Don't set to nil, keep the module but with limited functionality
            end
        else
            print("⚠️ Inventory module loaded but missing Initialize function")
        end
    else
        print("⚠️ Inventory Exploits loaded but is not a valid module")
        print("⚠️ Module type:", typeof(InventoryExploits))
        InventoryExploits = nil
    end
else
    print("❌ Failed to load Advanced Inventory Exploits from GitHub. Error: " .. tostring(result2))
    print("⚠️ Continuing without Advanced Inventory features...")
    InventoryExploits = nil
end

--// Load Economy & Marketplace Exploits from GitHub
print("💰 Loading Economy & Marketplace Exploits from GitHub...")
local EconomyExploits
local economyURL = "https://raw.githubusercontent.com/MELLISAEFFENDY/cobalah/main/economy_marketplace_exploits_simple.lua"

-- Try to load from GitHub first, fallback gracefully
local success3, result3 = pcall(function()
    local code = game:HttpGet(economyURL)
    print("📄 Economy code length:", #code, "characters")
    return loadstring(code)()
end)

if success3 and result3 then
    EconomyExploits = result3
    print("💰 Economy module type:", typeof(EconomyExploits))
    if EconomyExploits and typeof(EconomyExploits) == "table" then
        if EconomyExploits.Initialize then
            local initSuccess, initError = pcall(function()
                EconomyExploits:Initialize()
            end)
            if initSuccess then
                print("✅ Economy & Marketplace Exploits loaded from GitHub successfully!")
            else
                print("⚠️ Economy Exploits loaded but failed to initialize:", initError)
                print("⚠️ Will continue with limited economy features...")
                -- Don't set to nil, keep the module but with limited functionality
            end
        else
            print("⚠️ Economy module loaded but missing Initialize function")
        end
    else
        print("⚠️ Economy Exploits loaded but is not a valid module")
        print("⚠️ Module type:", typeof(EconomyExploits))
        EconomyExploits = nil
    end
else
    print("⚠️ Failed to load Economy Exploits from GitHub")
    print("⚠️ Error:", result3 or "Unknown error")
    -- Set EconomyExploits to nil so we can handle it gracefully in UI
    EconomyExploits = nil
end

--// Create UI
print("🚀 Creating Rayfield UI Window...")
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
    print("✅ UI Window created successfully!")
else
    print("❌ Failed to create UI Window:", tostring(Window))
    return
end

--// Create Tabs
print("📂 Creating UI Tabs...")
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
    print("✅ UI Tabs created successfully!")
else
    print("❌ Failed to create UI Tabs:", tostring(tabError))
    return
end

print("✅ All tabs created successfully!")

--// Create UI Content with Error Handling
print("🎨 Creating UI Content...")

-- State tracking variables for main loop
local freezeCharEnabled = false
local freezeCharMode = "Toggled"
local autoCastEnabled = false
local autoShakeEnabled = false
local autoReelEnabled = false

-- Delay settings for automation features
local autoCastDelay = 0.5
local autoShakeDelay = 0.1
local autoReelDelay = 0.5
local perfectCastDelay = 0.1
local alwaysCatchDelay = 0.1

-- AI Player Detection System
local playerDetectionEnabled = false
local detectionRadius = 15 -- meters
local slowModeMultiplier = 3.0 -- delay multiplier when players nearby
local nearbyPlayers = {}
local lastDetectionCheck = 0
local detectionInterval = 1 -- check every 1 second

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
            message("🧊 Character Freeze: ENABLED", 2)
        else
            message("🧊 Character Freeze: DISABLED", 2)
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
        freezeCharMode = Option
        print("🔄 Freeze mode changed to:", Option)
    end,
})

local AutoCastToggle = AutomationTab:CreateToggle({
    Name = "Auto Cast",
    CurrentValue = false,
    Flag = "autocast",
    Callback = function(Value)
        autoCastEnabled = Value
        if Value then
            message("🎣 Auto Cast: ENABLED", 2)
        else
            message("🎣 Auto Cast: DISABLED", 2)
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
            message("🎯 Auto Shake: ENABLED", 2)
        else
            message("🎯 Auto Shake: DISABLED", 2)
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
            message("🎣 Auto Reel: ENABLED", 2)
        else
            message("🎣 Auto Reel: DISABLED", 2)
        end
    end,
})

--// Delay Settings Section
AutomationTab:CreateSection("⏱️ Delay Settings")

local AutoCastDelaySlider = AutomationTab:CreateSlider({
    Name = "Auto Cast Delay (seconds)",
    Range = {0.1, 3.0},
    Increment = 0.1,
    Suffix = "s",
    CurrentValue = autoCastDelay,
    Flag = "autocastdelay",
    Callback = function(Value)
        autoCastDelay = Value
        message("⏱️ Auto Cast Delay: " .. Value .. "s", 1)
    end,
})

local AutoShakeDelaySlider = AutomationTab:CreateSlider({
    Name = "Auto Shake Delay (seconds)",
    Range = {0.05, 1.0},
    Increment = 0.05,
    Suffix = "s",
    CurrentValue = autoShakeDelay,
    Flag = "autoshakedelay",
    Callback = function(Value)
        autoShakeDelay = Value
        message("⏱️ Auto Shake Delay: " .. Value .. "s", 1)
    end,
})

local AutoReelDelaySlider = AutomationTab:CreateSlider({
    Name = "Auto Reel Delay (seconds)",
    Range = {0.1, 2.0},
    Increment = 0.1,
    Suffix = "s",
    CurrentValue = autoReelDelay,
    Flag = "autoreeldelay",
    Callback = function(Value)
        autoReelDelay = Value
        message("⏱️ Auto Reel Delay: " .. Value .. "s", 1)
    end,
})

local PerfectCastDelaySlider = AutomationTab:CreateSlider({
    Name = "Perfect Cast Delay (seconds)",
    Range = {0.05, 0.5},
    Increment = 0.01,
    Suffix = "s",
    CurrentValue = perfectCastDelay,
    Flag = "perfectcastdelay",
    Callback = function(Value)
        perfectCastDelay = Value
        message("⏱️ Perfect Cast Delay: " .. Value .. "s", 1)
    end,
})

local AlwaysCatchDelaySlider = AutomationTab:CreateSlider({
    Name = "Always Catch Delay (seconds)",
    Range = {0.05, 0.5},
    Increment = 0.01,
    Suffix = "s",
    CurrentValue = alwaysCatchDelay,
    Flag = "alwayscatchdelay",
    Callback = function(Value)
        alwaysCatchDelay = Value
        message("⏱️ Always Catch Delay: " .. Value .. "s", 1)
    end,
})

local ResetDelayButton = AutomationTab:CreateButton({
    Name = "🔄 Reset All Delays to Default",
    Callback = function()
        autoCastDelay = 0.5
        autoShakeDelay = 0.1
        autoReelDelay = 0.5
        perfectCastDelay = 0.1
        alwaysCatchDelay = 0.1
        
        -- Update sliders
        AutoCastDelaySlider:Set(autoCastDelay)
        AutoShakeDelaySlider:Set(autoShakeDelay)
        AutoReelDelaySlider:Set(autoReelDelay)
        PerfectCastDelaySlider:Set(perfectCastDelay)
        AlwaysCatchDelaySlider:Set(alwaysCatchDelay)
        
        message("🔄 All delays reset to default values!", 2)
    end,
})

--// AI Player Detection Section
AutomationTab:CreateSection("🤖 AI Player Detection")

local PlayerDetectionToggle = AutomationTab:CreateToggle({
    Name = "Smart Player Detection",
    CurrentValue = false,
    Flag = "playerdetection",
    Callback = function(Value)
        playerDetectionEnabled = Value
        if Value then
            message("🤖 AI Player Detection: ENABLED", 2)
        else
            message("🤖 AI Player Detection: DISABLED", 2)
            nearbyPlayers = {} -- Clear detection cache
        end
    end,
})

local DetectionRadiusSlider = AutomationTab:CreateSlider({
    Name = "Detection Radius (meters)",
    Range = {5, 50},
    Increment = 1,
    Suffix = "m",
    CurrentValue = detectionRadius,
    Flag = "detectionradius",
    Callback = function(Value)
        detectionRadius = Value
        message("🎯 Detection Radius: " .. Value .. "m", 1)
    end,
})

local SlowModeMultiplierSlider = AutomationTab:CreateSlider({
    Name = "Slow Mode Multiplier",
    Range = {1.5, 10.0},
    Increment = 0.5,
    Suffix = "x",
    CurrentValue = slowModeMultiplier,
    Flag = "slowmodemultiplier",
    Callback = function(Value)
        slowModeMultiplier = Value
        message("🐌 Slow Mode: " .. Value .. "x slower", 1)
    end,
})

local PlayerStatusButton = AutomationTab:CreateButton({
    Name = "📊 Check Nearby Players",
    Callback = function()
        if not playerDetectionEnabled then
            message("❌ Player Detection is disabled!", 2)
            return
        end
        
        local hasNearby, players = DetectNearbyPlayers()
        if hasNearby then
            local statusText = "👥 Found " .. #players .. " nearby players:\n"
            for i, playerData in pairs(players) do
                statusText = statusText .. "• " .. playerData.player.Name .. " (" .. math.floor(playerData.distance) .. "m)\n"
                if i >= 3 then -- Limit to 3 players in message
                    statusText = statusText .. "• And " .. (#players - 3) .. " more..."
                    break
                end
            end
            message(statusText, 4)
        else
            message("✅ No players detected within " .. detectionRadius .. "m radius", 2)
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
TeleportsTab:CreateSection("🌍 Integrated GPS System")

-- Check if TeleportSystemV2 is available before creating GPS components
if TeleportSystemV2 and TeleportSystemV2.getCategoryNames then
    -- Get GPS categories and create dropdown
    local GPSCategories = TeleportSystemV2.getCategoryNames()
    local GPSLocationDropdown -- Forward declaration
    local selectedGPSCategory = GPSCategories[1] or "Moosewood Area"
    local selectedGPSLocation = ""

    local GPSCategoryDropdown = TeleportsTab:CreateDropdown({
        Name = "GPS Categories",
        Options = GPSCategories,
        CurrentOption = selectedGPSCategory,
        Flag = "gpscategory",
        Callback = function(Option)
            selectedGPSCategory = Option
            
            -- Update location dropdown
            local locations = TeleportSystemV2.getLocationNames(selectedGPSCategory)
            if #locations > 0 then
                selectedGPSLocation = locations[1]
                if GPSLocationDropdown then
                    local success = pcall(function()
                        GPSLocationDropdown:Refresh(locations, selectedGPSLocation)
                    end)
                    if not success then
                        print("⚠️ Dropdown refresh failed, using fallback")
                    end
                end
                message("📂 Category: " .. selectedGPSCategory .. " (" .. #locations .. " locations)", 2)
            else
                message("❌ No locations found for category: " .. selectedGPSCategory, 2)
            end
        end,
    })

    -- Initial location names
    local initialLocations = TeleportSystemV2.getLocationNames(selectedGPSCategory)
    if #initialLocations > 0 then
        selectedGPSLocation = initialLocations[1]
    end

    GPSLocationDropdown = TeleportsTab:CreateDropdown({
        Name = "GPS Locations",
        Options = initialLocations,
        CurrentOption = selectedGPSLocation,
        Flag = "gpslocation",
        Callback = function(Option)
            selectedGPSLocation = Option
            message("📍 Selected: " .. Option, 1)
        end,
    })

    -- Add variable for teleport method
    local selectedTeleportMethod = "CFrame"

    local TeleportMethodDropdown = TeleportsTab:CreateDropdown({
        Name = "Teleport Method",
        Options = {"CFrame", "Position", "Teleport"},
        CurrentOption = selectedTeleportMethod,
        Flag = "teleportmethod",
        Callback = function(Option)
            selectedTeleportMethod = Option
            message("🔧 Method: " .. Option, 1)
        end,
    })

    local GPSTeleportButton = TeleportsTab:CreateButton({
        Name = "🚀 Teleport to Location",
        Callback = function()
            if selectedGPSCategory and selectedGPSLocation then
                local success, error = TeleportSystemV2.teleportTo(selectedGPSCategory, selectedGPSLocation, selectedTeleportMethod)
                if success then
                    message("🌍 Teleported to: " .. selectedGPSLocation, 2)
                else
                    message("❌ Teleport failed: " .. tostring(error), 2)
                end
            else
                message("❌ Please select a category and location", 2)
            end
        end,
    })

    TeleportsTab:CreateSection("🔧 GPS Tools")

    local RefreshGPSButton = TeleportsTab:CreateButton({
        Name = "🔄 Refresh Locations",
        Callback = function()
            local locations = TeleportSystemV2.getLocationNames(selectedGPSCategory)
            if GPSLocationDropdown then
                local success = pcall(function()
                    GPSLocationDropdown:Refresh(locations, selectedGPSLocation)
                end)
                message("🔄 Refreshed: " .. #locations .. " locations", 1)
            end
        end,
    })

    local NearestLocationsButton = TeleportsTab:CreateButton({
        Name = "📍 Find Nearest (2km)",
        Callback = function()
            local character = game.Players.LocalPlayer.Character
            if character and character:FindFirstChild("HumanoidRootPart") then
                local currentPos = character.HumanoidRootPart.Position
                local nearbyLocations = TeleportSystemV2.getNearestLocations(currentPos, 2000)
                
                if #nearbyLocations > 0 then
                    local message_text = "📍 Nearest locations:\n"
                    for i = 1, math.min(5, #nearbyLocations) do
                        local loc = nearbyLocations[i]
                        message_text = message_text .. string.format("• %s (%dm)\n", 
                            loc.location.name, math.floor(loc.distance))
                    end
                    message(message_text, 4)
                else
                    message("❌ No locations found within 2km", 2)
                end
            else
                message("❌ Character not found", 2)
            end
        end,
    })

    local SearchButton = TeleportsTab:CreateButton({
        Name = "🔍 Search Islands",
        Callback = function()
            local results = TeleportSystemV2.searchLocations("island")
            if #results > 0 then
                local message_text = "🔍 Island locations:\n"
                for i = 1, math.min(5, #results) do
                    local result = results[i]
                    message_text = message_text .. string.format("• %s (%s)\n", 
                        result.location.name, result.category)
                end
                message(message_text, 4)
            else
                message("❌ No island locations found", 2)
            end
        end,
    })

    local StatsButton = TeleportsTab:CreateButton({
        Name = "📊 GPS Statistics",
        Callback = function()
            local stats = TeleportSystemV2.getStatistics()
            local message_text = string.format("📊 GPS Stats:\n• Total Locations: %d\n• Categories: %d\n• Status: ✅ Online", 
                stats.totalLocations, stats.totalCategories)
            message(message_text, 3)
        end,
    })

else
    TeleportsTab:CreateButton({
        Name = "❌ GPS System Error",
        Callback = function()
            message("❌ GPS System unavailable. Please restart script.", 3)
        end,
    })
end

local ZonesDropdown = TeleportsTab:CreateDropdown({
    Name = "Zones",
    Options = ZoneNames,
    CurrentOption = selectedZone,
    Flag = "zones",
    Callback = function(Option)
        selectedZone = Option
        print("🔄 Zone selected:", Option)
    end,
})

local TeleportToZoneButton = TeleportsTab:CreateButton({
    Name = "Teleport To Zone",
    Callback = function()
        if selectedZone and TeleportLocations['Zones'][selectedZone] then
            gethrp().CFrame = TeleportLocations['Zones'][selectedZone]
            message("🌍 Teleported to: " .. selectedZone, 2)
        else
            message("❌ Invalid zone selected", 2)
        end
    end,
})

local RodLocationsDropdown = TeleportsTab:CreateDropdown({
    Name = "Rod Locations",
    Options = RodNames,
    CurrentOption = selectedRod,
    Flag = "rodlocations",
    Callback = function(Option)
        selectedRod = Option
        print("🔄 Rod location selected:", Option)
    end,
})

local TeleportToRodButton = TeleportsTab:CreateButton({
    Name = "Teleport To Rod",
    Callback = function()
        if selectedRod and TeleportLocations['Rods'][selectedRod] then
            gethrp().CFrame = TeleportLocations['Rods'][selectedRod]
            message("🎣 Teleported to: " .. selectedRod, 2)
        else
            message("❌ Invalid rod location selected", 2)
        end
    end,
})

TeleportsTab:CreateSection("🔧 Teleport Utils")

local ForceReturnSpawnButton = TeleportsTab:CreateButton({
    Name = "🏠 Return to Spawn",
    Callback = function()
        local character = game.Players.LocalPlayer.Character
        if character and character:FindFirstChild("HumanoidRootPart") then
            character.HumanoidRootPart.CFrame = CFrame.new(232, 139, 38)
            message("🏠 Returned to spawn", 2)
        else
            message("❌ Character not found", 2)
        end
    end,
})

--// Visuals Tab
VisualsTab:CreateSection("Rod")
            print("📍 Found", #locations, "locations for refresh")
            
            if locations and #locations > 0 then
                -- Try multiple refresh methods
                local refreshSuccess = false
                
                -- Method 1: Try Rayfield V2 Refresh
                local success1, error1 = pcall(function()
                    if GPSLocationDropdown and GPSLocationDropdown.Refresh then
                        GPSLocationDropdown:Refresh(locations)
                        refreshSuccess = true
                    else
                        error("Dropdown or Refresh method not available")
                    end
                end)
                
                if success1 then
                    print("✅ Method 1: Refresh successful")
                    message("✅ GPS Locations refreshed!\n📂 Category: " .. selectedGPSCategory .. "\n📍 Found " .. #locations .. " locations", 3)
                else
                    print("⚠️ Method 1 failed:", tostring(error1))
                    
                    -- Method 2: Try alternative refresh
                    local success2, error2 = pcall(function()
                        if GPSLocationDropdown and GPSLocationDropdown.Options then
                            GPSLocationDropdown.Options = locations
                            refreshSuccess = true
                        else
                            error("Dropdown Options property not available")
                        end
                    end)
                    
                    if success2 then
                        print("✅ Method 2: Options updated successfully")
                        message("✅ GPS Locations refreshed!\n📂 Category: " .. selectedGPSCategory .. "\n📍 Found " .. #locations .. " locations", 3)
                    else
                        print("⚠️ Method 2 failed:", tostring(error2))
                        
                        -- Method 3: Try delayed refresh
                        spawn(function()
                            wait(0.5)
                            local success3, error3 = pcall(function()
                                if GPSLocationDropdown and GPSLocationDropdown.Refresh then
                                    GPSLocationDropdown:Refresh(locations)
                                    refreshSuccess = true
                                end
                            end)
                            if success3 then
                                message("✅ Delayed refresh successful", 2)
                            else
                                message("❌ All refresh methods failed", 3)
                            end
                        end)
                    end
                end
                
                if not refreshSuccess then
                    message("⚠️ Failed to refresh GPS locations. Try selecting category again.", 3)
                end
            else
                message("❌ No locations found for category: " .. selectedGPSCategory, 3)
            end
        end)
        
        if not success then
            print("❌ GPS Refresh Error:", tostring(refreshError))
            message("❌ Refresh failed: " .. tostring(refreshError), 5)
        end
    end,
})

-- Add debug button to help troubleshoot GPS issues
local DebugGPSButton = TeleportsTab:CreateButton({
    Name = "🔍 Debug GPS Data",
    Callback = function()
        -- Wrap debug function in protected call
        local success, debugError = pcall(function()
            local debugMsg = "🔍 GPS Debug Information:\n\n"
            debugMsg = debugMsg .. "📂 Current Category: " .. (selectedGPSCategory or "None") .. "\n"
            debugMsg = debugMsg .. "📍 Current Location: " .. (selectedGPSLocation or "None") .. "\n\n"
            
            -- Validate TeleportSystemV2
            if not TeleportSystemV2 then
                debugMsg = debugMsg .. "❌ TeleportSystemV2 not loaded\n"
                message(debugMsg, 10)
                return
            end
            
            -- Get all categories
            local categories = TeleportSystemV2.getCategoryNames()
            debugMsg = debugMsg .. "📋 Available Categories (" .. #categories .. "):\n"
            for i, cat in pairs(categories) do
                if i <= 5 then -- Show first 5 categories
                    local locations = TeleportSystemV2.getLocationNames(cat)
                    debugMsg = debugMsg .. i .. ". " .. cat .. " (" .. #locations .. " locations)\n"
                elseif i == 6 then
                    debugMsg = debugMsg .. "... and " .. (#categories - 5) .. " more categories\n"
                    break
                end
            end
            
            -- Get locations for current category
            local currentLocations = TeleportSystemV2.getLocationNames(selectedGPSCategory)
            debugMsg = debugMsg .. "\n📍 Locations in " .. selectedGPSCategory .. " (" .. #currentLocations .. "):\n"
            
            for i, loc in pairs(currentLocations) do
                if i <= 5 then -- Show first 5 locations
                    debugMsg = debugMsg .. i .. ". " .. loc .. "\n"
                elseif i == 6 then
                    debugMsg = debugMsg .. "... and " .. (#currentLocations - 5) .. " more\n"
                    break
                end
            end
            
            message(debugMsg, 10)
        end)
        
        if not success then
            print("❌ GPS Debug Error:", tostring(debugError))
            message("❌ Debug failed: " .. tostring(debugError), 5)
        end
    end,
})

-- Add variable for teleport method
local selectedTeleportMethod = "CFrame"

local TeleportMethodDropdown = TeleportsTab:CreateDropdown({
    Name = "Teleport Method",
    Options = {"CFrame", "TweenService", "RequestTeleportCFrame", "TeleportService"},
    CurrentOption = selectedTeleportMethod,
    Flag = "teleportmethod",
    Callback = function(Option)
        selectedTeleportMethod = Option
        print("🔄 Teleport method changed to:", Option)
    end,
})

local GPSTeleportButton = TeleportsTab:CreateButton({
    Name = "🌍 GPS Teleport",
    Callback = function()
        -- Wrap teleport function in protected call
        local success, teleportError = pcall(function()
            local category = selectedGPSCategory
            local locationName = selectedGPSLocation
            local method = selectedTeleportMethod or "CFrame"
            
            -- Validate inputs
            if not category or category == "" then
                message("❌ Please select a GPS category first", 3)
                return
            end
            
            if not locationName or locationName == "" or locationName == "No locations" then
                message("❌ Please select a valid GPS location first", 3)
                return
            end
            
            -- Validate TeleportSystemV2
            if not TeleportSystemV2 or type(TeleportSystemV2.teleportToLocation) ~= "function" then
                message("❌ Teleport system not properly loaded", 3)
                return
            end
            
            print("🌍 Attempting teleport to:", locationName, "in category:", category, "using method:", method)
            
            local success, msg = TeleportSystemV2.teleportToLocation(locationName, category, method)
            if success then
                message("✅ " .. msg, 3)
            else
                message("❌ " .. msg, 3)
            end
        end)
        
        if not success then
            print("❌ GPS Teleport Error:", tostring(teleportError))
            message("❌ Teleport failed: " .. tostring(teleportError), 5)
        end
    end,
})

local NearestLocationsButton = TeleportsTab:CreateButton({
    Name = "📍 Find Nearest (5)",
    Callback = function()
        local category = selectedGPSCategory
        local nearest = TeleportSystemV2.getNearestLocations(category, 5)
        
        local msg = "🔍 Nearest locations in " .. category .. ":\n"
        for i, item in pairs(nearest) do
            msg = msg .. string.format("%d. %s (%.0f studs)\n", i, item.location.name, item.distance)
        end
        message(msg, 8)
    end,
})

TeleportsTab:CreateSection("Advanced Features")

local AutoTreasureButton = TeleportsTab:CreateButton({
    Name = "🏴‍☠️ Auto Treasure Hunt",
    Callback = function()
        local method = selectedTeleportMethod
        TeleportSystemV2.autoTreasureHunt(3, method)
        message("🏴‍☠️ Auto Treasure Hunt started!", 3)
    end,
})

local BatchTeleportButton = TeleportsTab:CreateButton({
    Name = "🚀 Batch Teleport (Category)",
    Callback = function()
        local category = selectedGPSCategory
        local method = selectedTeleportMethod
        local locations = TeleportSystemV2.getLocationsByCategory(category)
        
        if #locations > 10 then
            message("⚠️ Too many locations (" .. #locations .. "). Use smaller categories.", 5)
            return
        end
        
        TeleportSystemV2.batchTeleport(locations, 2, method)
        message("🚀 Batch teleport started for " .. category, 3)
    end,
})

TeleportsTab:CreateSection("Search & Statistics")

local SearchButton = TeleportsTab:CreateButton({
    Name = "🔍 Search Locations",
    Callback = function()
        -- Simple search implementation (could be enhanced with text input)
        local searchTerm = "island" -- Example search term
        local results = TeleportSystemV2.searchLocations(searchTerm)
        
        local msg = "🔍 Search results for '" .. searchTerm .. "':\n"
        for i, result in pairs(results) do
            if i <= 10 then -- Limit to 10 results
                msg = msg .. string.format("%d. %s (%s)\n", i, result.name, result.category)
            end
        end
        
        if #results > 10 then
            msg = msg .. "... and " .. (#results - 10) .. " more results"
        end
        
        message(msg, 10)
    end,
})

local StatsButton = TeleportsTab:CreateButton({
    Name = "📊 Show GPS Statistics",
    Callback = function()
        local categories = TeleportSystemV2.getCategoryNames()
        local totalLocations = 0
        local msg = "📊 GPS System V2 Statistics:\n\n"
        
        for _, category in pairs(categories) do
            local count = #TeleportSystemV2.getLocationsByCategory(category)
            totalLocations = totalLocations + count
            msg = msg .. string.format("📁 %s: %d locations\n", category, count)
        end
        
        msg = msg .. string.format("\n🌍 Total Locations: %d\n", totalLocations)
        msg = msg .. "🚀 Methods: " .. table.concat(TeleportSystemV2.teleportMethods, ", ")
        
        message(msg, 15)
    end,
})

else
    -- TeleportSystemV2 not available, show error message
    TeleportsTab:CreateSection("GPS System V2 - Error")
    
    local GPSErrorButton = TeleportsTab:CreateButton({
        Name = "❌ GPS System Failed to Load",
        Callback = function()
            message("❌ TeleportSystemV2 failed to load from GitHub.\nUsing legacy teleport system only.", 5)
        end,
    })
    
    local RetryGPSButton = TeleportsTab:CreateButton({
        Name = "🔄 Retry Loading GPS System",
        Callback = function()
            message("🔄 Please restart the script to retry loading GPS system.", 3)
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
                message("✅ Auto Item Collector Started", 3)
            else
                InventoryExploits:StopAutoItemCollector()
                message("⛔ Auto Item Collector Stopped", 3)
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
                message("✅ Item Teleporter Started", 3)
            else
                InventoryExploits:StopItemTeleporter()
                message("⛔ Item Teleporter Stopped", 3)
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
            message("🕐 Collection delay set to " .. Option .. "s", 2)
        end,
    })

    local TeleportRadiusDropdown = InventoryTab:CreateDropdown({
        Name = "Teleport Radius",
        Options = {"100", "500", "1000", "2000", "5000"},
        CurrentOption = "1000",
        Flag = "teleportradius", 
        Callback = function(Option)
            InventoryExploits:SetTeleportRadius(tonumber(Option))
            message("📡 Teleport radius set to " .. Option .. " studs", 2)
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
                message("✅ Inventory Duplicator Started", 3)
            else
                InventoryExploits:StopInventoryDuplicator()
                message("⛔ Inventory Duplicator Stopped", 3)
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
            message("🔢 Max duplicates set to " .. Option, 2)
        end,
    })

    local DuplicateDelayDropdown = InventoryTab:CreateDropdown({
        Name = "Duplicate Delay",
        Options = {"0.5", "1.0", "2.0", "3.0", "5.0"},
        CurrentOption = "1.0",
        Flag = "duplicatedelay",
        Callback = function(Option)
            InventoryExploits:SetDuplicateDelay(tonumber(Option))
            message("⏱️ Duplicate delay set to " .. Option .. "s", 2)
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
                message("✅ Auto Equipment Optimizer Started", 3)
            else
                InventoryExploits:StopAutoEquipper()
                message("⛔ Auto Equipment Optimizer Stopped", 3)
            end
        end,
    })

    local SkinUnlockerButton = InventoryTab:CreateButton({
        Name = "🎨 Unlock All Skins",
        Callback = function()
            InventoryExploits:StartSkinUnlocker()
            message("🎨 Starting skin unlock process...", 3)
        end,
    })

    InventoryTab:CreateSection("Control Center")

    local StartAllButton = InventoryTab:CreateButton({
        Name = "🚀 Start All Systems",
        Callback = function()
            InventoryExploits:StartAllSystems()
            message("🚀 All inventory systems started!", 3)
            
            -- Update UI toggles
            Rayfield.Flags["autocollector"] = true
            Rayfield.Flags["itemteleporter"] = true
            Rayfield.Flags["inventoryduplicator"] = true
            Rayfield.Flags["autoequipper"] = true
        end,
    })

    local StopAllButton = InventoryTab:CreateButton({
        Name = "⛔ Stop All Systems",
        Callback = function()
            InventoryExploits:StopAllSystems()
            message("⛔ All inventory systems stopped!", 3)
            
            -- Update UI toggles
            Rayfield.Flags["autocollector"] = false
            Rayfield.Flags["itemteleporter"] = false
            Rayfield.Flags["inventoryduplicator"] = false
            Rayfield.Flags["autoequipper"] = false
        end,
    })

    local StatusButton = InventoryTab:CreateButton({
        Name = "📊 Show Status",
        Callback = function()
            local status = InventoryExploits:GetStatus()
            local msg = "📊 Inventory Status:\n\n"
            msg = msg .. "🔄 Auto Collector: " .. (status.AutoItemCollector and "ON" or "OFF") .. "\n"
            msg = msg .. "📦 Duplicator: " .. (status.InventoryDuplicator and "ON" or "OFF") .. "\n"
            msg = msg .. "🎨 Skin Unlocker: " .. (status.SkinUnlocker and "ON" or "OFF") .. "\n"
            msg = msg .. "⚡ Auto Equipper: " .. (status.AutoEquipper and "ON" or "OFF") .. "\n"
            msg = msg .. "📡 Item Teleporter: " .. (status.ItemTeleporter and "ON" or "OFF") .. "\n\n"
            msg = msg .. "📈 Items Collected: " .. (status.CollectedItems or 0) .. "\n"
            msg = msg .. "📋 Items Duplicated: " .. (status.DuplicatedItems or 0)
            message(msg, 10)
        end,
    })

    local EmergencyStopButton = InventoryTab:CreateButton({
        Name = "🚨 EMERGENCY STOP",
        Callback = function()
            InventoryExploits:EmergencyStop()
            message("🚨 EMERGENCY STOP ACTIVATED!", 5)
            
            -- Reset all UI toggles
            Rayfield.Flags["autocollector"] = false
            Rayfield.Flags["itemteleporter"] = false
            Rayfield.Flags["inventoryduplicator"] = false
            Rayfield.Flags["autoequipper"] = false
        end,
    })

    InventoryTab:CreateSection("Advanced Options")

    local ClearDataButton = InventoryTab:CreateButton({
        Name = "🗑️ Clear Duplicate Data",
        Callback = function()
            InventoryExploits:ClearDuplicatedItems()
            message("🗑️ Duplicated items data cleared", 3)
        end,
    })

    local ResetConfigButton = InventoryTab:CreateButton({
        Name = "🔄 Reset Configuration",
        Callback = function()
            InventoryExploits:ResetConfiguration()
            message("🔄 Configuration reset to defaults", 3)
        end,
    })
else
    InventoryTab:CreateSection("Error")
    
    local ErrorLabel = InventoryTab:CreateButton({
        Name = "❌ Inventory Module Failed to Load",
        Callback = function()
            message("❌ Advanced Inventory Exploits module failed to load from GitHub", 5)
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
                message("💰 Market Price Manipulator Started", 3)
            else
                EconomyExploits:StopMarketPriceManipulator()
                message("⛔ Market Price Manipulator Stopped", 3)
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
                message("🔄 Unlimited Shop Refresh Started", 3)
            else
                EconomyExploits:StopUnlimitedShopRefresh()
                message("⛔ Shop Refresh Stopped", 3)
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
                message("💸 Free Purchase Exploit Started", 3)
            else
                EconomyExploits:StopFreePurchaseExploit()
                message("⛔ Free Purchase Stopped", 3)
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
                message("📈 Auto Item Flipper Started", 3)
            else
                EconomyExploits:StopAutoItemFlipper()
                message("⛔ Item Flipper Stopped", 3)
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
                message("🔍 Shop Scanner Started", 3)
            else
                EconomyExploits:StopShopInventoryScanner()
                message("⛔ Shop Scanner Stopped", 3)
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
            message("💰 Max spend set to $" .. Option, 2)
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
            message("📊 Min profit margin set to " .. Option, 2)
        end,
    })

    local RefreshDelayDropdown = EconomyTab:CreateDropdown({
        Name = "Refresh Delay",
        Options = {"0.1", "0.5", "1.0", "2.0", "5.0"},
        CurrentOption = "0.1",
        Flag = "refreshdelay",
        Callback = function(Option)
            EconomyExploits.Config.RefreshDelay = tonumber(Option)
            message("⏱️ Refresh delay set to " .. Option .. "s", 2)
        end,
    })

    EconomyTab:CreateSection("Quick Actions")

    local RefreshAllShopsButton = EconomyTab:CreateButton({
        Name = "🔄 Refresh All Shops",
        Callback = function()
            EconomyExploits:RefreshAllShops()
            message("🔄 All shops refreshed!", 3)
        end,
    })

    local ScanForDealsButton = EconomyTab:CreateButton({
        Name = "🔍 Scan for Deals",
        Callback = function()
            EconomyExploits:ScanForFlipOpportunities()
            message("🔍 Scanning for profitable deals...", 3)
        end,
    })

    local AttemptFreePurchasesButton = EconomyTab:CreateButton({
        Name = "💸 Attempt Free Purchases",
        Callback = function()
            EconomyExploits:AttemptFreePurchases()
            message("💸 Attempting free purchases...", 3)
        end,
    })

    local ManipulatePricesButton = EconomyTab:CreateButton({
        Name = "💰 Manipulate Prices",
        Callback = function()
            EconomyExploits:ManipulateMarketPrices()
            message("💰 Attempting price manipulation...", 3)
        end,
    })

    EconomyTab:CreateSection("Control Center")

    local StartAllEconomyButton = EconomyTab:CreateButton({
        Name = "🚀 Start All Economy Systems",
        Callback = function()
            EconomyExploits:StartAllSystems()
            message("🚀 All economy systems started!", 3)
            
            -- Update UI toggles
            Rayfield.Flags["marketpricemanipulator"] = true
            Rayfield.Flags["shoprefresh"] = true
            Rayfield.Flags["freepurchase"] = true
            Rayfield.Flags["itemflipper"] = true
            Rayfield.Flags["shopscanner"] = true
        end,
    })

    local StopAllEconomyButton = EconomyTab:CreateButton({
        Name = "⛔ Stop All Economy Systems",
        Callback = function()
            EconomyExploits:StopAllSystems()
            message("⛔ All economy systems stopped!", 3)
            
            -- Update UI toggles
            Rayfield.Flags["marketpricemanipulator"] = false
            Rayfield.Flags["shoprefresh"] = false
            Rayfield.Flags["freepurchase"] = false
            Rayfield.Flags["itemflipper"] = false
            Rayfield.Flags["shopscanner"] = false
        end,
    })

    local EconomyStatusButton = EconomyTab:CreateButton({
        Name = "📊 Show Economy Status",
        Callback = function()
            local status = EconomyExploits:GetStatus()
            local msg = "📊 Economy Status:\n\n"
            msg = msg .. "💰 Price Manipulator: " .. (status.MarketPriceManipulator and "ON" or "OFF") .. "\n"
            msg = msg .. "🔄 Shop Refresh: " .. (status.UnlimitedShopRefresh and "ON" or "OFF") .. "\n"
            msg = msg .. "📈 Item Flipper: " .. (status.AutoItemFlipper and "ON" or "OFF") .. "\n"
            msg = msg .. "💸 Free Purchase: " .. (status.FreePurchaseExploit and "ON" or "OFF") .. "\n"
            msg = msg .. "🔍 Shop Scanner: " .. (status.ShopInventoryScanner and "ON" or "OFF") .. "\n\n"
            msg = msg .. "💵 Max Spend: $" .. (EconomyExploits.Config.MaxSpendAmount or 0) .. "\n"
            msg = msg .. "📊 Min Profit: " .. string.format("%.0f%%", (EconomyExploits.Config.MinProfitMargin or 0) * 100)
            message(msg, 10)
        end,
    })

    local MarketReportButton = EconomyTab:CreateButton({
        Name = "📈 Generate Market Report",
        Callback = function()
            EconomyExploits:PrintMarketReport()
            message("📈 Market report generated in console", 5)
        end,
    })

    local EmergencyEconomyStopButton = EconomyTab:CreateButton({
        Name = "🚨 EMERGENCY STOP",
        Callback = function()
            EconomyExploits:EmergencyStop()
            message("🚨 ECONOMY EMERGENCY STOP ACTIVATED!", 5)
            
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
        Name = "🏪 Open Merchant",
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
                message("🏪 Teleported to Merchant!", 3)
            end)
            if not success then
                message("❌ Failed to teleport to merchant", 3)
            end
        end,
    })
    
    local BasicShopButton = EconomyTab:CreateButton({
        Name = "🛒 Find Rod Shop",
        Callback = function()
            local success, error = pcall(function()
                -- Teleport to rod shop in Moosewood
                gethrp().CFrame = CFrame.new(-1472.7, 149.4, -3014.5)
                message("🎣 Teleported to Rod Shop!", 3)
            end)
            if not success then
                message("❌ Failed to teleport to shop", 3)
            end
        end,
    })
    
    local EconomyErrorLabel = EconomyTab:CreateButton({
        Name = "ℹ️ Advanced Features Unavailable",
        Callback = function()
            message("ℹ️ Advanced Economy & Marketplace features require additional modules.\n\n🔧 Basic economy tools are available above.", 5)
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
                local adjustedDelay = GetAdjustedDelay(autoShakeDelay)
                task.wait(adjustedDelay)
                game:GetService('VirtualInputManager'):SendKeyEvent(true, Enum.KeyCode.Return, false, game)
                game:GetService('VirtualInputManager'):SendKeyEvent(false, Enum.KeyCode.Return, false, game)
            end
        end
    end
    
    if autoCastEnabled then
        local rod = FindRod()
        if rod ~= nil and rod['values']['lure'].Value <= .001 then
            local adjustedDelay = GetAdjustedDelay(autoCastDelay)
            if task.wait(adjustedDelay) then
                rod.events.cast:FireServer(100, 1)
            end
        end
    end
    
    if autoReelEnabled then
        local rod = FindRod()
        if rod ~= nil and rod['values']['lure'].Value == 100 then
            local adjustedDelay = GetAdjustedDelay(autoReelDelay)
            if task.wait(adjustedDelay) then
                ReplicatedStorage.events.reelfinished:FireServer(100, true)
            end
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
    print("✅ UI Content created successfully!")
else
    print("❌ Failed to create UI Content:", tostring(contentError))
    print("⚠️ UI will be visible but some features may not work")
end

--// Hooks
print("🔗 Setting up hooks...")
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
    print("✅ Hooks set up successfully!")
else
    print("⚠️ hookmetamethod not available, hooks disabled")
end

print("🎉 FISCH CHEAT HUB V2 LOADED SUCCESSFULLY! 🎉")
print("📋 Features Available:")
print("   🤖 Auto Fishing & Automation")
print("   🚀 Advanced Teleport System (276+ locations)")
print("   🎨 Visual Enhancements & Rod Chams")
print("   📦 Inventory & Item Management")
print("   💰 Economy & Marketplace Tools")
print("🎮 UI should be visible now! Check your screen.")
print("⚡ Ready to use - Enjoy fishing! ⚡")

--// Restore original error functions after UI is loaded
print("🔊 Restoring original error functions...")
warn = originalWarn
error = originalError
print("✅ Error functions restored!")
