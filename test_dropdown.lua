-- Test script untuk memvalidasi dropdown GPS system
print("🧪 Testing GPS Dropdown System...")

-- Simulasi load TeleportSystemV2
if loadfile("teleport-v2.lua") then
    local TeleportSystemV2 = loadfile("teleport-v2.lua")()
    TeleportSystemV2 = TeleportSystemV2.init()
    
    print("✅ TeleportSystemV2 loaded successfully")
    
    -- Test categories
    local categories = TeleportSystemV2.getCategories()
    print("📂 Available categories:", #categories)
    for i, cat in ipairs(categories) do
        print("  " .. i .. ". " .. cat)
    end
    
    -- Test specific category locations
    print("\n🧪 Testing 'Terrapin Island Area' locations:")
    local terrapinLocations = TeleportSystemV2.getLocationNames("Terrapin Island Area")
    print("📍 Found", #terrapinLocations, "locations:")
    for i, loc in ipairs(terrapinLocations) do
        print("  " .. i .. ". " .. loc)
    end
    
    -- Test another category
    print("\n🧪 Testing 'Ancient Isle Area' locations:")
    local ancientLocations = TeleportSystemV2.getLocationNames("Ancient Isle Area")
    print("📍 Found", #ancientLocations, "locations:")
    for i, loc in ipairs(ancientLocations) do
        print("  " .. i .. ". " .. loc)
    end
    
    print("\n✅ GPS Dropdown System Test Complete!")
else
    print("❌ Failed to load TeleportSystemV2")
end
