local uiOpen = false
local peds = {}
local points = {}

local RESOURCE = GetCurrentResourceName()
local DOCS_WEAPON_IMG = "https://docs.fivem.net/weapons/%s.png"

local function makeBlip(loc)
  if not loc.blip or not loc.blip.enabled then return end
  local blip = AddBlipForCoord(loc.coords.x, loc.coords.y, loc.coords.z)
  SetBlipSprite(blip, loc.blip.sprite or 110)
  SetBlipDisplay(blip, 4)
  SetBlipScale(blip, loc.blip.scale or 0.85)
  SetBlipColour(blip, loc.blip.color or 3)
  SetBlipAsShortRange(blip, true)
  BeginTextCommandSetBlipName("STRING")
  AddTextComponentString(loc.blip.name or "LS Armory")
  EndTextCommandSetBlipName(blip)
end

local function loadModel(model)
  local hash = type(model) == "number" and model or joaat(model)
  RequestModel(hash)
  while not HasModelLoaded(hash) do Wait(0) end
  return hash
end

local function spawnPed(loc)
  local hash = loadModel(loc.pedModel or `s_m_y_ammucity_01`)
  local ped = CreatePed(4, hash, loc.coords.x, loc.coords.y, loc.coords.z - 1.0, loc.heading or 0.0, false, true)
  SetEntityInvincible(ped, true)
  SetBlockingOfNonTemporaryEvents(ped, true)
  FreezeEntityPosition(ped, true)
  if loc.scenario then
    TaskStartScenarioInPlace(ped, loc.scenario, 0, true)
  end
  SetModelAsNoLongerNeeded(hash)
  return ped
end

local function buildWeaponsForUI()
  local out = {}
  for _, w in ipairs(Config.Weapons or {}) do
    local copy = {}
    for k,v in pairs(w) do copy[k] = v end

    
    if not copy.image or copy.image == "" then
      if copy.weapon and type(copy.weapon) == "string" then
        copy.image = DOCS_WEAPON_IMG:format(copy.weapon)
      end
    end

    
    if not copy.attachments then copy.attachments = {} end

    out[#out+1] = copy
  end
  return out
end

local function setUI(state)
  uiOpen = state
  SetNuiFocus(state, state)
  SetNuiFocusKeepInput(state)

  if state then
    SendNUIMessage({
      app = RESOURCE,
      action = "open",
      shop = Config.Shop,
      categories = Config.Categories,
      weapons = buildWeaponsForUI()
    })
  else
    SendNUIMessage({ app = RESOURCE, action = "close" })
  end
end

local function isNearShop()
  local ped = PlayerPedId()
  local pcoords = GetEntityCoords(ped)
  local best = 9999.0

  for _, shopPed in ipairs(peds) do
    if shopPed and shopPed ~= 0 and DoesEntityExist(shopPed) then
      local c = GetEntityCoords(shopPed)
      local d = #(pcoords - c)
      if d < best then best = d end
    end
  end

  return best <= (Config.Interaction.Dist or 2.2), best
end

CreateThread(function()
  for _, loc in ipairs(Config.Locations or {}) do
    makeBlip(loc)
    local ped = spawnPed(loc)
    peds[#peds+1] = ped

    
    local pt = lib.points.new({
      coords = loc.coords,
      distance = (Config.Interaction.Dist or 2.2) + 1.25
    })

    function pt:onEnter()
      lib.showTextUI(("[E] %s"):format(loc.label or "Open LS Armory"), { position = "left-center" })
    end

    function pt:onExit()
      lib.hideTextUI()
    end

    function pt:nearby()
      if uiOpen then return end
      
      local checkCoords = loc.coords
      if ped and DoesEntityExist(ped) then checkCoords = GetEntityCoords(ped) end

      local playerPed = PlayerPedId()
      local pcoords = GetEntityCoords(playerPed)
      local d = #(pcoords - checkCoords)

      if d <= (Config.Interaction.Dist or 2.2) then
        if IsControlJustReleased(0, Config.Interaction.Key or 38) then
          setUI(true)
        end
      end
    end

    points[#points+1] = pt
  end
end)


RegisterCommand("armory", function()
  if uiOpen then
    setUI(false)
    return
  end
  local ok = isNearShop()
  if not ok then
    lib.notify({ title = "LS Armory", description = "You must be at a weapon shop.", type = "error" })
    return
  end
  setUI(true)
end, false)

RegisterNUICallback("close", function(_, cb)
  setUI(false)
  cb({ ok = true })
end)

RegisterNUICallback("purchase", function(data, cb)
  local res = lib.callback.await('ls-armory:purchase', false, data)
  if res and res.ok then
    lib.notify({ title = "LS Armory", description = res.msg or "Success", type = "success" })
  else
    lib.notify({ title = "LS Armory", description = (res and res.msg) or "Failed", type = "error" })
  end
  cb(res or { ok=false, msg="No response." })
end)
