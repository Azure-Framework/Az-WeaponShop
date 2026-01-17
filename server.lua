local function lower(s) return (s and string.lower(s)) or "" end

local function isBlockedWeapon(name)
  for _, w in ipairs(Config.BlockedWeapons or {}) do
    if lower(w) == lower(name) then return true end
  end
  return false
end

local function findWeaponById(id)
  for _, w in ipairs(Config.Weapons or {}) do
    if w.id == id then return w end
  end
end

local function findAttachment(weaponEntry, attId)
  if not weaponEntry or not weaponEntry.attachments then return nil end
  for _, a in ipairs(weaponEntry.attachments) do
    if a.id == attId then return a end
  end
end

local function giveWeaponAndAmmo(src, weaponName)
  local ped = GetPlayerPed(src)
  if not ped or ped == 0 then return false, "Player ped not found." end

  local hash = GetHashKey(weaponName)
  if hash == 0 then return false, "Invalid weapon." end

  
  GiveWeaponToPed(ped, hash, 120, false, true)
  return true
end

local function giveComponent(src, weaponName, componentName)
  local ped = GetPlayerPed(src)
  if not ped or ped == 0 then return false, "Player ped not found." end

  local weaponHash = GetHashKey(weaponName)
  local compHash = GetHashKey(componentName)

  if weaponHash == 0 or compHash == 0 then
    return false, "Invalid attachment."
  end

  
  GiveWeaponComponentToPed(ped, weaponHash, compHash)
  return true
end

lib.callback.register('ls-armory:purchase', function(src, payload)
  if type(payload) ~= "table" then
    return { ok=false, msg="Bad request." }
  end

  local kind = payload.kind
  if kind ~= "weapon" and kind ~= "attachment" then
    return { ok=false, msg="Bad request." }
  end

  local weaponId = payload.weaponId
  local weaponEntry = findWeaponById(weaponId)
  if not weaponEntry then
    return { ok=false, msg="Item not found." }
  end

  local weaponName = weaponEntry.weapon
  if not weaponName or isBlockedWeapon(weaponName) then
    return { ok=false, msg="That item is not available." }
  end

  
  local price = 0
  if kind == "weapon" then
    price = tonumber(weaponEntry.price) or 0
  else
    local att = findAttachment(weaponEntry, payload.attachmentId)
    if not att then return { ok=false, msg="Attachment not found." } end
    price = tonumber(att.price) or 0
  end

  if Config.UsePayments then
    if not Config.CanAfford(src, price) then
      return { ok=false, msg=("Not enough %s."):format(Config.PaymentLabel or "money") }
    end
    local removed = Config.RemoveMoney(src, price)
    if not removed then
      return { ok=false, msg="Payment failed." }
    end
  end

  if kind == "weapon" then
    local ok, err = giveWeaponAndAmmo(src, weaponName)
    if not ok then return { ok=false, msg=err or "Could not equip weapon." } end
    return { ok=true, msg=("Purchased %s."):format(weaponEntry.label) }
  else
    local att = findAttachment(weaponEntry, payload.attachmentId)
    local ok, err = giveComponent(src, weaponName, att.component)
    if not ok then return { ok=false, msg=err or "Could not apply attachment." } end
    return { ok=true, msg=("Installed %s."):format(att.label) }
  end
end)
