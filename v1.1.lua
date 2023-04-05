game.StarterGui:SetCore("SendNotification", {
Title = "Shadow Scripts - DOORS";
Text = "0%";
Icon = "rbxassetid://6646175695"; -- the image if u want. 
Duration = 1; -- how long the notification should in secounds
})
local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/Rayfield/main/source'))()

local Window = Rayfield:CreateWindow({
	Name = "Doors Entity Replicator | " .. (identifyexecutor and identifyexecutor() or syn and "Synapse X" or "Unknown"),
	LoadingTitle = "Loading Doors Entity Spawner",
	LoadingSubtitle = "Made by Zepsyy and Spongus",
	ConfigurationSaving = {
		Enabled = true,
		FolderName = nil, -- Create a custom folder for your hub/game
		FileName = "L.N.K v1" -- ZEPSYY I TOLD YOU ITS NOT GONNA BE NAMED LINK  
	},
	Discord = {
		Enabled = false,
		Invite = "scripters", -- The Discord invite code, do not include discord.gg/
		RememberJoins = false -- Set this to false to make them join the discord every time they load it up
	},
	KeySystem = false
})
