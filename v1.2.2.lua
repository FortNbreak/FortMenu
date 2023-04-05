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
end
--#endregion

--#region Window
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
--#endregion
--#region Connections & Variables

--//MAIN VARIABLES\\--
local Debris = game:GetService("Debris")


local player = game.Players.LocalPlayer
local Character = player.Character or player.CharacterAdded:Wait()
local RootPart = Character:FindFirstChild("HumanoidRootPart")
local Humanoid = Character:FindFirstChild("Humanoid")

local allLimbs = {}

for i, v in pairs(Character:GetChildren()) do
	if v:IsA("BasePart") then
		table.insert(allLimbs, v)
	end
end

--//MAIN USABLE FUNCTIONS\\--

function removeDebris(obj, Duration)
	Debris:AddItem(obj, Duration)
end

-- Services

local Players = game:GetService("Players")
local RS = game:GetService("RunService")
local ReSt = game:GetService("ReplicatedStorage")
local TextService = game:GetService("TextService")
local TS = game:GetService("TweenService")


local Plr = Players.LocalPlayer
local Char = Plr.Character or Plr.CharacterAdded:Wait()
local Root = Char:WaitForChild("HumanoidRootPart")
local Hum = Char:WaitForChild("Humanoid")

local ModuleScripts = {
	MainGame = require(Plr.PlayerGui.MainUI.Initiator.Main_Game),
	SeekIntro = require(Plr.PlayerGui.MainUI.Initiator.Main_Game.RemoteListener.Cutscenes.SeekIntro),
}
local Connections = {}


local function playSound(soundId, source, properties)
	local sound = Instance.new("Sound")
	sound.SoundId = "rbxassetid://" .. soundId
	sound.PlayOnRemove = true
	for i, v in next, properties do
		if i ~= "SoundId" and i ~= "Parent" and i ~= "PlayOnRemove" then
			sound[i] = v
		end
	end
	sound.Parent = source
	sound:Destroy()
end

local function drag(model, dest, speed)
	local reached = false
	Connections.Drag = RS.Stepped:Connect(function(_, step)
		if model.Parent then
			local seekPos = model.PrimaryPart.Position
			local newDest = Vector3.new(dest.X, seekPos.Y, dest.Z)
			local diff = newDest - seekPos
			if diff.Magnitude > 0.1 then
				model:SetPrimaryPartCFrame(CFrame.lookAt(seekPos + diff.Unit * math.min(step * speed, diff.Magnitude - 0.05), newDest))
			else
				Connections.Drag:Disconnect()
				reached = true
			end
		else
			Connections.Drag:Disconnect()
		end
	end)
	repeat
		task.wait()
	until reached
end

local function jumpscareSeek()
	Hum.Health = 0
	workspace.Ambience_Seek:Stop()
	local func = getconnections(ReSt.Bricks.Jumpscare.OnClientEvent)[1].Function
	debug.setupvalue(func, 1, false)
	func("Seek")
end

