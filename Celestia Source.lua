repeat task.wait() until game.IsLoaded
repeat task.wait() until game:GetService("Players").LocalPlayer.Character

local Config = {
    WindowName = "Celestia - Deepwoken",
	Color = Color3.fromRGB(255, 0, 0),
	Keybind = Enum.KeyCode.RightBracket
}

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/AlexR32/Roblox/main/BracketV3.lua"))()
local Window = Library:CreateWindow(Config, game:GetService("CoreGui").RobloxGui)

local deepwokenTab = Window:CreateTab("Deepwoken")
local MiscTab = Window:CreateTab("Misc")
local keybindsTab = Window:CreateTab("Keybinds")
local settingsTab = Window:CreateTab("UI Settings")
local creditsTab = Window:CreateTab("Credits")

local characterSection = deepwokenTab:CreateSection("Character")
local espSection = deepwokenTab:CreateSection("ESP")
local worldSection = deepwokenTab:CreateSection("World")
local autoLootSection = deepwokenTab:CreateSection("Auto Loot")
local creditsSection = deepwokenTab:CreateSection("Credits")
local settingsSection = settingsTab:CreateSection("Settings")
local BlatantSection = MiscTab:CreateSection("Blatant")
local TeleportSection = MiscTab:CreateSection("Teleports")

--// Services / Classes
local PlayerService = game:GetService("Players")
local CurrentCam = workspace.CurrentCamera
local player = PlayerService.LocalPlayer
local RunService = game:GetService("RunService")
local mouse = player:GetMouse()

--// Variables for global classes
local ESP_TOGGLE = false
local ESP_TOGGLE_NPC = false
local ESP_TOGGLE_NPC2 = false
local ESP_CHEST = false

getgenv().Distance = false

getgenv().DistanceNPC = 0
getgenv().DistanceEnemy = 0
getgenv().DistanceChest = 0

--[[

local espDistanceSlider = espSection:CreateSlider("ESP Render Distance", 0, 15000, 2000, true, function(currentValue)
	getgenv().currentEspDistance = currentValue
end)

]]
--// Functions
local function GetMagnitude(part1, part2, floor)
	local Magnitude = (part1.Position - part2.Position).Magnitude

	if floor == true then
		return math.floor(Magnitude)
	else
		return Magnitude
	end
end



local function CreateESP(plr, character, type, font, size, color, typ)
		local hum = character:WaitForChild("Humanoid")
		local root = character:FindFirstChild("HumanoidRootPart") or character:FindFirstChild("Torso")

    if tostring(type):lower() == "text" or tostring(type) == "Text" then
    local txt = Drawing.new("Text")
    txt.Visible = false
    txt.Center = true
    txt.Outline = true
    txt.Font = font
    txt.Color = color
    txt.Size = size

    local connection = nil
    local connection2 = nil
    local connection3 = nil

    local function DestroyESP()
        txt.Visible = false
        txt:Remove()

        if connection then
            connection:Disconnect()
        end
        if connection2 then
            connection2:Disconnect()
        end
        if connection3 then
            connection3:Disconnect()
        end
    end

    connection2 = character.AncestryChanged:Connect(function(_,parent)
        if not parent then
            DestroyESP()
        end
    end)

    connection3 = hum.HealthChanged:Connect(function(hp)
        if (hp<=0) or (hum:GetState() == Enum.HumanoidStateType.Dead) then 
        DestroyESP()
        end
    end)

	
    connection = RunService.RenderStepped:Connect(function()
		if ESP_TOGGLE == false then
			DestroyESP()
		end

        local rootpos, rootonscr = CurrentCam:WorldToViewportPoint(root.Position + Vector3.new(0,4,0))
        if rootonscr then
            txt.Position = Vector2.new(rootpos.X, rootpos.Y)

		if not getgenv().Distance then
			txt.Text = plr.Name .. " " .. "(" .. math.floor(hum.Health) .. "/" .. math.floor(hum.MaxHealth) .. "hp" .. ")"
		elseif getgenv().Distance then
		    txt.Text = "[" .. GetMagnitude(root, player.Character.HumanoidRootPart, true) .. "m" .. "] " .. plr.Name .. " " .. "(" .. math.floor(hum.Health) .. "/" .. math.floor(hum.MaxHealth) .. "hp" .. ")"
		end

            txt.Visible = true
        else
            txt.Visible = false
		end

		if (root.Position - player.Character.HumanoidRootPart.Position).Magnitude < getgenv().currentEspDistance and rootonscr then
			txt.Visible = true
		else
			txt.Visible = false
		end
    end)
    end
