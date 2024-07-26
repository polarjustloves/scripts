local a =
    loadstring(
    game:HttpGet("https://raw.githubusercontent.com/e266cfd65ad46a67fc54b0efd38e40dd/libs/main/pep/main.lua", true)
)()
a.UnloadCallback = function()
    getgenv().EightBall = nil
end
local b = game:GetService("Players")
local c = game:GetService("StarterGui")
local d = game:GetService("TweenService")
local e = game:GetService("RunService")
local f = game:GetService("ReplicatedStorage")
local g = game.Players.LocalPlayer
local h = f.Packages.Knit.Services.ToolService.RF
local i = g:GetMouse()
local j = workspace.CurrentCamera
local k = game.Players.LocalPlayer.Character.Humanoid.Health
local function l(m, n)
    h.ToggleBlockSword:InvokeServer(m, n)
end
local o = a:CreateWindow({Name = "EightBall", Themeable = {Image = "7059346386", Credit = false}})
local p = o:CreateTab({Name = "Blatant"})
local q = p:CreateSection({Name = "Aura"})
local r = p:CreateSection({Name = "Bow Aura"})
local s = p:CreateSection({Name = "Movement", Side = "Right"})
local t = p:CreateSection({Name = "Strafe", Side = "Right"})
local u = p:CreateSection({Name = "Anti void", Side = "Right"})
local v = p:CreateSection({Name = "Anti lagback [beta]"})
local w = o:CreateTab({Name = "Closet"})
local x = w:CreateSection({Name = "Hitbox", Side = "Right"})
local y = w:CreateSection({Name = "Auto"})
local z = w:CreateSection({Name = "Lag", Side = "Right"})
local A = w:CreateSection({Name = "Aim"})
local B = o:CreateTab({Name = "Visuals"})
local C = B:CreateSection({Name = "chams"})
local D = B:CreateSection({Name = "Target hud"})
local E = B:CreateSection({Name = "Render", Side = "Right"})
local F, G, H, I = "Closest", "PreSimulation", false, 24
local J = game:GetService("Players")
local g = J.LocalPlayer
q:AddDropdown(
    {
        Name = "RunService type",
        Default = "PreSimulation",
        List = {"Stepped", "PreSimulation", "Heartbeat", "RenderStepped", "PreRender", "PostSimulation"},
        Callback = function(K)
            G = K
        end
    }
)
local function L()
    local M = J:GetPlayers()
    local N = nil
    local O = math.huge
    local P = g.Character and g.Character.HumanoidRootPart.Position
    if not P then
        return nil
    end
    for Q, R in ipairs(M) do
        local S = R.Character
        if S and S:FindFirstChild("Humanoid") and S.Humanoid.Health > 0 and not S:FindFirstChildOfClass("ForceField") then
            local T = (S.HumanoidRootPart.Position - P).magnitude
            if T < O then
                O = T
                N = S.HumanoidRootPart.Position
            end
        end
    end
    return N
end
local function U(R)
    return R ~= g and R.Character and R.Character:FindFirstChild("HumanoidRootPart") and
        R.Character:FindFirstChild("Humanoid").Health > 0 and
        not R.Character:FindFirstChildOfClass("ForceField")
