
return {
	Name = "sososomuchmorphssss",
	Title = "变身怪物",
	Description = "重生之我是DOORS怪物[推荐使用第三人称]",
	Game = "*",

	Elements = {
		{
			Type = "Button",
			Name = "figurebecome",
			Arguments = {
				Text = '瞎子',
				Tooltip = '把你变成figure',

				Func = function()
				   if _G.TransformedIntoAnyMorph == true then
	return
end
_G.TransformedIntoAnyMorph = true

local figureNew = game:GetObjects("rbxassetid://116871580020558")[1]
--game:GetObjects("rbxassetid://116871580020558")[1]
local giggles = {}
local gigglesDed = Instance.new("Folder",workspace)
local stompCooldown = false
local footstepType = 0
local footstepType2 = 0
local canwalk = true

local StompAnim
local IdleAnim
local WalkAnim
local RunAnim

gigglesDed.Name = "GigglesFake"
figureNew.Parent = workspace

if game.GameId == 6627207668 then
	StompAnim = figureNew.AnimationController.Animator:LoadAnimation(figureNew.AnimsTest.Stomp)
	IdleAnim = figureNew.AnimationController.Animator:LoadAnimation(figureNew.AnimsTest.Idle)
	WalkAnim = figureNew.AnimationController.Animator:LoadAnimation(figureNew.AnimsTest.Walk)
	RunAnim = figureNew.AnimationController.Animator:LoadAnimation(figureNew.AnimsTest.Run)
else
	StompAnim = figureNew.AnimationController.Animator:LoadAnimation(figureNew.Anims.Stomp)
	IdleAnim = figureNew.AnimationController.Animator:LoadAnimation(figureNew.Anims.Idle)
	WalkAnim = figureNew.AnimationController.Animator:LoadAnimation(figureNew.Anims.Walk)
	RunAnim = figureNew.AnimationController.Animator:LoadAnimation(figureNew.Anims.Run)
end

IdleAnim:Play()

WalkAnim:GetMarkerReachedSignal("Footstep"):Connect(function()
	footstepSoundWalk()
end)

RunAnim:GetMarkerReachedSignal("Footstep"):Connect(function()
	footstepSoundWalk()
end)

spawn(function()
	game.Players.LocalPlayer.Character.Humanoid.Running:Connect(function(speed)
		if speed >= 20 then
			IdleAnim:Stop()
			WalkAnim:Stop()
			if RunAnim.IsPlaying == false then
				RunAnim:Play()
				RunAnim:AdjustSpeed(1.5)
			end
		elseif speed >= 5 then
			IdleAnim:Stop()
			RunAnim:Stop()
			if WalkAnim.IsPlaying == false then
				WalkAnim:Play()
			end
		else
			WalkAnim:Stop()
			RunAnim:Stop()
			if IdleAnim.IsPlaying == false then
				IdleAnim:Play()
			end
		end
	end)
end)

function footstepSound()
	if footstepType == 1 then
		footstepType = 0
		figureNew.LeftFoot.Footstep:Play()
		figureNew.LeftFoot.FootstepLow:Play()
	else
		footstepType = 1
		figureNew.RightFoot.Footstep:Play()
		figureNew.RightFoot.FootstepLow:Play()
	end
end

function footstepSoundWalk()
	if canwalk == true then
		if footstepType2 == 1 then
			footstepType2 = 0
			figureNew.LeftFoot.Footstep:Play()
			figureNew.LeftFoot.FootstepLow:Play()
		else
			footstepType2 = 1
			figureNew.RightFoot.Footstep:Play()
			figureNew.RightFoot.FootstepLow:Play()
		end
	end
end

local function stompF()
	if stompCooldown == false then
		canwalk = false
		game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = true
		StompAnim:Play()
		getNearestWhileStomping()
		StompAnim:GetMarkerReachedSignal("Stomp"):Connect(function()
			figureNew.RightFoot.FootstepLowLoud:Play()
		end)
		StompAnim:GetMarkerReachedSignal("Footstep"):Connect(function()
			footstepSound()
		end)
		StompAnim:GetMarkerReachedSignal("Roar"):Connect(function()
			figureNew.Head.Growl:Play()
		end)
		StompAnim.Ended:Wait()
		canwalk = true
		game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false
	end
end

local function addGiggle(giggle)
	table.insert(giggles,giggle)
	workspace.ChildRemoved:Connect(function(what)
		if what == giggle then
			table.remove(giggles,table.find(giggles,giggle))
		end
	end)
end
local function killTheCacaoBallButWhite(ahhball:Model)
	if ahhball then
		print("found lil bro")
	end
	if _G.StompGigglesEnabled == false then
		warn("can't step giggle: stepping giggles is disabled")
		return
	end
	local newBall = ahhball:Clone()
	ahhball:Destroy()
	newBall.Name = "StompedGiggle"..game.Players.LocalPlayer.Name
	newBall.Parent = gigglesDed
	newBall:SetAttribute("RealName","StompedGiggle")
	newBall.Root.Sound_Laugh:Stop()
	wait(0.3)
	newBall.Root.Sound_Kill:Play()
	wait(0.6)
	print("GiggleFunction")
	for _, GiggleThing in pairs(newBall:GetDescendants()) do
		if GiggleThing:IsA("NoCollisionConstraint") or GiggleThing:IsA("BallSocketConstraint") then
			GiggleThing:Destroy()
		end
	end
	wait(5)
	for _, GigglePart in pairs(newBall:GetDescendants()) do
		if GigglePart:IsA("BasePart") then
			game:GetService("TweenService"):Create(GigglePart,TweenInfo.new(5,Enum.EasingStyle.Linear,Enum.EasingDirection.In),{
				Transparency = 1
			}):Play()
		end
	end
	wait(6)
	newBall:Destroy()
end
function getNearestWhileStomping()
	local nearest = 5
	local nearestGiggle = nil
	for _, Giggle in pairs(giggles) do
		if Giggle:FindFirstChild("Root") then
			print((figureNew.UserPivot.Position - Giggle.Root.Position).Magnitude)
			if (figureNew.UserPivot.Position - Giggle.Root.Position).Magnitude <= nearest then
				nearest = (figureNew.UserPivot.Position - Giggle.Root.Position).Magnitude
				nearestGiggle = Giggle
			end
		else
			table.remove(giggles,table.find(giggles,Giggle))
		end
	end
	if nearestGiggle then
		spawn(function()
			killTheCacaoBallButWhite(nearestGiggle)
		end)
	end
end
local function checkIfIsAGiggleRagdoll(giggle)
	spawn(function()
		local okkkk = 0
		repeat wait() print("trest" ..okkkk) okkkk += 1 until okkkk >= 20 or giggle:FindFirstChild("Root")
		if giggle:FindFirstChild("Root") then
			if giggle.Root:FindFirstChild("Sound_Kill") and giggle.Root:FindFirstChild("Sound_Laugh") and giggle:FindFirstChild("AnimationController") then
				addGiggle(giggle)
			end
		end
	end)
end
spawn(function()
	game:GetService("RunService").RenderStepped:Connect(function()
		if game.Players.LocalPlayer.Character:FindFirstChild("Head") then
			game.Players.LocalPlayer.Character:FindFirstChild("Head").Transparency = 1
		end
		if game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
			game.Players.LocalPlayer.Character:FindFirstChild("Humanoid").HipHeight = 2.3
		end
		figureNew:PivotTo(game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame)
		for _, v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
			if v:IsA("BasePart") then
				v.LocalTransparencyModifier = 1
				for _, dadada in pairs(v:GetDescendants()) do
					if dadada:IsA("Decal") or dadada:IsA("Texture") then
						dadada.Transparency = 1
					end
				end
			elseif v:IsA("Accessory") then
				if v:FindFirstChild("Handle") then
					v.Handle.Transparency = 1
				end
			end
		end
	end)
end)

workspace.ChildAdded:Connect(function(giggle)
	checkIfIsAGiggleRagdoll(giggle)
end)


game.Players.LocalPlayer:GetMouse().KeyDown:Connect(function(key)
	if key == "r" then
		stompF()
	end
end)
				end
			},
		},
		{
			Type = "Button",
			Name = "gloombecome",
			Arguments = {
				Text = '飞蛾',
				Tooltip = '将你变成死苍蝇',

				Func = function()
				   if _G.TransformedIntoAnyMorph == true then
	return
end
_G.TransformedIntoAnyMorph = true

local figureNew = game:GetObjects("rbxassetid://72951473062980")[1]
local testingPlace = false
--game:GetObjects("rbxassetid://72951473062980")[1]

figureNew.Parent = workspace

local IdleAnim

if game.GameId == 6627207668 then
	IdleAnim = figureNew.AnimationController:LoadAnimation(figureNew.AnimIdleT)
	testingPlace = true
else
	IdleAnim = figureNew.AnimationController:LoadAnimation(figureNew.AnimIdle)
	testingPlace = false
end

IdleAnim:Play()

if testingPlace == true then
	for _, Sounds in pairs(figureNew.Main.Sounds["test game"]:GetChildren()) do
		local newSound = Sounds:Clone()
		newSound.Parent = figureNew.Main
	end
else
	for _, Sounds in pairs(figureNew.Main.Sounds["DOORS"]:GetChildren()) do
		local newSound = Sounds:Clone()
		newSound.Parent = figureNew.Main
	end
end
figureNew.Main.Sounds:Destroy()

figureNew.Main.SoundFlying:Play()
figureNew.Main.SoundFlyingClose:Play()

spawn(function()
	game:GetService("RunService").RenderStepped:Connect(function()
		if game.Players.LocalPlayer.Character:FindFirstChild("Head") then
			game.Players.LocalPlayer.Character:FindFirstChild("Head").Transparency = 1
		end
		figureNew:PivotTo(game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame)
		for _, v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
			if v:IsA("BasePart") then
				v.LocalTransparencyModifier = 1
				for _, dadada in pairs(v:GetDescendants()) do
					if dadada:IsA("Decal") or dadada:IsA("Texture") then
						dadada.Transparency = 1
					end
				end
			elseif v:IsA("Accessory") then
				if v:FindFirstChild("Handle") then
					v.Handle.Transparency = 1
				end
			end
		end
	end)
end)

game.Players.LocalPlayer:GetMouse().KeyDown:Connect(function(key)
	if key == "r" then
		local randomRoar = math.random(1,2)
		if randomRoar == 1 then
			figureNew.Main.SoundRoar1.PlaybackSpeed = math.random(1,1.2)
			figureNew.Main.SoundRoar1:Play()
		else
			figureNew.Main.SoundRoar2.PlaybackSpeed = math.random(1,1.2)
			figureNew.Main.SoundRoar2:Play()
		end
	end
end)
				end
			}
		},
		{
			Type = "Button",
			Name = "rushbecome",
			Arguments = {
				Text = 'Rush',
				Tooltip = '将你变成 Rush',

				Func = function()
				   if _G.TransformedIntoAnyMorph == true then
	return
end
_G.TransformedIntoAnyMorph = true

local figureNew = game:GetObjects("rbxassetid://100327482330650")[1]
local testingPlace = false
--game:GetObjects("rbxassetid://100327482330650")[1]

figureNew.Parent = workspace

if game.GameId == 6627207668 then
	testingPlace = true
else
	testingPlace = false
end

if testingPlace == true then
	for _, Sounds in pairs(figureNew.Main.Sounds["test game"]:GetChildren()) do
		local newSound = Sounds:Clone()
		newSound.Parent = figureNew.Main
	end
else
	for _, Sounds in pairs(figureNew.Main.Sounds["DOORS"]:GetChildren()) do
		local newSound = Sounds:Clone()
		newSound.Parent = figureNew.Main
	end
end
figureNew.Main.Sounds:Destroy()

figureNew.Main.Footsteps:Play()
figureNew.Main.PlaySound:Play()

spawn(function()
	game:GetService("RunService").RenderStepped:Connect(function()
		if game.Players.LocalPlayer.Character:FindFirstChild("Head") then
			game.Players.LocalPlayer.Character:FindFirstChild("Head").Transparency = 1
		end
		figureNew:PivotTo(game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame)
		for _, v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
			if v:IsA("BasePart") then
				v.LocalTransparencyModifier = 1
				for _, dadada in pairs(v:GetDescendants()) do
					if dadada:IsA("Decal") or dadada:IsA("Texture") then
						dadada.Transparency = 1
					end
				end
			elseif v:IsA("Accessory") then
				if v:FindFirstChild("Handle") then
					v.Handle.Transparency = 1
				end
			end
		end
	end)
end)

game.Players.LocalPlayer:GetMouse().KeyDown:Connect(function(key)
	if key == "r" then
		if figureNew.Main.Footsteps.IsPlaying == true then
			figureNew.Main.Footsteps:Stop()
		else
			figureNew.Main.Footsteps:Play()
		end
		if figureNew.Main.PlaySound.IsPlaying == true then
			figureNew.Main.PlaySound:Stop()
		else
			figureNew.Main.PlaySound:Play()
		end
	end
end)
				end
			}
		},
		{
			Type = "Button",
			Name = "ambushbecome",
			Arguments = {
				Text = 'Ambush',
				Tooltip = '将你变成 Ambush',

				Func = function()
				   if _G.TransformedIntoAnyMorph == true then
	return
end
_G.TransformedIntoAnyMorph = true

local figureNew = game:GetObjects("rbxassetid://98266611233960")[1]
local testingPlace = false
--game:GetObjects("rbxassetid://98266611233960")[1]

figureNew.Parent = workspace

if game.GameId == 6627207668 then
	testingPlace = true
else
	testingPlace = false
end

figureNew.Main.Footsteps:Play()
figureNew.Main.PlaySound:Play()

spawn(function()
	game:GetService("RunService").RenderStepped:Connect(function()
		if game.Players.LocalPlayer.Character:FindFirstChild("Head") then
			game.Players.LocalPlayer.Character:FindFirstChild("Head").Transparency = 1
		end
		figureNew:PivotTo(game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame)
		for _, v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
			if v:IsA("BasePart") then
				v.LocalTransparencyModifier = 1
				for _, dadada in pairs(v:GetDescendants()) do
					if dadada:IsA("Decal") or dadada:IsA("Texture") then
						dadada.Transparency = 1
					end
				end
			elseif v:IsA("Accessory") then
				if v:FindFirstChild("Handle") then
					v.Handle.Transparency = 1
				end
			end
		end
	end)
end)

game.Players.LocalPlayer:GetMouse().KeyDown:Connect(function(key)
	if key == "r" then
		if figureNew.Main.Footsteps.IsPlaying == true then
			figureNew.Main.Footsteps:Stop()
		else
			figureNew.Main.Footsteps:Play()
		end
		if figureNew.Main.PlaySound.IsPlaying == true then
			figureNew.Main.PlaySound:Stop()
		else
			figureNew.Main.PlaySound:Play()
		end
	end
end)
				end
			}
		},
		{
			Type = "Button",
			Name = "seekbecome",
			Arguments = {
				Text = 'Seek',
				Tooltip = '将你变成老寒腿',

				Func = function()
				   if _G.TransformedIntoAnyMorph == true then
	return
end
_G.TransformedIntoAnyMorph = true

local figureNew = game:GetObjects("rbxassetid://86341229891935")[1]
local testingPlace = false
local canWalk = true
local introCD = false
--game:GetObjects("rbxassetid://86341229891935")[1]

figureNew.Parent = workspace

if game.GameId == 6627207668 then
	testingPlace = true
else
	testingPlace = false
end

local IntroAnim
local PipeSlimeAnim
local WalkAnim

if testingPlace then
	figureNew.SeekMusic.Intro.SoundId = "rbxassetid://138877504428539"
	IntroAnim = figureNew.SeekRig.AnimationController.Animator:LoadAnimation(figureNew.AnimationsTest.minesintro)
	WalkAnim = figureNew.SeekRig.AnimationController.Animator:LoadAnimation(figureNew.AnimationsTest.run)
	PipeSlimeAnim = figureNew.FullPipe._SeekCutscene.AnimationController:LoadAnimation(figureNew.FullPipe._SeekCutscene.AnimationP)
else
	IntroAnim = figureNew.SeekRig.AnimationController.Animator:LoadAnimation(figureNew.Animations.minesintro)
	WalkAnim = figureNew.SeekRig.AnimationController.Animator:LoadAnimation(figureNew.Animations.run)
	PipeSlimeAnim = figureNew.FullPipe._SeekCutscene.AnimationController:LoadAnimation(figureNew.FullPipe._SeekCutscene.Animation)
end

WalkAnim:Play()
WalkAnim:AdjustSpeed(0)

spawn(function()
	while wait() do
		if canWalk == false then
			figureNew.Figure.Footsteps:Stop()
			figureNew.Figure.FootstepsFar:Stop()
		end
		if figureNew.Figure.Footsteps.IsPlaying == true then
			if figureNew.Figure.FootstepsFar.IsPlaying == false then
				figureNew.Figure.FootstepsFar:Play()
			end
		end
		if figureNew.Figure.FootstepsFar.IsPlaying == true then
			if figureNew.Figure.Footsteps.IsPlaying == false then
				figureNew.Figure.Footsteps:Play()
			end
		end
	end
end)

spawn(function()
	game.Players.LocalPlayer.Character.Humanoid.Running:Connect(function(speed)
		if speed >= 5 then
			WalkAnim:AdjustSpeed(1)
			if figureNew.Figure.Footsteps.IsPlaying == false and canWalk then
				figureNew.Figure.Footsteps:Play()
				figureNew.Figure.FootstepsFar:Play()
			end
		else
			WalkAnim:AdjustSpeed(0)
			if figureNew.Figure.Footsteps.IsPlaying == true and canWalk then
				figureNew.Figure.Footsteps:Stop()
				figureNew.Figure.FootstepsFar:Stop()
			end
		end
	end)
end)

local function playIntro()
	if introCD == false then
		introCD = true
		canWalk = false
		game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = true
		figureNew.FullPipe._SeekCutscene.SlimeDrip1.Transparency = 0
		figureNew.FullPipe._SeekCutscene.SlimeDrip2.Transparency = 0
		figureNew.FullPipe.GrateCap.Circle.Transparency = 0
		figureNew.FullPipe.GrateCap.Grate.Transparency = 0
		figureNew.FullPipe.FigurePipe.PipeBase.Transparency = 0
		figureNew.SeekRig.SeekPuddle.Transparency = 0
		spawn(function()
			wait(8.11)
			for _, Beam in pairs(figureNew.SeekRig:GetChildren()) do
				if Beam:IsA("Beam") and Beam.Name == "StringCheese" then
					Beam.Enabled = true
				end
			end
		end)
		spawn(function()
			wait(10.2)
			for _, Beam in pairs(figureNew.SeekRig:GetChildren()) do
				if Beam:IsA("Beam") and Beam.Name == "StringCheese" then
					Beam.Enabled = false
				end
			end
		end)
		IntroAnim:Play()
		PipeSlimeAnim:Play()
		figureNew.SeekMusic.Intro:Play()
		wait(IntroAnim.Length-2)
		IntroAnim:Stop()
		figureNew.FullPipe._SeekCutscene.SlimeDrip1.Transparency = 1
		figureNew.FullPipe._SeekCutscene.SlimeDrip2.Transparency = 1
		figureNew.FullPipe.GrateCap.Circle.Transparency = 1
		figureNew.FullPipe.GrateCap.Grate.Transparency = 1
		figureNew.FullPipe.FigurePipe.PipeBase.Transparency = 1
		figureNew.SeekRig.SeekPuddle.Transparency = 1
		canWalk = true
		game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false
		introCD = false
	end
end

spawn(function()
	game:GetService("RunService").RenderStepped:Connect(function()
		if game.Players.LocalPlayer.Character:FindFirstChild("Head") then
			game.Players.LocalPlayer.Character:FindFirstChild("Head").Transparency = 1
		end
		figureNew:PivotTo(game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame)
		for _, v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
			if v:IsA("BasePart") then
				v.LocalTransparencyModifier = 1
				for _, dadada in pairs(v:GetDescendants()) do
					if dadada:IsA("Decal") or dadada:IsA("Texture") then
						dadada.Transparency = 1
					end
				end
			elseif v:IsA("Accessory") then
				if v:FindFirstChild("Handle") then
					v.Handle.Transparency = 1
				end
			end
		end
	end)
end)

game.Players.LocalPlayer:GetMouse().KeyDown:Connect(function(key)
	if key == "r" then
		playIntro()
	elseif key == "t" then
		figureNew.Figure.Scream:Play()
	end
end)
				end
			}
		},
		{
			Type = "Divider"
		},
        {
			Type = "Toggle",
			Name = "FigureSGE",
			Arguments = {
				Text = '战争践踏',
				Tooltip = '(仅用于figure变形)',

				Enabled = false,

				Callback = function(value)
					_G.StompGigglesEnabled = not value
					print("Enabled: "..tostring(not value))
				end
			}
		}
	}
}