end

--[[
	elseif tostring(typ):lower() == "npc" then
			txt.Text = "[" .. GetMagnitude(root, player.Character.HumanoidRootPart, true) .. "m" .. "] " .. plr.Name .. " " .. "(" .. math.floor(hum.Health) .. "/" .. math.floor(hum.MaxHealth) .. "hp" .. ")"
			
			]]
local function CreateNPCESP(plr, character, type, font, size, color, typ)
	local hum = character:WaitForChild("Humanoid")
	local root = character:WaitForChild("HumanoidRootPart") or character:WaitForChild("Torso")
	print('a')
if tostring(type):lower() == "text" or tostring(type) == "Text" then
local txt = Drawing.new("Text")
txt.Visible = false
txt.Center = true
txt.Outline = true
txt.Font = font
txt.Color = color
txt.Size = size
print('b')

local connection = nil
local connection2 = nil
local connection3 = nil

local function DestroyESP()
	txt.Visible = false
	txt:Remove()

	if connection then
		connection:Disconnect()
	end
	if connection2 then
		connection2:Disconnect()
	end
	if connection3 then
		connection3:Disconnect()
	end
end

connection2 = character.AncestryChanged:Connect(function(_,parent)
	if not parent then
		DestroyESP()
	end
end)

connection3 = hum.HealthChanged:Connect(function(hp)
	if (hp<=0) or (hum:GetState() == Enum.HumanoidStateType.Dead) then 
	DestroyESP()
	end
end)


connection = RunService.RenderStepped:Connect(function()
	if ESP_TOGGLE_NPC == false then
		DestroyESP()
	end

	local rootpos, rootonscr = CurrentCam:WorldToViewportPoint(root.Position + Vector3.new(0,4,0))
	if rootonscr then
		txt.Position = Vector2.new(rootpos.X, rootpos.Y)


	if tostring(typ):lower() == "npc" then
		txt.Text = "[" .. GetMagnitude(root, player.Character.HumanoidRootPart, true) .. "m" .. "] " .. plr.Name .. " " .. "(" .. math.floor(hum.Health) .. "/" .. math.floor(hum.MaxHealth) .. "hp" .. ")"
	end
		txt.Visible = true
	else
		txt.Visible = false
	end

	if (root.Position - player.Character.HumanoidRootPart.Position).Magnitude < getgenv().DistanceEnemy and rootonscr then
		txt.Visible = true
	else
		txt.Visible = false
	end
end)
end
end

local function CreateChest1(plr, character, type, font, size, color, typ)
	local root = character:WaitForChild("Lid")
	print('a')
if tostring(type):lower() == "text" or tostring(type) == "Text" then
local txt = Drawing.new("Text")
txt.Visible = false
txt.Center = true
txt.Outline = true
txt.Font = font
txt.Color = color
txt.Size = size
print('b')

local connection = nil
local connection2 = nil

local function DestroyESP()
	txt.Visible = false
	txt:Remove()

	if connection then
		connection:Disconnect()
	end
	if connection2 then
		connection2:Disconnect()
	end
end

connection2 = character.AncestryChanged:Connect(function(_,parent)
	if not parent then
		DestroyESP()
	end
end)