local function connectSeek(room)
	local seekMoving = workspace.SeekMoving
	local seekRig = seekMoving.SeekRig

    -- Intro
	seekMoving:SetPrimaryPartCFrame(room.RoomStart.CFrame * CFrame.new(0, 0, -15))
	seekRig.AnimationController:LoadAnimation(seekRig.AnimRaise):Play()
	task.spawn(function()
		task.wait(7)
		workspace.Footsteps_Seek:Play()
	end)
	workspace.Ambience_Seek:Play()
	ModuleScripts.SeekIntro(ModuleScripts.MainGame)
	seekRig.AnimationController:LoadAnimation(seekRig.AnimRun):Play()
	Char:SetPrimaryPartCFrame(room.RoomEnd.CFrame * CFrame.new(0, 0, 20))
	ModuleScripts.MainGame.chase = true
	Hum.WalkSpeed = 22
    
    -- Movement
	task.spawn(function()
		local nodes = {}
		for _, v in next, workspace.CurrentRooms:GetChildren() do
			for i2, v2 in next, v:GetAttributes() do
				if string.find(i2, "Seek") and v2 then
					nodes[#nodes + 1] = v.RoomEnd
				end
			end
		end
		for _, v in next, nodes do
			if seekMoving.Parent and not seekMoving:GetAttribute("IsDead") then
				drag(seekMoving, v.Position, 15)
			end
		end
	end)

    -- Killing
	task.spawn(function()
		while seekMoving.Parent do
			if (Root.Position - seekMoving.PrimaryPart.Position).Magnitude <= 30 and Hum.Health > 0 and not seekMoving.GetAttribute(seekMoving, "IsDead") then
				Connections.Drag:Disconnect()
				workspace.Footsteps_Seek:Stop()
				ModuleScripts.MainGame.chase = false
				Hum.WalkSpeed = 15
                
                -- Crucifix / death
				if not Char.FindFirstChild(Char, "Crucifix") then
					jumpscareSeek()
				else
					seekMoving.Figure.Repent:Play()
					seekMoving:SetAttribute("IsDead", true)
					workspace.Ambience_Seek.TimePosition = 92.6
					task.spawn(function()
						ModuleScripts.MainGame.camShaker:ShakeOnce(35, 25, 0.15, 0.15)
						task.wait(0.5)
						ModuleScripts.MainGame.camShaker:ShakeOnce(5, 25, 4, 4)
					end)

                    -- Crucifix float
					local model = Instance.new("Model")
					model.Name = "Crucifix"
					local hl = Instance.new("Highlight")
					local crucifix = Char.Crucifix
					local fakeCross = crucifix.Handle:Clone()
					fakeCross:FindFirstChild("EffectLight").Enabled = true
					ModuleScripts.MainGame.camShaker:ShakeOnce(35, 25, 0.15, 0.15)
					model.Parent = workspace
                    -- hl.Parent = model
                    -- hl.FillTransparency = 1
                    -- hl.OutlineColor = Color3.fromRGB(75, 177, 255)
					fakeCross.Anchored = true
					fakeCross.Parent = model
					crucifix:Destroy()
					for i, v in pairs(fakeCross:GetChildren()) do
						if v.Name == "E" and v:IsA("BasePart") then
							v.Transparency = 0
							v.CanCollide = false
						end
						if v:IsA("Motor6D") then
							v.Name = "Motor6D"
						end
					end
        


                    -- Seek death
					task.wait(4)
					seekMoving.Figure.Scream:Play()
					playSound(11464351694, workspace, {
						Volume = 3
					})
					game.TweenService:Create(seekMoving.PrimaryPart, TweenInfo.new(4), {
						CFrame = seekMoving.PrimaryPart.CFrame - Vector3.new(0, 10, 0)
					}):Play()
					task.wait(4)
					seekMoving:Destroy()
					fakeCross.Anchored = false
					fakeCross.CanCollide = true
					task.wait(0.5)
					model:Remove()
				end
				break
			end
			task.wait()
		end
	end)
end

-- Setup

local newIdx;
newIdx = hookmetamethod(game, "__newindex", newcclosure(function(t, k, v)
	if k == "WalkSpeed" and not checkcaller() then
		if ModuleScripts.MainGame.chase then
			v = ModuleScripts.MainGame.crouching and 17 or 22
		else
			v = ModuleScripts.MainGame.crouching and 10 or 15
		end
	end
	return newIdx(t, k, v)
end))

-- Scripts
 
local roomConnection;
roomConnection = workspace.CurrentRooms.ChildAdded:Connect(function(room)
	local trigger = room:WaitForChild("TriggerEventCollision", 1)
	if trigger then
		roomConnection:Disconnect()
		local collision = trigger.Collision:Clone()
		collision.Parent = room
		trigger:Destroy()
		local touchedConnection;
		touchedConnection = collision.Touched:Connect(function(p)
			if p:IsDescendantOf(Char) then
				touchedConnection:Disconnect()
				connectSeek(room)
			end
		end)
	end
end)
--#endregion
--#region Tabs
local MainTab = Window:CreateTab("Entity Spawning", 4370345144)
local DoorsMods = Window:CreateTab("Doors Modifications", 10722835155)
local ConfigEntities = Window:CreateTab("Configure Entities", 8285095937)
local publicServers = Window:CreateTab("Special Servers", 9692125126)
local Tools = Window:CreateTab("Tools", 29402763) 
local CharacterMods = Window:CreateTab("Character Modifications", 483040244)
local global = Window:CreateTab("Global", 1588352259) 
--#endregion
    
