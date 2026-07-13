/* ============================================================
   APP.JS — Router SPA + navegación + búsqueda live
============================================================ */

const app = document.getElementById('app');

async function navigate(path, pushState = true) {
  try {
    showLoading();
    const url = buildEndpoint(path);
    const res  = await fetch(url, { headers: { 'Accept': 'text/html' } });
    const html = await res.text();
    app.innerHTML = html;

    const pageBody = app.querySelector('[data-breadcrumb]');
    if (pageBody) {
      const bc = document.getElementById('breadcrumb-current');
      if (bc) bc.textContent = pageBody.dataset.breadcrumb;
    }

    if (pushState) {
      history.pushState({ path }, '', path);
    } else {
      history.replaceState({ path }, '', path);
    }

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

document.addEventListener('click', e => {
  const link = e.target.closest('[data-link]');
  if (!link) return;
  e.preventDefault();
  navigate(link.dataset.link);
});

window.addEventListener('popstate', e => {
  if (e.state?.path) navigate(e.state.path, false);
});

/* ── Sidebar ─────────────────────────────────────────────── */
function initSidebar() {
  const sidebar = document.getElementById('sidebar');
  const menuBtn = document.getElementById('menu-btn');
  const overlay = document.getElementById('sidebar-overlay');

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

/* ── Filtrado de productos ───────────────────────────────── */
window.filterProducts = async function(seccionId, tipo) {
  document.querySelectorAll('.section-filters .chip').forEach(c => {
    c.classList.remove('chip-active');
    c.classList.add('chip-filter');
  });
  event.target.classList.add('chip-active');
  event.target.classList.remove('chip-filter');

  if (tipo === 'Todos') {
    const res  = await fetch(`/views/section?id=${seccionId}`, { headers: { 'Accept': 'text/html' } });
    const html = await res.text();
    const tmp  = document.createElement('div');
    tmp.innerHTML = html;
    const newGrid = tmp.querySelector('.products-grid');
    const curGrid = document.querySelector('.products-grid');
    if (newGrid && curGrid) curGrid.replaceWith(newGrid);
    return;
  }

  try {
    const res  = await fetch(`/api/seccion/filtro?id=${seccionId}&tipo=${encodeURIComponent(tipo)}`);
    const data = await res.json();
    const grid = document.querySelector('.products-grid');
    if (!grid) return;

    if (!data.ok || !data.productos.length) {
      grid.innerHTML = `
        <div class="empty-state">
          <div class="empty-state-icon">🔍</div>
          <div class="empty-state-title">Sin productos</div>
          <div class="empty-state-desc">No hay productos de tipo "${tipo}" en esta sección.</div>
        </div>`;
      return;
    }

    grid.innerHTML = data.productos.map(p => `
      <div class="product-card" data-tipo="${p.tipo}">
        <div class="product-card-tags"><span class="tag tag-green">${p.tipo}</span></div>
        <div class="product-card-image">🛍️</div>
        <div class="product-card-brand">${p.marca}</div>
        <div class="product-card-name">${p.nombre}</div>
        <div class="product-card-meta">${p.presentacion}</div>
        <div class="product-card-footer">
          <span class="product-card-price">$${p.precio}</span>
        </div>
      </div>
    `).join('');

  } catch (err) {
    console.error('Error filtrando productos:', err);
  }
}

/* ── Búsqueda live ───────────────────────────────────────── */
function initSearch() {
  const input    = document.getElementById('search-input');
  const clearBtn = document.getElementById('search-clear');

  if (!input || input._searchInit) return;
  input._searchInit = true;

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
    results.innerHTML = `<div class="search-empty"><span>😕</span> Sin resultados</div>`;
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
  document.getElementById('search-results')?.classList.remove('visible');
}

document.addEventListener('click', e => {
  if (!e.target.closest('.search-wrapper')) hideSearchResults();
});

/* ── Eventos post-navegación ─────────────────────────────── */
function attachViewEvents() {
  initSearch();
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

/* ── Init ────────────────────────────────────────────────── */
(function init() {
  initSidebar();
  initSearch();
  const path = window.location.pathname || '/';
  navigate(path, false);
  document.getElementById('topbar-back')?.addEventListener('click', () => history.back());
})();