connection = RunService.RenderStepped:Connect(function()
	if ESP_CHEST == false then
		DestroyESP()
	end

	local rootpos, rootonscr = CurrentCam:WorldToViewportPoint(root.Position + Vector3.new(0,2,0))
	if rootonscr then
		txt.Position = Vector2.new(rootpos.X, rootpos.Y)

	if tostring(typ):lower() == "chest" then
		txt.Text = "[" .. GetMagnitude(root, player.Character.HumanoidRootPart, true) .. "m" .. "] " .. "Chest"
	end
		txt.Visible = true
	else
		txt.Visible = false
	end
	if (root.Position - player.Character.HumanoidRootPart.Position).Magnitude < getgenv().DistanceChest and rootonscr then
		txt.Visible = true
	else
		txt.Visible = false
	end
end)
end
end

local function CreateNPCESP2(plr, character, type, font, size, color, typ)
	local hum = character:WaitForChild("Humanoid")
	local root = character:WaitForChild("HumanoidRootPart") or character:WaitForChild("Torso")
	print('a')
if tostring(type):lower() == "text" or tostring(type) == "Text" then
local txt = Drawing.new("Text")
txt.Visible = false
txt.Center = true
txt.Outline = true
txt.Font = font
txt.Color = color
txt.Size = size
print('b')

local connection = nil
local connection2 = nil
local connection3 = nil

local function DestroyESP()
	txt.Visible = false
	txt:Remove()

	if connection then
		connection:Disconnect()
	end
	if connection2 then
		connection2:Disconnect()
	end
	if connection3 then
		connection3:Disconnect()
	end
end

connection2 = character.AncestryChanged:Connect(function(_,parent)
	if not parent then
		DestroyESP()
	end
end)

connection3 = hum.HealthChanged:Connect(function(hp)
	if (hp<=0) or (hum:GetState() == Enum.HumanoidStateType.Dead) then 
	DestroyESP()
	end
end)


connection = RunService.RenderStepped:Connect(function()
	if ESP_TOGGLE_NPC2 == false then
		DestroyESP()
	end

	local rootpos, rootonscr = CurrentCam:WorldToViewportPoint(root.Position + Vector3.new(0,4,0))
	if rootonscr then
		txt.Position = Vector2.new(rootpos.X, rootpos.Y)


	if tostring(typ):lower() == "npc" then
		txt.Text = "[" .. GetMagnitude(root, player.Character.HumanoidRootPart, true) .. "m" .. "] " .. plr.Name .. " " .. "(" .. math.floor(hum.Health) .. "/" .. math.floor(hum.MaxHealth) .. "hp" .. ")"
	end
		txt.Visible = true
	else
		txt.Visible = false
	end
	if (root.Position - player.Character.HumanoidRootPart.Position).Magnitude < getgenv().DistanceNPC and rootonscr then
			txt.Visible = true
		else
			txt.Visible = false
		end
end)
end
end

--// Tables
getgenv().setting = {
	["SpeedHack"] = 2,
	["SpeedKeybind"] = Enum.KeyCode.C,
	["FlyKeybind"] = Enum.KeyCode.Z,
	["FlySpeed"] = 125,
  }


