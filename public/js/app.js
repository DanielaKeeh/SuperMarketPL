/* ══════════════════════════════
   APP — eventos globales e init
══════════════════════════════ */

/* ── Clicks en zonas del mapa ── */
document.querySelectorAll('.zone[data-zone]').forEach(zone => {
  zone.addEventListener('click', () => openZoneView(zone));
  zone.addEventListener('keydown', e => {
    if (e.key === 'Enter' || e.key === ' ') {
      e.preventDefault();
      openZoneView(zone);
    }
  });
});

/* ── Bottom sheet (mobile) ── */
const bsOverlay     = document.getElementById('bsOverlay');
const bottomSheet   = document.getElementById('bottomSheet');
const sidebarToggle = document.getElementById('sidebarToggle');

sidebarToggle.addEventListener('click', () => {
  bsOverlay.classList.add('open');
  bottomSheet.classList.add('open');
});

bsOverlay.addEventListener('click', () => {
  bsOverlay.classList.remove('open');
  bottomSheet.classList.remove('open');
});

let touchStartY = 0;
bottomSheet.addEventListener('touchstart', e => {
  touchStartY = e.touches[0].clientY;
}, { passive:true });

bottomSheet.addEventListener('touchend', e => {
  if (e.changedTouches[0].clientY - touchStartY > 80) {
    bsOverlay.classList.remove('open');
    bottomSheet.classList.remove('open');
  }
}, { passive:true });

/* ── Init ── */
cargarProductos();