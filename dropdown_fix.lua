-- Dropdown Fix for GPS System
-- This script fixes dropdown issues that cause UI freezing

print("🔧 Loading GPS Dropdown Fix...")

-- Function to safely refresh dropdown
local function safeRefreshDropdown(dropdown, newOptions, newDefault)
    if not dropdown then 
        print("❌ Dropdown is nil")
        return false 
    end
    
    -- Method 1: Standard Refresh
    local success1, error1 = pcall(function()
        if dropdown.Refresh and type(dropdown.Refresh) == "function" then
            dropdown:Refresh(newOptions, newDefault)
            return true
        else
            error("Refresh method not available")
        end
    end)
    
    if success1 then
        print("✅ Method 1: Standard refresh successful")
        return true
    end
    
    print("⚠️ Method 1 failed:", tostring(error1))
    
    -- Method 2: Direct Options Update
    local success2, error2 = pcall(function()
        if dropdown.Options then
            dropdown.Options = newOptions
            if dropdown.CurrentOption then
                dropdown.CurrentOption = newDefault or newOptions[1]
            end
            return true
        else
            error("Options property not available")
        end
    end)
    
    if success2 then
        print("✅ Method 2: Direct options update successful")
        return true
    end
    
    print("⚠️ Method 2 failed:", tostring(error2))
    
    -- Method 3: Force UI Update (delayed)
    spawn(function()
        wait(0.5)
        local success3, error3 = pcall(function()
            if dropdown.Update and type(dropdown.Update) == "function" then
                dropdown:Update(newOptions)
            elseif dropdown.Refresh then
                dropdown:Refresh(newOptions)
            end
        end)
        
        if success3 then
            print("✅ Method 3: Delayed refresh successful")
        else
            print("❌ Method 3 failed:", tostring(error3))
        end
    end)
    
    return false
end

-- Function to fix stuck dropdown state
local function fixStuckDropdown(dropdown)
    if not dropdown then return end
    
    pcall(function()
        -- Try to close dropdown if stuck open
        if dropdown.Close and type(dropdown.Close) == "function" then
            dropdown:Close()
        end
        
        -- Reset dropdown state
        if dropdown.Visible then
            dropdown.Visible = false
        end
        
        -- Force redraw
        if dropdown.Parent and dropdown.Parent.Enabled then
            dropdown.Parent.Enabled = false
            wait(0.1)
            dropdown.Parent.Enabled = true
        end
    end)
end

-- Export functions
local DropdownFix = {
    safeRefresh = safeRefreshDropdown,
    fixStuck = fixStuckDropdown
}

print("✅ GPS Dropdown Fix loaded successfully!")
return DropdownFix
