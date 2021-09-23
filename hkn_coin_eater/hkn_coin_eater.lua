local addonName = 'hknCoinEater'
local addonVersion = '1.0.0'
local debug = false

local targets = {
    'misc_pvp_mine2',
    'reputation_Coin', 
    'GabijaCertificateCoin_1p',
    'GabijaCertificateCoin_100p',
    'GabijaCertificateCoin_1000p',
    'GabijaCertificateCoin_5000p',
    'GabijaCertificateCoin_10000p',
    'GabijaCertificateCoin_50000p'
}

local towns = {
    c_Klaipe = true,
    c_orsha = true,
    c_fedimian = true
}

local reserveCommandDelay = 0

local function LOGGER(fmt, ...)
    local fmt = '[%s] ' .. fmt
    CHAT_SYSTEM(fmt:format(addonName, ...))
end

local function LOGGER_DBG(fmt, ...)
    if not debug then
        return false
    end
    LOGGER(fmt, ...)
end

local function RESERVE_COMMAND(cmd, ...)
    reserveCommandDelay = reserveCommandDelay + 2
    ReserveScript(cmd:format(...), reserveCommandDelay)
end

local function IS_IN_TOWN()
    local mapName = session.GetMapName()
    if mapName and towns[mapName] then
        return true
    end
    return false
end

local function HAS_ITEM(name)
    if session.GetInvItemByName(name) then
        return true
    end
    return false
end

local function USE_INV_ITEM(name)
    if not HAS_ITEM(name) then
        return false
    end
    LOGGER_DBG('INV_ICON_USE => %s', name)
    RESERVE_COMMAND("INV_ICON_USE(session.GetInvItemByName('%s'))", name)
end

LOGGER('v%s Loaded', addonVersion)

function HKN_COIN_EATER_ON_INIT(addon, frame)
    if not IS_IN_TOWN() then
        return false
    end
    for i = 1, #targets do
        USE_INV_ITEM(targets[i])
    end
end
