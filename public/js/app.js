/* ============================================================
   APP.JS — Router SPA + navegación + búsqueda live
============================================================ */

/* ── Estado global ───────────────────────────────────────── */
const state = {
  cart:        [],
  currentView: 'home',
};

/* ── Router ──────────────────────────────────────────────── */
const app = document.getElementById('app');

async function navigate(path, pushState = true) {
  try {
    showLoading();

    const url = buildEndpoint(path);
    const res  = await fetch(url, { headers: { 'Accept': 'text/html' } });
    const html = await res.text();

    app.innerHTML = html;

    /* Lee el breadcrumb que Prolog puso en data-breadcrumb */
    const pageBody = app.querySelector('[data-breadcrumb]');
    if (pageBody) {
      const bc = document.getElementById('breadcrumb-current');
      if (bc) bc.textContent = pageBody.dataset.breadcrumb;
    }

    if (pushState) history.pushState({ path }, '', path);
    updateActiveNav(path);
    attachViewEvents();
    window.scrollTo({ top: 0, behavior: 'smooth' });

  } catch (err) {
    app.innerHTML = renderError('No se pudo cargar la vista.');
  }
}

function buildEndpoint(path) {
  if (path.startsWith('/section/')) {
    const id = path.replace('/section/', '');
    return `/views/section?id=${id}`;
  }
  if (path === '/' || path === '') return '/views/home';
  return `/views${path}`;
}

/* Intercept clicks en links internos */
document.addEventListener('click', e => {
  const link = e.target.closest('[data-link]');
  if (!link) return;
  e.preventDefault();
  const path = link.dataset.link;
  navigate(path);
});

/* Botón atrás/adelante del navegador */
window.addEventListener('popstate', e => {
  if (e.state?.path) navigate(e.state.path, false);
});

/* ── Sidebar ─────────────────────────────────────────────── */
function initSidebar() {
  const sidebar  = document.getElementById('sidebar');
  const menuBtn  = document.getElementById('menu-btn');
  const overlay  = document.getElementById('sidebar-overlay');

  if (!menuBtn || !sidebar) return;

  menuBtn.addEventListener('click', () => {
    sidebar.classList.toggle('open');
    overlay.classList.toggle('open');
  });

  overlay?.addEventListener('click', () => {
    sidebar.classList.remove('open');
    overlay.classList.remove('open');
  });
}

function updateActiveNav(path) {
  document.querySelectorAll('.nav-link').forEach(link => {
    link.classList.remove('active');
    const linkPath = link.dataset.link || '';
    if (path === linkPath || (path === '/' && linkPath === '/')) {
      link.classList.add('active');
    }
  });
}

/* ── Búsqueda live ───────────────────────────────────────── */
function initSearch() {
  const input    = document.getElementById('search-input');
  const clearBtn = document.getElementById('search-clear');
  const results  = document.getElementById('search-results');

  if (!input) return;

  let debounceTimer;

  input.addEventListener('input', e => {
    const q = e.target.value.trim();
    clearBtn?.classList.toggle('visible', !!q);
    clearTimeout(debounceTimer);
    if (!q) { hideSearchResults(); return; }
    debounceTimer = setTimeout(() => fetchSearch(q), 300);
  });

  clearBtn?.addEventListener('click', () => {
    input.value = '';
    clearBtn.classList.remove('visible');
    hideSearchResults();
  });
}

async function fetchSearch(query) {
  try {
    const res  = await fetch(`/api/buscar?q=${encodeURIComponent(query)}`);
    const data = await res.json();
    renderSearchResults(data.resultados || []);
  } catch {
    hideSearchResults();
  }
}

function renderSearchResults(resultados) {
  const results = document.getElementById('search-results');
  if (!results) return;

  if (!resultados.length) {
    results.innerHTML = `
      <div class="search-empty">
        <span>😕</span> Sin resultados
      </div>`;
    results.classList.add('visible');
    return;
  }

  results.innerHTML = resultados.map(r => `
    <button class="search-result-item" data-link="/section/${r.seccion}">
      <div class="search-result-nombre">${r.nombre}</div>
      <div class="search-result-meta">${r.marca} · $${r.precio}</div>
    </button>
  `).join('');

  results.classList.add('visible');
}

function hideSearchResults() {
  const results = document.getElementById('search-results');
  if (results) results.classList.remove('visible');
}

document.addEventListener('click', e => {
  if (!e.target.closest('.search-wrapper')) hideSearchResults();
});

/* ── Carrito ─────────────────────────────────────────────── */
function addToCart(nombre, marca, precio) {
  const existing = state.cart.find(i => i.nombre === nombre);
  if (existing) {
    existing.cantidad++;
  } else {
    state.cart.push({ nombre, marca, precio: Number(precio), cantidad: 1 });
  }
  updateCartBadge();
  showCartToast(nombre);
}

