local Players = game:GetService("Players")
local RS = game:GetService("ReplicatedStorage")
local UIS = game:GetService("UserInputService")
local Tween = game:GetService("TweenService")

local Player = Players.LocalPlayer
local Events = RS:WaitForChild("rEvents")

local EvolveEvent = Events:WaitForChild("autoEvolveRemote")
local HatchEvent = Events:WaitForChild("openCrystalRemote")
local RebirthEvent = Events:WaitForChild("rebirthRemote")
local EquipEvent = Events:WaitForChild("equipPetEvent")
local StrengthEvent = Player:WaitForChild("muscleEvent")

local PetsFolder = Player:WaitForChild("petsFolder")

--==================================================
-- FONT
--==================================================

local MainFont = Enum.Font.FredokaOne
local SmallFont = Enum.Font.GothamMedium

--==================================================
-- PET CONFIG
--==================================================

local PetNames = {
	"Golden Sun Pegasus",
	"Darkstorm Elemental Hydra",
	"GLITCH: Awakened Nighthunter"
}

--==================================================
-- STATE
--==================================================

local State = {
	Evolve = false,
	Hatch = false,
	Strength = false,
	Rebirth = false,
	AutoEquip = false
}

-- Biến này dùng để dừng toàn bộ hệ thống
local ScriptRunning = true

--==================================================
-- UI
--==================================================

local Gui = Instance.new("ScreenGui")
Gui.Name = "AutoFeaturesUI"
Gui.ResetOnSpawn = false
Gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
Gui.Parent = Player:WaitForChild("PlayerGui")

--==================================================
-- MAIN FRAME
--==================================================

local Frame = Instance.new("Frame")
Frame.Size = UDim2.fromOffset(300, 370)
Frame.Position = UDim2.new(.5, -150, .5, -185)
Frame.BackgroundColor3 = Color3.fromRGB(18, 19, 25)
Frame.BorderSizePixel = 0
Frame.Parent = Gui

Instance.new("UICorner", Frame).CornerRadius = UDim.new(0, 18)

local Border = Instance.new("UIStroke", Frame)
Border.Color = Color3.fromRGB(75, 78, 95)
Border.Thickness = 1.5

--==================================================
-- HEADER
--==================================================

local Header = Instance.new("Frame")
Header.Size = UDim2.new(1, -16, 0, 60)
Header.Position = UDim2.fromOffset(8, 8)
Header.BackgroundColor3 = Color3.fromRGB(30, 32, 42)
Header.BorderSizePixel = 0
Header.Active = true
Header.Parent = Frame

Instance.new("UICorner", Header).CornerRadius = UDim.new(0, 13)

local HeaderGradient = Instance.new("UIGradient")
HeaderGradient.Rotation = 90
HeaderGradient.Color = ColorSequence.new({
	ColorSequenceKeypoint.new(0, Color3.fromRGB(42, 45, 60)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(24, 25, 32))
})
HeaderGradient.Parent = Header

--==================================================
-- HEADER ICON
--==================================================

local HeaderIcon = Instance.new("TextLabel")
HeaderIcon.Size = UDim2.fromOffset(42, 42)
HeaderIcon.Position = UDim2.fromOffset(9, 9)
HeaderIcon.BackgroundColor3 = Color3.fromRGB(70, 95, 190)
HeaderIcon.Text = "+"
HeaderIcon.TextColor3 = Color3.new(1, 1, 1)
HeaderIcon.TextSize = 25
HeaderIcon.Font = MainFont
HeaderIcon.Parent = Header

Instance.new("UICorner", HeaderIcon).CornerRadius = UDim.new(0, 11)

--==================================================
-- TITLE
--==================================================

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -125, 0, 28)
Title.Position = UDim2.fromOffset(60, 5)
Title.BackgroundTransparency = 1
Title.Text = "AUTO FEATURES"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 19
Title.Font = MainFont
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = Header

local TitleStroke = Instance.new("UIStroke")
TitleStroke.Color = Color3.fromRGB(0, 0, 0)
TitleStroke.Thickness = 1
TitleStroke.Transparency = .45
TitleStroke.Parent = Title

--==================================================
-- SUBTITLE
--==================================================