local speedToggle = characterSection:CreateToggle("Speed", false, function(currentState)
	if currentState then
		  getgenv().setting["SpeedKeybind"] = Enum.KeyCode.C
		  
		  local client = game.Players.LocalPlayer
		  local char = client.Character
		  local Root = char:WaitForChild("HumanoidRootPart")
		  
		  local Camera = workspace.CurrentCamera
		  
		  local loop = false
		  local active = false
		  
		  local dir = {Left = false, Right = false, Forward = false, Backward = false}
			  local uis = game:GetService("UserInputService")
			  
			  uis.InputBegan:Connect(function(key, chat)
				  if not chat then
					  if key.KeyCode == Enum.KeyCode.W then
						  dir.Forward = true
						  
					  elseif key.KeyCode == Enum.KeyCode.A then
						  dir.Left = true
						  
					  elseif key.KeyCode == Enum.KeyCode.S then
						  dir.Backward = true
						  
					  elseif key.KeyCode == Enum.KeyCode.D then
						  dir.Right = true
						  
						  end
					  end
			  end)
			  
			  uis.InputEnded:Connect(function(key)
					  if key.KeyCode == Enum.KeyCode.W then
						  dir.Forward = false
						  
					  elseif key.KeyCode == Enum.KeyCode.A then
						  dir.Left = false
						  
					  elseif key.KeyCode == Enum.KeyCode.S then
						  dir.Backward = false
						  
					  elseif key.KeyCode == Enum.KeyCode.D then
						  dir.Right = false
						  
						  end
			  end)
			  
			  uis.InputBegan:Connect(function(key,chat)
				  local character = client.Character
				  local Root = character.HumanoidRootPart
				  pcall(function()
				  if chat then return end
				  if character and character.Humanoid and character.Humanoid.Health ~= 0 then
				  if key.KeyCode == getgenv().setting["SpeedKeybind"] then
					  loop = true
					  while task.wait() do
						  if uis:IsKeyDown(getgenv().setting["SpeedKeybind"]) then
							  active = true
							  if active then
				  if dir.Forward then
					  Root.CFrame = Root.CFrame + (Root.CFrame.LookVector * (getgenv().setting["SpeedHack"]))
				  end
				  if dir.Backward then
					  Root.CFrame = Root.CFrame + (-Root.CFrame.LookVector * (getgenv().setting["SpeedHack"]))
				  end
				  if dir.Left then
					  Root.CFrame = Root.CFrame + (-Root.CFrame.RightVector * (getgenv().setting["SpeedHack"]))
				  end
				  if dir.Right then
					  Root.CFrame = Root.CFrame + (Root.CFrame.RightVector * (getgenv().setting["SpeedHack"]))
				  end
							  end
						  end
						  if loop == false then break end
					  end -- loop end
				  end
				  
			  end
		  end)
		  end)
		  
		  
		  uis.InputEnded:Connect(function(key,chat)
			  if chat then return end
			  if key.KeyCode == getgenv().setting["SpeedKeybind"] then
				  loop = false
			  end
		  end)
	else
		getgenv().setting["SpeedKeybind"] = Enum.KeyCode.Unknown
	end
end)
local speedAmountTog = characterSection:CreateSlider("Speed Amount", 0, 10, 2, true, function(currentValue)
	getgenv().setting["SpeedHack"] = currentValue
end)
----------------------
pcall(function()
local flyToggle = characterSection:CreateToggle("Fly", false, function(currentState)
	if currentState then
		getgenv().setting["FlyKeybind"] = Enum.KeyCode.Z
		local Float = nil
		local on = true
					
		local UIS = game:GetService("UserInputService")
		local OnRender = game:GetService("RunService").RenderStepped

		local Player = game:GetService("Players").LocalPlayer
		local Character = Player.Character or Player.CharacterAdded:Wait()

		local Camera = workspace.CurrentCamera
		local Root = Character:WaitForChild("HumanoidRootPart")

		local C1, C2, C3;
		local Nav = {Flying = false, Forward = false, Backward = false, Left = false, Right = false}
		C1 = UIS.InputBegan:Connect(function(Input, chat)
			if chat then return end
			if Input.UserInputType == Enum.UserInputType.Keyboard then
				if Input.KeyCode == getgenv().setting["FlyKeybind"] then
					kp = true
					Nav.Flying = not Nav.Flying
					--Root.Anchored = Nav.Flying
				elseif Input.KeyCode == Enum.KeyCode.W then
					Nav.Forward = true
				elseif Input.KeyCode == Enum.KeyCode.S then
					Nav.Backward = true
				elseif Input.KeyCode == Enum.KeyCode.A then
					Nav.Left = true
				elseif Input.KeyCode == Enum.KeyCode.D then
					Nav.Right = true
				end
			end
		end)

		C2 = UIS.InputEnded:Connect(function(Input)
			if Input.UserInputType == Enum.UserInputType.Keyboard then
				if Input.KeyCode == Enum.KeyCode.W then
					Nav.Forward = false
				elseif Input.KeyCode == Enum.KeyCode.S then
					Nav.Backward = false
				elseif Input.KeyCode == Enum.KeyCode.A then
					Nav.Left = false
				elseif Input.KeyCode == Enum.KeyCode.D then
					Nav.Right = false
				end
			end
		end)

		C3 = Camera:GetPropertyChangedSignal("CFrame"):Connect(function()
			if Nav.Flying then
				Root.CFrame = CFrame.new(Root.CFrame.Position, Root.CFrame.Position + Camera.CFrame.LookVector)
			end
		end)

		while true do -- not EndAll
			local Delta = OnRender:Wait()
			
			if Float == nil then
			Float = Instance.new('Part')
			Float.Name = "OldDebris"
			Float.Parent = game.Workspace
			Float.Transparency = 1
			Float.Size = Vector3.new(6,1,6)
			Float.Anchored = true
			end
					
					
			if Float then 
				Float.CFrame = game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame * CFrame.new(0,-math.random(2.5,3.7),0)
			end
			
					
			if Nav.Flying then
				if Nav.Forward then
					Root.CFrame = Root.CFrame + (Camera.CFrame.LookVector * (Delta * getgenv().setting["FlySpeed"]))
				end
				if Nav.Backward then
					Root.CFrame = Root.CFrame + (-Camera.CFrame.LookVector * (Delta * getgenv().setting["FlySpeed"]))
				end
				if Nav.Left then
					Root.CFrame = Root.CFrame + (-Camera.CFrame.RightVector * (Delta * getgenv().setting["FlySpeed"]))
				end
				if Nav.Right then
					Root.CFrame = Root.CFrame + (Camera.CFrame.RightVector * (Delta * getgenv().setting["FlySpeed"]))
				end
			end
			
			if not Nav.Flying then
				Float:Destroy()
				Float = nil
			end
		end
	else
        getgenv().setting["FlyKeybind"] = Enum.KeyCode.Unknown
		if Nav.Flying == true then
            Nav.Flying = false
			Root.Anchored = false
		end
		if C1 then
        C1:Disconnect()
		end

		if C2 then
		C2:Disconnect()
		end

		if C3 then
		C3:Disconnect()
		end
	end
end)
end)