function removeFromCart(nombre) {
  state.cart = state.cart.filter(i => i.nombre !== nombre);
  updateCartBadge();
}

function updateCartBadge() {
  const badge = document.getElementById('cart-badge');
  if (!badge) return;
  const total = state.cart.reduce((acc, i) => acc + i.cantidad, 0);
  badge.textContent = total;
  badge.classList.toggle('visible', total > 0);
}

function cartTotal() {
  return state.cart
    .reduce((acc, i) => acc + i.precio * i.cantidad, 0)
    .toFixed(2);
}

function showCartToast(nombre) {
  const toast = document.createElement('div');
  toast.className = 'cart-toast';
  toast.innerHTML = `🛒 <strong>${nombre}</strong> agregado al carrito`;
  document.body.appendChild(toast);
  setTimeout(() => toast.classList.add('visible'), 10);
  setTimeout(() => {
    toast.classList.remove('visible');
    setTimeout(() => toast.remove(), 300);
  }, 2500);
}

/* ── Eventos dinámicos post-navegación ───────────────────── */
function attachViewEvents() {
  document.querySelectorAll('[data-add-cart]').forEach(btn => {
    btn.addEventListener('click', () => {
      const { nombre, marca, precio } = btn.dataset;
      addToCart(nombre, marca, precio);
    });
  });

  initSearch();
  updateCartBadge();
}

/* ── Loading state ───────────────────────────────────────── */
function showLoading() {
  app.innerHTML = `
    <div class="page-body">
      <div class="skeleton" style="height:2rem;width:40%;margin-bottom:var(--space-4)"></div>
      <div class="skeleton" style="height:1rem;width:60%;margin-bottom:var(--space-8)"></div>
      <div style="display:grid;grid-template-columns:repeat(3,1fr);gap:var(--space-4)">
        ${Array(6).fill('<div class="skeleton" style="height:200px;border-radius:var(--radius-xl)"></div>').join('')}
      </div>
    </div>`;
}

/* ── Error state ─────────────────────────────────────────── */
function renderError(msg) {
  return `
    <div class="empty-state">
      <div class="empty-state-icon">⚠️</div>
      <div class="empty-state-title">Algo salió mal</div>
      <div class="empty-state-desc">${msg}</div>
      <button class="btn btn-primary" onclick="navigate('/')">Volver al inicio</button>
    </div>`;
}

/* ── Estilos dinámicos ───────────────────────────────────── */
const toastStyle = document.createElement('style');
toastStyle.textContent = `
  .cart-toast {
    position: fixed;
    bottom: var(--space-6);
    left: 50%;
    transform: translateX(-50%) translateY(20px);
    background: var(--primary);
    color: var(--on-primary);
    padding: var(--space-3) var(--space-6);
    border-radius: var(--radius-full);
    font-size: var(--text-body-md);
    font-weight: var(--weight-medium);
    box-shadow: var(--shadow-lg);
    opacity: 0;
    transition: opacity var(--transition-base), transform var(--transition-base);
    z-index: 9999;
    white-space: nowrap;
  }
  .cart-toast.visible {
    opacity: 1;
    transform: translateX(-50%) translateY(0);
  }
  .search-results {
    position: absolute;
    top: calc(100% + var(--space-2));
    left: 0;
    right: 0;
    background: var(--surface-container-lowest);
    border-radius: var(--radius-xl);
    box-shadow: var(--shadow-lg);
    z-index: 200;
    display: none;
    overflow: hidden;
    max-height: 360px;
    overflow-y: auto;
  }
  .search-results.visible { display: block; }
  .search-result-item {
    display: flex;
    flex-direction: column;
    gap: 2px;
    width: 100%;
    padding: var(--space-3) var(--space-5);
    background: none;
    border: none;
    cursor: pointer;
    text-align: left;
    transition: background var(--transition-fast);
  }
  .search-result-item:hover { background: var(--surface-container); }
  .search-result-nombre {
    font-weight: var(--weight-semibold);
    color: var(--on-surface);
    font-size: var(--text-body-md);
  }
  .search-result-meta {
    font-size: var(--text-label-md);
    color: var(--on-surface-variant);
    text-transform: none;
    letter-spacing: 0;
  }
  .search-empty {
    padding: var(--space-6);
    text-align: center;
    color: var(--on-surface-variant);
    font-size: var(--text-body-md);
    display: flex;
    align-items: center;
    justify-content: center;
    gap: var(--space-2);
  }
`;
document.head.appendChild(toastStyle);

/* ── Init ────────────────────────────────────────────────── */
(function init() {
  initSidebar();
  initSearch();
  const path = window.location.pathname || '/';
  navigate(path, false);
  document.getElementById('topbar-back')?.addEventListener('click', () => history.back());
})();