end
local function V(W)
    local X = nil
    local P = g.Character and g.Character.HumanoidRootPart.Position
    if not P then
        return nil
    end
    local M = J:GetPlayers()
    if W == "Closest" then
        local T = math.huge
        for Q, Y in ipairs(M) do
            if U(Y) then
                local Z = (P - Y.Character.HumanoidRootPart.Position).Magnitude
                if Z < T then
                    X, T = Y, Z
                end
            end
        end
    elseif W == "Random" then
        local _ = {}
        for Q, Y in ipairs(M) do
            if U(Y) and (P - Y.Character.HumanoidRootPart.Position).Magnitude <= I then
                table.insert(_, Y)
            end
        end
        if #_ > 0 then
            X = _[math.random(1, #_)]
        end
    elseif W == "Farthest" then
        local a0 = 0
        for Q, Y in ipairs(M) do
            if U(Y) then
                local Z = (P - Y.Character.HumanoidRootPart.Position).Magnitude
                if Z > a0 and Z <= I then
                    X, a0 = Y, Z
                end
            end
        end
    elseif W == "Weakest" then
        local a1 = math.huge
        for Q, Y in ipairs(M) do
            if U(Y) then
                local Z = (P - Y.Character.HumanoidRootPart.Position).Magnitude
                if Z <= I and Y.Character.Humanoid.Health < a1 then
                    X, a1 = Y, Y.Character.Humanoid.Health
                end
            end
        end
    elseif W == "Strongest" then
        local a2 = 0
        for Q, Y in ipairs(M) do
            if U(Y) then
                local Z = (P - Y.Character.HumanoidRootPart.Position).Magnitude
                if Z <= I and Y.Character.Humanoid.Health > a2 then
                    X, a2 = Y, Y.Character.Humanoid.Health
                end
            end
        end
    end
    return X
end
q:AddDropdown(
    {
        Name = "Targeting Mode",
        Default = "Closest",
        List = {"Closest", "Farthest", "Strongest", "Weakest", "Random"},
        Callback = function(K)
            F = K
        end
    }
)
local function a3()
    local a4 = V(F)
    if a4 then
        local Z = (g.Character.HumanoidRootPart.Position - a4.Character.HumanoidRootPart.Position).Magnitude
        if Z <= I and a4.Character.Humanoid.Health > 0 and not a4.Character:FindFirstChildOfClass("ForceField") then
            if H then
                for Q, a5 in ipairs({"WoodenSword", "Sword"}) do
                    l(true, a5)
                end
            end
            for Q, n in ipairs({"WoodenSword", "Sword"}) do
                h.AttackPlayerWithSword:InvokeServer(a4.Character, critsActive, n)
            end
        else
            if H then
                for Q, a5 in ipairs({"WoodenSword", "Sword"}) do
                    l(false, a5)
                end
            end
        end
    end
end
local a6
local function a7(a8)
    if a8 then
        if not a6 then
            a6 =
                game:GetService("RunService")[G]:Connect(
                function()
                    pcall(a3)
                end
            )
        end
    elseif a6 then
        a6:Disconnect()
        a6 = nil
    end
end
q:AddToggle({Name = "Aura", Default = false, Keybind = 1, Callback = a7})
q:AddToggle(
    {Name = "Auto block", Default = false, Callback = function(a8)
            H = a8
        end}
)
q:AddToggle(
    {Name = "Crits", Default = false, Callback = function(a8)
            critsActive = a8
        end}
)
q:AddSlider(
    {Name = "Aura Range", Min = 1, Max = 36, Default = 24, Callback = function(K)
            I = K
        end}
)
local a9
q:AddToggle(
    {
        Name = "Click Aura",
        Default = false,
        Keybind = 1,
        Callback = function(aa)
            local R = game.Players.LocalPlayer
            local i = R:GetMouse()
            local function ab(R)
                local ac, ad = nil, math.huge
                for Q, ae in pairs(game.Players:GetPlayers()) do
                    if ae ~= R and ae.Character and ae.Character:FindFirstChild("HumanoidRootPart") then
                        local T =
                            (R.Character.HumanoidRootPart.Position - ae.Character.HumanoidRootPart.Position).Magnitude
                        if T < ad then
                            ad, ac = T, ae
                        end
                    end
                end
                return ac
            end
            local function af()
                local ac = ab(R)
                if ac and ac.Character then
                    local ag = {"WoodenSword", "Sword"}
                    for Q, n in ipairs(ag) do
                        local ah = {[1] = workspace:WaitForChild(ac.Name), [2] = true, [3] = n}
                        game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("Knit"):WaitForChild(
                            "Services"
                        ):WaitForChild("ToolService"):WaitForChild("RF"):WaitForChild("AttackPlayerWithSword"):InvokeServer(
                            unpack(ah)
                        )
                    end
                end
            end
            if aa then
                a9 = i.Button1Down:Connect(af)
            else
                if a9 then
                    a9:Disconnect()
                    a9 = nil
                end
            end
        end
    }
)
local function ai()
    if FaceTarget then
        local aj = L()
        task.wait(0.05)
        local ah = {[1] = Vector3.new(aj.X, aj.Y, aj.Z)}
        game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("Knit"):WaitForChild("Services"):WaitForChild(
            "ToolService"
        ):WaitForChild("RF"):WaitForChild("UpdateHeadRotation"):InvokeServer(unpack(ah))
    end
end
game:GetService("RunService").Heartbeat:Connect(ai)
q:AddToggle(
    {Name = "Serverside Face", Default = false, Callback = function(a8)
            FaceTarget = a8
        end}
)
local ak, al, am, an, a8 = "Head", 30, 1, 0.1, false
local ao = false
local function ap(aq)
    local ar = game.Players.LocalPlayer:WaitForChild("Backpack"):FindFirstChild(aq)
    if a8 and ar and ar:IsA("Tool") then
        ar.Parent = game.Players.LocalPlayer.Character or game.Players.LocalPlayer.CharacterAdded:Wait()
    end
end
local function as(aq)
    local ar = game.Players.LocalPlayer.Character or game.Players.LocalPlayer.CharacterAdded:Wait():FindFirstChild(aq)
    if a8 and ar and ar:IsA("Tool") then
        ar.Parent = game.Players.LocalPlayer:WaitForChild("Backpack")
    end
end
local function at(au, av, aw, am)
    return au + av * aw + Vector3.new(0, am, 0)
end
local function ax(ay, az)
    local aA = Ray.new(ay, (az - ay).unit * (az - ay).magnitude)
    local aB, aC = workspace:FindPartOnRay(aA, game.Players.LocalPlayer.Character, false, true)
    return aB == nil
end
local function aD()
    local aE = game.Players.LocalPlayer
    local S = aE.Character or aE.CharacterAdded:Wait()
    local aF = S:FindFirstChild(ak)
    local aG = aF and aF.Position
    if not aG then
        return
    end
    local ac, ad, aH
    for Q, R in ipairs(game.Players:GetPlayers()) do
        if R ~= aE and R.Character then
            local aI = R.Character:FindFirstChild(ak)
            local au = aI and aI.Position
            local aJ = R.Character.HumanoidRootPart.Velocity
            if au then
                local T = (au - aG).magnitude
                local aK = at(au, aJ, an, am)
                local aL = (aK - aG).magnitude
                if not ad or aL < ad then
                    if ax(aG, aK) then
                        ac = R
                        ad = aL
                        aH = aK
                    end
                end
            end
        end
    end
    if ac and aH then
        ap("DefaultBow")
        game.Players.LocalPlayer.Character.DefaultBow.__comm__.RF.Fire:InvokeServer(aH, al)
        as("DefaultBow")
    end
end
r:AddDropdown(
    {
        Name = "Target Part",
        List = {
            "Head",
            "HumanoidRootPart",
            "LeftLowerArm",
            "RightLowerArm",
            "LeftUpperArm",
            "RightUpperArm",
            "LeftLowerLeg",
            "UpperTorso",
            "LeftUpperLeg",
            "RightLowerLeg",
            "LowerTorso",
            "RightUpperLeg"
        },
        Default = ak,
        Callback = function(aM)
            ak = aM
        end
    }
)
r:AddSlider(
    {Name = "Charge time", Min = 0, Max = 50, Default = al, Callback = function(K)
            al = K
        end}
)
r:AddSlider(
    {Name = "Y Offset", Min = -15, Max = 15, Default = am, Callback = function(K)
            am = K
        end}
)
r:AddSlider(
    {Name = "Prediction", Min = 0, Max = 3.0, Default = an, Precise = 1, Callback = function(K)
            an = K
        end}
)
r:AddToggle(
    {Name = "Bow Aura", Callback = function(aN)
            a8 = aN
            if a8 then
                ao = true
                while ao do
                    aD()
                    wait(3)
                end
            else
                ao = false
            end
        end}
)
local a8 = false
local aO = 10
local aP = 20
local aQ = 0.3
local aR = 0.001
local a9
local aS = false
local function aT(aU)
    aR = aR + aU
    if aR < aQ then
        return
    end
    aR = 0
    local b = game:GetService("Players")
    local R = b.LocalPlayer
    local S = R.Character
    if not S then
        return
    end
    local aV = S:FindFirstChild("Humanoid")
    if not aV then
        return
    end
    local aW = S:FindFirstChild("HumanoidRootPart")
    if not aW then
        return
    end
    local aX = aW.CFrame
    local T = (aX.Position - lastValidPosition.Position).Magnitude
    if T > aO and T < aP then
        local aJ = aV.MoveDirection * aV.WalkSpeed
        local aY = lastValidPosition.Position + aJ * aQ
        if (aX.Position - aY).Magnitude > aO then
            S:SetPrimaryPartCFrame(lastValidPosition)
        else
            lastValidPosition = aX
        end
    else
        lastValidPosition = aX
    end
    if aS then
        local aZ = aW.Position
        local a_ = lastValidPosition.Position
        local b0 = (aZ - a_).Magnitude
        if b0 > aP then
            local b1 = (aZ - a_).unit
            aW.CFrame = CFrame.new(a_ + b1 * aP)
        end
    end
end
v:AddToggle(
    {Name = "Anti lagback", Default = false, Callback = function(aN)
            a8 = aN
            if a8 then
                local b = game:GetService("Players")
                local e = game:GetService("RunService")
                local R = b.LocalPlayer
                local S = R.Character or R.CharacterAdded:Wait()
                lastValidPosition = S.PrimaryPart.CFrame
                a9 = e.Heartbeat:Connect(aT)
            else
                if a9 then
                    a9:Disconnect()
                    a9 = nil
                end
            end
        end}
)
v:AddToggle(
    {Name = "Area Lock", Default = false, Callback = function(b2)
            aS = b2
        end}
)
v:AddSlider(
    {
        Name = "Lag Back Threshold",
        Min = 0,
        Max = 30,
        Default = aO,
        Increment = 0.1,
        ValueName = "studs",
        Callback = function(K)
            aO = K
        end
    }
)
v:AddSlider(
    {
        Name = "Max Prevention Distance",
        Min = 0,
        Max = 50,
        Default = aP,
        Increment = 0.1,
        ValueName = "studs",
        Callback = function(K)
            aP = K
        end
    }
)
v:AddSlider(
    {
        Name = "Update Delay",
        Min = 0,
        Max = 1,
        Default = aQ,
        Increment = 0.01,
        ValueName = "seconds",
        Callback = function(K)
            aQ = K
        end
    }
)
local b3, b4, b5, b6, b7, a9 = 1.0, false, false, 1.0 / 200, false, false
local function b8()
    if b5 then
        b7 = true
        if a9 then
            a9:Disconnect()
        end
        a9 =
            game:GetService("RunService").Stepped:Connect(
            function()
                if not b7 then
                    return
                end
                local b9 = b6
                if b4 and game.Players.LocalPlayer:GetAttribute("Blocking") == true then
                    b9 = b9 * b3
                end
                local S = game.Players.LocalPlayer.Character
                if S and S:FindFirstChild("HumanoidRootPart") then
                    S.HumanoidRootPart.CFrame = S.HumanoidRootPart.CFrame + S.Humanoid.MoveDirection * b9
                end
            end
        )
    else
        b7 = false
        if a9 then
            a9:Disconnect()
        end
    end
end
s:AddSlider(
    {Name = "Block Speed", Min = 1, Max = 2.20, Value = b3, Precise = 2, Callback = function(K)
            b3 = K
        end}
)
s:AddToggle(
    {Name = "Block Noslow", Value = b4, Callback = function(ba)
            b4 = ba
        end}
)
s:AddToggle(
    {Name = "Speed", Value = b5, Keybind = 1, Callback = function(ba)
            b5 = ba
            b8()
        end}
)
s:AddSlider(
    {Name = "Movement Speed", Min = 0, Max = 50, Value = b6 * 200, Callback = function(K)
            b6 = K / 200
            if b5 then
                b8()
            end
        end}
)
game.Players.LocalPlayer.CharacterAdded:Connect(
    function()
        b8()
    end
)
s:AddSlider(
    {Name = "Gravity", Min = 0, Max = 192, Callback = function(bb, bc)
            workspace.Gravity = bb
        end}
)
local bd, be, bf = {}, nil, false
local function bg()
    for Q, aF in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
        if aF:IsA("BasePart") and aF.CanCollide then
            bd[aF] = true
            aF.CanCollide = false
        end
    end
end
s:AddToggle(
    {Name = "Phase", Value = bf, Keybind = 1, Callback = function(a8)
            bf = a8
            if a8 then
                be = game:GetService("RunService").Stepped:Connect(bg)
            else
                if be then
                    be:Disconnect()
                end
                for aF in pairs(bd) do
                    if aF then
                        aF.CanCollide = true
                    end
                end
                table.clear(bd)
            end
        end}
)
local bh, bi = false, 0.80
s:AddToggle(
    {Name = "Air Check", Value = bh, Callback = function(a8)
            bh = a8
        end}
)
s:AddToggle(
    {Name = "Bhop", Value = BhopActive, Keybind = 1, Callback = function(a8)
            BhopActive = a8
            if a8 then
                while a8 do
                    if
                        not bh or
                            game.Players.LocalPlayer.Character.Humanoid:GetState() ~= Enum.HumanoidStateType.Freefall
                     then
                        game.Players.LocalPlayer.Character:WaitForChild("Humanoid"):ChangeState(
                            Enum.HumanoidStateType.Jumping
                        )
                        task.wait(bi)
                    end
                    if not BhopActive then
                        break
                    end
                    task.wait()
                end
            end
        end}
)
s:AddSlider(
    {Name = "Bhop delay", Min = 0, Max = 1, Precise = 2, Value = bi, Callback = function(bb, bc)
            bi = bb
        end}
)
local bj = false
local bk = 0
s:AddToggle(
    {
        Name = "Derp",
        Default = false,
        Callback = function(bl)
            bj = bl
            if bj then
                local M = game:GetService("Players")
                local bm = game:GetService("TweenService")
                local bn = game:GetService("RunService")
                local function bo(S)
                    local bp = S:WaitForChild("HumanoidRootPart")
                    local bq = 0.01
                    local br = 0
                    local function bs(aU)
                        br = (br + bk * aU) % (2 * math.pi)
                        local bt = math.cos(br) * bq
                        local bu = math.sin(br) * bq
                        local bv = CFrame.new(bp.Position) * CFrame.Angles(0, br, 0)
                        local bw = TweenInfo.new(-1, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut)
                        local bx = bm:Create(bp, bw, {CFrame = bv})
                        bx:Play()
                    end
                    local by
                    by =
                        bn.Heartbeat:Connect(
                        function(aU)
                            if bj then
                                bs(aU)
                            else
                                by:Disconnect()
                            end
                        end
                    )
                end
                local aE = M.LocalPlayer
                local S = aE.Character or aE.CharacterAdded:Wait()
                bo(S)
                aE.CharacterAdded:Connect(
                    function(bz)
                        if bj then
                            bo(bz)
                        end
                    end
                )
            end
        end
    }
)
s:AddSlider(
    {Name = "Derp spin speed", Min = 0, Max = 50, Precise = 2, Default = bk, Callback = function(bA)
            bk = bA
        end}
)
local bB = false
local bC
local function bs(S)
    if S:FindFirstChild("HumanoidRootPart") then
        local bD = S.HumanoidRootPart.Position
        local am = S.Humanoid.HipHeight - -1
        bC.Position = Vector3.new(bD.X, bD.Y - am, bD.Z)
    end
end
s:AddToggle(
    {Name = "Fly", Value = bB, Keybind = 1, Callback = function(a8)
            bB = a8
            local R = game.Players.LocalPlayer
            local S = R.Character or R.CharacterAdded:Wait()
            if a8 then
                bC = Instance.new("Part")
                bC.Size = Vector3.new(2, 0.1, 2)
                bC.Anchored = true
                bC.CanCollide = true
                bC.Transparency = 1
                bC.BrickColor = BrickColor.new("Medium stone grey")
                bC.Parent = game.Workspace
                while bB do
                    bs(S)
                    task.wait()
                end
            else
                if bC then
                    bC:Destroy()
                end
            end
        end}
)
local bE, bF = false, 0.02
local function bG(bH, bI, bJ)
    local bK, bL, bM = math.clamp, Vector3.new, tick()
    local bN = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if bN then
        bN.Anchored = true
    end
    while tick() - bM <= bF do
        if bN then
            bN.Velocity = bL(bK(bN.Velocity.X, -bH, bH), bK(bN.Velocity.Y, -bI, bI), bK(bN.Velocity.Z, -bJ, bJ))
        end
        task.wait()
    end
    if bN then
        bN.Anchored = false
    end
end
local function bO(bP)
    if bE and k and bP < k then
        bG(0, 0, 0)
    end
    k = bP
end
local function bQ()
    while bE do
        bO(game.Players.LocalPlayer.Character.Humanoid.Health)
        task.wait(0.03)
    end
end
game.Players.LocalPlayer.Character.Humanoid.HealthChanged:Connect(bO)
s:AddToggle(
    {Name = "Antikb", Default = false, Callback = function(K)
            bE = K
            if bE then
                spawn(bQ)
            end
        end}
)
s:AddSlider(
    {Name = "Anti kb no-move", Min = 0, Max = 1, Precise = 2, Default = 0.02, Callback = function(K)
            bF = K
        end}
)
local bR = false
local bS = 20
local bT = 20
local bU = false
local bV, bW, bX
local function bY()
    local ad, bZ = math.huge, nil
    local R = game.Players.LocalPlayer
    local S = R.Character or R.CharacterAdded:Wait()
    for Q, ae in pairs(game:GetService("Players"):GetPlayers()) do
        local b_ = ae.Character
        local c0 = b_ and b_:FindFirstChild("HumanoidRootPart")
        if ae ~= R and c0 and b_.Humanoid.Health > 0 then
            local T = (S.HumanoidRootPart.Position - c0.Position).magnitude
            if T < ad and T <= bT then
                ad, bZ = T, ae
            end
        end
    end
    return bZ
end
local function bs()
    local R = game.Players.LocalPlayer
    local S = R.Character
    local bp = S and S:FindFirstChild("HumanoidRootPart")
    if bp and bV and bV.Character then
        local c1 = bV.Character:FindFirstChild("HumanoidRootPart")
        if c1 and bV.Character.Humanoid.Health > 0 then
            local au = c1.Position
            if (bp.Position - au).magnitude <= bT then
                task.wait(0.0195)
                if bV ~= bW then
                    if R:GetAttribute("Blocking") == true then
                        R:SetAttribute("Blocking", false)
                        task.wait(0.068)
                        if bU then
                            local b1 = (au - bp.Position).unit
                            bp.CFrame = CFrame.new(bp.Position + b1 * bS * 0.0195)
                        else
                            bp.CFrame = CFrame.new(bp.Position):lerp(CFrame.new(au), bS * 0.01)
                        end
                        R:SetAttribute("Blocking", true)
                    else
                        if bU then
                            local b1 = (au - bp.Position).unit
                            bp.CFrame = CFrame.new(bp.Position + b1 * bS * 0.0195)
                        else
                            bp.CFrame = CFrame.new(bp.Position):lerp(CFrame.new(au), bS * 0.01)
                        end
                    end
                    bW = bV
                else
                    if bU then
                        local b1 = (au - bp.Position).unit
                        bp.CFrame = CFrame.new(bp.Position + b1 * bS * 0.0195)
                    else
                        bp.CFrame = CFrame.new(bp.Position):lerp(CFrame.new(au), bS * 0.01)
                    end
                end
            else
                bV = nil
            end
        else
            bV = nil
        end
    else
        bV = bY()
    end
end
t:AddToggle(
    {Name = "Strafe", Keybind = 1, Default = false, Callback = function(K)
            bR = K
            if K then
                bX = game:GetService("RunService").RenderStepped:Connect(bs)
            elseif bX then
                bX:Disconnect()
                bX = nil
            end
        end}
)
t:AddSlider(
    {Name = "Follow Speed", Min = 0, Max = 30, Precise = 2, Value = bS, Callback = function(bb)
            bS = bb
        end}
)
t:AddSlider(
    {Name = "Max Target Distance", Min = 1, Max = 100, Value = bT, Callback = function(bb)
            bT = bb
        end}
)
t:AddToggle(
    {Name = "Linear", Default = false, Callback = function(K)
            bU = K
        end}
)
local c2
u:AddToggle(
    {Name = "Antivoid", Value = false, Callback = function(a8)
            if a8 then
                c2 = Instance.new("Part")
                c2.Name = "Antivoid"
                c2.Position = Vector3.new(0, -150, 0)
                c2.Size = Vector3.new(1000, 1, 1000)
                c2.Anchored = true
                c2.CanCollide = true
                c2.Transparency = 1
                c2.BrickColor = BrickColor.new("Medium stone grey")
                c2.Parent = game.Workspace
            else
                local c3 = game.Workspace:FindFirstChild("Antivoid")
                if c3 then
                    c3:Destroy()
                end
            end
        end}
)
u:AddSlider(
    {Name = "Antivoid Transparency", Value = 0, Min = 0, Max = 1, Precise = 1, Callback = function(c4)
            if c2 then
                c2.Transparency = c4
            end
        end}
)
local c5, c6, c7, c8, c9, ca, cb, cc = 1, 1, 1, false, nil, 0.5, Enum.Material.Neon, Color3.fromRGB(225, 160, 255)
x:AddSlider(
    {Name = "X axis", Min = 1, Max = 10, Callback = function(K)
            c5 = K
        end}
)
x:AddSlider(
    {Name = "Y axis", Min = 1, Max = 10, Callback = function(K)
            c6 = K
        end}
)
x:AddSlider(
    {Name = "Z axis", Min = 1, Max = 10, Callback = function(K)
            c7 = K
        end}
)
x:AddSlider(
    {Name = "Transparency", Min = 0, Max = 1, Callback = function(K)
            ca = K
        end}
)
x:AddDropdown(
    {
        Name = "Material",
        List = {"Plastic", "SmoothPlastic", "Neon", "ForceField", "Glass"},
        Default = "Neon",
        Callback = function(aM)
            if aM == "Plastic" then
                cb = Enum.Material.Plastic
            elseif aM == "SmoothPlastic" then
                cb = Enum.Material.SmoothPlastic
            elseif aM == "Neon" then
                cb = Enum.Material.Neon
            elseif aM == "ForceField" then
                cb = Enum.Material.ForceField
            elseif aM == "Glass" then
                cb = Enum.Material.Glass
            end
        end
    }
)
x:AddColorPicker(
    {Name = "Color", Default = cc, Callback = function(cd)
            cc = cd
        end}
)
x:AddToggle(
    {Name = "Hitbox Visual", Callback = function(a8)
            c8 = a8
        end}
)
x:AddToggle(
    {
        Name = "Hitbox",
        Callback = function(a8)
            if a8 then
                local function ce()
                    c9 =
                        game:GetService("RunService").RenderStepped:Connect(
                        function()
                            for Q, R in ipairs(game:GetService("Players"):GetPlayers()) do
                                if R.Name ~= game:GetService("Players").LocalPlayer.Name then
                                    pcall(
                                        function()
                                            local bp = R.Character and R.Character:FindFirstChild("HumanoidRootPart")
                                            if bp then
                                                bp.Size = Vector3.new(c5, c6, c7)
                                                bp.Transparency = c8 and ca or 1
                                                bp.Material = cb
                                                bp.Color = cc
                                                bp.CanCollide = false
                                            end
                                        end
                                    )
                                end
                            end
                        end
                    )
                end
                ce()
            else
                if c9 then
                    c9:Disconnect()
                    c9 = nil
                end
                for Q, R in ipairs(game:GetService("Players"):GetPlayers()) do
                    if R.Name ~= game:GetService("Players").LocalPlayer.Name then
                        pcall(
                            function()
                                local bp = R.Character and R.Character:FindFirstChild("HumanoidRootPart")
                                if bp then
                                    bp.Size = Vector3.new(2, 2, 2)
                                    bp.Transparency = 1
                                    bp.Material = Enum.Material.Plastic
                                    bp.CanCollide = false
                                end
                            end
                        )
                    end
                end
            end
        end
    }
)
local cf, cg, ch = false, false, 18
y:AddToggle(
    {Name = "Auto Clicker", Keybind = 1, Callback = function(a8)
            cf = a8
            if a8 then
                cg = true
                while cf and cg do
                    mouse1click()
                    task.wait(1 / ch)
                end
            else
                cg = false
            end
        end}
)
y:AddSlider(
    {Name = "CPS", Min = 1, Max = 50, Def = ch, Callback = function(c4)
            ch = c4
        end}
)
local ci, i, cj, ck = game:GetService("UserInputService"), game.Players.LocalPlayer:GetMouse(), false, false
local a9
y:AddToggle(
    {
        Name = "Double click",
        Callback = function(a8)
            ck = a8
            if a8 then
                a9 =
                    ci.InputBegan:Connect(
                    function(cl, cm)
                        if not cm and cl.UserInputType == Enum.UserInputType.MouseButton1 and not cj then
                            task.wait(0.1)
                            cj = true
                            mouse1click()
                            cj = false
                        end
                    end
                )
            elseif a9 then
                a9:Disconnect()
            end
        end
    }
)
y:AddToggle(
    {
        Name = "Trigger bot",
        Keybind = 1,
        Callback = function(a8)
            triggerbotActive = a8
            local cn
            local co = 0
            local minInterval = 1 / cpslimit
            local function cp(cq)
                for Q, R in pairs(game.Players:GetPlayers()) do
                    if R.Character and cq and cq:IsDescendantOf(R.Character) then
                        return true
                    end
                end
                return false
            end
            if a8 then
                cn =
                    game:GetService("RunService").Heartbeat:Connect(
                    function()
                        if cp(game.Players.LocalPlayer:GetMouse().Target) then
                            local cr = tick()
                            if cr - co >= minInterval then
                                co = cr
                                mouse1press()
                                task.wait()
                                mouse1release()
                            end
                        end
                    end
                )
                getgenv().disable = function()
                    if cn then
                        warn("Disconnecting:", cn)
                        cn:Disconnect()
                        cn = nil
                    end
                    getgenv().disable = nil
                end
            else
                if getgenv().disable then
                    getgenv().disable()
                end
            end
        end
    }
)
y:AddSlider(
    {Name = "CPS limit", Min = 1, Max = 50, Def = cpslimit, Callback = function(c4)
            cpslimit = c4
            minInterval = 1 / cpslimit
        end}
)
local cs, ct, cu, cv, ak = false, 1, 30, 30, "Head"
local function cw(cx, cy, cz, cA)
    return cx:Lerp(cy, cz * cA)
end
local function cB(aU)
    if cs then
        local cC = nil
        local O = math.huge
        local aE = game:GetService("Players").LocalPlayer
        local cD = aE.Character
        if cD then
            local cE = cD:FindFirstChild(ak).Position
            local cF = cD:FindFirstChild(ak).CFrame.lookVector
            for Q, R in ipairs(game:GetService("Players"):GetPlayers()) do
                if R ~= aE then
                    local cG = R.Character
                    if cG then
                        local cH = cG:FindFirstChild(ak) and cG:FindFirstChild(ak).Position
                        if cH then
                            local T = (cE - cH).magnitude
                            if T < O and T <= cu then
                                local cI = (cH - cE).unit
                                local br = math.acos(cF:Dot(cI)) * 180 / math.pi
                                if br <= cv then
                                    O = T
                                    cC = R
                                end
                            end
                        end
                    end
                end
            end
        end
        if cC then
            local cJ = game:GetService("Workspace").CurrentCamera.CFrame
            local cK = cC.Character:FindFirstChild(ak) and cC.Character:FindFirstChild(ak).Position
            if cK then
                local cL = CFrame.new(cJ.Position, cK)
                local cM = cw(cJ, cL, aU, ct)
                game:GetService("Workspace").CurrentCamera.CFrame = cM
            end
        end
    end
end
A:AddToggle(
    {Name = "Aim Assist", Keybind = 1, Callback = function(a8)
            cs = a8
        end}
)
A:AddDropdown(
    {
        Name = "Target Part",
        List = {
            "Head",
            "HumanoidRootPart",
            "LeftLowerArm",
            "RightLowerArm",
            "LeftUpperArm",
            "RightUpperArm",
            "LeftLowerLeg",
            "UpperTorso",
            "LeftUpperLeg",
            "RightLowerLeg",
            "LowerTorso",
            "RightUpperLeg"
        },
        Default = ak,
        Callback = function(aM)
            ak = aM
        end
    }
)
A:AddSlider(
    {Name = "Smoothness", Min = 1, Max = 25, Default = 1, Precise = 2, Callback = function(K)
            ct = K
        end}
)
A:AddSlider(
    {Name = "Range", Min = 5, Max = 100, Default = 30, Callback = function(K)
            cu = K
        end}
)
A:AddSlider(
    {Name = "Aim fov", Min = 0, Max = 360, Default = 30, Callback = function(K)
            cv = K
        end}
)
game:GetService("RunService").RenderStepped:Connect(
    function(aU)
        cB(aU)
    end
)
local cN = 40
D:AddSlider(
    {Name = "Hide distance", Min = 0, Max = 250, Value = cN, Callback = function(K)
            cN = K
        end}
)
D:AddToggle(
    {
        Name = "Target Hud",
        Callback = function(a8)
            if a8 then
                local b = game:GetService("Players")
                local e = game:GetService("RunService")
                local d = game:GetService("TweenService")
                local cO = game:GetService("UserInputService")
                local g = b.LocalPlayer
                local function cP(cQ, cR, cS)
                    local cT = Instance.new(cQ)
                    for cU, K in pairs(cR) do
                        cT[cU] = K
                    end
                    cT.Parent = cS
                    return cT
                end
                local function cV(cW)
                    local cX = workspace.CurrentCamera.ViewportSize
                    local cY = cW.Size
                    cW.Position = UDim2.new(0.5, -cY.X.Offset / 2, 0.5, -cY.Y.Offset / 2)
                end
                local cZ = cP("ScreenGui", {Name = "TargetHUD"}, g.PlayerGui)
                local c_ =
                    cP(
                    "Frame",
                    {
                        Size = UDim2.new(0, 280, 0, 130),
                        BackgroundColor3 = Color3.new(0.1, 0.1, 0.1),
                        BorderSizePixel = 0,
                        Draggable = true
                    },
                    cZ
                )
                cP("UICorner", {CornerRadius = UDim.new(0, 10)}, c_)
                local d0 =
                    cP(
                    "TextLabel",
                    {
                        Size = UDim2.new(1, 0, 0, 35),
                        Position = UDim2.new(0, 0, 0, 5),
                        BackgroundTransparency = 1,
                        TextColor3 = Color3.new(1, 1, 1),
                        TextSize = 22,
                        Font = Enum.Font.SourceSansBold
                    },
                    c_
                )
                local d1 =
                    cP(
                    "Frame",
                    {
                        Size = UDim2.new(0.92, 0, 0, 20),
                        Position = UDim2.new(0.04, 0, 0.38, 0),
                        BackgroundColor3 = Color3.new(0.2, 0.2, 0.2),
                        BorderSizePixel = 0
                    },
                    c_
                )
                cP("UICorner", {CornerRadius = UDim.new(0, 4)}, d1)
                local d2 =
                    cP(
                    "Frame",
                    {Size = UDim2.new(1, 0, 1, 0), BackgroundColor3 = Color3.new(1, 1, 1), BorderSizePixel = 0},
                    d1
                )
                cP("UICorner", {CornerRadius = UDim.new(0, 4)}, d2)
                local d3 =
                    cP(
                    "TextLabel",
                    {
                        Size = UDim2.new(1, 0, 1, 0),
                        BackgroundTransparency = 1,
                        TextColor3 = Color3.new(0, 0, 0),
                        TextSize = 18,
                        Font = Enum.Font.SourceSansBold
                    },
                    d1
                )
                local d4 =
                    cP(
                    "TextLabel",
                    {
                        Size = UDim2.new(0, 110, 0, 25),
                        Position = UDim2.new(0, 10, 1, -30),
                        BackgroundTransparency = 0.5,
                        BackgroundColor3 = Color3.new(0, 0.5, 1),
                        TextColor3 = Color3.new(1, 1, 1),
                        TextSize = 16,
                        Font = Enum.Font.SourceSansBold,
                        TextXAlignment = Enum.TextXAlignment.Center
                    },
                    c_
                )
                cP("UICorner", {CornerRadius = UDim.new(0, 5)}, d4)
                local d5 =
                    cP(
                    "TextLabel",
                    {
                        Size = UDim2.new(0, 110, 0, 25),
                        Position = UDim2.new(1, -120, 1, -30),
                        BackgroundTransparency = 0.5,
                        BackgroundColor3 = Color3.new(0.2, 0.2, 0.2),
                        TextColor3 = Color3.new(1, 1, 1),
                        TextSize = 16,
                        Font = Enum.Font.SourceSansBold,
                        TextXAlignment = Enum.TextXAlignment.Center
                    },
                    c_
                )
                cP("UICorner", {CornerRadius = UDim.new(0, 5)}, d5)
                cV(c_)
                local d6 = false
                local d7 = nil
                local d8 = nil
                local d9 = c_.Position
                local da = nil
                local function db(cl)
                    d6 = true
                    d7 = cl.Position
                    d8 = c_.Position
                    if da then
                        da:Cancel()
                    end
                end
                local function dc(cl)
                    if d6 then
                        local dd = cl.Position - d7
                        local de = UDim2.new(d8.X.Scale, d8.X.Offset + dd.X, d8.Y.Scale, d8.Y.Offset + dd.Y)
                        c_.Position = de
                    end
                end
                local function df()
                    d6 = false
                    local de = c_.Position
                    da = d:Create(c_, TweenInfo.new(0.3), {Position = de})
                    da:Play()
                end
                c_.InputBegan:Connect(
                    function(cl)
                        if cl.UserInputType == Enum.UserInputType.MouseButton1 then
                            db(cl)
                        end
                    end
                )
                cO.InputChanged:Connect(
                    function(cl)
                        if d6 and cl.UserInputType == Enum.UserInputType.MouseMovement then
                            dc(cl)
                        end
                    end
                )
                cO.InputEnded:Connect(
                    function(cl)
                        if cl.UserInputType == Enum.UserInputType.MouseButton1 then
                            df()
                        end
                    end
                )
                local function dg()
                    local ac, ad = nil, math.huge
                    for Q, R in pairs(b:GetPlayers()) do
                        if R ~= g and R.Character and R.Character:FindFirstChild("HumanoidRootPart") then
                            local dh = g.Character or g.CharacterAdded:Wait()
                            local di = dh:WaitForChild("HumanoidRootPart")
                            local T = (R.Character.HumanoidRootPart.Position - di.Position).Magnitude
                            if T <= cN and T < ad then
                                ac, ad = R, T
                            end
                        end
                    end
                    if ac then
                        local dj = ac.Character:FindFirstChild("Humanoid")
                        local dh = g.Character or g.CharacterAdded:Wait()
                        local dk = dh:FindFirstChild("Humanoid")
                        d0.Text = ac.Name
                        d4.Text = string.format("Distance %.1f", ad)
                        if dj then
                            d3.Text = tostring(math.floor(dj.Health))
                            d:Create(d2, TweenInfo.new(0.3), {Size = UDim2.new(dj.Health / dj.MaxHealth, 0, 1, 0)}):Play(

                            )
                        else
                            d3.Text = "N/A"
                            d2.Size = UDim2.new(0, 0, 1, 0)
                        end
                        if dk and dj then
                            local dl = dk.Health / dk.MaxHealth
                            local dm = dj.Health / dj.MaxHealth
                            if dl > dm then
                                d5.Text = "Winning"
                                d5.BackgroundColor3 = Color3.new(0, 0.7, 0)
                            elseif dl < dm then
                                d5.Text = "Losing"
                                d5.BackgroundColor3 = Color3.new(0.7, 0, 0)
                            else
                                d5.Text = "Even"
                                d5.BackgroundColor3 = Color3.new(0.7, 0.7, 0)
                            end
                        else
                            d5.Text = "N/A"
                            d5.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
                        end
                        c_.Visible = true
                    else
                        c_.Visible = false
                    end
                end
                e.RenderStepped:Connect(dg)
            else
                if g.PlayerGui:FindFirstChild("TargetHUD") then
                    g.PlayerGui.TargetHUD:Destroy()
                end
            end
        end
    }
)
E:AddToggle(
    {Name = "Hide guis", Callback = function(ba)
            if ba then
                game.Players.LocalPlayer.PlayerGui.MainGui["BRIDGE DUEL"].Visible = false
            else
                game.Players.LocalPlayer.PlayerGui.MainGui["BRIDGE DUEL"].Visible = true
            end
        end}
)
local dn = {Ambient = nil, OutdoorAmbient = nil, FogColor = nil, FogStart = nil, FogEnd = nil, PartColors = {}}
local dp, dq, dr = Color3.new(225, 160, 255), Color3.fromRGB(225, 160, 255), Vector3.new(2, 1, 3)
local ds = false
local function dt(a8)
    local du = game:GetService("Lighting")
    if a8 then
        dn.Ambient = du.Ambient
        dn.OutdoorAmbient = du.OutdoorAmbient
        dn.FogColor = du.FogColor
        dn.FogStart = du.FogStart
        dn.FogEnd = du.FogEnd
        for Q, aF in ipairs(workspace:GetDescendants()) do
            if aF:IsA("BasePart") then
                dn.PartColors[aF] = aF.Color
            end
        end
        du.Ambient = dp
        du.OutdoorAmbient = dp
        du.FogColor = dp
        du.FogStart = dn.FogStart or 0
        du.FogEnd = dn.FogEnd or 100
        for Q, aF in ipairs(workspace:GetDescendants()) do
            if aF:IsA("BasePart") then
                aF.Color = dp
            end
        end
    else
        du.Ambient = dn.Ambient
        du.OutdoorAmbient = dn.OutdoorAmbient
        du.FogColor = dn.FogColor
        du.FogStart = dn.FogStart
        du.FogEnd = dn.FogEnd
        for Q, aF in ipairs(workspace:GetDescendants()) do
            if aF:IsA("BasePart") and dn.PartColors[aF] then
                aF.Color = dn.PartColors[aF]
            end
        end
    end
end
E:AddToggle(
    {Name = "Ambient", Callback = function(a8)
            dt(a8)
        end}
)
local dv = {}
E:AddToggle(
    {Name = "Low gfx", Callback = function(ba)
            local workspace = game:GetService("Workspace")
            for Q, aF in ipairs(workspace:GetDescendants()) do
                if aF:IsA("BasePart") then
                    if ba then
                        dv[aF] = aF.Material
                        aF.Material = Enum.Material.Ice
                    else
                        aF.Material = dv[aF] or aF.Material
                        dv[aF] = nil
                    end
                end
            end
        end}
)
E:AddToggle(
    {
        Name = "Water mark",
        Value = false,
        Callback = function(K)
            local b = game:GetService("Players")
            local d = game:GetService("TweenService")
            local e = game:GetService("RunService")
            local function dw(R)
                local dx = R:WaitForChild("PlayerGui")
                local dy = Instance.new("ScreenGui")
                dy.Name = "GameSenseWatermark"
                dy.ResetOnSpawn = false
                local cW = Instance.new("Frame")
                cW.Size = UDim2.new(0, 280, 0, 25)
                cW.Position = UDim2.new(0, -280, 0, 10)
                cW.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
                cW.BorderSizePixel = 0
                cW.Parent = dy
                local dz = Instance.new("UICorner")
                dz.CornerRadius = UDim.new(0, 4)
                dz.Parent = cW
                local dA = Instance.new("Frame")
                dA.Size = UDim2.new(1, 0, 0, 2)
                dA.Position = UDim2.new(0, 0, 0, 0)
                dA.BorderSizePixel = 0
                dA.Parent = cW
                local dB = Instance.new("UIGradient")
                dB.Color =
                    ColorSequence.new {
                    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 255)),
                    ColorSequenceKeypoint.new(1, Color3.fromRGB(128, 0, 128))
                }
                dB.Parent = dA
                local dC = Instance.new("ImageLabel")
                dC.Size = UDim2.new(0, 60, 0, 60)
                dC.Position = UDim2.new(0, -15, 0.5, -30)
                dC.BackgroundTransparency = 1
                dC.Image = "rbxassetid://18335445948"
                dC.Parent = cW
                local dD = Instance.new("TextLabel")
                dD.Size = UDim2.new(1, -60, 1, 0)
                dD.Position = UDim2.new(0, 40, 0, 0)
                dD.BackgroundTransparency = 1
                dD.Font = Enum.Font.Code
                dD.TextColor3 = Color3.fromRGB(255, 255, 255)
                dD.TextSize = 16
                dD.Text = "8 ball | 00:00:00"
                dD.TextXAlignment = Enum.TextXAlignment.Left
                dD.Parent = cW
                dy.Parent = dx
                local bw = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
                local bx = d:Create(cW, bw, {Position = UDim2.new(0, 10, 0, 10)})
                bx:Play()
                local bM = tick()
                local a9
                a9 =
                    e.Heartbeat:Connect(
                    function()
                        if dy.Parent == nil then
                            a9:Disconnect()
                            return
                        end
                        local dE = tick() - bM
                        local dF = math.floor(dE / 3600)
                        local dG = math.floor(dE % 3600 / 60)
                        local dH = math.floor(dE % 60)
                        dD.Text = string.format("8 ball | %02d:%02d:%02d", dF, dG, dH)
                    end
                )
            end
            local function dI(R)
                local dx = R:FindFirstChild("PlayerGui")
                if dx then
                    local dy = dx:FindFirstChild("GameSenseWatermark")
                    if dy then
                        local cW = dy:FindFirstChildOfClass("Frame")
                        if cW then
                            local bw = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
                            local bx = d:Create(cW, bw, {Position = UDim2.new(0, -280, 0, 10)})
                            bx:Play()
                            bx.Completed:Connect(
                                function()
                                    dy:Destroy()
                                end
                            )
                        else
                            dy:Destroy()
                        end
                    end
                end
            end
            if K then
                for Q, R in ipairs(b:GetPlayers()) do
                    dw(R)
                end
                b.PlayerAdded:Connect(dw)
            else
                for Q, R in ipairs(b:GetPlayers()) do
                    dI(R)
                end
                b.PlayerAdded:Connect(dI)
            end
        end
    }
)
local function dJ()
    local dK = game:GetService("Workspace").Camera:FindFirstChild("Viewmodel")
    if dK then
        local dL = dK:FindFirstChild("WoodenSword")
        if dL then
            local dM = dL:FindFirstChild("MainPart")
            if dM then
                return dM:FindFirstChild("Mesh")
            end
        end
    end
    return nil
