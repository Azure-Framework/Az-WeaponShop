Config = Config or {}

-- ------------------------------------------------------------
-- Branding / UI
-- ------------------------------------------------------------
Config.Shop = {
  BrandName   = "LS ARMORY",
  SubBrand    = "SUPPLY",
  DomainPill  = "www.lsarmory.net",
  RightTitle  = "WEAPON & ATTACHMENT SERVICE",
  RightSub    = "Select an item — we’ll equip it safely.",
}

-- Tabs shown in UI
Config.Categories = {
  { id = "featured", label = "Featured" },
  { id = "pistols",  label = "Pistols"  },
  { id = "smgs",     label = "SMGs"     },
  { id = "rifles",   label = "Rifles"   },
  { id = "shotguns", label = "Shotguns" },
  { id = "melee",    label = "Melee"    },
}

-- ------------------------------------------------------------
-- GTA V Ammu-Nation storefront locations (approx. vanilla)
-- ------------------------------------------------------------
Config.Locations = {
  { label="LS Armory (Pillbox Hill)",  coords=vector3(22.0, -1107.2, 29.8),  heading=160.0, pedModel=`s_m_y_ammucity_01`, scenario="WORLD_HUMAN_CLIPBOARD", blip={ enabled=true, sprite=110, color=3, scale=0.85, name="LS Armory" } },
  { label="LS Armory (Hawick)",        coords=vector3(252.3, -50.0, 69.9),   heading=70.0,  pedModel=`s_m_y_ammucity_01`, scenario="WORLD_HUMAN_CLIPBOARD", blip={ enabled=true, sprite=110, color=3, scale=0.85, name="LS Armory" } },
  { label="LS Armory (Little Seoul)",  coords=vector3(-662.1, -935.3, 21.8), heading=180.0, pedModel=`s_m_y_ammucity_01`, scenario="WORLD_HUMAN_CLIPBOARD", blip={ enabled=true, sprite=110, color=3, scale=0.85, name="LS Armory" } },
  { label="LS Armory (Morningwood)",   coords=vector3(-1306.2, -394.0, 36.7),heading=75.0,  pedModel=`s_m_y_ammucity_01`, scenario="WORLD_HUMAN_CLIPBOARD", blip={ enabled=true, sprite=110, color=3, scale=0.85, name="LS Armory" } },
  { label="LS Armory (Chumash)",       coords=vector3(-3172.6, 1087.8, 20.8),heading=245.0, pedModel=`s_m_y_ammucity_01`, scenario="WORLD_HUMAN_CLIPBOARD", blip={ enabled=true, sprite=110, color=3, scale=0.85, name="LS Armory" } },
  { label="LS Armory (Cypress Flats)", coords=vector3(810.2, -2157.3, 29.6), heading=0.0,   pedModel=`s_m_y_ammucity_01`, scenario="WORLD_HUMAN_CLIPBOARD", blip={ enabled=true, sprite=110, color=3, scale=0.85, name="LS Armory" } },
  { label="LS Armory (La Mesa)",       coords=vector3(842.4, -1033.4, 28.2), heading=0.0,   pedModel=`s_m_y_ammucity_01`, scenario="WORLD_HUMAN_CLIPBOARD", blip={ enabled=true, sprite=110, color=3, scale=0.85, name="LS Armory" } },
  { label="LS Armory (Sandy Shores)",  coords=vector3(1693.4, 3759.5, 34.7), heading=220.0, pedModel=`s_m_y_ammucity_01`, scenario="WORLD_HUMAN_CLIPBOARD", blip={ enabled=true, sprite=110, color=3, scale=0.85, name="LS Armory" } },
  { label="LS Armory (Grapeseed)",     coords=vector3(2567.6, 294.3, 108.7), heading=0.0,   pedModel=`s_m_y_ammucity_01`, scenario="WORLD_HUMAN_CLIPBOARD", blip={ enabled=true, sprite=110, color=3, scale=0.85, name="LS Armory" } },
  { label="LS Armory (Route 68)",      coords=vector3(-1117.5, 2698.6, 18.5),heading=0.0,   pedModel=`s_m_y_ammucity_01`, scenario="WORLD_HUMAN_CLIPBOARD", blip={ enabled=true, sprite=110, color=3, scale=0.85, name="LS Armory" } },
  { label="LS Armory (Paleto Bay)",    coords=vector3(-330.2, 6083.8, 31.4), heading=225.0, pedModel=`s_m_y_ammucity_01`, scenario="WORLD_HUMAN_CLIPBOARD", blip={ enabled=true, sprite=110, color=3, scale=0.85, name="LS Armory" } },
}

