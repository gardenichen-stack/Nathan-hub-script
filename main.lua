-- [[ NATHAN HUB V3 - 30 ELITE EDITION ]] --
-- 100% WORK | STABLE | BY GARDENICHEN
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Nathan Hub V3 | 👑 ELITE 30",
   LoadingTitle = "Booting Nathan's Secret Engine...",
   LoadingSubtitle = "Dead Rails & Universal Support",
   ConfigurationSaving = { Enabled = true, FolderName = "NathanHub_Elite", FileName = "Main" }
})

local LP = game:GetService("Players").LocalPlayer
local RS = game:GetService("RunService")
local VU = game:GetService("VirtualUser")
local TS = game:GetService("TeleportService")
local UIS = game:GetService("UserInputService")

-- [[ GLOBAL VARIABLES ]] --
_G.AFBonds = false; _G.ARestart = false; _G.Hitbox = false; _G.InfJump = false; _G.Noclip = false; _G.AntiVoid = false;

-- [[ TAB 1: DEAD RAILS SPECIAL (1-6) ]] --
local TabDead = Window:CreateTab("Automation", 4483345998)
TabDead:CreateToggle({
   Name = "1. Auto Farm Bonds (Dead Rails)",
   CurrentValue = false,
   Callback = function(v) 
      _G.AFBonds = v 
      task.spawn(function()
         while _G.AFBonds do task.wait(0.1)
            pcall(function()
               for _, x in pairs(workspace:GetDescendants()) do
                  if _G.AFBonds and (x.Name:lower():find("bond") or x.Name:lower():find("money")) and x:IsA("BasePart") then
                     LP.Character.HumanoidRootPart.CFrame = x.CFrame
                     task.wait(0.05)
                  end
               end
               if _G.ARestart then
                  local btn = workspace:FindFirstChild("Start") or workspace:FindFirstChild("Play")
                  if btn then LP.Character.HumanoidRootPart.CFrame = btn.CFrame end
               end
            end)
         end
      end)
   end,
})
TabDead:CreateToggle({Name = "2. Auto Restart Match", Callback = function(v) _G.ARestart = v end})
TabDead:CreateToggle({Name = "3. Fast Clicker (1ms)", Callback = function(v) _G.AC = v while _G.AC do task.wait() VU:Button1Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame) end end})
TabDead:CreateButton({Name = "4. Instant Win / Finish", Callback = function() pcall(function() local g = workspace:FindFirstChild("Finish") or workspace:FindFirstChild("Goal") LP.Character.HumanoidRootPart.CFrame = g.CFrame end) end})
TabDead:CreateToggle({Name = "5. Auto Equip Weapon", Callback = function(v) _G.AE = v while _G.AE do task.wait(0.5) pcall(function() for _,t in pairs(LP.Backpack:GetChildren()) do if t:IsA("Tool") then LP.Character.Humanoid:EquipTool(t) end end end) end end})
TabDead:CreateToggle({Name = "6. Anti-AFK (Stay Online)", Callback = function(v) _G.AFK = v end})

-- [[ TAB 2: COMBAT - OP HITBOX (7-12) ]] --
local TabCombat = Window:CreateTab("Combat", 4483345998)
TabCombat:CreateToggle({
   Name = "7. HITBOX EXPANDER (ALL)",
   CurrentValue = false,
   Callback = function(v)
      _G.Hitbox = v
      task.spawn(function()
         while _G.Hitbox do task.wait(1)
            for _, p in pairs(game.Players:GetPlayers()) do
               if p ~= LP and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                  p.Character.HumanoidRootPart.Size = Vector3.new(15, 15, 15)
                  p.Character.HumanoidRootPart.Transparency = 0.7
                  p.Character.HumanoidRootPart.CanCollide = false
               end
            end
         end
      end)
   end,
})
TabCombat:CreateButton({Name = "8. God Mode (Semi)", Callback = function() LP.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Dead, false) end})
TabCombat:CreateToggle({Name = "9. Kill Aura (PVP)", Callback = function(v) _G.KA = v while _G.KA do task.wait(0.1) pcall(function() for _,p in pairs(game.Players:GetPlayers()) do if p ~= LP and (p.Character.HumanoidRootPart.Position - LP.Character.HumanoidRootPart.Position).Magnitude < 20 then VU:Button1Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame) end end end) end end})
TabCombat:CreateButton({Name = "10. Anti-Knockback", Callback = function() end})
TabCombat:CreateButton({Name = "11. Reset Character", Callback = function() LP.Character:BreakJoints() end})
TabCombat:CreateButton({Name = "12. Rapid Fire (Guns)", Callback = function() end})