end
E:AddToggle(
    {Name = "Custom sword", Callback = function(a8)
            ds = a8
            if not ds then
                local dN = dJ()
                if dN then
                    dN.Offset = Vector3.new(0, 0, 0)
                end
            end
        end}
)
game:GetService("RunService").Heartbeat:Connect(
    function()
        if ds then
            local dN = dJ()
            if dN then
                dN.Offset = dr
            end
        end
    end
)
local function dO()
    if ds then
        local dN = dJ()
        if dN then
            dN.Offset = dr
        end
    end
end
E:AddSlider(
    {Name = "Sword front", Min = -10, Max = 10, Value = dr.X, Callback = function(K)
            dr = Vector3.new(K, dr.Y, dr.Z)
            dO()
        end}
)
E:AddSlider(
    {Name = "Sword vertical", Min = -10, Max = 10, Value = dr.Y, Callback = function(K)
            dr = Vector3.new(dr.X, K, dr.Z)
            dO()
        end}
)
E:AddSlider(
    {Name = "Sword side", Min = -10, Max = 10, Value = dr.Z, Callback = function(K)
            dr = Vector3.new(dr.X, dr.Y, K)
            dO()
        end}
)
E:AddSlider(
    {Name = "Fog Start", Min = 0, Max = 1000, Value = dn.FogStart or 0, Callback = function(K)
            dn.FogStart = K
            if ds then
                game:GetService("Lighting").FogStart = K
            end
        end}
)
E:AddSlider(
    {Name = "Fog End", Min = 0, Max = 1000, Value = dn.FogEnd or 100, Callback = function(K)
            dn.FogEnd = K
            if ds then
                game:GetService("Lighting").FogEnd = K
            end
        end}
)
E:AddColorpicker(
    {Name = "Atmo color", Value = dp, Callback = function(dP, dQ)
            dp = dP
            if a8 then
                local du = game:GetService("Lighting")
                du.Ambient = dp
                du.OutdoorAmbient = dp
                du.FogColor = dp
                for Q, aF in ipairs(workspace:GetDescendants()) do
                    if aF:IsA("BasePart") then
                        aF.Color = dp
                    end
                end
            end
        end}
)
local dR, dS = 1, false
getgenv().res = dR
E:AddToggle(
    {Name = "ress", Callback = function(ba)
            dS = ba
            if ba then
                while dS do
                    game:GetService("RunService").RenderStepped:Wait()
                    j.CFrame = j.CFrame * CFrame.new(0, 0, 0, 1, 0, 0, 0, getgenv().res, 0, 0, 0, 1)
                end
            end
        end}
)
E:AddSlider(
    {Name = "Resolution", Min = 0, Max = 1.2, Precise = 2, Value = dR, Callback = function(K)
            getgenv().res = K
        end}
)
local dT = 0.5
local dU = Color3.fromRGB(200, 150, 255)
local dV, dW, dX = false, false, false
local dY
local function dZ(d_)
    return Color3.new(d_.r, d_.g, d_.b)
