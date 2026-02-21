local gethui_support = gethui ~= nil
local uis = cloneref ~= nil and cloneref(game:GetService("UserInputService")) or game:GetService("UserInputService")

local function rand_str(len)
	local chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
	local result = {}
	for i = 1, len do result[i] = chars:sub(math.random(1, #chars), math.random(1, #chars)) end
	return table.concat(result)
end

local ui = Instance.new("ScreenGui")
ui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ui.Name = rand_str(5)
ui.Parent = gethui_support and gethui() or game:GetService("CoreGui") -- be ud if exec isnt shitty

local main = Instance.new("Frame")
main.BackgroundColor3 = Color3.fromRGB(21, 21, 21)
main.BackgroundTransparency = 0.2
main.BorderSizePixel = 0
main.Position = UDim2.new(0.692137837, 0, 0.4375, 0)
main.Size = UDim2.new(0, 222, 0, 219)
main.Name = "main"
main.Parent = ui

local top = Instance.new("Frame")
top.BackgroundColor3 = Color3.fromRGB(31, 31, 31)
top.BackgroundTransparency = 0.5
top.BorderSizePixel = 0
top.Size = UDim2.new(0, 222, 0, 25)
top.Name = "top"
top.Parent = main

local title_text = Instance.new("TextLabel")
title_text.Font = Enum.Font.Code
title_text.Text = "ring-zero | open source"
title_text.TextColor3 = Color3.fromRGB(255, 255, 255)
title_text.TextSize = 14
title_text.TextXAlignment = Enum.TextXAlignment.Left
title_text.BackgroundTransparency = 1
title_text.BorderSizePixel = 0
title_text.Position = UDim2.new(0.0405408144, 0, 0, 0)
title_text.Size = UDim2.new(0, 213, 0, 25)
title_text.Name = "title_text"
title_text.Parent = top

local boxes_text = Instance.new("TextLabel")
boxes_text.Font = Enum.Font.Code
boxes_text.Text = "boxes"
boxes_text.TextColor3 = Color3.fromRGB(255, 255, 255)
boxes_text.TextSize = 14
boxes_text.TextXAlignment = Enum.TextXAlignment.Left
boxes_text.BackgroundTransparency = 1
boxes_text.BorderSizePixel = 0
boxes_text.Position = UDim2.new(0.0855858624, 0, 0.141552508, 0)
boxes_text.Size = UDim2.new(0, 92, 0, 25)
boxes_text.Name = "boxes_text"
boxes_text.Parent = main

local boxes_checkbox = Instance.new("ImageButton")
boxes_checkbox.Image = "rbxassetid://10709790644"
boxes_checkbox.ImageTransparency = 1
boxes_checkbox.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
boxes_checkbox.BackgroundTransparency = 0.5
boxes_checkbox.BorderSizePixel = 0
boxes_checkbox.Position = UDim2.new(0.842000008, 0, 0.180000007, 0)
boxes_checkbox.Size = UDim2.new(0, 15, 0, 15)
boxes_checkbox.Name = "boxes_checkbox"
boxes_checkbox.Parent = main
Instance.new("UICorner", boxes_checkbox).CornerRadius = UDim.new(0, 4)

local skeleton_checkbox = Instance.new("ImageButton")
skeleton_checkbox.Image = "rbxassetid://10709790644"
skeleton_checkbox.ImageTransparency = 1
skeleton_checkbox.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
skeleton_checkbox.BackgroundTransparency = 0.5
skeleton_checkbox.BorderSizePixel = 0
skeleton_checkbox.Position = UDim2.new(0.842000067, 0, 0.2941553, 0)
skeleton_checkbox.Size = UDim2.new(0, 15, 0, 15)
skeleton_checkbox.Name = "skeleton_checkbox"
skeleton_checkbox.Parent = main
Instance.new("UICorner", skeleton_checkbox).CornerRadius = UDim.new(0, 4)

local skeleton_text = Instance.new("TextLabel")
skeleton_text.Font = Enum.Font.Code
skeleton_text.Text = "skeletons"
skeleton_text.TextColor3 = Color3.fromRGB(255, 255, 255)
skeleton_text.TextSize = 14
skeleton_text.TextXAlignment = Enum.TextXAlignment.Left
skeleton_text.BackgroundTransparency = 1
skeleton_text.BorderSizePixel = 0
skeleton_text.Position = UDim2.new(0.0855858624, 0, 0.255707771, 0)
skeleton_text.Size = UDim2.new(0, 92, 0, 25)
skeleton_text.Name = "skeleton_text"
skeleton_text.Parent = main

local menubind_text = Instance.new("TextLabel")
menubind_text.Font = Enum.Font.Code
menubind_text.Text = "menu bind"
menubind_text.TextColor3 = Color3.fromRGB(255, 255, 255)
menubind_text.TextSize = 14
menubind_text.TextXAlignment = Enum.TextXAlignment.Left
menubind_text.BackgroundTransparency = 1
menubind_text.BorderSizePixel = 0
menubind_text.Position = UDim2.new(0.0855858624, 0, 0.369863003, 0)
menubind_text.Size = UDim2.new(0, 92, 0, 25)
menubind_text.Name = "menubind_text"
menubind_text.Parent = main

local menu_keybind = Instance.new("TextButton")
menu_keybind.Font = Enum.Font.Code
menu_keybind.Text = "[ delete ]"
menu_keybind.TextColor3 = Color3.fromRGB(255, 255, 255)
menu_keybind.TextSize = 12
menu_keybind.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
menu_keybind.BackgroundTransparency = 0.5
menu_keybind.BorderSizePixel = 0
menu_keybind.Position = UDim2.new(0.500000298, 0, 0.388127863, 0)
menu_keybind.Size = UDim2.new(0, 90, 0, 21)
menu_keybind.Name = "menu_keybind"
menu_keybind.Parent = main
Instance.new("UICorner", menu_keybind).CornerRadius = UDim.new(0, 4)

local discord_invite = Instance.new("TextLabel")
discord_invite.Font = Enum.Font.Code
discord_invite.Text = "discord.gg/polarisrbx"
discord_invite.TextColor3 = Color3.fromRGB(255, 255, 255)
discord_invite.TextSize = 12
discord_invite.TextXAlignment = Enum.TextXAlignment.Left
discord_invite.BackgroundTransparency = 1
discord_invite.BorderSizePixel = 0
discord_invite.Position = UDim2.new(0.0405408144, 0, 0.885844767, 0)
discord_invite.Size = UDim2.new(0, 213, 0, 19)
discord_invite.Name = "discord_invite"
discord_invite.Parent = main

-- drag (totally not pasted trust)
local dragging, drag_start, start_pos

top.InputBegan:Connect(function(input)
	if input.UserInputType ~= Enum.UserInputType.MouseButton1 then return end
	dragging = true
	drag_start = input.Position
	start_pos = main.Position
end)

top.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
end)

uis.InputChanged:Connect(function(input)
	if not dragging or input.UserInputType ~= Enum.UserInputType.MouseMovement then return end
	local delta = input.Position - drag_start
	main.Position = UDim2.new(start_pos.X.Scale, start_pos.X.Offset + delta.X, start_pos.Y.Scale, start_pos.Y.Offset + delta.Y)
end)

local function set_toggle(checkbox, state)
	checkbox.ImageTransparency = state and 0 or 1
end

-- ultra detected
local listening = false
menu_keybind.MouseButton1Click:Connect(function()
	if listening then return end
	listening = true
	menu_keybind.Text = "[ ... ]"
	local conn
	conn = uis.InputBegan:Connect(function(input)
		if input.UserInputType ~= Enum.UserInputType.Keyboard then return end
		conn:Disconnect()
		listening = false
		_G.new_menu_key = input.KeyCode
		menu_keybind.Text = "[ " .. input.KeyCode.Name:lower() .. " ]"
	end)
end)

_G.set_boxes = function(state) set_toggle(boxes_checkbox, state) end
_G.set_skeletons = function(state) set_toggle(skeleton_checkbox, state) end

boxes_checkbox.MouseButton1Click:Connect(function()
	if _G.toggle_boxes then _G.toggle_boxes() end
end)
skeleton_checkbox.MouseButton1Click:Connect(function()
	if _G.toggle_skeletons then _G.toggle_skeletons() end
end)

_G.user_interface = ui