local FlySpeedTog = characterSection:CreateSlider("Fly Speed", 0, 150, 75, true, function(currentValue)
	getgenv().setting["FlySpeed"] = currentValue
end)
----------------------
local function AddedChar(player)
    if player.Character then
        CreateESP(player, player.Character, "Text", 3, 14, Color3.fromRGB(255,255,255), "plr")
    end
    player.CharacterAdded:Connect(function(char)
        CreateESP(player, char, "Text", 3, 14, Color3.fromRGB(255,255,255), "plr")
    end)
end

local function MobChar(char, clr)
	if char:FindFirstChild("Humanoid") and char:FindFirstChild("HumanoidRootPart") then
		print("added esp")
		CreateNPCESP(char, char, "Text", 3, 15, clr, "npc")
	end
end

local function MobChar2(char, clr)
	if char:FindFirstChild("Humanoid") and char:FindFirstChild("HumanoidRootPart") then
		print("added esp")
		CreateNPCESP2(char, char, "Text", 3, 14, clr, "npc")
	end
end

local function Chest1(obj, clr)
	if obj:FindFirstChild("Lid") and obj:FindFirstChild("RootPart") then
		print("added chestesp")
		CreateChest1(obj, obj, "Text", 3, 14, clr, "chest")
	end
end

local espToggle = espSection:CreateToggle("ESP", false, function(currentState)
	while task.wait(0.5) do 
	if currentState == true then
	for _,v in pairs(PlayerService:GetPlayers()) do
		if v ~= player then
			AddedChar(v)
		end
	end

	ESP_TOGGLE = true

	local con = PlayerService.PlayerAdded:Connect(AddedChar)

	break
elseif currentState == false then
		if con then
		con:Disconnect()
		end

		ESP_TOGGLE = false
	end
	break
end -- loop end
end)

local Distance = espSection:CreateToggle("Distance", false, function(currentState)
	getgenv().Distance = currentState
end)

-- for loops for esp lol

--[[
local function AddedChar(player)
    if player.Character then
        CreateESP(player, player.Character, "Text", 2, 12)
    end
    player.CharacterAdded:Connect(function(char)
        CreateESP(player, char, "Text", 2, 12)
    end)
end--]]