end
local function e0(Y)
    local e1 = Instance.new("Highlight")
    e1.Name = Y.Name
    e1.FillColor = dU
    e1.DepthMode = "AlwaysOnTop"
    e1.FillTransparency = dT
    e1.OutlineTransparency = dT
    e1.Parent = dY
    e1.Adornee = Y.Character
    Y.CharacterAdded:Connect(
        function(e2)
            e1.Adornee = e2
        end
    )
    Y:GetPropertyChangedSignal("Team"):Connect(
        function()
            e1.FillColor = dZ(Y.TeamColor)
        end
    )
end
local function e3()
    for Q, R in ipairs(game.Players:GetPlayers()) do
        if R == game.Players.LocalPlayer then
            if dV then
                if not dY:FindFirstChild(R.Name) then
                    e0(R)
                end
            else
                local e4 = dY:FindFirstChild(R.Name)
                if e4 then
                    e4:Destroy()
                end
            end
        else
            if not dY:FindFirstChild(R.Name) then
                e0(R)
            end
        end
    end
end
local function e5(e6)
    dX = e6
    if e6 then
        dY = Instance.new("Folder", game:GetService("CoreGui"))
        dY.Name = "Highlight_Storage"
        e3()
        coroutine.wrap(
            function()
                while dX do
                    task.wait(0.15)
                    e3()
                end
            end
        )()
    else
        if dY then
            dY:Destroy()
            dY = nil
        end
    end
