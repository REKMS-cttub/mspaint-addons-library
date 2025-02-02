return [[
local modifierNames = {
    ["EyeMost"] = "眼睛在每个房间都生成",
    ["Chaos2"] = "", -- no need to show since black listed
    ["Chaos1"] = "", -- no need to show since black listed
    ["Chaos3"] = "", -- no need to show since black listed
    ["Dread"] = "时钟怪",
    ["DreadMost"] = "最可怕的",
    ["HideTime"] = "躲藏时间缩小",
    ["SnareMore"] = "更多地刺",
    ["NoGuidingLight"] = "引导之光消失了",
    ["Fog"] = "雾",
    ["Firedamp"] = "沼气",
    ["FireDampMost"] = "消防大",
    ["Slippery"] = "冰面",
    ["NoKeySound"] = "没有钥匙声音",
    ["PlayerLeastSlots"] = "玩家最不时段",
    ["DupeMore"] = "更多假门",
    ["DupeMost"] = "更多的假门",
    ["RushMore"] = "更多rush",
    ["GoldSpawnLess"] = "生成苍蝇蛋",
    ["entitiesMore"] = "更多实体",
    ["LockMore"] = "钥匙更多",
    ["LockMost"] = "钥匙会很多",
    ["LightsLeast"] = "灯光最少",
    ["BackdoorHaste"] = "红色骷髅头",
    ["BackdoorLookman"] = "Lookman",
    ["BackdoorRush"] = "闪电战",
    ["BackdoorVacuum"] = "真空",
    ["EntitiesLess"] = "实体更少",
    ["Giggle"] = "傻笑",
    ["GiggleSunglasses"] = "傻笑太阳镜",
    ["Gloombat"] = "蚊子蛋",
    ["GloombatMore"] = "蝙蝠更多",
    ["ItemDurabilityLess"] = "物品耐久更少",
    ["ItemSpawnLess"] = "物品生成变少",
    ["ItemSpawnMore"] = "物品生成更多",
    ["ItemSpawnNone"] = "物品不生成",
    ["LeastHidingSpots"] = "隐藏点生成变小",
    ["LightLess"] = "无光",
    ["SeekFaster"] = "seek更快",
    ["TimothyMore"] = "更多蜘蛛",
    ["PlayerFast"] = "跑起来",
    ["PlayerCrouchSlow"] = "跑的更慢",
    ["ScreechLight"] = "尖叫会在有光的地方生成",
    ["ScreechFast"] = "快速尖叫",
    ["PlayerSlowHealth"] = "受伤",
    ["HideLever2"] = "两个拉杆",
    ["Rooms"] = "更多的房间",
    ["RoomsA90"] = "A90",
    ["AmbushAlways"] = "Ambush更多次",
    ["AmbushFaster"] = "Ambush更快",
    ["AmbushMore"] = "Ambush生成的概率变大",
    ["EntitiesMost"] = "实体更多",
    ["EntitiesMoster"] = "实体太多了",
    ["EyesFour"] = "四只眼睛",
    ["EyesLevel2"] = "每个方向都会生成眼睛",
    ["EyesMore"] = "眼睛更多",
    ["EyesTwice"] = "两只眼睛",
    ["GiggleMore"] = "giggle变多",
    ["GiggleMost"] = "没有giggle",
    ["LightsNeverFlicker"] = "灯不会闪",
    ["LightsOut"] = "关灯"
}

local blacklistedModifiers = {
    ["Chaos1"] = true,
    ["Chaos2"] = true,
    ["Chaos3"] = true
}

local Addon = {
    Name = "ModifierUIAddon", -- Addon Name
    Title = "修饰符汉化查看", -- Title for the groupbox
    Description = "在游戏中显示活动修饰符", -- Description
    Game = "doors/doors", -- Only for Doors btw!

    Elements = {
        {
            Type = "Button",  
            Name = "DisplayModifiers", 
            Arguments = {
                Text = "显示所有修饰符",  
                Tooltip = "单击按钮以查看所有正在进行的修饰符.", 

                Func = function()
                    local ReplicatedStorage = game:GetService("ReplicatedStorage")
                    local LiveModifiers = ReplicatedStorage:WaitForChild("LiveModifiers")

                    local function createModifierUI(modifierFolders, isDescriptions)
                        local player = game.Players.LocalPlayer
                        local screenGui = Instance.new("ScreenGui")
                        screenGui.Parent = player.PlayerGui
                        screenGui.Name = "ModifiersUI"

                        local frame = Instance.new("Frame")
                        frame.Size = UDim2.new(0, 300, 0, 400)
                        frame.Position = UDim2.new(0, 20, 0, 200)
                        frame.BackgroundTransparency = 0.5
                        frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
                        frame.Parent = screenGui

                        local UIListLayout = Instance.new("UIListLayout")
                        UIListLayout.Parent = frame
                        UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
                        UIListLayout.Padding = UDim.new(0, 8)

                        for _, modifier in pairs(modifierFolders) do
                            local folderName = modifier.Name

                            if blacklistedModifiers[folderName] then
                                continue
                            end

                            local displayName = modifierNames[folderName] or folderName
                            local descriptionText = isDescriptions and modifierDescriptions[folderName] or displayName
                            
                            local label = Instance.new("TextLabel")
                            label.Text = descriptionText
                            label.Size = UDim2.new(1, 0, 0, 30)
                            label.TextColor3 = Color3.fromRGB(255, 255, 255)
                            label.TextSize = 18
                            label.BackgroundTransparency = 1
                            label.Parent = frame
                        end

                        wait(10)
                        screenGui:Destroy()
                    end

                    local modifierFolders = LiveModifiers:GetChildren()
                    createModifierUI(modifierFolders, false) -- Show modifier names
                end
            }
        },
    }

}

return Addon
]]
