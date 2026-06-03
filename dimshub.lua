-- ==========================================================
--               DimsHUB - SOLITARY FISH LOADER             
-- ==========================================================

local VERSION = "1.0"
local HUB_NAME = "DimsHUB"

-- Kami persempit hanya untuk game Fish It saja
local games = {
    [6701277882] = "https://raw.githubusercontent.com/4LynxX/all_Game/refs/heads/main/Fish_It.lua"
}

-- ==========================================================
-- SYSTEM ANTI-LYNX HOOK (MEMBAJAK SEMUA OUTPUT TEXT)
-- ==========================================================
local function cleanText(text)
    if type(text) == "string" then
        -- Membersihkan semua variasi nama Lynx
        text = text:gsub("Lynxx", "DimsHUB")
                   :gsub("lynxx", "DimsHUB")
                   :gsub("Lynx", "DimsHUB")
                   :gsub("lynx", "DimsHUB")
                   :gsub("4LynxX", "DimsHUB")
    end
    return text
end

-- Membajak fungsi print bawaan
local oldPrint = print
print = function(...)
    local args = {...}
    for i, v in ipairs(args) do
        args[i] = cleanText(v)
    end
    return oldPrint(table.unpack(args))
end

-- Membajak fungsi warn bawaan
local oldWarn = warn
warn = function(...)
    local args = {...}
    for i, v in ipairs(args) do
        args[i] = cleanText(v)
    end
    return oldWarn(table.unpack(args))
end

-- Membajak rconsoleprint jika kamu pakai executor PC/Android tertentu
if rconsoleprint then
    local oldRprint = rconsoleprint
    rconsoleprint = function(text)
        return oldRprint(cleanText(text))
    end
end
-- ==========================================================

-- EXECUTION LOGIC
local universeId = game.GameId
local placeId    = game.PlaceId
local scriptURL  = games[universeId]

print(string.format("[%s v%s] PlaceId: %d | UniverseId: %d", HUB_NAME, VERSION, placeId, universeId))

if scriptURL then
    print(string.format("[%s] Game supported! UniverseId: %d", HUB_NAME, universeId))
    print(string.format("[%s] Loading script...", HUB_NAME))
    
    local ok, err = pcall(function()
        -- Menjalankan script pancing asli sambil diproteksi oleh hook di atas
        loadstring(game:HttpGet(scriptURL))()
    end)
    
    if not ok then
        warn(string.format("[%s] Gagal load script: %s", HUB_NAME, tostring(err)))
    end
else
    local msg = string.format(
        "\n[%s] Game belum didukung!\nPlaceId: %d\nUniverseId: %d!",
        HUB_NAME, placeId, universeId
    )
    warn(msg)
    print(msg)
end