--[[
for _,v in pairs(PlayerService:GetPlayers()) do
    if v ~= player then
        AddedChar(v)
    end
end

--// connections
PlayerService.PlayerAdded:Connect(AddedChar)--]]

local espDistanceSlider = espSection:CreateSlider("ESP Render Distance", 0, 15000, 2000, true, function(currentValue)
	getgenv().currentEspDistance = currentValue
end)

--// Misc Tab Toggles -----------------------------------------
getgenv().NoFall = false
getgenv().NoAcid = false

local FallDamage = BlatantSection:CreateToggle("No Fall Damage", false, function(currentState)
	getgenv().NoFall = currentState

	local hook; hook = hookmetamethod(game, "__namecall", function(Self,...)
		if not checkcaller() then
			local getname = getnamecallmethod()
			local args = {...}
			
			if getgenv().NoFall then
			if tostring(getname) == "FireServer" and getcallingscript().Name == "WorldClient" and type(args[1]) == "number" and type(args[2]) == "boolean" then
				   return args[1] == 0.1
				   end
				end
			end
		return hook(Self,...)
	end)
end)

local NoAcidDamage = BlatantSection:CreateToggle("No Acid Damage", false, function(currentState)
	getgenv().NoAcid = currentState

	local hook; hook = hookmetamethod(game, "__namecall", function(Self,...)
		if not checkcaller() then
			local getname = getnamecallmethod()
			local args = {...}
			
			if getgenv().NoAcid then
			if tostring(getname) == "FireServer" and getcallingscript().Name == "InputClient" and tostring(Self) == "AcidCheck" then
				return
				end
			end
		end
		return hook(Self,...)
	end)	
end)

--// Teleport section (misc)
--[[local TeleportDepths = TeleportSection:CreateButton("Teleport To Depths", function() -- Still In Testing
	if player.Character and player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid.Health > 1 then
	player.Character.HumanoidRootPart.CFrame = CFrame.new(-5100.91895, -1.51667786, -11167.6152)
	firetouchinterest(game:GetService("Workspace").DepthsWhirlpool.Part, game.Players.LocalPlayer.Character.HumanoidRootPart, 0)
    firetouchinterest(game:GetService("Workspace").DepthsWhirlpool.Part, game.Players.LocalPlayer.Character.HumanoidRootPart, 1)
    firetouchinterest(game:GetService("Workspace").DepthsWhirlpool.Part, game.Players.LocalPlayer.Character.HumanoidRootPart, 0)
	end
end)

local TeleportTrails = TeleportSection:CreateButton("Teleport To Trials of One", function()
	if player.Character and player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid.Health > 1 then

		firetouchinterest(game:GetService("Workspace").OneEntrance, player.Character.HumanoidRootPart, 0)
		firetouchinterest(game:GetService("Workspace").OneEntrance, player.Character.HumanoidRootPart, 1)
		firetouchinterest(game:GetService("Workspace").OneEntrance, player.Character.HumanoidRootPart, 0)
	end
end)
--]]

-- DONT USE THESE ABOVE WILL GET U BANNED ^^^^^^^^^^^^^^

---------------
local function FireSignalFunc(button)
	for i,v in pairs(getconnections(button.MouseButton1Click)) do
	   v:Fire()
	end
end
	
local ColorTable = {
	--Color3.fromRGB(226, 255, 230) or Color3.new(0.886275, 1, 0.901961), -- Enchant (White)
	--Color3.fromRGB(64, 80, 76) or Color3.new(0.25098, 0.313726, 0.298039), -- Grey (Common)
	--Color3.fromRGB(86, 144, 119) or Color3.new(0.337255, 0.564706, 0.466667), -- Green (Uncommon)
	--Color3.fromRGB(135, 82, 82) or Color3.new(0.529412, 0.321569, 0.321569), -- Red
	--Color3.fromRGB(163, 120, 82) or Color3.new(0.639216, 0.470588, 0.196078), -- Gold
}

