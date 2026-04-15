/* ══════════════════════════════
   VISTA DE DETALLE DE ZONA
══════════════════════════════ */
const zoneView      = document.getElementById('zoneView');
const zoneViewTitle = document.getElementById('zoneViewTitle');
const zoneViewSub   = document.getElementById('zoneViewSub');
const zoneViewLoc   = document.getElementById('zoneViewLocation');
const productosBody = document.getElementById('productosBody');
const emptyState    = document.getElementById('emptyState');
const infoCard      = document.getElementById('infoCard');
const productosTable= document.getElementById('productosTable');

/* ── Zonas especiales (no productos) ── */
const zonasEspeciales = {
  oficina: {
    tipo: 'info',
    encargado: 'Karol Daniela Maldonado Lopez',
    correo: 'daniela_keeeh@outlook.com',
    horario: '9:00 AM – 3:00 PM · Lunes a Viernes',
    servicios: [
      { icon: '🧾', nombre: 'Facturación electrónica', desc: 'Emisión de CFDI en menos de 5 minutos' },
      { icon: '↩️', nombre: 'Devoluciones',            desc: 'Cambios y devoluciones con ticket de compra' },
      { icon: '📋', nombre: 'Atención a clientes',     desc: 'Quejas, sugerencias y aclaraciones' },
      { icon: '💼', nombre: 'Proveedores',              desc: 'Recepción de propuestas y cotizaciones' },
      { icon: '🎁', nombre: 'Programa de lealtad',      desc: 'Alta y consulta de puntos FrescaVida' },
    ]
  }
};

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

  // Abrir vista
  zoneView.classList.add('open');
  document.body.style.overflow = 'hidden';

  // ── Zona especial (oficina, etc) ──
  const especial = zonasEspeciales[el.dataset.zone];
  if (especial?.tipo === 'info') {
    productosTable.style.display = 'none';
    emptyState.style.display     = 'none';
    infoCard.style.display       = 'block';

    document.getElementById('infoEncargado').textContent = especial.encargado;
    document.getElementById('infoCorreo').textContent    = especial.correo;
    document.getElementById('infoCorreo').href           = 'mailto:' + especial.correo;
    document.getElementById('infoHorario').textContent   = especial.horario;
    document.getElementById('infoServicios').innerHTML   = especial.servicios.map(s => `
      <div class="servicio-card">
        <span class="servicio-card-icon">${s.icon}</span>
        <div>
          <div class="servicio-card-nombre">${s.nombre}</div>
          <div class="servicio-card-desc">${s.desc}</div>
        </div>
      </div>
    `).join('');
    return;
  }

  // ── Zona normal (productos) ──
  productosTable.style.display = '';
  infoCard.style.display       = 'none';

  productosBody.innerHTML = `
    <tr>
      <td colspan="5" style="text-align:center;opacity:.5;padding:24px">
        Cargando…
      </td>
    </tr>`;
  emptyState.style.display = 'none';

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

document.getElementById('zoneViewBack').addEventListener('click', closeZoneView);

document.addEventListener('keydown', e => {
  if (e.key === 'Escape' && zoneView.classList.contains('open')) closeZoneView();
});