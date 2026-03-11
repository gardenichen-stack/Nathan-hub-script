-- [[ NATHAN HUB V3 - BONDS EDITION ]] --
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Nathan Hub V3 | 💎 BONDS FARMER",
   LoadingTitle = "Booting Bonds Engine...",
   LoadingSubtitle = "by Nathan - Auto-Restart Active",
   ConfigurationSaving = { Enabled = true, FolderName = "NathanHub_Bonds", FileName = "Config" }
})

-- [[ SERVICES ]] --
local LP = game:GetService("Players").LocalPlayer
local RS = game:GetService("RunService")
local VU = game:GetService("VirtualUser")

-- [[ TAB: AUTOMATION ]] --
local TabFarm = Window:CreateTab("Automation", 4483345998)

TabFarm:CreateToggle({
   Name = "1. Auto Farm Bonds (Universal)",
   CurrentValue = false,
   Callback = function(v)
      _G.AutoBonds = v
      task.spawn(function()
         while _G.AutoBonds do
            task.wait(0.1)
            local foundBonds = false
            pcall(function()
               for _, obj in pairs(workspace:GetDescendants()) do
                  -- Mencari objek bernama "Bonds", "Bond", atau koin
                  if _G.AutoBonds and (obj.Name:lower():find("bond") or obj.Name:lower():find("coin")) and obj:IsA("BasePart") then
                     foundBonds = true
                     LP.Character.HumanoidRootPart.CFrame = obj.CFrame
                     task.wait(0.05)
                  end
               end
               
               -- 2. FITUR AUTO RESTART (Kalau Bonds Habis)
               if not foundBonds and _G.AutoRestart then
                  -- Mencari tombol "Play", "Start", atau "Next" di UI atau Workspace
                  local startPart = workspace:FindFirstChild("Start") or workspace:FindFirstChild("Play")
                  if startPart then
                     LP.Character.HumanoidRootPart.CFrame = startPart.CFrame
                  end
                  -- Mencoba menekan tombol Replay otomatis via RemoteEvent (Umum di banyak game)
                  game:GetService("ReplicatedStorage"):FindFirstChild("Events"):FindFirstChild("JoinGame"):FireServer()
               end
            end)
         end
      end)
   end,
})

TabFarm:CreateToggle({
   Name = "2. Auto Restart / Requeue",
   CurrentValue = false,
   Callback = function(v)
      _G.AutoRestart = v
   end,
})

-- [[ TAB: MOVEMENT ]] --
local TabMove = Window:CreateTab("Movement", 4483345998)
TabMove:CreateSlider({
   Name = "Speed Hack", Range = {16, 500}, CurrentValue = 16,
   Callback = function(v) LP.Character.Humanoid.WalkSpeed = v end,
})

TabMove:CreateToggle({
   Name = "Anti-Void (Gak Bisa Jatuh)",
   Callback = function(v)
      _G.AV = v
      RS.Heartbeat:Connect(function()
         if _G.AV and LP.Character.HumanoidRootPart.Position.Y < 5 then
            LP.Character.HumanoidRootPart.Velocity = Vector3.new(0, 100, 0)
         end
      end)
   end,
})

-- [[ TAB: UTILS ]] --
local TabUtil = Window:CreateTab("Utilities", 4483362458)
TabUtil:CreateButton({Name = "FPS Boost (Anti-Lag)", Callback = function() 
    for _,v in pairs(game:GetDescendants()) do if v:IsA("BasePart") then v.Material = "SmoothPlastic" end end 
end})

-- ANTI-AFK (Biar gak kena kick pas AFK Farm)
LP.Idled:Connect(function() VU:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame) task.wait(1) VU:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame) end)

Rayfield:Notify({Title = "Nathan Hub V3 Loaded", Content = "Bonds Farm & Auto-Restart Ready!", Duration = 5})
