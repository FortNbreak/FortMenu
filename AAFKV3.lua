
   local OrionLib = loadstring(game:HttpGet('https://raw.githubusercontent.com/FortNbreak/FortMenu/main/LIBupdated.lua'))()
local Orion = OrionLib:MakeWindow({Name = "AAFK", HidePremium = false, SaveConfig = true, ConfigFolder = "Doors Summon"})



local itemsTab = Orion:MakeTab({
    Name = "Anti AFK V3",
    Icon = ,
    PremiumOnly = false
})

itemsTab:AddParagraph("Anti AFK Script V3", "By FortNbreak")

game:service'Players'.LocalPlayer.Idled:connect(function()
bb:CaptureController()bb:ClickButton2(Vector2.new())





end)
