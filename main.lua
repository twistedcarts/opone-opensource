--[[
    edit these variables to toggle the visuals

    example:
    local boxes = true will enable the boxes
    local boxes = false will disable the boxes

    local skeletons = true will enable the skeletons
    local skeletons = false will disable the skeletons

    (manual editing not needed since controlleld by ui now)
]]--

local boxes = false
local skeletons = true


--[[
    begin main script
]]--

local menu_key = Enum.KeyCode.Delete
local pi = math.pi -- pi 😂 (those who know)

-- check for shitty executors
local cloneref_support = cloneref ~= nil
local gethui_support = gethui ~= nil

local runservice = cloneref_support and cloneref(game:GetService("RunService")) or game:GetService("RunService")
local uis = cloneref_support and cloneref(game:GetService("UserInputService")) or game:GetService("UserInputService")

local bones = {
	{ "torso", "head" },
	{ "torso", "shoulder1" }, { "torso", "shoulder2" },
	{ "shoulder1", "arm1" }, { "shoulder2", "arm2" },
	{ "torso", "hip1" }, { "torso", "hip2" },
	{ "hip1", "leg1" }, { "hip2", "leg2" },
}

local required_bones = { "torso", "head", "shoulder1", "shoulder2", "arm1", "arm2", "hip1", "hip2", "leg1", "leg2" }
local esp_list = {}
local skeleton_list = {}
local viewmodels = workspace:FindFirstChild("Viewmodels")
local camera = workspace.CurrentCamera

-- refresh camera cache (i dont think opone does this but js in case)
workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function()
	camera = workspace.CurrentCamera
end)

-- pro
local teammate_highlights = {}

workspace.ChildAdded:Connect(function(child)
	if child:IsA("Highlight") then teammate_highlights[child] = true end
end)
workspace.ChildRemoved:Connect(function(child)
	if child:IsA("Highlight") then teammate_highlights[child] = nil end
end)
for _, child in ipairs(workspace:GetChildren()) do
	if child:IsA("Highlight") then teammate_highlights[child] = true end
end

local function is_teammate(model)
	for highlight in pairs(teammate_highlights) do
		if highlight.Adornee == model then return true end
	end
	return false
end

-- validate players (prevents esp from drawing on random shti)
local function is_valid(model)
	if not model or not model.Parent then return false end
	if model.Name == "LocalViewmodel" then return false end
	if not viewmodels or model.Parent ~= viewmodels then return false end
	local torso = model:FindFirstChild("torso")
	return torso and torso:IsA("BasePart")
end