local Sub = Instance.new("TextLabel")
Sub.Size = UDim2.new(1, -125, 0, 17)
Sub.Position = UDim2.fromOffset(60, 34)
Sub.BackgroundTransparency = 1
Sub.Text = "Automation panel"
Sub.TextColor3 = Color3.fromRGB(145, 149, 165)
Sub.TextSize = 10
Sub.Font = SmallFont
Sub.TextXAlignment = Enum.TextXAlignment.Left
Sub.Parent = Header

--==================================================
-- MINIMIZE BUTTON
--==================================================

local MinimizeButton = Instance.new("TextButton")
MinimizeButton.Size = UDim2.fromOffset(28, 28)
MinimizeButton.Position = UDim2.new(1, -66, 0, 16)
MinimizeButton.BackgroundColor3 = Color3.fromRGB(55, 58, 72)
MinimizeButton.Text = "−"
MinimizeButton.TextColor3 = Color3.fromRGB(235, 235, 240)
MinimizeButton.TextSize = 20
MinimizeButton.Font = MainFont
MinimizeButton.AutoButtonColor = false
MinimizeButton.BorderSizePixel = 0
MinimizeButton.Parent = Header

Instance.new("UICorner", MinimizeButton).CornerRadius = UDim.new(0, 8)

MinimizeButton.MouseEnter:Connect(function()
	Tween:Create(
		MinimizeButton,
		TweenInfo.new(.12),
		{
			BackgroundColor3 = Color3.fromRGB(75, 80, 100)
		}
	):Play()
end)

MinimizeButton.MouseLeave:Connect(function()
	Tween:Create(
		MinimizeButton,
		TweenInfo.new(.12),
		{
			BackgroundColor3 = Color3.fromRGB(55, 58, 72)
		}
	):Play()
end)

--==================================================
-- CLOSE X BUTTON
--==================================================

local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.fromOffset(28, 28)
CloseButton.Position = UDim2.new(1, -34, 0, 16)
CloseButton.BackgroundColor3 = Color3.fromRGB(170, 55, 65)
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.TextSize = 14
CloseButton.Font = MainFont
CloseButton.AutoButtonColor = false
CloseButton.BorderSizePixel = 0
CloseButton.Parent = Header

Instance.new("UICorner", CloseButton).CornerRadius = UDim.new(0, 8)

CloseButton.MouseEnter:Connect(function()
	Tween:Create(
		CloseButton,
		TweenInfo.new(.12),
		{
			BackgroundColor3 = Color3.fromRGB(220, 65, 75)
		}
	):Play()
end)

CloseButton.MouseLeave:Connect(function()
	Tween:Create(
		CloseButton,
		TweenInfo.new(.12),
		{
			BackgroundColor3 = Color3.fromRGB(170, 55, 65)
		}
	):Play()
end)

--==================================================
-- BUTTON CREATOR
--==================================================

