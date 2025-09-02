-- Rayfield UI Library
-- Modified version for fishing script

local Rayfield = {
    Main = nil,
    Objects = {},
    Tabs = {},
    Flags = {},
    Theme = {
        Default = Color3.fromRGB(43, 43, 43),
        Background = Color3.fromRGB(25, 25, 25),
        Border = Color3.fromRGB(61, 61, 61),
        TopbarBackground = Color3.fromRGB(34, 34, 34),
        TopbarBorder = Color3.fromRGB(47, 47, 47),
        Search = Color3.fromRGB(57, 57, 57),
        NotificationBackground = Color3.fromRGB(20, 20, 20),
        NotificationActionsBackground = Color3.fromRGB(230, 230, 230),
        TabBackground = Color3.fromRGB(80, 80, 80),
        TabStroke = Color3.fromRGB(85, 85, 85),
        TabBackgroundSelected = Color3.fromRGB(210, 210, 210),
        TabTextColor = Color3.fromRGB(240, 240, 240),
        SelectedTabTextColor = Color3.fromRGB(50, 50, 50),
        ElementBackground = Color3.fromRGB(35, 35, 35),
        ElementBackgroundHover = Color3.fromRGB(40, 40, 40),
        SecondaryElementBackground = Color3.fromRGB(25, 25, 25),
        ElementStroke = Color3.fromRGB(50, 50, 50),
        SecondaryElementStroke = Color3.fromRGB(40, 40, 40),
        SliderBackground = Color3.fromRGB(43, 43, 43),
        SliderProgress = Color3.fromRGB(0, 162, 255),
        SliderStroke = Color3.fromRGB(31, 31, 31),
        ToggleBackground = Color3.fromRGB(30, 30, 30),
        ToggleEnabled = Color3.fromRGB(0, 146, 214),
        ToggleDisabled = Color3.fromRGB(100, 100, 100),
        ToggleEnabledStroke = Color3.fromRGB(0, 170, 255),
        ToggleDisabledStroke = Color3.fromRGB(125, 125, 125),
        InputBackground = Color3.fromRGB(30, 30, 30),
        InputStroke = Color3.fromRGB(65, 65, 65),
        InputPlaceholder = Color3.fromRGB(178, 178, 178),
        InputText = Color3.fromRGB(240, 240, 240),
        TextColor = Color3.fromRGB(240, 240, 240),
        TextFont = Enum.Font.Gotham
    }
}

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")

local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

-- Utility Functions
local function CreateObject(ObjectType, Properties)
    local Object = Instance.new(ObjectType)
    for Property, Value in pairs(Properties) do
        if Property ~= "Parent" then
            if typeof(Value) == "Instance" then
                Value.Parent = Object
            else
                Object[Property] = Value
            end
        end
    end
    if Properties.Parent then
        Object.Parent = Properties.Parent
    end
    return Object
end

local function MakeDraggable(topbarobject, object)
    local Dragging = nil
    local DragStart = nil
    local StartPosition = nil

    local function Update(input)
        local Delta = input.Position - DragStart
        local Position = UDim2.new(StartPosition.X.Scale, StartPosition.X.Offset + Delta.X, StartPosition.Y.Scale, StartPosition.Y.Offset + Delta.Y)
        object.Position = Position
    end

    topbarobject.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            Dragging = true
            DragStart = input.Position
            StartPosition = object.Position

            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    Dragging = false
                end
            end)
        end
    end)

    topbarobject.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            if Dragging then
                Update(input)
            end
        end
    end)
end

