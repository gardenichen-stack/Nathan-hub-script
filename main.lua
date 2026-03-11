-- [[ NATHAN HUB - PROFESSIONAL EDITION ]] --
-- Fitur: Auto Coin, Auto 80KM, Auto Mission, Full Bypass, Anti-Lag
-- Theme: Deep Blue / Ocean (Professional UI)

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("Nathan Hub - Professional", "Ocean")

-- [[ 1. SYSTEM BYPASS & ANTI-CHEAT ]] --
local function GlobalBypass()
    local mt = getrawmetatable(game)
    setreadonly(mt, false)
    local old = mt.__namecall
    mt.__namecall = newcclosure(function(self, ...)
        local method = getnamecallmethod()
        local args = {...}
        -- Memblokir pelaporan cheat ke server
        if method == "FireServer" and (self.Name:lower():find("ban") or self.Name:lower():find("kick") or self.Name:lower():find("log")) then
            return nil
        end
        return old(self, unpack(args))
    end)
    setreadonly(mt, true)
end
GlobalBypass()

-- [[ 2. TAB AUTOMATION ]] --
local Main = Window:NewTab("Automation")
local AutoSection = Main:NewSection("Main Farming")

-- Auto Coin & Teleport
AutoSection:NewToggle("Auto Farm Coins", "Teleport otomatis ke koin di sekitar", function(state)
    _G.AutoCoin = state
    spawn(function()
        while _G.AutoCoin do
            task.wait(0.4)
            pcall(function()
                for _, v in pairs(game.Workspace:GetDescendants()) do
                    if v.Name:lower():find("coin") and v:IsA("BasePart") and _G.AutoCoin then
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.CFrame
                        task.wait(0.1)
                    end
                end
            end)
        end
    end)
end)

-- Auto 80KM Speed (Velocity Control)
AutoSection:NewToggle("Maintain 80KM Speed", "Mengunci kecepatan lari/kereta", function(state)
    _G.VelSpeed = state
    spawn(function()
        while _G.VelSpeed do
            task.wait()
            pcall(function()
                local hrp = game.Players.LocalPlayer.Character.HumanoidRootPart
                hrp.Velocity = hrp.CFrame.LookVector * 60 -- Setara 80 KM/jam
            end)
        end
    end)
end)

-- Auto Complete Mission (Instant Finish)
AutoSection:NewButton("Auto Finish Mission", "Selesaikan misi secara instan", function()
    pcall(function()
        local finish = workspace:FindFirstChild("Finish") or workspace:FindFirstChild("End")
        if finish then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = finish.CFrame
        end
    end)
end)

-- [[ 3. TAB PLAYER BUFFS ]] --
local PlayerTab = Window:NewTab("Player")
local BuffSection = PlayerTab:NewSection("Character Enhancement")

BuffSection:NewSlider("Walkspeed", "Kecepatan jalan", 500, 16, function(s)
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = s
end)

BuffSection:NewToggle("Infinite Jump", "Lompat tanpa batas di udara", function(state)
    _G.InfJump = state
    game:GetService("UserInputService").JumpRequest:Connect(function()
        if _G.InfJump then
            game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
        end
    end)
end)

BuffSection:NewToggle("Noclip (Anti-Die)", "Tembus dinding & rintangan", function(state)
    _G.Noclip = state
    game:GetService("RunService").Stepped:Connect(function()
        if _G.Noclip then
            for _, v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
                if v:IsA("BasePart") then v.CanCollide = false end
            end
        end
    end)
end)

-- [[ 4. TAB SETTINGS & UTILS ]] --
local Settings = Window:NewTab("Settings")
local SetSection = Settings:NewSection("Utility")

SetSection:NewButton("Clear Lag / FPS Boost", "Menghapus objek tidak penting agar FPS naik", function()
    for _, v in pairs(game.Workspace:GetDescendants()) do
        if v:IsA("Texture") or v:IsA("Decal") then
            v:Destroy()
        end
    end
end)

SetSection:NewKeybind("Toggle Menu", "Tutup/Buka Nathan Hub", Enum.KeyCode.RightControl, function()
    Library:ToggleUI()
end)

SetSection:NewButton("Destroy Script", "Hapus script secara total", function()
    Library:DestroyGui()
end)