Config.Interaction = {
  UseOxTarget = false,   -- set true if you want ox_target zones (not required)
  Key = 38,              -- E
  Dist = 2.2,            -- slightly larger for reliability
  ShowMarker = false,
}

-- ------------------------------------------------------------
-- SAFE WEAPONS ONLY (NO explosives / rockets / grenades)
-- Images AUTO: https://docs.fivem.net/weapons/WEAPON_XXX.png
-- (client will fill "image" if omitted)
-- ------------------------------------------------------------

-- Attachments are GTA components (COMPONENT_*)
-- Some components only work for certain weapons; server validates.
Config.Weapons = {
  -- FEATURED
  {
    id="pistol",
    label="9mm Service Pistol",
    category="featured",
    weapon="WEAPON_PISTOL",
    price=25000,
    desc="Standard-issue sidearm. Reliable, easy to handle.",
    attachments={
      { id="flashlight", label="Flashlight", component="COMPONENT_AT_PI_FLSH", price=2500, desc="Improves visibility in low light." },
      { id="suppressor", label="Suppressor", component="COMPONENT_AT_PI_SUPP_02", price=9000, desc="Reduces report and recoil impulse." },
      { id="extclip",    label="Extended Mag", component="COMPONENT_PISTOL_CLIP_02", price=6000, desc="More rounds per magazine." },
    }
  },
  {
    id="combatpistol",
    label="Combat Pistol",
    category="pistols",
    weapon="WEAPON_COMBATPISTOL",
    price=32000,
    desc="Higher capacity and better ergonomics.",
    attachments={
      { id="flashlight", label="Flashlight", component="COMPONENT_AT_PI_FLSH", price=2500, desc="Improves visibility in low light." },
      { id="suppressor", label="Suppressor", component="COMPONENT_AT_PI_SUPP", price=9500, desc="Reduces report and recoil impulse." },
      { id="extclip",    label="Extended Mag", component="COMPONENT_COMBATPISTOL_CLIP_02", price=6500, desc="More rounds per magazine." },
    }
  },
  {
    id="appistol",
    label="Auto Pistol",
    category="pistols",
    weapon="WEAPON_APPISTOL",
    price=45000,
    desc="High rate-of-fire pistol for close quarters.",
    attachments={
      { id="flashlight", label="Flashlight", component="COMPONENT_AT_PI_FLSH", price=2500, desc="Improves visibility in low light." },
      { id="suppressor", label="Suppressor", component="COMPONENT_AT_PI_SUPP", price=10000, desc="Reduces report and recoil impulse." },
      { id="extclip",    label="Extended Mag", component="COMPONENT_APPISTOL_CLIP_02", price=7500, desc="More rounds per magazine." },
    }
  },

  -- SMGs
  {
    id="microsmg",
    label="Micro SMG",
    category="smgs",
    weapon="WEAPON_MICROSMG",
    price=62000,
    desc="Compact SMG. Great for vehicles and tight spaces.",
    attachments={
      { id="flashlight", label="Flashlight", component="COMPONENT_AT_PI_FLSH", price=2500, desc="Improves visibility in low light." },
      { id="suppressor", label="Suppressor", component="COMPONENT_AT_PI_SUPP", price=11000, desc="Reduces report." },
      { id="extclip",    label="Extended Mag", component="COMPONENT_MICROSMG_CLIP_02", price=9000, desc="More rounds per magazine." },
    }
  },
  {
    id="smg",
    label="SMG",
    category="smgs",
    weapon="WEAPON_SMG",
    price=78000,
    desc="Balanced automatic platform with good control.",
    attachments={
      { id="scope",      label="Scope", component="COMPONENT_AT_SCOPE_MACRO_02", price=8000, desc="Improves sight picture." },
      { id="flashlight", label="Flashlight", component="COMPONENT_AT_AR_FLSH", price=3000, desc="Improves visibility in low light." },
      { id="suppressor", label="Suppressor", component="COMPONENT_AT_PI_SUPP", price=12000, desc="Reduces report." },
      { id="extclip",    label="Extended Mag", component="COMPONENT_SMG_CLIP_02", price=11000, desc="More rounds per magazine." },
    }
  },

  -- RIFLES
  {
    id="carbinerifle",
    label="Carbine Rifle",
    category="rifles",
    weapon="WEAPON_CARBINERIFLE",
    price=125000,
    desc="Versatile rifle for medium-range engagements.",
    attachments={
      { id="scope",      label="Optic", component="COMPONENT_AT_SCOPE_MEDIUM", price=14000, desc="Improves target acquisition." },
      { id="flashlight", label="Flashlight", component="COMPONENT_AT_AR_FLSH", price=3000, desc="Improves visibility in low light." },
      { id="suppressor", label="Suppressor", component="COMPONENT_AT_AR_SUPP", price=16000, desc="Reduces report." },
      { id="grip",       label="Grip", component="COMPONENT_AT_AR_AFGRIP", price=9000, desc="Better stability under fire." },
      { id="extclip",    label="Extended Mag", component="COMPONENT_CARBINERIFLE_CLIP_02", price=15000, desc="More rounds per magazine." },
    }
  },
  {
    id="assaultrifle",
    label="Assault Rifle",
    category="rifles",
    weapon="WEAPON_ASSAULTRIFLE",
    price=135000,
    desc="Hard-hitting automatic rifle platform.",
    attachments={
      { id="scope",      label="Optic", component="COMPONENT_AT_SCOPE_MACRO", price=12000, desc="Improves target acquisition." },
      { id="flashlight", label="Flashlight", component="COMPONENT_AT_AR_FLSH", price=3000, desc="Improves visibility in low light." },
      { id="suppressor", label="Suppressor", component="COMPONENT_AT_AR_SUPP_02", price=16500, desc="Reduces report." },
      { id="grip",       label="Grip", component="COMPONENT_AT_AR_AFGRIP", price=9000, desc="Better stability under fire." },
      { id="extclip",    label="Extended Mag", component="COMPONENT_ASSAULTRIFLE_CLIP_02", price=15000, desc="More rounds per magazine." },
    }
  },

  -- SHOTGUNS
  {
    id="pumpshotgun",
    label="Pump Shotgun",
    category="shotguns",
    weapon="WEAPON_PUMPSHOTGUN",
    price=68000,
    desc="Close-range powerhouse with classic pump action.",
    attachments={
      { id="flashlight", label="Flashlight", component="COMPONENT_AT_AR_FLSH", price=3000, desc="Improves visibility in low light." },
      { id="suppressor", label="Suppressor", component="COMPONENT_AT_SR_SUPP", price=14000, desc="Reduces report." },
    }
  },
  {
    id="sawnoff",
    label="Sawed-Off Shotgun",
    category="shotguns",
    weapon="WEAPON_SAWNOFFSHOTGUN",
    price=54000,
    desc="Compact shotgun for extreme close quarters.",
    attachments={}
  },

  -- MELEE
  {
    id="knife",
    label="Utility Knife",
    category="melee",
    weapon="WEAPON_KNIFE",
    price=2500,
    desc="Basic utility blade.",
    attachments={}
  },
  {
    id="bat",
    label="Aluminum Bat",
    category="melee",
    weapon="WEAPON_BAT",
    price=4500,
    desc="Lightweight and durable.",
    attachments={}
  },
}

-- Hard-block these even if accidentally added
Config.BlockedWeapons = {
  "WEAPON_RPG",
  "WEAPON_HOMINGLAUNCHER",
  "WEAPON_GRENADE",
  "WEAPON_STICKYBOMB",
  "WEAPON_PIPEBOMB",
  "WEAPON_PROXMINE",
  "WEAPON_MOLOTOV",
  "WEAPON_COMPACTLAUNCHER",
  "WEAPON_RAILGUN",
  "WEAPON_MINIGUN",
  "WEAPON_GRENADELAUNCHER",
  "WEAPON_GRENADELAUNCHER_SMOKE",
}
