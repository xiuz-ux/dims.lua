-- ==========================================================
--               DimsHUB - SOLITARY FISH LOADER             
-- ==========================================================

local VERSION = "1.0"
local HUB_NAME = "DimsHUB"

local games = {
    [6701277882] = "https://raw.githubusercontent.com/4LynxX/all_Game/refs/heads/main/Fish_It.lua"
}

-- ==========================================================
--               CORE CLEANER & TEXT REPLACER
-- ==========================================================
local function cleanText(text)
    if type(text) == "string" then
        text = text:gsub("Lynxx", "DimsHUB")
                   :gsub("lynxx", "DimsHUB")
                   :gsub("Lynx", "DimsHUB")
                   :gsub("lynx", "DimsHUB")
                   :gsub("4LynxX", "DimsHUB")
    end
    return text
end

-- 1. BAJAK CONSOLE (PRINT & WARN)
local oldPrint = print
print = function(...)
    local args = {...}
    for i, v in ipairs(args) do args[i] = cleanText(v) end
    return oldPrint(table.unpack(args))
end

local oldWarn = warn
warn = function(...)
    local args = {...}
    for i, v in ipairs(args) do args[i] = cleanText(v) end
    return oldWarn(table.unpack(args))
end

if rconsoleprint then
    local oldRprint = rconsoleprint
    rconsoleprint = function(text) return oldRprint(cleanText(text)) end
end

-- ==========================================================
-- 2. BAJAK INSTANCE GUI ROBLOX (MENGHAPUS TEKS DI MENU / UI)
-- ==========================================================
local mt = getrawmetatable(game)
local old_index = mt.__index
local old_newindex = mt.__newindex
setreadonly(mt, false)

-- Mencegat saat script Lynx mencoba memasukkan nama teks ke menu UI
mt.__newindex = newcclosure(function(t, k, v)
    if (k == "Text" or k == "Name") and type(v) == "string" then
        v = cleanText(v)
    end
    return old_newindex(t, k, v)
end)

-- Mencegat saat script membaca properti nama teks
mt.__index = newcclosure(function(t, k)
    local val = old_index(t, k)
    if (k == "Text" or k == "Name") and type(val) == "string" then
        return cleanText(val)
    end
    return val
end)

setreadonly(mt, true)

-- ==========================================================
-- EXECUTION LOGIC
-- ==========================================================
local universeId = game.GameId
local placeId    = game.PlaceId
local scriptURL  = games[universeId]

print(string.format("[%s v%s] PlaceId: %d | UniverseId: %d", HUB_NAME, VERSION, placeId, universeId))

if scriptURL then
    print(string.format("[%s] Game supported! UniverseId: %d", HUB_NAME, universeId))
    print(string.format("[%s] Loading script...", HUB_NAME))
    
    local ok, err = pcall(function()
        loadstring(game:HttpGet(scriptURL))()
    end)
    
    if not ok then
        warn(string.format("[%s] Gagal load script: %s", HUB_NAME, tostring(err)))
    end
else
    local msg = string.format("\n[%s] Game belum didukung!", HUB_NAME)
    warn(msg)
end
