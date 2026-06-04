-- ==========================================================
--        DimsHUB - PERFECT UI HIJACKER & FUNCTION BINDER
-- ==========================================================

local OrionLib = loadstring(game:HttpGet(("https://raw.githubusercontent.com/jensonhirst/Orion/main/source")))()

-- Pembersih Teks Console
local function cleanText(text)
    if type(text) == "string" then
        return text:gsub("Lynx", "DimsHUB"):gsub("lynx", "DimsHUB")
    end
    return text
end
local oldPrint = print
print = function(...)
    local args = {...}
    for i, v in ipairs(args) do args[i] = cleanText(v) end
    return oldPrint(table.unpack(args))
end

-- Tempat menyimpan fungsi asli dari tombol Lynx
local LynxFunctions = {
    AutoFish = nil,
    AutoEvent = nil,
    TeleportNPC = nil
}

-- 1. BAJAK INSTANCE (Mencuri fungsi klik dari tombol asli Lynx sebelum disembunyikan)
local oldInstanceNew = Instance.new
Instance.new = function(className, parent)
    local obj = oldInstanceNew(className, parent)
    
    if className == "TextButton" or className == "MouseButton1Click" then
        -- Deteksi tombol berdasarkan teksnya di menu Lynx
        task.defer(function()
            if obj.Text:find("Mancing") or obj.Text:find("Fishing") or obj.Text:find("Auto Farm") then
                -- Simpan fungsi klik asli untuk Auto Fish
                local connections = getconnections(obj.MouseButton1Click)
                if connections[1] then LynxFunctions.AutoFish = connections[1].Function end
            elseif obj.Text:find("Event") or obj.Text:find("Megalodon") then
                local connections = getconnections(obj.MouseButton1Click)
                if connections[1] then LynxFunctions.AutoEvent = connections[1].Function end
            elseif obj.Text:find("NPC") or obj.Text:find("Teleport to NPC") then
                local connections = getconnections(obj.MouseButton1Click)
                if connections[1] then LynxFunctions.TeleportNPC = connections[1].Function end
            end
        end)
    end
    return obj
end

-- 2. JALANKAN SCRIPT LYNX & SEMBUNYIKAN UI-NYA
task.spawn(function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/4LynxX/all_Game/refs/heads/main/Fish_It.lua"))()
end)

task.spawn(function()
    local CoreGui = game:GetService("CoreGui")
    while task.wait(0.5) do
        for _, gui in ipairs(CoreGui:GetChildren()) do
            if gui:IsA("ScreenGui") and (gui.Name:find("Lynx") or gui:FindFirstChild("MainFrame") or gui:FindFirstChild("Main")) then
                gui.Enabled = false -- Menu oranye Lynx disembunyikan, tidak akan muncul di layar
            end
        end
    end
end)

-- ==========================================================
-- 3. MEMBUAT TAMPILAN BARU DIMSHUB (ORION UI)
-- ==========================================================
local Window = OrionLib:MakeWindow({
    Name = "DimsHUB | Fish It Edition", 
    HidePremium = true, 
    SaveConfig = false, 
    IntroText = "Loading DimsHUB UI..."
})

local MainTab = Window:MakeTab({ Name = "Main / Farm", Icon = "rbxassetid://4483345998" })
local EventTab = Window:MakeTab({ Name = "Events", Icon = "rbxassetid://4483345998" })
local TeleportTab = Window:MakeTab({ Name = "Teleport", Icon = "rbxassetid://4483345998" })

-- 4. HUBUNGKAN TOMBOL BARU KE FUNGSI YANG SUDAH DICURI
MainTab:AddToggle({
    Name = "Auto Fishing (Mancing Otomatis)",
    Default = false,
    Callback = function(Value)
        if LynxFunctions.AutoFish then
            -- Memicu fungsi klik tombol asli Lynx lewat latar belakang
            pcall(LynxFunctions.AutoFish)
        else
            -- Backup plan menggunakan variabel global standar jika fungsi belum tercatat
            _G.AutoFish = Value
            _G.AutoCast = Value
            _G.AutoCatch = Value
        end
    end
})

EventTab:AddToggle({
    Name = "Auto Event Teleport (Megalodon/Shark)",
    Default = false,
    Callback = function(Value)
        if LynxFunctions.AutoEvent then
            pcall(LynxFunctions.AutoEvent)
        else
            _G.AutoEvent = Value
        end
    end
})

TeleportTab:AddButton({
    Name = "Teleport to NPC Penjual",
    Callback = function()
        if LynxFunctions.TeleportNPC then
            pcall(LynxFunctions.TeleportNPC)
        else
            print("DimsHUB: Fungsi teleport belum siap, pastikan script sudah ter-load sempurna.")
        end
    end
})

OrionLib:Init()
            