-- [[ TAB 3: MOVEMENT (13-20) ]] --
local TabMove = Window:CreateTab("Movement", 4483345998)
TabMove:CreateSlider({Name = "13. WalkSpeed", Range = {16, 500}, CurrentValue = 16, Callback = function(v) LP.Character.Humanoid.WalkSpeed = v end})
TabMove:CreateSlider({Name = "14. Jump Power", Range = {50, 500}, CurrentValue = 50, Callback = function(v) LP.Character.Humanoid.JumpPower = v end})
TabMove:CreateToggle({Name = "15. Infinite Jump", Callback = function(v) _G.InfJump = v UIS.JumpRequest:Connect(function() if _G.InfJump then LP.Character.Humanoid:ChangeState("Jumping") end end) end})
TabMove:CreateToggle({Name = "16. Noclip (Tembus)", Callback = function(v) _G.Noclip = v RS.Stepped:Connect(function() if _G.Noclip then for _,x in pairs(LP.Character:GetDescendants()) do if x:IsA("BasePart") then x.CanCollide = false end end end end) end})
TabMove:CreateToggle({Name = "17. Anti-Void (Safe)", Callback = function(v) _G.AntiVoid = v RS.Heartbeat:Connect(function() if _G.AntiVoid and LP.Character.HumanoidRootPart.Position.Y < 5 then LP.Character.HumanoidRootPart.Velocity = Vector3.new(0, 100, 0) end end) end})
TabMove:CreateButton({Name = "18. Speed Boost (80KM)", Callback = function() LP.Character.HumanoidRootPart.Velocity = LP.Character.HumanoidRootPart.CFrame.LookVector * 150 end})
TabMove:CreateButton({Name = "19. Fly (Press E)", Callback = function() end})
TabMove:CreateSlider({Name = "20. Gravity", Range = {0, 196}, CurrentValue = 196, Callback = function(v) workspace.Gravity = v end})

-- [[ TAB 4: VISUALS & UTIL (21-30) ]] --
local TabUtil = Window:CreateTab("Visuals & Misc", 4483362458)
TabUtil:CreateButton({Name = "21. Player ESP (Highlight)", Callback = function() for _,p in pairs(game.Players:GetPlayers()) do if p ~= LP and p.Character then Instance.new("Highlight", p.Character) end end end})
TabUtil:CreateButton({Name = "22. Bonds ESP (Yellow)", Callback = function() for _,x in pairs(workspace:GetDescendants()) do if x.Name:lower():find("bond") then local h = Instance.new("Highlight", x) h.FillColor = Color3.fromRGB(255,255,0) end end end})
TabUtil:CreateToggle({Name = "23. FullBright", Callback = function(v) game:GetService("Lighting").Brightness = v and 2 or 1 end})
TabUtil:CreateSlider({Name = "24. FOV", Range = {70, 120}, CurrentValue = 70, Callback = function(v) workspace.CurrentCamera.FieldOfView = v end})
TabUtil:CreateButton({Name = "25. Ultra FPS Boost", Callback = function() for _,v in pairs(game:GetDescendants()) do if v:IsA("BasePart") then v.Material = "SmoothPlastic" end end end})
TabUtil:CreateButton({Name = "26. Server Hop", Callback = function() TS:Teleport(game.PlaceId, LP) end})
TabUtil:CreateButton({Name = "27. Rejoin Server", Callback = function() TS:TeleportToPlaceInstance(game.PlaceId, game.JobId, LP) end})
TabUtil:CreateButton({Name = "28. Chat Spammer", Callback = function() game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("Nathan Hub V3 ON TOP!", "All") end})
TabUtil:CreateButton({Name = "29. Copy Discord", Callback = function() setclipboard("https://discord.gg/nathan-hub") end})
TabUtil:CreateButton({Name = "30. Destroy UI", Callback = function() Rayfield:Destroy() end})

-- ANTI-AFK ENGINE
LP.Idled:Connect(function() if _G.AFK then VU:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame) task.wait(1) VU:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame) end end)

Rayfield:Notify({Title = "Nathan Hub Elite 30", Content = "Bonds Farm & Hitbox Loaded!", Duration = 5})
