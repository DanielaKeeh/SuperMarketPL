/* ══════════════════════════════
   VISTA DE DETALLE DE ZONA
══════════════════════════════ */
const zoneView      = document.getElementById('zoneView');
const zoneViewTitle = document.getElementById('zoneViewTitle');
const zoneViewSub   = document.getElementById('zoneViewSub');
const zoneViewLoc   = document.getElementById('zoneViewLocation');
const productosBody = document.getElementById('productosBody');
const emptyState    = document.getElementById('emptyState');

async function openZoneView(el) {
  if (!el?.dataset.zone) return;

  const icon  = el.dataset.icon  || '';
  const label = el.dataset.label || '';
  const sub   = el.querySelector('.zone-sub')?.textContent || '';
  const cat   = zonaACategoria[el.dataset.zone];
  const lugar = cat ? (offlineLugares[cat] || '') : '';

  // Poblar header
  zoneViewTitle.innerHTML = icon + ' ' + label;
  zoneViewSub.textContent = sub;
  zoneViewLoc.innerHTML   = '📍 ' + (lugar || 'Consulta en tienda');

  // Mostrar loading
  productosBody.innerHTML = `
    <tr>
      <td colspan="5" style="text-align:center;opacity:.5;padding:24px">
        Cargando…
      </td>
    </tr>`;
  emptyState.style.display = 'none';

  // Abrir vista
  zoneView.classList.add('open');
  document.body.style.overflow = 'hidden';

  // Obtener productos
  let productos = [];

  if (cat) {
    const data = await apiGet('/api/buscar', { cat });
    if (data?.productos?.length) {
      productos = data.productos;
    } else {
      const tipos = offlineCategorias[cat] || [];
      productos = offlineProductos
        .filter(p => tipos.includes(p.tipo))
        .map(p => ({
          tipo:         p.tipo,
          marca:        p.marca,
          nombre:       p.nombre,
          presentacion: p.presentacion,
          precio:       p.precio,
          comentario:   p.comentario
        }));
    }
  }

  // Renderizar tabla
  if (productos.length) {
    productosBody.innerHTML = productos.map(p => `
      <tr>
        <td><strong>${p.nombre}</strong></td>
        <td>${p.marca}</td>
        <td>${p.presentacion || '—'}</td>
        <td><span class="precio-badge">$${p.precio}</span></td>
        <td><span class="comentario-tag">${p.comentario || ''}</span></td>
      </tr>
    `).join('');
    emptyState.style.display = 'none';
  } else {
    productosBody.innerHTML  = '';
    emptyState.style.display = 'block';
  }
}

function closeZoneView() {
  zoneView.classList.remove('open');
  document.body.style.overflow = '';
  document.querySelectorAll('.zone.highlight').forEach(z => z.classList.remove('highlight'));
}

// Eventos
document.getElementById('zoneViewBack').addEventListener('click', closeZoneView);

// Cerrar con Escape
document.addEventListener('keydown', e => {
  if (e.key === 'Escape' && zoneView.classList.contains('open')) closeZoneView();
});