local LegendariesTable = {
	Color3.fromRGB(163, 120, 82),-- Legendary (Gold)
    Color3.new(0.639216, 0.470588, 0.196078), -- Legendary (Gold)
}

local EnchantTable = {
	Color3.fromRGB(226, 255, 230),
    Color3.new(0.886275, 1, 0.901961), -- Enchant (White)
}

local CommonTable = {
	Color3.fromRGB(64, 80, 76),
	 Color3.new(0.25098, 0.313726, 0.298039), -- Common (Grey)
}

local UncommonTable = {
	Color3.fromRGB(86, 144, 119),
	Color3.new(0.337255, 0.564706, 0.466667), -- Uncommon (Green)
}

local RareTable = {
	Color3.fromRGB(135, 82, 82),
	Color3.new(0.529412, 0.321569, 0.321569), -- Rare (Red)
}

getgenv().Enchants = false
getgenv().Commons = false
getgenv().Legendaries = false
getgenv().Uncommon = false
getgenv().Rare = false
	
local autoLoot = autoLootSection:CreateToggle("Auto Loot", false, function(currentState)
	if currentState then
		pcall(function()
		while task.wait() do
			if player.Character then
				if player.Character.Humanoid then
					if player.Character.Humanoid.Health ~= 0 or player.Character.Humanoid.Health > 0.1 then
							if player.PlayerGui then
								local plrgui = player.PlayerGui
								
								if plrgui:FindFirstChild("ChoicePrompt") then
									
									local prompt = plrgui.ChoicePrompt
										for z,x in pairs(prompt:GetChildren()) do
											if x:FindFirstChild("Options") then
												for _,k in pairs(x.Options:GetChildren()) do
													if k.ClassName == "TextButton" and k.Name ~= "Nothing" then
														--print(k.BackgroundColor3 .. " [" .. k.Name .. "]")
													--if table.find(ColorTable, k.BackgroundColor3) then -- very buggy doesnt work

														if getgenv().Enchants == true then
															if table.find(EnchantTable, k.BackgroundColor3) then-- waiting to be added
																for i = 1, 3 do
																	FireSignalFunc(k)
																	print("firing signal " .. k.Name .. " ")
																end
															end

															if getgenv().Commons == true then
																if table.find(CommonTable, k.BackgroundColor3) then
																for i = 1, 3 do
																	FireSignalFunc(k)
																	print("firing signal " .. k.Name .. " ")
																end
															end

															if getgenv().Uncommon == true then
																if table.find(UncommonTable, k.BackgroundColor3) then
																for i = 1, 3 do
																	FireSignalFunc(k)
																	print("firing signal " .. k.Name .. " ")
																end
															end

															if getgenv().Legendaries == true then
																if table.find(LegendariesTable, k.BackgroundColor3) then
																for i = 1, 3 do
																	FireSignalFunc(k)
																	print("firing signal " .. k.Name .. " ")
																end
															end

															if getgenv().Rare == true then
																if table.find(RareTable, k.BackgroundColor3) then
																for i = 1, 3 do
																	FireSignalFunc(k)
																	print("firing signal " .. k.Name .. " ")
																end

														end
													end
												end
											end
									end
								end
						end
					end
											end
										end
								end
end
end
end
			if not currentState then break end
		end
		end
	end)
	end
end)

local autoLootEnchant = autoLootSection:CreateToggle("Loot Enchants", false, function(currentState)
	if getgenv().Enchants == false then
		getgenv().Enchants = true
	else
		getgenv().Enchants = false
	end
end)

local autoLootCommon = autoLootSection:CreateToggle("Loot Commons", false, function(currentState)
	if getgenv().Commons == false then
		getgenv().Commons = true
	else
		getgenv().Commons = false
	end
end)

local autoLootUncommon = autoLootSection:CreateToggle("Loot Uncommons", false, function(currentState)
	if getgenv().Uncommon == false then
		getgenv().Uncommon = true
	else
		getgenv().Uncommon = false
	end
end)

