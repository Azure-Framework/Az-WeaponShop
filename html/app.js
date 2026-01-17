const app = document.getElementById("app");
const grid = document.getElementById("grid");
const tabs = document.getElementById("tabs");
const searchInput = document.getElementById("searchInput");
const sortSelect = document.getElementById("sortSelect");

const closeBtn = document.getElementById("closeBtn");
const closeBottom = document.getElementById("closeBottom");

const domainPill = document.getElementById("domainPill");
const brandName = document.getElementById("brandName");
const brandSub = document.getElementById("brandSub");
const rightTitle = document.getElementById("rightTitle");
const rightSub = document.getElementById("rightSub");

const modal = document.getElementById("modal");
const modalBackdrop = document.getElementById("modalBackdrop");
const modalX = document.getElementById("modalX");
const modalTitle = document.getElementById("modalTitle");
const modalDesc = document.getElementById("modalDesc");
const modalPrice = document.getElementById("modalPrice");
const attList = document.getElementById("attList");
const buyWeaponBtn = document.getElementById("buyWeaponBtn");

let state = {
  resourceName: (window.GetParentResourceName ? GetParentResourceName() : ''),
  open: false,
  categories: [],
  weapons: [],
  activeCat: "featured",
  search: "",
  sort: "name",
  selected: null,
  shop: null
};

function money(n){
  const v = Number(n || 0);
  return "$" + v.toLocaleString();
}

function postNui(name, data = {}) {
  return fetch(`https://${GetParentResourceName()}/${name}`, {
    method: "POST",
    headers: { "Content-Type": "application/json; charset=UTF-8" },
    body: JSON.stringify(data),
  }).then(r => r.json()).catch(() => ({ ok:false }));
}

function setOpen(v){
  state.open = v;
  app.classList.toggle("hidden", !v);
  if (!v) closeModal();
}

function setShopText(shop){
  if (!shop) return;
  domainPill.textContent = shop.DomainPill || "www.lsarmory.net";
  brandName.textContent  = shop.BrandName || "LS ARMORY";
  brandSub.textContent   = shop.SubBrand || "SUPPLY";
  rightTitle.textContent = shop.RightTitle || "WEAPON SERVICE";
  rightSub.textContent   = shop.RightSub || "";
}

function renderTabs(){
  tabs.innerHTML = "";
  state.categories.forEach(cat => {
    const b = document.createElement("button");
    b.className = "tab" + (state.activeCat === cat.id ? " active" : "");
    b.textContent = cat.label;
    b.onclick = () => {
      state.activeCat = cat.id;
      renderTabs();
      renderGrid();
    };
    tabs.appendChild(b);
  });
}

function filteredWeapons(){
  const s = (state.search || "").trim().toLowerCase();

  let items = state.weapons.filter(w => {
    if (state.activeCat === "featured") {
      return w.category === "featured" || w.category === "pistols";
    }
    return w.category === state.activeCat;
  });

  if (s.length) {
    items = items.filter(w =>
      (w.label || "").toLowerCase().includes(s) ||
      (w.weapon || "").toLowerCase().includes(s) ||
      (w.desc || "").toLowerCase().includes(s)
    );
  }

  const sort = state.sort;
  items.sort((a,b) => {
    if (sort === "priceAsc") return (a.price||0) - (b.price||0);
    if (sort === "priceDesc") return (b.price||0) - (a.price||0);
    return (a.label || "").localeCompare(b.label || "");
  });

  return items;
}