local function CreateButton(name, desc, icon, y)

	local B = Instance.new("TextButton")
	B.Size = UDim2.new(1, -28, 0, 48)
	B.Position = UDim2.fromOffset(14, y)
	B.BackgroundColor3 = Color3.fromRGB(30, 32, 41)
	B.Text = ""
	B.AutoButtonColor = false
	B.BorderSizePixel = 0
	B.Parent = Frame

	Instance.new("UICorner", B).CornerRadius = UDim.new(0, 11)

	local Stroke = Instance.new("UIStroke")
	Stroke.Color = Color3.fromRGB(55, 58, 70)
	Stroke.Thickness = 1
	Stroke.Parent = B

	-- Icon
	local I = Instance.new("TextLabel")
	I.Size = UDim2.fromOffset(34, 34)
	I.Position = UDim2.fromOffset(8, 7)
	I.BackgroundColor3 = Color3.fromRGB(45, 48, 60)
	I.Text = icon
	I.TextColor3 = Color3.fromRGB(220, 223, 235)
	I.TextSize = 15
	I.Font = MainFont
	I.Parent = B

	Instance.new("UICorner", I).CornerRadius = UDim.new(0, 9)

	-- Name
	local L = Instance.new("TextLabel")
	L.Size = UDim2.new(1, -140, 0, 22)
	L.Position = UDim2.fromOffset(50, 3)
	L.BackgroundTransparency = 1
	L.Text = name
	L.TextColor3 = Color3.fromRGB(248, 248, 252)
	L.TextSize = 14
	L.Font = MainFont
	L.TextXAlignment = Enum.TextXAlignment.Left
	L.Parent = B

	-- Description
	local D = Instance.new("TextLabel")
	D.Size = UDim2.new(1, -140, 0, 15)
	D.Position = UDim2.fromOffset(50, 27)
	D.BackgroundTransparency = 1
	D.Text = desc
	D.TextColor3 = Color3.fromRGB(125, 130, 145)
	D.TextSize = 9
	D.Font = SmallFont
	D.TextXAlignment = Enum.TextXAlignment.Left
	D.Parent = B

	-- Status
	local S = Instance.new("TextLabel")
	S.Size = UDim2.fromOffset(57, 25)
	S.Position = UDim2.new(1, -67, .5, -12)
	S.BackgroundColor3 = Color3.fromRGB(48, 50, 60)
	S.Text = "OFF"
	S.TextColor3 = Color3.fromRGB(165, 168, 180)
	S.TextSize = 11
	S.Font = MainFont
	S.Parent = B

	Instance.new("UICorner", S).CornerRadius = UDim.new(1, 0)

	-- Hover
	B.MouseEnter:Connect(function()

		Tween:Create(
			B,
			TweenInfo.new(.12),
			{
				BackgroundColor3 = Color3.fromRGB(39, 42, 53)
			}
		):Play()

		Tween:Create(
			Stroke,
			TweenInfo.new(.12),
			{
				Color = Color3.fromRGB(90, 95, 120)
			}
		):Play()

	end)

	B.MouseLeave:Connect(function()

		Tween:Create(
			B,
			TweenInfo.new(.12),
			{
				BackgroundColor3 = Color3.fromRGB(30, 32, 41)
			}
		):Play()

		Tween:Create(
			Stroke,
			TweenInfo.new(.12),
			{
				Color = Color3.fromRGB(55, 58, 70)
			}
		):Play()

	end)

	return {
		Button = B,
		Status = S,
		Icon = I,
		Stroke = Stroke
	}
end

--==================================================
-- BUTTONS
--==================================================

local Evolve = CreateButton(
	"Auto Evolve",
	"Automatically evolve",
	"E",
	76
)

local Hatch = CreateButton(
	"Auto Hatch",
	"Automatically hatch",
	"H",
	130
)

local Strength = CreateButton(
	"Auto Strength",
	"Automatically train",
	"S",
	184
)

local Rebirth = CreateButton(
	"Auto Rebirth",
	"Automatically rebirth",
	"R",
	238
)

local AutoEquipButton = CreateButton(
	"Auto Equip",
	"Automatically equip pets",
	"P",
	292
)

--==================================================
-- MADE BY
--==================================================

local Footer = Instance.new("TextLabel")
Footer.Name = "MadeBy"
Footer.Size = UDim2.new(1, -20, 0, 25)
Footer.Position = UDim2.new(0, 10, 1, -31)
Footer.BackgroundTransparency = 1
Footer.Text = "Made by Khangpro19050"
Footer.TextColor3 = Color3.fromRGB(255, 204, 70)
Footer.TextSize = 14
Footer.Font = MainFont
Footer.TextXAlignment = Enum.TextXAlignment.Center
Footer.TextYAlignment = Enum.TextYAlignment.Center
Footer.Parent = Frame

local FooterStroke = Instance.new("UIStroke")
FooterStroke.Color = Color3.fromRGB(90, 45, 0)
FooterStroke.Thickness = 1
FooterStroke.Transparency = .25
FooterStroke.Parent = Footer

local FooterGradient = Instance.new("UIGradient")
FooterGradient.Rotation = 0
FooterGradient.Color = ColorSequence.new({
	ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 183, 45)),
	ColorSequenceKeypoint.new(.5, Color3.fromRGB(255, 225, 100)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 183, 45))
})
FooterGradient.Parent = Footer

--==================================================
-- STATUS
--==================================================