-- Main Rayfield Functions
function Rayfield:CreateWindow(WindowSettings)
    local WindowSettings = WindowSettings or {}
    local Name = WindowSettings.Name or "Rayfield UI"
    local LoadingTitle = WindowSettings.LoadingTitle or "Rayfield Interface Suite"
    local LoadingSubtitle = WindowSettings.LoadingSubtitle or "by Sirius"
    local ConfigurationSaving = WindowSettings.ConfigurationSaving or {}
    local DisableRayfieldPrompts = WindowSettings.DisableRayfieldPrompts or false
    local DisableBuildWarnings = WindowSettings.DisableBuildWarnings or false
    local KeySystem = WindowSettings.KeySystem or false

    if Rayfield.Main then
        return
    end

    -- Create Main UI
    Rayfield.Main = CreateObject("ScreenGui", {
        Name = "RayfieldUI",
        Parent = CoreGui,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
        ResetOnSpawn = false
    })

    local Main = CreateObject("Frame", {
        Name = "Main",
        Parent = Rayfield.Main,
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundColor3 = Rayfield.Theme.Background,
        BorderSizePixel = 0,
        Position = UDim2.new(0.5, 0, 0.5, 0),
        Size = UDim2.new(0, 580, 0, 460),
        ClipsDescendants = true
    })

    CreateObject("UICorner", {
        CornerRadius = UDim.new(0, 6),
        Parent = Main
    })

    CreateObject("UIStroke", {
        Color = Rayfield.Theme.Border,
        Thickness = 1,
        Parent = Main
    })

    -- Topbar
    local Topbar = CreateObject("Frame", {
        Name = "Topbar",
        Parent = Main,
        BackgroundColor3 = Rayfield.Theme.TopbarBackground,
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 0, 45)
    })

    CreateObject("UICorner", {
        CornerRadius = UDim.new(0, 6),
        Parent = Topbar
    })

    CreateObject("UIStroke", {
        Color = Rayfield.Theme.TopbarBorder,
        Thickness = 1,
        Parent = Topbar
    })

    local TopbarShadow = CreateObject("Frame", {
        Name = "Shadow",
        Parent = Topbar,
        BackgroundColor3 = Rayfield.Theme.TopbarBackground,
        BorderSizePixel = 0,
        Position = UDim2.new(0, 0, 1, -6),
        Size = UDim2.new(1, 0, 0, 6)
    })

    local Title = CreateObject("TextLabel", {
        Name = "Title",
        Parent = Topbar,
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 15, 0, 0),
        Size = UDim2.new(1, -30, 1, 0),
        Font = Rayfield.Theme.TextFont,
        Text = Name,
        TextColor3 = Rayfield.Theme.TextColor,
        TextSize = 18,
        TextXAlignment = Enum.TextXAlignment.Left
    })

    -- Close Button
    local CloseButton = CreateObject("TextButton", {
        Name = "CloseButton",
        Parent = Topbar,
        BackgroundTransparency = 1,
        Position = UDim2.new(1, -45, 0, 0),
        Size = UDim2.new(0, 45, 1, 0),
        Font = Rayfield.Theme.TextFont,
        Text = "×",
        TextColor3 = Rayfield.Theme.TextColor,
        TextSize = 18
    })

    CloseButton.MouseButton1Click:Connect(function()
        Rayfield.Main:Destroy()
        Rayfield.Main = nil
    end)

    -- Tab Container
    local TabContainer = CreateObject("Frame", {
        Name = "TabContainer",
        Parent = Main,
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 0, 0, 45),
        Size = UDim2.new(0, 150, 1, -45)
    })

    local TabList = CreateObject("ScrollingFrame", {
        Name = "TabList",
        Parent = TabContainer,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Position = UDim2.new(0, 10, 0, 10),
        Size = UDim2.new(1, -20, 1, -20),
        ScrollBarThickness = 0,
        CanvasSize = UDim2.new(0, 0, 0, 0),
        ScrollingDirection = Enum.ScrollingDirection.Y
    })

    CreateObject("UIListLayout", {
        Parent = TabList,
        FillDirection = Enum.FillDirection.Vertical,
        HorizontalAlignment = Enum.HorizontalAlignment.Left,
        SortOrder = Enum.SortOrder.LayoutOrder,
        VerticalAlignment = Enum.VerticalAlignment.Top,
        Padding = UDim.new(0, 5)
    })

    -- Content Container
    local ContentContainer = CreateObject("Frame", {
        Name = "ContentContainer",
        Parent = Main,
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 150, 0, 45),
        Size = UDim2.new(1, -150, 1, -45)
    })

    MakeDraggable(Topbar, Main)

    local Window = {
        Tabs = {},
        CurrentTab = nil
    }

    function Window:CreateTab(TabSettings)
        local TabSettings = TabSettings or {}
        local Name = TabSettings.Name or "Tab"
        local Image = TabSettings.Image or nil
        local ImageSize = TabSettings.ImageSize or UDim2.new(0, 16, 0, 16)

        local Tab = CreateObject("TextButton", {
            Name = Name,
            Parent = TabList,
            BackgroundColor3 = Rayfield.Theme.TabBackground,
            BorderSizePixel = 0,
            Size = UDim2.new(1, 0, 0, 35),
            Font = Rayfield.Theme.TextFont,
            Text = Name,
            TextColor3 = Rayfield.Theme.TabTextColor,
            TextSize = 14,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextTruncate = Enum.TextTruncate.AtEnd
        })

        CreateObject("UIPadding", {
            Parent = Tab,
            PaddingLeft = UDim.new(0, 15),
            PaddingRight = UDim.new(0, 15)
        })

        CreateObject("UICorner", {
            CornerRadius = UDim.new(0, 4),
            Parent = Tab
        })

        CreateObject("UIStroke", {
            Color = Rayfield.Theme.TabStroke,
            Thickness = 1,
            Parent = Tab
        })

        local TabContent = CreateObject("ScrollingFrame", {
            Name = Name .. "Content",
            Parent = ContentContainer,
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            Position = UDim2.new(0, 10, 0, 10),
            Size = UDim2.new(1, -20, 1, -20),
            ScrollBarThickness = 3,
            CanvasSize = UDim2.new(0, 0, 0, 0),
            ScrollingDirection = Enum.ScrollingDirection.Y,
            Visible = false
        })

        CreateObject("UIListLayout", {
            Parent = TabContent,
            FillDirection = Enum.FillDirection.Vertical,
            HorizontalAlignment = Enum.HorizontalAlignment.Left,
            SortOrder = Enum.SortOrder.LayoutOrder,
            VerticalAlignment = Enum.VerticalAlignment.Top,
            Padding = UDim.new(0, 8)
        })

        Tab.MouseButton1Click:Connect(function()
            for _, TabObject in pairs(Window.Tabs) do
                TabObject.Tab.BackgroundColor3 = Rayfield.Theme.TabBackground
                TabObject.Tab.TextColor3 = Rayfield.Theme.TabTextColor
                TabObject.Content.Visible = false
            end

            Tab.BackgroundColor3 = Rayfield.Theme.TabBackgroundSelected
            Tab.TextColor3 = Rayfield.Theme.SelectedTabTextColor
            TabContent.Visible = true
            Window.CurrentTab = TabContent
        end)

        local TabObj = {
            Tab = Tab,
            Content = TabContent,
            Name = Name
        }

        Window.Tabs[Name] = TabObj

        if #Window.Tabs == 1 then
            Tab.BackgroundColor3 = Rayfield.Theme.TabBackgroundSelected
            Tab.TextColor3 = Rayfield.Theme.SelectedTabTextColor
            TabContent.Visible = true
            Window.CurrentTab = TabContent
        end

        -- Update canvas size
        local function UpdateCanvasSize()
            local ContentSize = TabContent.UIListLayout.AbsoluteContentSize
            TabContent.CanvasSize = UDim2.new(0, 0, 0, ContentSize.Y + 10)
        end

        TabContent.UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(UpdateCanvasSize)

        function TabObj:CreateSection(SectionSettings)
            local SectionSettings = SectionSettings or {}
            local Name = SectionSettings.Name or "Section"

            local Section = CreateObject("Frame", {
                Name = Name,
                Parent = TabContent,
                BackgroundColor3 = Rayfield.Theme.ElementBackground,
                BorderSizePixel = 0,
                Size = UDim2.new(1, 0, 0, 35)
            })

            CreateObject("UICorner", {
                CornerRadius = UDim.new(0, 4),
                Parent = Section
            })

            CreateObject("UIStroke", {
                Color = Rayfield.Theme.ElementStroke,
                Thickness = 1,
                Parent = Section
            })

            local SectionTitle = CreateObject("TextLabel", {
                Name = "Title",
                Parent = Section,
                BackgroundTransparency = 1,
                Position = UDim2.new(0, 15, 0, 0),
                Size = UDim2.new(1, -30, 1, 0),
                Font = Rayfield.Theme.TextFont,
                Text = Name,
                TextColor3 = Rayfield.Theme.TextColor,
                TextSize = 16,
                TextXAlignment = Enum.TextXAlignment.Left
            })

            return Section
        end

        function TabObj:CreateToggle(ToggleSettings)
            local ToggleSettings = ToggleSettings or {}
            local Name = ToggleSettings.Name or "Toggle"
            local CurrentValue = ToggleSettings.CurrentValue or false
            local Flag = ToggleSettings.Flag or nil
            local Callback = ToggleSettings.Callback or function() end

            local Toggle = CreateObject("Frame", {
                Name = Name,
                Parent = TabContent,
                BackgroundColor3 = Rayfield.Theme.ElementBackground,
                BorderSizePixel = 0,
                Size = UDim2.new(1, 0, 0, 50)
            })

            CreateObject("UICorner", {
                CornerRadius = UDim.new(0, 4),
                Parent = Toggle
            })

            CreateObject("UIStroke", {
                Color = Rayfield.Theme.ElementStroke,
                Thickness = 1,
                Parent = Toggle
            })

            local ToggleTitle = CreateObject("TextLabel", {
                Name = "Title",
                Parent = Toggle,
                BackgroundTransparency = 1,
                Position = UDim2.new(0, 15, 0, 0),
                Size = UDim2.new(1, -80, 1, 0),
                Font = Rayfield.Theme.TextFont,
                Text = Name,
                TextColor3 = Rayfield.Theme.TextColor,
                TextSize = 14,
                TextXAlignment = Enum.TextXAlignment.Left,
                TextYAlignment = Enum.TextYAlignment.Center
            })

            local ToggleFrame = CreateObject("Frame", {
                Name = "ToggleFrame",
                Parent = Toggle,
                BackgroundColor3 = CurrentValue and Rayfield.Theme.ToggleEnabled or Rayfield.Theme.ToggleDisabled,
                Position = UDim2.new(1, -60, 0.5, -10),
                Size = UDim2.new(0, 45, 0, 20)
            })

            CreateObject("UICorner", {
                CornerRadius = UDim.new(0, 10),
                Parent = ToggleFrame
            })

            CreateObject("UIStroke", {
                Color = CurrentValue and Rayfield.Theme.ToggleEnabledStroke or Rayfield.Theme.ToggleDisabledStroke,
                Thickness = 1,
                Parent = ToggleFrame
            })

            local ToggleButton = CreateObject("Frame", {
                Name = "ToggleButton",
                Parent = ToggleFrame,
                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                Position = CurrentValue and UDim2.new(1, -18, 0, 2) or UDim2.new(0, 2, 0, 2),
                Size = UDim2.new(0, 16, 0, 16)
            })

            CreateObject("UICorner", {
                CornerRadius = UDim.new(0, 8),
                Parent = ToggleButton
            })

            local ToggleButtonClick = CreateObject("TextButton", {
                Name = "ToggleButtonClick",
                Parent = ToggleFrame,
                BackgroundTransparency = 1,
                Size = UDim2.new(1, 0, 1, 0),
                Text = ""
            })

            if Flag then
                Rayfield.Flags[Flag] = CurrentValue
            end

            ToggleButtonClick.MouseButton1Click:Connect(function()
                CurrentValue = not CurrentValue

                local ToggleFrameTween = TweenService:Create(ToggleFrame, TweenInfo.new(0.2), {
                    BackgroundColor3 = CurrentValue and Rayfield.Theme.ToggleEnabled or Rayfield.Theme.ToggleDisabled
                })
                local ToggleButtonTween = TweenService:Create(ToggleButton, TweenInfo.new(0.2), {
                    Position = CurrentValue and UDim2.new(1, -18, 0, 2) or UDim2.new(0, 2, 0, 2)
                })
                local ToggleStrokeTween = TweenService:Create(ToggleFrame.UIStroke, TweenInfo.new(0.2), {
                    Color = CurrentValue and Rayfield.Theme.ToggleEnabledStroke or Rayfield.Theme.ToggleDisabledStroke
                })

                ToggleFrameTween:Play()
                ToggleButtonTween:Play()
                ToggleStrokeTween:Play()

                if Flag then
                    Rayfield.Flags[Flag] = CurrentValue
                end

                Callback(CurrentValue)
            end)

            local ToggleObject = {
                Type = "Toggle",
                CurrentValue = CurrentValue,
                Flag = Flag,
                Callback = Callback
            }

            function ToggleObject:Set(Value)
                CurrentValue = Value

                local ToggleFrameTween = TweenService:Create(ToggleFrame, TweenInfo.new(0.2), {
                    BackgroundColor3 = CurrentValue and Rayfield.Theme.ToggleEnabled or Rayfield.Theme.ToggleDisabled
                })
                local ToggleButtonTween = TweenService:Create(ToggleButton, TweenInfo.new(0.2), {
                    Position = CurrentValue and UDim2.new(1, -18, 0, 2) or UDim2.new(0, 2, 0, 2)
                })
                local ToggleStrokeTween = TweenService:Create(ToggleFrame.UIStroke, TweenInfo.new(0.2), {
                    Color = CurrentValue and Rayfield.Theme.ToggleEnabledStroke or Rayfield.Theme.ToggleDisabledStroke
                })

                ToggleFrameTween:Play()
                ToggleButtonTween:Play()
                ToggleStrokeTween:Play()

                if Flag then
                    Rayfield.Flags[Flag] = CurrentValue
                end

                Callback(CurrentValue)
            end

            return ToggleObject
        end

        function TabObj:CreateDropdown(DropdownSettings)
            local DropdownSettings = DropdownSettings or {}
            local Name = DropdownSettings.Name or "Dropdown"
            local Options = DropdownSettings.Options or {}
            local CurrentOption = DropdownSettings.CurrentOption or Options[1] or ""
            local Flag = DropdownSettings.Flag or nil
            local Callback = DropdownSettings.Callback or function() end

            local Dropdown = CreateObject("Frame", {
                Name = Name,
                Parent = TabContent,
                BackgroundColor3 = Rayfield.Theme.ElementBackground,
                BorderSizePixel = 0,
                Size = UDim2.new(1, 0, 0, 50)
            })

            CreateObject("UICorner", {
                CornerRadius = UDim.new(0, 4),
                Parent = Dropdown
            })

            CreateObject("UIStroke", {
                Color = Rayfield.Theme.ElementStroke,
                Thickness = 1,
                Parent = Dropdown
            })

            local DropdownTitle = CreateObject("TextLabel", {
                Name = "Title",
                Parent = Dropdown,
                BackgroundTransparency = 1,
                Position = UDim2.new(0, 15, 0, 0),
                Size = UDim2.new(0.5, -15, 1, 0),
                Font = Rayfield.Theme.TextFont,
                Text = Name,
                TextColor3 = Rayfield.Theme.TextColor,
                TextSize = 14,
                TextXAlignment = Enum.TextXAlignment.Left,
                TextYAlignment = Enum.TextYAlignment.Center
            })

            local DropdownFrame = CreateObject("TextButton", {
                Name = "DropdownFrame",
                Parent = Dropdown,
                BackgroundColor3 = Rayfield.Theme.SecondaryElementBackground,
                BorderSizePixel = 0,
                Position = UDim2.new(0.5, 10, 0.5, -10),
                Size = UDim2.new(0.5, -25, 0, 20),
                Font = Rayfield.Theme.TextFont,
                Text = CurrentOption,
                TextColor3 = Rayfield.Theme.TextColor,
                TextSize = 12,
                TextXAlignment = Enum.TextXAlignment.Center
            })

            CreateObject("UICorner", {
                CornerRadius = UDim.new(0, 4),
                Parent = DropdownFrame
            })

            CreateObject("UIStroke", {
                Color = Rayfield.Theme.SecondaryElementStroke,
                Thickness = 1,
                Parent = DropdownFrame
            })

            local DropdownList = CreateObject("Frame", {
                Name = "DropdownList",
                Parent = Dropdown,
                BackgroundColor3 = Rayfield.Theme.ElementBackground,
                BorderSizePixel = 0,
                Position = UDim2.new(0.5, 10, 1, 5),
                Size = UDim2.new(0.5, -25, 0, 0),
                Visible = false,
                ZIndex = 10
            })

            CreateObject("UICorner", {
                CornerRadius = UDim.new(0, 4),
                Parent = DropdownList
            })

            CreateObject("UIStroke", {
                Color = Rayfield.Theme.ElementStroke,
                Thickness = 1,
                Parent = DropdownList
            })

            local DropdownListContainer = CreateObject("ScrollingFrame", {
                Name = "Container",
                Parent = DropdownList,
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                Size = UDim2.new(1, 0, 1, 0),
                ScrollBarThickness = 3,
                CanvasSize = UDim2.new(0, 0, 0, 0),
                ScrollingDirection = Enum.ScrollingDirection.Y
            })

            CreateObject("UIListLayout", {
                Parent = DropdownListContainer,
                FillDirection = Enum.FillDirection.Vertical,
                HorizontalAlignment = Enum.HorizontalAlignment.Left,
                SortOrder = Enum.SortOrder.LayoutOrder,
                VerticalAlignment = Enum.VerticalAlignment.Top
            })

            if Flag then
                Rayfield.Flags[Flag] = CurrentOption
            end

            local function UpdateDropdownList()
                for _, child in pairs(DropdownListContainer:GetChildren()) do
                    if child:IsA("TextButton") then
                        child:Destroy()
                    end
                end

                for _, option in pairs(Options) do
                    local OptionButton = CreateObject("TextButton", {
                        Name = option,
                        Parent = DropdownListContainer,
                        BackgroundColor3 = Rayfield.Theme.SecondaryElementBackground,
                        BorderSizePixel = 0,
                        Size = UDim2.new(1, 0, 0, 25),
                        Font = Rayfield.Theme.TextFont,
                        Text = option,
                        TextColor3 = Rayfield.Theme.TextColor,
                        TextSize = 12,
                        TextXAlignment = Enum.TextXAlignment.Center
                    })

                    OptionButton.MouseButton1Click:Connect(function()
                        CurrentOption = option
                        DropdownFrame.Text = option
                        DropdownList.Visible = false

                        if Flag then
                            Rayfield.Flags[Flag] = CurrentOption
                        end

                        Callback(CurrentOption)
                    end)
                end

                local ContentSize = DropdownListContainer.UIListLayout.AbsoluteContentSize
                DropdownList.Size = UDim2.new(0.5, -25, 0, math.min(ContentSize.Y, 100))
                DropdownListContainer.CanvasSize = UDim2.new(0, 0, 0, ContentSize.Y)
            end

            UpdateDropdownList()

            DropdownFrame.MouseButton1Click:Connect(function()
                DropdownList.Visible = not DropdownList.Visible
            end)

            local DropdownObject = {
                Type = "Dropdown",
                CurrentOption = CurrentOption,
                Options = Options,
                Flag = Flag,
                Callback = Callback
            }

            function DropdownObject:Set(Option)
                CurrentOption = Option
                DropdownFrame.Text = Option

                if Flag then
                    Rayfield.Flags[Flag] = CurrentOption
                end

                Callback(CurrentOption)
            end

            function DropdownObject:Refresh(NewOptions)
                Options = NewOptions
                UpdateDropdownList()
            end

            return DropdownObject
        end

        function TabObj:CreateButton(ButtonSettings)
            local ButtonSettings = ButtonSettings or {}
            local Name = ButtonSettings.Name or "Button"
            local Callback = ButtonSettings.Callback or function() end

            local Button = CreateObject("TextButton", {
                Name = Name,
                Parent = TabContent,
                BackgroundColor3 = Rayfield.Theme.ElementBackground,
                BorderSizePixel = 0,
                Size = UDim2.new(1, 0, 0, 40),
                Font = Rayfield.Theme.TextFont,
                Text = Name,
                TextColor3 = Rayfield.Theme.TextColor,
                TextSize = 14
            })

            CreateObject("UICorner", {
                CornerRadius = UDim.new(0, 4),
                Parent = Button
            })

            CreateObject("UIStroke", {
                Color = Rayfield.Theme.ElementStroke,
                Thickness = 1,
                Parent = Button
            })

            Button.MouseButton1Click:Connect(function()
                Callback()
            end)

            Button.MouseEnter:Connect(function()
                TweenService:Create(Button, TweenInfo.new(0.2), {
                    BackgroundColor3 = Rayfield.Theme.ElementBackgroundHover
                }):Play()
            end)

            Button.MouseLeave:Connect(function()
                TweenService:Create(Button, TweenInfo.new(0.2), {
                    BackgroundColor3 = Rayfield.Theme.ElementBackground
                }):Play()
            end)

            return Button
        end

        return TabObj
    end

    return Window
end

return Rayfield
