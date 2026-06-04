-- ==========================================================
--          DimsHUB - STABLE & SAFE VERSION (ANTI-ERROR)
-- ==========================================================

-- 1. LOAD ORION UI LIBRARY (Menu Utama DimsHUB)
local OrionLib = loadstring(game:HttpGet(("https://raw.githubusercontent.com/jensonhirst/Orion/main/source")))()

-- Pembersih Teks Console standar
local function cleanText(text)
    if type(text) == "string" then return text:gsub("Lynx", "DimsHUB") end
    return text
end
print = function(...)
    local args = {...}
    for i, v in ipairs(args) do args[i] = cleanText(v) end
    return print(table.unpack(args))
end

-- 2. JALANKAN SCRIPT ASLI LYNX DI LATAR BELAKANG
task.spawn(function()
    pcall(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/4LynxX/all_Game/refs/heads/main/Fish_It.lua"))()
    end)
end)

-- 3. BIKIN WINDOW UTAMA DIMSHUB
local Window = OrionLib:MakeWindow({
    Name = "DimsHUB | Fish It Edition", 
    HidePremium = true, 
    SaveConfig = false, 
    IntroText = "Welcome to DimsHUB"
})

-- TAB KONTROL
local ControlTab = Window:MakeTab({
    Name = "Menu Controller",
    Icon = "rbxassetid://4483345998"
})

-- ==========================================================
--                   FITUR TOMBOL SAKLAR MENU
-- ==========================================================

ControlTab:AddToggle({
    Name = "Tampilkan Menu Fitur (Lynx Menu)",
    Default = true,
    Callback = function(Value)
        -- Mencari UI bawaan game/Lynx secara aman tanpa merusak script
        local CoreGui = game:GetService("CoreGui")
        for _, gui in ipairs(CoreGui:GetChildren()) do
            if gui:IsA("ScreenGui") and (gui.Name:find("Lynx") or gui:FindFirstChild("MainFrame") or gui:FindFirstChild("Main")) then
                gui.Enabled = Value -- true untuk muncul, false untuk sembunyi
            end
        end
    end
})

ControlTab:AddButton({
    Name = "Sembunyikan Semua UI (Clean Screen)",
    Callback = function()
        -- Mematikan sementara menu DimsHUB jika layar HP kepenuhan
        OrionLib:Destroy()
    end
})

OrionLib:Init()
