--Script/Addon by stx
return [[ 

local Players = game:GetService("Players")

local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character

local Connection = getconnections(Character.AttributeChanged)[1]

local EditDashCooldown = debug.getupvalue(Connection.Function, 2)

return {
    Name = "delusional_office",
	Title = "delusional_office",
	Description = "support for the game delusional office",
    Game = "*",

	Elements = {
		{
			Type = "Button",
			Name = "godmode",
			Arguments = {
				Text = "Godmode",
				Tooltip = "self explanatory",

				Func = function()
					game.ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("EditValueCall"):FireServer("maxhealth", 1/0);
				end
			},
        },

        {
			Type = "Button",
			Name = "nodashcooldown",
			Arguments = {
				Text = "No Dash Cooldown",
				Tooltip = "self explanatory",

				Func = function()
					debug.setupvalue(EditDashCooldown, 2, 0)
				end
			},
        },

        {
			Type = "Button",
			Name = "dash boost",
			Arguments = {
				Text = "Dash Boost",
				Tooltip = "self explanatory",

				Func = function()
					debug.setupvalue(EditDashCooldown, 3, 100)
				end
			},
        },

        {
			Type = "Button",
			Name = "shotty",
			Arguments = {
				Text = "get weaopns",
				Tooltip = "self explanatory",

				Func = function()
                    game.ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("EditValueCall"):FireServer("giveitem", "DB Shotgun");
                    game.ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("EditValueCall"):FireServer("giveitem", "MG-D-LE-TR");
                    game.ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("EditValueCall"):FireServer("giveitem", "DB Manual");
				end
			},
        }
    }
}
]]
