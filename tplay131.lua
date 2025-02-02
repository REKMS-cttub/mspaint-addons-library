--Addon/script by Tplay
return [[
local Options = getgenv().Linoria.Options;
local Toggles = getgenv().Linoria.Toggles;

local collision = game.Players.LocalPlayer.Character.Collision
_G.DeletingFigure = false
_G.InvisFigure = false
_G.InvisGrumbles = false
_G.EffectPredicter = false

local Addon = {
    Name = "TplaysAddonDoors",
    Title = "Tplay's Addon Doors",
    Game = {
        "doors/doors"
    },
    
    Elements = {
        {
            Type = "Label",
            Name = "Text",
            Arguments = {
                "Main"
            }
        },

        {
            Type = "Toggle",
            Name = "NoWardrobeVignette",
            Arguments = {
                Text = 'No Wardrobe Vignette',
                Default = false,

                Callback = function(value)
                    local vignette = game:GetService("Players").LocalPlayer.PlayerGui.MainUI.MainFrame.HideVignette

                    if value then
                        vignette.Size = UDim2.new(0,0,0,0)
                    else
                        vignette.Size = UDim2.new(1,0,1,0)
                    end
                end
            }
        },

        {
            Type = "Toggle",
            Name = "RemoveAmbience",
            Arguments = {
                Text = 'No Ambience',
                Tooltip = 'Disables: Random Ambience, Hotel/Mines Ambience, Dark Ambience',
                Default = false,

                Callback = function(value)
                    if not game.SoundService:FindFirstChild("AmbienceRemove") then
                        local ambiencerem = Instance.new("BoolValue")
                        ambiencerem.Name = "AmbienceRemove"
                        ambiencerem.Parent = game.SoundService
                    end
                    if value then
                        workspace.Ambience_Dark.Volume = 0
                        if workspace:FindFirstChild("AmbienceMines") then
                            workspace.AmbienceMines.Volume = 0
                        else
                            workspace.Ambience_Hotel.Volume = 0
                            workspace.Ambience_Hotel2.Volume = 0
                            workspace.Ambience_Hotel3.Volume = 0
                        end
                        game.SoundService.AmbienceRemove.Value = true
                        task.wait()
                        repeat if workspace.Terrain:FindFirstChildWhichIsA("Attachment") then workspace.Terrain:FindFirstChildWhichIsA("Attachment"):remove() end task.wait(0.01) until game.SoundService.AmbienceRemove.Value == false
                    else
                        workspace.Ambience_Dark.Volume = 0.6
                        if workspace:FindFirstChild("AmbienceMines") then
                            workspace.AmbienceMines.Volume = 0.4
                        else
                            workspace.Ambience_Hotel.Volume = 0.2
                            workspace.Ambience_Hotel2.Volume = 0.3
                            workspace.Ambience_Hotel3.Volume = 0.05
                        end
                        game.SoundService.AmbienceRemove.Value = false
                    end
                end
            }
        },

        {
            Type = "Toggle",
            Name = "GlitchFragmentEffectPredict",
            Arguments = {
                Text = "Effect Predicter",
                Tooltip = "Predicting Effect from Glitch Fragment (don't use more than 1 glitch fragment, or else Effect Predicter will start bugging)",
                Default = false,

                Callback = function(value)
                    local glitch = game.Players.LocalPlayer.PlayerGui.MainUI.MainFrame.GlitchTrial
                    if value then
                        _G.EffectPredicter = true
                        while _G.EffectPredicter == true do
                            while _G.EffectPredicter == true and glitch.Visible == false do
                                task.wait(0.1)
                            end
                            if _G.EffectPredicter == true then
                                if glitch.TextLabel.Text == "NDAxIEZPUkJJRERFTg==" or glitch.TextLabel.Text == "NDAzIEZPUkJJRERFTg==" then
                                    if glitch.TextLabel.Text == "NDAxIEZPUkJJRERFTg==" then
                                        getgenv().Library:Notify("[Effect Predicter] You'll get coins", 3)
                                    end
                                    if glitch.TextLabel.Text == "NDAzIEZPUkJJRERFTg==" then
                                        getgenv().Library:Notify("[Effect Predicter] You'll become immortal for a few seconds and get coins", 3)
                                    end
                                    task.wait(3)
                                    repeat task.wait(0.1) until glitch.Visible == true
                                else
                                    if glitch.TextLabel.Text == "Q0FDSEUgUkVGUkVTSA==" then
                                        getgenv().Library:Notify("[Effect Predicter] All items in your inventory will be duplicated", 5)
                                        task.wait(3)
                                        repeat task.wait(0.1) until glitch.Visible == true
                                    else
                                        if glitch.TextLabel.Text == "UlVOVElNRSBCT09TVA==" or glitch.TextLabel.Text == "UlVOVElNRSBCT09TVA===" then
                                            getgenv().Library:Notify("[Effect Predicter] You'll get a speedboost", 3.5)
                                            task.wait(3)
                                            repeat task.wait(0.1) until glitch.Visible == true
                                        else
                                            if glitch.TextLabel.Text == "UE9XRVIgU1VSR0U=" then
                                                getgenv().Library:Notify("[Effect Predicter] Your max health will be changed", 6.5)
                                                task.wait(3)
                                                repeat task.wait(0.1) until glitch.Visible == true
                                            else
                                                getgenv().Library:Notify("[Effect Predicter] Unknown Effect (maybe i forgot to add something effects)", 5)
                                                task.wait(3)
                                                repeat task.wait(0.1) until glitch.Visible == true
                                            end
                                        end
                                    end
                                end
                            end
                            while glitch.Visible == true do task.wait(0.1) end
                            task.wait()
                        end
                    else
                        _G.EffectPredicter = false
                    end
                end
            }
        },

        {
            Type = "Divider",
        },

        {
            Type = "Label",
            Name = "Text",
            Arguments = {
                "Troll"
            }
        },

        {
            Type = "Toggle",
            Name = "Stun",
            Arguments = {
                Text = 'Stun',
                Enabled = false,

                Callback = function(value)
                    local lplr = game.Players.LocalPlayer
                    
                    if value then
                        lplr.Character:SetAttribute('Stunned', true)
                        lplr.Character.Humanoid:SetAttribute('Stunned', true)
                    else
                        lplr.Character:SetAttribute('Stunned', false)
                        lplr.Character.Humanoid:SetAttribute('Stunned', false)
                    end
                end
            }
        },
    
        {
            Type = "Toggle",
            Name = "ThinkingAnimation",
            Arguments = {
                Text = 'Thinking Animation',
                Enabled = false,

                Callback = function(value)
                    local lplr = game.Players.LocalPlayer
                    
                    local thinkanims = {"18885101321", "18885098453", "18885095182"}
                    
                    if value then
                        local animation = Instance.new("Animation")
                        animation.AnimationId = "rbxassetid://" .. thinkanims[math.random(1, #thinkanims)]
                        animtrack = lplr.Character:FindFirstChildWhichIsA("Humanoid"):LoadAnimation(animation)
                        animtrack.Looped = true
                        animtrack:Play()
                    else
                        if animtrack then
                            animtrack:Stop()
                            animtrack:Destroy()
                        end
                    end
                end
            }
        },

        {
            Type = "Divider",
        },

        {
            Type = "Label",
            Name = "Text",
            Arguments = {
                "Figure [FE, but need alarm clock]"
            }
        },

        {
            Type = "Button",
            Name = "removefigure",
            Arguments = {
                Text = 'Delete Figure',

                Func = function(value)
                    local room = game.Players.LocalPlayer:GetAttribute("CurrentRoom")
                    local crooms = workspace.CurrentRooms
                    _G.notsuccess = 0
                    if _G.DeletingFigure == false then
                        _G.DeletingFigure = true
                        local Part = Instance.new("Part", workspace)
                        local Attachment1 = Instance.new("Attachment", Part)
                        Part.Anchored = true
                        Part.Position = Vector3.new(0,0,0)
                        Attachment1.Position = Vector3.new(0,-49000,0)
                        if crooms:WaitForChild(room):FindFirstChild("FigureSetup") then
                            if crooms:WaitForChild(room).FigureSetup.FigureRig:FindFirstChild("Root") then
                                local figure = crooms:WaitForChild(room).FigureSetup.FigureRig
                                local Torque = Instance.new("Torque")
                                Torque.Parent = figure.Hitbox
                                Torque.Torque = Vector3.new(100000,100000,100000)
                                local AlignPosition = Instance.new("AlignPosition")
                                local Attachment2 = Instance.new("Attachment")
                                AlignPosition.Parent = figure.Hitbox
                                Attachment2.Parent = figure.Hitbox
                                Torque.Attachment0 = Attachment2
                                AlignPosition.MaxForce = 9999999999999999
                                AlignPosition.MaxVelocity = math.huge
                                AlignPosition.Responsiveness = 100
                                AlignPosition.Attachment0 = Attachment2
                                AlignPosition.Attachment1 = Attachment1
                                task.wait(1.5)
                                Part:remove()
                                Attachment1:remove()
                                Torque:remove()
                                AlignPosition:remove()
                                Attachment2:remove()
                                Part:remove()
                                repeat _G.notsuccess = _G.notsuccess+1 task.wait(0.1) until figure.Hitbox.Position == Vector3.new() or _G.notsuccess == 100
                                if _G.notsuccess == 100 then
                                    getgenv().Library:Notify("[Error] Failed to delete figure", 4)
                                    _G.DeletingFigure = false
                                else
                                    getgenv().Library:Notify("[Message] Figure deleted succesfully!", 4)
                                    _G.DeletingFigure = false
                                end
                            else
                                getgenv().Library:Notify("[Error] Figure not found", 3)
                                _G.DeletingFigure = false
                                Part:remove()
                                Attachment1:remove()
                            end
                        else
                            getgenv().Library:Notify("[Error] Figure not found", 3)
                            _G.DeletingFigure = false
                            Part:remove()
                            Attachment1:remove()
                        end
                    end
                end
            }
        },

        {
            Type = "Divider",
        },

        {
            Type = "Label",
            Name = "Text",
            Arguments = {
                "Grumbles [FE]"
            }
        },

        {
            Type = "Toggle",
            Name = "invisgrumbles",
            Arguments = {
                Text = 'Invisible Grumbles',
                Default = false,

                Callback = function(value)
                    local room = game.Players.LocalPlayer:GetAttribute("CurrentRoom")
                    local crooms = workspace.CurrentRooms
                    if value then
                        if crooms:WaitForChild(room):FindFirstChild("_NestHandler") then
                            if crooms:WaitForChild(room):WaitForChild("_NestHandler"):FindFirstChild("Grumbles") then
                                _G.InvisGrumbles = true
                                for i,v in ipairs(crooms:WaitForChild(room):WaitForChild("_NestHandler").Grumbles:GetChildren()) do v.MainPart.GrumbleAttach.CFrame = CFrame.new(Vector3.new(0,500,0)) end
                            else
                                getgenv().Library:Notify("[Error] Grumbles not found", 3)
                                task.wait()
                                Toggles["TplaysAddonDoors_invisgrumbles"]:SetValue(false)
                            end
                        else
                            getgenv().Library:Notify("[Error] Grumbles not found", 3)
                            task.wait()
                            Toggles["TplaysAddonDoors_invisgrumbles"]:SetValue(false)
                        end
                    else
                        if _G.InvisGrumbles == true then
                            _G.InvisGrumbles = false
                            if crooms:WaitForChild(room):FindFirstChild("_NestHandler") then
                                if crooms:WaitForChild(room):WaitForChild("_NestHandler"):FindFirstChild("Grumbles") then
                                    for i,v in ipairs(crooms:WaitForChild(room):WaitForChild("_NestHandler").Grumbles:GetChildren()) do v.MainPart.GrumbleAttach.CFrame = CFrame.new(Vector3.new(0,0,0)) end
                                end
                            end
                        end
                    end
                end
            }
        }
    }
}

return Addon;
]]