local function SetStatus(Data, On)

	Data.Status.Text = On and "ON" or "OFF"

	if On then

		Data.Status.BackgroundColor3 = Color3.fromRGB(45, 175, 95)
		Data.Status.TextColor3 = Color3.fromRGB(255, 255, 255)
		Data.Icon.BackgroundColor3 = Color3.fromRGB(45, 175, 95)
		Data.Stroke.Color = Color3.fromRGB(60, 195, 110)

	else

		Data.Status.BackgroundColor3 = Color3.fromRGB(48, 50, 60)
		Data.Status.TextColor3 = Color3.fromRGB(165, 168, 180)
		Data.Icon.BackgroundColor3 = Color3.fromRGB(45, 48, 60)
		Data.Stroke.Color = Color3.fromRGB(55, 58, 70)

	end

end

--==================================================
-- AUTO EQUIP SYSTEM
--==================================================

local function GetAllPetsByName(PetName)

	local Result = {}

	for _, Folder in ipairs(PetsFolder:GetChildren()) do

		for _, Pet in ipairs(Folder:GetChildren()) do

			if Pet.Name == PetName then
				table.insert(Result, Pet)
			end

		end

	end

	return Result
end

local function EquipAllPets()

	if not ScriptRunning then
		return
	end

	for _, PetName in ipairs(PetNames) do

		if not ScriptRunning or not State.AutoEquip then
			return
		end

		local Pets = GetAllPetsByName(PetName)

		for _, Pet in ipairs(Pets) do

			if not ScriptRunning or not State.AutoEquip then
				return
			end

			if Pet and Pet.Parent then

				pcall(function()

					EquipEvent:FireServer(
						"equipPet",
						Pet
					)

				end)

				task.wait(0.1)

			end

		end

	end

end

--==================================================
-- NORMAL AUTO TOGGLE
--==================================================

local function Toggle(Data, Key, Callback)

	Data.Button.MouseButton1Click:Connect(function()

		if not ScriptRunning then
			return
		end

		State[Key] = not State[Key]

		SetStatus(
			Data,
			State[Key]
		)

		if State[Key] then

			task.spawn(function()

				while ScriptRunning and State[Key] do

					pcall(Callback)

					if Key == "Evolve" then

						task.wait(0.1)

					elseif Key == "Hatch" then

						task.wait(0.05)

					else

						task.wait(0.01)

					end

				end

			end)

		end

	end)

end

--==================================================
-- AUTO EVOLVE
--==================================================

Toggle(Evolve, "Evolve", function()

	EvolveEvent:InvokeServer()

end)

--==================================================
-- AUTO HATCH
--==================================================

Toggle(Hatch, "Hatch", function()

	HatchEvent:InvokeServer(
		"openCrystal",
		"Unlimited Secrets Crystal",
		1
	)

end)

--==================================================
-- AUTO STRENGTH
--==================================================

Toggle(Strength, "Strength", function()

	StrengthEvent:FireServer("rep")

end)

--==================================================
-- AUTO REBIRTH
--==================================================

Toggle(Rebirth, "Rebirth", function()

	RebirthEvent:InvokeServer(
		"massRebirthRequest",
		500
	)

end)

--==================================================
-- AUTO EQUIP
--==================================================

AutoEquipButton.Button.MouseButton1Click:Connect(function()

	if not ScriptRunning then
		return
	end

	State.AutoEquip = not State.AutoEquip

	SetStatus(
		AutoEquipButton,
		State.AutoEquip
	)

	if State.AutoEquip then

		task.spawn(function()

			EquipAllPets()

		end)

	end

end)

--==================================================
-- AUTO EQUIP LOOP
--==================================================

task.spawn(function()

	while ScriptRunning do

		task.wait(2)

		if ScriptRunning and State.AutoEquip then

			pcall(function()
				EquipAllPets()
			end)

		end

	end

end)

--==================================================
-- SHOW / HIDE BUTTON
--==================================================

local ShowButton = Instance.new("TextButton")
ShowButton.Name = "ShowAutoFeatures"
ShowButton.Size = UDim2.fromOffset(52, 52)
ShowButton.Position = UDim2.new(0, 20, .5, -26)
ShowButton.BackgroundColor3 = Color3.fromRGB(30, 32, 42)
ShowButton.Text = "☰"
ShowButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ShowButton.TextSize = 22
ShowButton.Font = MainFont
ShowButton.AutoButtonColor = false
ShowButton.Visible = false
ShowButton.Parent = Gui

