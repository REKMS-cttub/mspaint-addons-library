local Library = getgenv().Library

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer
local LatestRoom = ReplicatedStorage:WaitForChild("GameData"):WaitForChild("LatestRoom")

local TimerGui = Instance.new("ScreenGui") do
    TimerGui.Enabled = false
    TimerGui.IgnoreGuiInset = true
    TimerGui.Parent = LocalPlayer.PlayerGui
end

local TimerLabel = Instance.new("TextLabel") do
    TimerLabel.AnchorPoint = Vector2.new(0.5, 0)

    TimerLabel.BackgroundColor3 = Library.MainColor
    TimerLabel.BorderColor3 = Library.AccentColor
    TimerLabel.TextColor3 = Library.FontColor

    TimerLabel.BorderSizePixel = 2
    TimerLabel.Position = UDim2.new(0.5, 0, 0, 0)
    TimerLabel.Size = UDim2.fromOffset(262, 64)

    TimerLabel.Font = Library.Font
    TimerLabel.Text = "00:00.00"
    TimerLabel.TextScaled = true

    TimerLabel.Parent = TimerGui
    
    Library:AddToRegistry(TimerLabel, {
        BackgroundColor3 = "MainColor",
        BorderColor3 = "AccentColor",
        TextColor3 = "FontColor"
    })
end

local Addon = {
    Name = "SpeedrunTimer",
    Title = "倒计时",
    Game = "doors/doors",

    Elements = {
        {
            Type = "Toggle",
            Name = "Timer",
            Arguments = {
                Text = "显示计时器",
                Enabled = false,

                Callback = function(value) TimerGui.Enabled = value end
            }
        }
    }
}

if getgenv().SpeedRunStopped then
    getgenv().SpeedRunTime += (tick() - getgenv().SpeedRunStopped)
else
    getgenv().SpeedRunTime = 0
end

task.spawn(function()
    if LatestRoom.Value < 1 then
        LatestRoom.Changed:Wait()
    end

    if Library.Unloaded then return end
    Library:GiveSignal(RunService.RenderStepped:Connect(function(delta)
        getgenv().SpeedRunTime += delta
        TimerLabel.Text = string.format("%02i:%02i.%02i", SpeedRunTime / 60, SpeedRunTime % 60, (SpeedRunTime % 1) * 100)
    end))
end)

task.spawn(function()
    repeat task.wait() until Library.Unloaded

    getgenv().SpeedRunStopped = tick()
    TimerGui:Destroy()
end)

return Addon