-- not needed js is cool as fuck
local function rand_str(len)
	local chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
	local result = {}
	for i = 1, len do result[i] = chars:sub(math.random(1, #chars), math.random(1, #chars)) end
	return table.concat(result)
end

local screen_gui = Instance.new("ScreenGui")
screen_gui.Name = rand_str(12)
screen_gui.Parent = gethui_support and gethui() or game:GetService("CoreGui") -- be ud if exec isnt shitty

local function remove_skeleton(character)
	local data = skeleton_list[character]
	if not data then return end
	for _, line in ipairs(data.lines) do line:Remove() end
	skeleton_list[character] = nil
end

local function create_skeleton(character)
	if not character or skeleton_list[character] or not is_valid(character) then return end

	-- prevents skeletons from being partial
	local char_bones = {}
	for _, name in ipairs(required_bones) do
		local b = character:FindFirstChild(name)
		if not b or not b:IsA("BasePart") then return end
		char_bones[name] = b
	end

	local lines = {}
	for i = 1, #bones do
		local line = Drawing.new("Line")
		line.Visible = false
		line.Color = Color3.new(1, 1, 1)
		line.Thickness = 1
		line.Transparency = 1
		lines[i] = line
	end

	skeleton_list[character] = { lines = lines, bones = char_bones }
end

local function create_esp(character)
	if not character or not is_valid(character) or esp_list[character] then return end
	local folder = Instance.new("Folder", screen_gui)
	local box = Instance.new("Frame", folder)
	local stroke = Instance.new("UIStroke", box)
	box.BackgroundTransparency = 1
	box.BorderSizePixel = 0
	stroke.Color = Color3.new(1, 1, 1)
	stroke.Thickness = 1
	esp_list[character] = { folder = folder, box = box }
end

_G.toggle_boxes = function()
	boxes = not boxes
	if _G.set_boxes then _G.set_boxes(boxes) end
end
_G.toggle_skeletons = function()
	skeletons = not skeletons
	if _G.set_skeletons then _G.set_skeletons(skeletons) end
end

-- ui lib
loadstring(game:HttpGet("https://raw.githubusercontent.com/twistedcarts/opone-opensource/refs/heads/main/interface/ui.lua"))()

task.defer(function()
	if _G.set_boxes then _G.set_boxes(boxes) end
	if _G.set_skeletons then _G.set_skeletons(skeletons) end
end)

-- peak optimization
runservice.RenderStepped:Connect(function()
	if _G.new_menu_key then
		menu_key = _G.new_menu_key
		_G.new_menu_key = nil
	end

	for character, data in pairs(esp_list) do
		local box = data.box
		local folder = data.folder

		if not character or not character.Parent or not is_valid(character) then
			box.Visible = false
			folder:Destroy()
			esp_list[character] = nil
			remove_skeleton(character)
			continue
		end

		local torso = character:FindFirstChild("torso")
		if not torso or torso.Transparency >= 1 or is_teammate(character) then
			box.Visible = false
			continue
		end

		local pos, on_screen = camera:WorldToScreenPoint(torso.Position)

		if on_screen and (camera.CFrame.Position - torso.Position).Magnitude <= 3571.4 then
			local needs_bones = boxes or skeletons

			if needs_bones then
				if not skeleton_list[character] then create_skeleton(character) end
				local skel = skeleton_list[character]
				if skel then
					local min_x, min_y = math.huge, math.huge
					local max_x, max_y = -math.huge, -math.huge

					for i, conn in ipairs(bones) do
						local b1, b2 = skel.bones[conn[1]], skel.bones[conn[2]]
						if b1 and b2 then
							local p1, on1 = camera:WorldToViewportPoint(b1.Position)
							local p2, on2 = camera:WorldToViewportPoint(b2.Position)
							local s1, son1 = camera:WorldToScreenPoint(b1.Position)
							local s2, son2 = camera:WorldToScreenPoint(b2.Position)
							if son1 then
								if s1.X < min_x then min_x = s1.X end
								if s1.X > max_x then max_x = s1.X end
								if s1.Y < min_y then min_y = s1.Y end
								if s1.Y > max_y then max_y = s1.Y end
							end
							if son2 then
								if s2.X < min_x then min_x = s2.X end
								if s2.X > max_x then max_x = s2.X end
								if s2.Y < min_y then min_y = s2.Y end
								if s2.Y > max_y then max_y = s2.Y end
							end
							if skeletons and on1 and on2 then
								skel.lines[i].From = Vector2.new(p1.X, p1.Y)
								skel.lines[i].To = Vector2.new(p2.X, p2.Y)
								skel.lines[i].Visible = true
							else
								skel.lines[i].Visible = false
							end
						else
							skel.lines[i].Visible = false
						end
					end

					if boxes and min_x ~= math.huge then
						local pad = 4
						box.Visible = true
						box.Position = UDim2.fromOffset(min_x - pad, min_y - pad)
						box.Size = UDim2.fromOffset(max_x - min_x + pad * 2, max_y - min_y + pad * 2)
					else
						box.Visible = false
					end
				end
			else
				remove_skeleton(character)
				box.Visible = false
			end
		else
			box.Visible = false
			remove_skeleton(character)
		end
	end
end)

uis.InputBegan:Connect(function(input, processed)
	if processed or input.KeyCode ~= menu_key then return end
	local menu_ui = _G.user_interface
	if menu_ui then menu_ui.Enabled = not menu_ui.Enabled end
end)

-- entry
if viewmodels then
	for _, v in ipairs(viewmodels:GetChildren()) do
		if v:IsA("Model") then task.delay(0.1, create_esp, v) end
	end
	viewmodels.ChildAdded:Connect(function(v)
		if v:IsA("Model") then task.delay(0.2, create_esp, v) end
	end)
	viewmodels.ChildRemoved:Connect(function(v)
		if esp_list[v] then esp_list[v].folder:Destroy(); esp_list[v] = nil end
		remove_skeleton(v)
	end)
end
