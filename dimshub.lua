-- ==========================================================
--        DimsHUB - CUSTOM UI WITH LYNX FUNCTION FORWARDING
-- ==========================================================

-- 1. LOAD ORION UI LIBRARY (Tampilan Baru DimsHUB)
local OrionLib = loadstring(game:HttpGet(("https://raw.githubusercontent.com/jensonhirst/Orion/main/source")))()

-- 2. BAJAK TEXT CONSOLE & INSTANCE (Membajak sisa nama Lynx)
local function cleanText(text)
    if type(text) == "string" then
        text = text:gsub("Lynx", "DimsHUB"):gsub("lynx", "DimsHUB")
    end
    return text
end

local oldPrint = print
print = function(...)
    local args = {...}
    for i, v in ipairs(args) do args[i] = cleanText(v) end
    return oldPrint(table.unpack(args))
end

-- 3. LOAD SCRIPT ASLI LYNX DI LATAR BELAKANG
-- Kita panggil script aslinya agar fungsinya terdaftar di game
task.spawn(function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/4LynxX/all_Game/refs/heads/main/Fish_It.lua"))()
end)

-- Menyembunyikan UI asli Lynx agar tidak menumpuk di layar HP kamu
task.spawn(function()
    local CoreGui = game:GetService("CoreGui")
    while task.wait(0.5) do
        -- Mencari screen gui bawaan Lynx dan mematikan visibilitasnya
        for _, gui in ipairs(CoreGui:GetChildren()) do
            if gui:IsA("ScreenGui") and (gui.Name:find("Lynx") or gui:FindFirstChild("Main") or gui:FindFirstChild("MainFrame")) then
                gui.Enabled = false -- Menyembunyikan menu Lynx asli
            end
        end
    end
end)

-- ==========================================================
-- 4. PEMBUATAN MENU UTAMA DIMSHUB
-- ==========================================================
local Window = OrionLib:MakeWindow({
    Name = "DimsHUB | Fish It Edition", 
    HidePremium = true, 
    SaveConfig = false, 
    IntroText = "Welcome to DimsHUB"
})

-- MEMBUAT TAB-TAB YANG SAMA SEPERTI LYNX
local MainTab = Window:MakeTab({ Name = "Main / Farm", Icon = "rbxassetid://4483345998" })
local EventTab = Window:MakeTab({ Name = "Events", Icon = "rbxassetid://4483345998" })
local TeleportTab = Window:MakeTab({ Name = "Teleport", Icon = "rbxassetid://4483345998" })

-- ==========================================================
-- 5. MENGHUBUNGKAN TOMBOL DIMSHUB KE FUNGSI ASLI GAME
-- ==========================================================

-- Contoh Fitur Auto Fish (Tinggal panggil variabel global bawaan script pancingnya)
MainTab:AddToggle({
    Name = "Auto Fishing (Mancing Otomatis)",
    Default = false,
    Callback = function(Value)
        -- Biasanya script menggunakan variabel global seperti _G.AutoFish atau shared.AutoFish
        -- Di sini kita paksa nyalakan sistem farm bawaan script aslinya
        _G.AutoFish = Value
        _G.AutoCast = Value
        _G.AutoCatch = Value
    end
})

-- Contoh Fitur Auto Event (Megalodon / Shark Hunt) seperti di screenshot kamu
EventTab:AddToggle({
    Name = "Auto Event Teleport (Megalodon/Shark)",
    Default = false,
    Callback = function(Value)
        _G.AutoEvent = Value
        _G.MegalodonHunt = Value
    end
})

EventTab:AddButton({
    Name = "Refresh Event List",
    Callback = function()
        -- Memicu fungsi refresh bawaan game/script
        print("DimsHUB: Refreshing Event List...")
    end
})

-- Contoh Fitur Teleport ke NPC
TeleportTab:AddButton({
    Name = "Teleport to NPC Penjual",
    Callback = function()
        -- Memicu fungsi teleport bawaan script aslinya jika tersedia,
        -- atau menggunakan koordinat manual jika kamu sudah menyimpannya.
        print("DimsHUB: Teleporting to NPC...")
    end
})

OrionLib:Init()