function renderGrid(){
  const items = filteredWeapons();
  grid.innerHTML = "";

  items.forEach(w => {
    const card = document.createElement("div");
    card.className = "card";
    card.onclick = () => openModal(w);

    const media = document.createElement("div");
    media.className = "cardMedia";
    const img = w.image || (w.weapon ? `https://docs.fivem.net/weapons/${w.weapon}.png` : "assets/weapon_placeholder.svg");
    media.style.backgroundImage = `url(${img})`;

    const overlay = document.createElement("div");
    overlay.className = "cardOverlay";

    const top = document.createElement("div");
    top.className = "cardTop";
    top.innerHTML = `
      <div>
        <div class="brandMini">LS ARMORY</div>
        <div class="brandMiniSub">SUPPLY</div>
      </div>
      <div class="priceTag">${money(w.price)}</div>
    `;

    const bottom = document.createElement("div");
    bottom.className = "cardBottom";

    const left = document.createElement("div");
    left.innerHTML = `
      <div class="itemName">${w.label}</div>
      <div class="itemMeta">${(w.weapon || "").replace("WEAPON_","")} • ${(w.attachments?.length||0)} attachments</div>
    `;

    const actions = document.createElement("div");
    actions.className = "cardActions";

    const st = document.createElement("div");
    st.className = "statePill";
    st.textContent = "Ready";

    const btn = document.createElement("button");
    btn.className = "callBtn";
    btn.textContent = "Buy";
    btn.onclick = (e) => {
      e.stopPropagation();
      openModal(w);
    };

    actions.appendChild(st);
    actions.appendChild(btn);

    bottom.appendChild(left);
    bottom.appendChild(actions);

    card.appendChild(media);
    card.appendChild(overlay);
    card.appendChild(top);
    card.appendChild(bottom);

    grid.appendChild(card);
  });
}

function openModal(w){
  state.selected = w;
  modalTitle.textContent = w.label || "Item";
  modalDesc.textContent  = w.desc || "";
  modalPrice.textContent = money(w.price || 0);

  attList.innerHTML = "";
  const atts = w.attachments || [];
  if (!atts.length){
    const empty = document.createElement("div");
    empty.style.color = "rgba(255,255,255,.6)";
    empty.style.fontSize = "12px";
    empty.style.padding = "8px";
    empty.textContent = "No attachments available for this item.";
    attList.appendChild(empty);
  } else {
    atts.forEach(a => {
      const row = document.createElement("div");
      row.className = "att";
      row.innerHTML = `
        <div class="left">
          <div class="name">${a.label}</div>
          <div class="desc">${a.desc || ""}</div>
        </div>
        <div class="right">
          <div class="cost">${money(a.price)}</div>
          <button class="btn">Install</button>
        </div>
      `;
      row.querySelector(".btn").onclick = async (e) => {
        e.stopPropagation();
        await postNui("purchase", { kind:"attachment", weaponId: w.id, attachmentId: a.id });
      };
      attList.appendChild(row);
    });
  }

  buyWeaponBtn.onclick = async () => {
    await postNui("purchase", { kind:"weapon", weaponId: w.id });
  };

  modal.classList.remove("hidden");
}

function closeModal(){
  state.selected = null;
  modal.classList.add("hidden");
}

function closeAll(){
  postNui("close", {});
}

closeBtn.onclick = closeAll;
closeBottom.onclick = closeAll;

modalBackdrop.onclick = closeModal;
modalX.onclick = closeModal;

searchInput.oninput = (e) => {
  state.search = e.target.value || "";
  renderGrid();
};
sortSelect.onchange = (e) => {
  state.sort = e.target.value;
  renderGrid();
};

document.addEventListener("keydown", (e) => {
  if (!state.open) return;
  if (e.key === "Escape") {
    if (!modal.classList.contains("hidden")) closeModal();
    else closeAll();
  }
});

window.addEventListener("message", (event) => {
  const msg = event.data || {};
  if (msg.app !== state.resourceName) return;
  if (msg.action === "open") {
    state.shop = msg.shop || null;
    state.categories = msg.categories || [];
    state.weapons = msg.weapons || [];
    state.activeCat = (state.categories?.[0]?.id) || "featured";
    state.search = "";
    state.sort = "name";
    searchInput.value = "";
    sortSelect.value = "name";

    setShopText(state.shop);
    app.classList.remove("hidden");
    renderTabs();
    renderGrid();
  }

  if (msg.action === "close") {
    app.classList.add("hidden");
    closeModal();
  }
});