Instance.new("UICorner", ShowButton).CornerRadius = UDim.new(0, 14)

local ShowStroke = Instance.new("UIStroke")
ShowStroke.Color = Color3.fromRGB(75, 78, 95)
ShowStroke.Thickness = 1.5
ShowStroke.Parent = ShowButton

ShowButton.MouseEnter:Connect(function()

	Tween:Create(
		ShowButton,
		TweenInfo.new(.12),
		{
			BackgroundColor3 = Color3.fromRGB(55, 60, 80)
		}
	):Play()

end)

ShowButton.MouseLeave:Connect(function()

	Tween:Create(
		ShowButton,
		TweenInfo.new(.12),
		{
			BackgroundColor3 = Color3.fromRGB(30, 32, 42)
		}
	):Play()

end)

--==================================================
-- HIDE GUI
--==================================================

MinimizeButton.MouseButton1Click:Connect(function()

	if not ScriptRunning then
		return
	end

	Frame.Visible = false
	ShowButton.Visible = true

end)

--==================================================
-- SHOW GUI
--==================================================

ShowButton.MouseButton1Click:Connect(function()

	if not ScriptRunning then
		return
	end

	Frame.Visible = true
	ShowButton.Visible = false

end)

--==================================================
-- CLOSE / STOP SCRIPT
--==================================================

CloseButton.MouseButton1Click:Connect(function()

	-- Ngăn tất cả loop tiếp tục
	ScriptRunning = false

	-- Tắt toàn bộ Auto
	State.Evolve = false
	State.Hatch = false
	State.Strength = false
	State.Rebirth = false
	State.AutoEquip = false

	-- Xóa GUI hoàn toàn
	Gui:Destroy()

end)

--==================================================
-- DRAG MAIN FRAME
--==================================================

local Dragging = false
local DragStart
local StartPos

Header.InputBegan:Connect(function(Input)

	if Input.UserInputType == Enum.UserInputType.MouseButton1
		or Input.UserInputType == Enum.UserInputType.Touch then

		Dragging = true
		DragStart = Input.Position
		StartPos = Frame.Position

	end

end)

Header.InputEnded:Connect(function(Input)

	if Input.UserInputType == Enum.UserInputType.MouseButton1
		or Input.UserInputType == Enum.UserInputType.Touch then

		Dragging = false

	end

end)

UIS.InputChanged:Connect(function(Input)

	if not Dragging or not ScriptRunning then
		return
	end

	if Input.UserInputType == Enum.UserInputType.MouseMovement
		or Input.UserInputType == Enum.UserInputType.Touch then

		local Delta = Input.Position - DragStart

		Frame.Position = UDim2.new(
			StartPos.X.Scale,
			StartPos.X.Offset + Delta.X,
			StartPos.Y.Scale,
			StartPos.Y.Offset + Delta.Y
		)

	end

end)

--==================================================
-- DRAG SHOW BUTTON
--==================================================

local ShowDragging = false
local ShowDragStart
local ShowStartPos

ShowButton.InputBegan:Connect(function(Input)

	if Input.UserInputType == Enum.UserInputType.MouseButton1
		or Input.UserInputType == Enum.UserInputType.Touch then

		ShowDragging = true
		ShowDragStart = Input.Position
		ShowStartPos = ShowButton.Position

	end

end)

ShowButton.InputEnded:Connect(function(Input)

	if Input.UserInputType == Enum.UserInputType.MouseButton1
		or Input.UserInputType == Enum.UserInputType.Touch then

		ShowDragging = false

	end

end)

UIS.InputChanged:Connect(function(Input)

	if not ShowDragging or not ScriptRunning then
		return
	end

	if Input.UserInputType == Enum.UserInputType.MouseMovement
		or Input.UserInputType == Enum.UserInputType.Touch then

		local Delta = Input.Position - ShowDragStart

		ShowButton.Position = UDim2.new(
			ShowStartPos.X.Scale,
			ShowStartPos.X.Offset + Delta.X,
			ShowStartPos.Y.Scale,
			ShowStartPos.Y.Offset + Delta.Y
		)

	end

end)