end
local function e7(e6)
    dV = e6
    e3()
end
local function e8(e6)
    dW = e6
    e3()
end
local function e9(dP)
    dU = dP
    if dY then
        for Q, ea in ipairs(dY:GetChildren()) do
            ea.FillColor = dP
        end
    end
end
C:AddToggle({Name = "Chams", Value = false, Callback = e5})
C:AddColorpicker({Name = "Color", Value = dU, Callback = e9})
C:AddToggle({Name = "Self", Value = false, Callback = e7})
C:AddSlider(
    {Name = "Transparency", Min = 0, Max = 1, Value = dT, Callback = function(K)
            dT = K
            if dY then
                for Q, ea in ipairs(dY:GetChildren()) do
                    ea.FillTransparency = K
                    ea.OutlineTransparency = K
                end
            end
        end}
)
C:AddToggle(
    {
        Name = "Cape",
        Value = false,
        Callback = function(K)
            local R = game.Players.LocalPlayer
            local S = R.Character
            local function eb()
                local aV = S:WaitForChild("Humanoid")
                local ec =
                    aV.RigType == Enum.HumanoidRigType.R15 and S:WaitForChild("UpperTorso") or S:WaitForChild("Torso")
                local ed = Instance.new("Part", S)
                ed.Name = "Cape"
                ed.Anchored = false
                ed.CanCollide = false
                ed.TopSurface = Enum.SurfaceType.Smooth
                ed.BottomSurface = Enum.SurfaceType.Smooth
                ed.Size = Vector3.new(0.2, 0.2, 0.2)
                ed.Transparency = 0
                ed.BrickColor = BrickColor.new("Really black")
                local ee = Instance.new("BlockMesh", ed)
                ee.Scale = Vector3.new(9, 17.5, 0.08)
                local ef = Instance.new("Motor", ed)
                ef.Part0 = ed
                ef.Part1 = ec
                ef.MaxVelocity = 0.01
                ef.C0 = CFrame.new(0, 2, 0) * CFrame.Angles(0, math.rad(90), 0)
                ef.C1 = CFrame.new(0, 1, 0.45) * CFrame.Angles(0, math.rad(90), 0)
                spawn(
                    function()
                        local eg = false
                        while ed.Parent == S do
                            task.wait(1 / 60)
                            local br = 0.1
                            local eh = ec.Velocity.Magnitude
                            if eg then
                                br = br + ec.Velocity.Magnitude / 10 * 0.05 + 0.05
                                eg = false
                            else
                                eg = true
                            end
                            br = br + math.min(ec.Velocity.Magnitude / 11, 0.5)
                            ef.MaxVelocity = math.min(ec.Velocity.Magnitude / 111, 0.04)
                            ef.DesiredAngle = -br
                            if ef.CurrentAngle < -0.2 and ef.DesiredAngle > -0.2 then
                                ef.MaxVelocity = 0.04
                            end
                            repeat
                                task.wait()
                            until ef.CurrentAngle == ef.DesiredAngle or
                                math.abs(ec.Velocity.Magnitude - eh) >= ec.Velocity.Magnitude / 10 + 1
                            if ec.Velocity.Magnitude < 0.1 then
                                task.wait(0.1)
                            end
                        end
                    end
                )
            end
            local function ei()
                local ed = S:FindFirstChild("Cape")
                if ed then
                    ed:Destroy()
                end
            end
            if K then
                if not S:FindFirstChild("Cape") then
                    eb()
                end
            else
                ei()
            end
        end
    }
)
local ej = {
    {Name = "Mouse", Value = "Mouse"},
    {Name = "Bottom Center", Value = "BottomCenter"},
    {Name = "Top Center", Value = "TopCenter"},
    {Name = "Left Center", Value = "LeftCenter"},
    {Name = "Right Center", Value = "RightCenter"}
}
local ek = 1
C:AddDropdown(
    {
        Name = "Tracer Source",
        Default = ej[ek].Name,
        List = {ej[1].Name, ej[2].Name, ej[3].Name, ej[4].Name, ej[5].Name},
        Callback = function(K)
            for el, em in ipairs(ej) do
                if em.Name == K then
                    ek = el
                    break
                end
            end
        end
    }
)
C:AddToggle(
    {
        Name = "Tracer",
        Value = false,
        Callback = function(a8)
            Tracer = a8
            local e = game:GetService("RunService")
            local b = game:GetService("Players")
            local en = game:GetService("Workspace")
            local cO = game:GetService("UserInputService")
            local j = en.CurrentCamera
            local eo = {
                DefaultSettings = false,
                TeamCheck = false,
                TracersVisible = true,
                TracerColor = Color3.fromRGB(128, 0, 128),
                TracerThickness = 1.8,
                TracerTransparency = 0.8
            }
            local ep = {}
            local function eq(S)
                local er = Drawing.new("Line")
                er.Thickness = eo.TracerThickness
                er.Transparency = eo.TracerTransparency
                er.Visible = false
                er.Color = eo.TracerColor
                local function es()
                    if not S:IsDescendantOf(en) or not S:FindFirstChild("HumanoidRootPart") then
                        er.Visible = false
                        return
                    end
                    local et = S:FindFirstChild("Head") or S:FindFirstChild("HumanoidRootPart")
                    if not et then
                        er.Visible = false
                        return
                    end
                    local eu = et.Position
                    local ev, ew = j:WorldToViewportPoint(eu)
                    local ex = ej[ek]
                    if ex.Value == "Mouse" then
                        er.From = Vector2.new(cO:GetMouseLocation().X, cO:GetMouseLocation().Y)
                    elseif ex.Value == "BottomCenter" then
                        er.From = Vector2.new(j.ViewportSize.X / 2, j.ViewportSize.Y)
                    elseif ex.Value == "TopCenter" then
                        er.From = Vector2.new(j.ViewportSize.X / 2, 0)
                    elseif ex.Value == "LeftCenter" then
                        er.From = Vector2.new(0, j.ViewportSize.Y / 2)
                    elseif ex.Value == "RightCenter" then
                        er.From = Vector2.new(j.ViewportSize.X, j.ViewportSize.Y / 2)
                    end
                    if ew then
                        er.To = Vector2.new(ev.X, ev.Y)
                        if eo.TeamCheck then
                            er.Visible = b.LocalPlayer.Team ~= S.Team
                        else
                            er.Visible = Tracer
                        end
                    else
                        er.Visible = false
                    end
                end
                ep[S] = er
                return er, es
            end
            local function ey(R, S)
                if R == b.LocalPlayer then
                    return
                end
                if not S or not S:IsDescendantOf(en) or not S:FindFirstChild("HumanoidRootPart") then
                    return
                end
                local ez, eA = eq(S)
                e.RenderStepped:Connect(
                    function()
                        eA()
                    end
                )
                S.AncestryChanged:Connect(
                    function()
                        if not S:IsDescendantOf(en) then
                            ez.Visible = false
                            ep[S] = nil
                        end
                    end
                )
            end
            b.PlayerAdded:Connect(
                function(R)
                    R.CharacterAdded:Connect(
                        function(S)
                            ey(R, S)
                        end
                    )
                end
            )
            for Q, R in ipairs(b:GetPlayers()) do
                ey(R, R.Character)
            end
            cO.InputBegan:Connect(
                function(cl)
                    if cl.KeyCode == eo.ModeSkipKey and not cO:GetFocusedTextBox() then
                        ek = ek % #ej + 1
                        for Q, er in pairs(ep) do
                            er.Visible = eo.TracersVisible and Tracer
                        end
                    elseif cl.KeyCode == eo.DisableKey and not cO:GetFocusedTextBox() then
                        eo.TracersVisible = not eo.TracersVisible
                        for Q, er in pairs(ep) do
                            er.Visible = eo.TracersVisible and Tracer
                        end
                    end
                end
            )
            if eo.DefaultSettings then
                eo.TeamCheck = false
                eo.TracersVisible = true
                eo.TracerColor = Color3.fromRGB(128, 0, 128)
                eo.TracerThickness = 1.8
                eo.TracerTransparency = 0.8
            end
        end
    }
)
local R, eB = game.Players.LocalPlayer, false
local function eC(S)
    local et = S:FindFirstChild("Head")
    if et then
        local eD = et:FindFirstChild("face")
        if eD then
            eD:Destroy()
        end
    end
end
local function eE(aF)
    if aF:IsA("Accessory") or aF:IsA("Shirt") or aF:IsA("Pants") or aF.Name == "Face" then
        aF:Destroy()
    elseif aF:IsA("BasePart") then
        aF.Material = Enum.Material.ForceField
        aF.Color = Color3.fromRGB(225, 160, 255)
    end
end
local function eF(S)
    eC(S)
    for Q, aF in ipairs(S:GetChildren()) do
        eE(aF)
    end
    S.ChildAdded:Connect(eE)
end
local function eG(S)
    task.wait(0.14)
    if eB then
        eF(S)
    end
end
C:AddToggle(
    {Name = "Self visual", Value = false, Callback = function(ba)
            eB = ba
            if ba then
                eG(R.Character or R.CharacterAdded:Wait())
            end
        end}
)
R.CharacterAdded:Connect(eG)
