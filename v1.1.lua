
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

repeat
	task.wait()
until game:IsLoaded() and game.Players.LocalPlayer and game.Players.LocalPlayer.Character

--#region Setup
if getgenv then
	if getgenv().DGEM_LOADED == true then
		repeat
			task.wait()
		until false
	end
	getgenv().DGEM_LOADED = true
end
local entities = {
	AllEntities = {
		"All",
		"Ambush",
		"Eyes",
		"Glitch",
		"Grundge",
		"Halt",
		"Hide",
		"None",
		"Random",
		"Rush",
		"Screech",
		"Seek",
		"Shadow",
		"Smiler",
		"Timothy",
		"Trashbag",
		"Trollface"
	},
	DeveloperEntities = {
		"Trollface",
		"None",
		"Smiler"
	},
	CustomEntities = {
		"Grundge",
		"Trashbag",
		"None"
	},
	RegularEntities = {
		"All",
		"Ambush",
		"Eyes",
		"Glitch",
		"Halt",
		"Hide",
		"Random",
		"None",
		"Rush",
		"Screech",
		"Seek",
		"Shadow",
		"Timothy"
	}
}
for _, tb in pairs(entities) do
	table.sort(tb)
end

if not isfile("interactedWithDiscordPrompt.txt") then
	writefile("interactedWithDiscordPrompt.txt", ".")
	local Inviter = loadstring(game:HttpGet("https://raw.githubusercontent.com/RegularVynixu/Utilities/main/Discord%20Inviter/Source.lua"))()
	Inviter.Prompt({
		name = "Zepsyy's Exploiting Community",
		invite = "discord.gg/scripters",
	})