local autoLootRare = autoLootSection:CreateToggle("Loot Rares", false, function(currentState)
	if getgenv().Rare == false then
		getgenv().Rare = true
	else
		getgenv().Rare = false
	end
end)

local autoLootLegendary = autoLootSection:CreateToggle("Loot Legendaries", false, function(currentState)
	if getgenv().Legendaries == false then
		getgenv().Legendaries = true
	else
		getgenv().Legendaries = false
	end
end)

--// world
local playersTable = {}

for _,v in pairs(game:GetService("Players"):GetPlayers()) do
	table.insert(playersTable, v.Name)
end

game:GetService("Players").PlayerAdded:Connect(function(v)
	table.insert(playersTable, v.Name)
end)

game:GetService("Players").PlayerRemoving:Connect(function(v)
	if table.find(playersTable, v.Name) then
		table.remove(playersTable, table.find(playersTable, v.Name))

		print(v.Name .. " was already removed")
	end
end)

local ShowMobs = worldSection:CreateToggle("Show Mobs", false, function(state)
	while task.wait(0.5) do
		if state == true then
		for _,v in pairs(game:GetService("Workspace").Live:GetChildren()) do
			if v:FindFirstChild("HumanoidRootPart") and not table.find(playersTable, v.Name) then
				MobChar(v, Color3.fromRGB(255,30,30))
			end
		end
	
		ESP_TOGGLE_NPC = true


		local con = game:GetService("Workspace").Live.ChildAdded:Connect(function(v)
			if v:WaitForChild("HumanoidRootPart") and not table.find(playersTable, v.Name) and v:FindFirstChild("Torso") then
				MobChar(v, Color3.fromRGB(255,30,30))
			end
		end)
	
		break
	elseif state == false then
			if con then
			con:Disconnect()
			end
			ESP_TOGGLE_NPC = false
		end
		break
	end -- loop end
end)

local MobRender = worldSection:CreateSlider("Mob Render Distance", 0, 15000, 2000, true, function(currentValue)
	getgenv().DistanceEnemy = currentValue
end)

local ShowNpcs = worldSection:CreateToggle("Show NPCS", false, function(state)
	while task.wait(0.5) do
		if state == true then
		for _,v in pairs(game:GetService("Workspace").NPCs:GetChildren()) do
			if v:FindFirstChild("HumanoidRootPart") and not table.find(playersTable, v.Name) then
				MobChar2(v, Color3.fromRGB(51,153,255))
			end
		end
	
		ESP_TOGGLE_NPC2 = true


		local con = game:GetService("Workspace").NPCs.ChildAdded:Connect(function(v)
			if v:WaitForChild("HumanoidRootPart") and not table.find(playersTable, v.Name) and v:FindFirstChild("Torso") then
				MobChar2(v, Color3.fromRGB(51,153,255))
			end
		end)
	
		break
	elseif state == false then
			if con then
			con:Disconnect()
			end
			ESP_TOGGLE_NPC2 = false
		end
		break
	end -- loop end
end)

local MobRender = worldSection:CreateSlider("NPC Render Distance", 0, 15000, 2000, true, function(currentValue)
	getgenv().DistanceNPC = currentValue
end)

local ShowNpcs = worldSection:CreateToggle("Show Chests", false, function(state)
	while task.wait(0.5) do
		if state == true then
		for _,v in pairs(game:GetService("Workspace").Thrown:GetChildren()) do
			if v:FindFirstChild("Lid") then
				Chest1(v, Color3.fromRGB(240,177,3))
			end
		end
	
		ESP_CHEST = true


		local con = game:GetService("Workspace").Thrown.ChildAdded:Connect(function(v)
			if v:FindFirstChild("Lid") then
				Chest1(v, Color3.fromRGB(240,177,3))
			end
		end)
	
		break
	elseif state == false then
			if con then
			con:Disconnect()
			end
			ESP_CHEST = false
		end
		break
	end -- loop end
end)

local MobRender = worldSection:CreateSlider("Chest Render Distance", 0, 15000, 2000, true, function(currentValue)
	getgenv().DistanceChest = currentValue
end)
