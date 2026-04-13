/* ══════════════════════════════
   BÚSQUEDA DE PRODUCTOS
══════════════════════════════ */
const searchInput = document.getElementById('searchInput');
const searchClear = document.getElementById('searchClear');
const searchChips = document.getElementById('searchChips');

function normalizeStr(s) {
  return s.toLowerCase().normalize('NFD').replace(/[\u0300-\u036f]/g, '');
}

async function doSearch(query) {
  document.querySelectorAll('.zone.highlight').forEach(z => z.classList.remove('highlight'));
  searchChips.innerHTML = '';

  const q = normalizeStr(query.trim());
  if (!q) return;

  const matchedZones = new Map();
  todosProductos.forEach(p => {
    const haystack = normalizeStr([p.tipo, p.marca, p.nombre, p.comentario].join(' '));
    if (haystack.includes(q)) {
      const zona = tipoAZona[p.tipo];
      if (zona && !matchedZones.has(zona)) {
        matchedZones.set(zona, { zona, tipo: p.tipo });
      }
    }
  });

  if (matchedZones.size === 0) {
    const chip = document.createElement('span');
    chip.className = 'chip';
    chip.style.cssText = 'background:#fee;border-color:#f4a261';
    chip.textContent = '❌ Sin resultados';
    searchChips.appendChild(chip);
    return;
  }

  matchedZones.forEach(({ zona }) => {
    document.querySelectorAll(`[data-zone="${zona}"]`).forEach(el => {
      el.classList.add('highlight');
      el.scrollIntoView({ behavior:'smooth', block:'nearest' });
    });
    const el = document.querySelector(`[data-zone="${zona}"]`);
    const chip = document.createElement('button');
    chip.className = 'chip';
    chip.textContent = (el?.dataset.icon || '') + ' ' + (el?.dataset.label || zona);
    chip.addEventListener('click', () => el && openZoneView(el));
    searchChips.appendChild(chip);
  });
}

searchInput.addEventListener('input', e => {
  searchClear.classList.toggle('visible', !!e.target.value);
  doSearch(e.target.value);
});

searchClear.addEventListener('click', () => {
  searchInput.value = '';
  searchClear.classList.remove('visible');
  doSearch('');
});