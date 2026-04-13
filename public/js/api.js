/* ══════════════════════════════
   CONFIGURACIÓN API
   Con SWI-Prolog: mismo origen
   Sin servidor: modo offline
══════════════════════════════ */
const API_BASE = window.location.protocol === 'file:' ? null : '';

/* ── Datos offline (fallback) ── */
const offlineProductos = [
  { tipo:'Leche',       marca:'Lala',       nombre:'Entera',         presentacion:'1L',    precio:'22', comentario:'' },
  { tipo:'Leche',       marca:'Alpura',     nombre:'Deslactosada',   presentacion:'1L',    precio:'25', comentario:'Sin lactosa' },
  { tipo:'Yogurt',      marca:'Yoplait',    nombre:'Natural',         presentacion:'900g',  precio:'38', comentario:'Refrigerado' },
  { tipo:'Refresco',    marca:'Coca-Cola',  nombre:'Cola',            presentacion:'600ml', precio:'18', comentario:'Botella PET' },
  { tipo:'Jugo',        marca:'Del Valle',  nombre:'Naranja',         presentacion:'1L',    precio:'30', comentario:'Sin azucar' },
  { tipo:'Agua',        marca:'Bonafont',   nombre:'Natural',         presentacion:'1.5L',  precio:'14', comentario:'Sin gas' },
  { tipo:'Botana',      marca:'Sabritas',   nombre:'Papas Limon',     presentacion:'45g',   precio:'15', comentario:'Bolsa chica' },
  { tipo:'Galleta',     marca:'Gamesa',     nombre:'Marias',           presentacion:'200g',  precio:'22', comentario:'Clasico' },
  { tipo:'Cereal',      marca:'Kelloggs',   nombre:'Granola Miel',    presentacion:'300g',  precio:'45', comentario:'Desayuno' },
  { tipo:'Cloro',       marca:'Cloralex',   nombre:'Liquido',          presentacion:'1L',    precio:'19', comentario:'Multiusos' },
  { tipo:'Detergente',  marca:'Ariel',      nombre:'Polvo',            presentacion:'1kg',   precio:'55', comentario:'Ropa blanca' },
  { tipo:'Lavatrastes', marca:'Axion',      nombre:'Crema Limon',     presentacion:'500g',  precio:'28', comentario:'' },
  { tipo:'Fruta',       marca:'A granel',   nombre:'Platano',          presentacion:'1kg',   precio:'18', comentario:'Fresco' },
  { tipo:'Verdura',     marca:'A granel',   nombre:'Jitomate',         presentacion:'1kg',   precio:'22', comentario:'Fresco' },
  { tipo:'Verdura',     marca:'A granel',   nombre:'Brocoli',          presentacion:'1kg',   precio:'35', comentario:'Organico' },
  { tipo:'Fiambre',     marca:'San Rafael', nombre:'Jamon de Pavo',   presentacion:'200g',  precio:'35', comentario:'Rebanado' },
  { tipo:'Fiambre',     marca:'FUD',        nombre:'Salchicha Viena', presentacion:'500g',  precio:'42', comentario:'' },
  { tipo:'Queso',       marca:'Chilchota',  nombre:'Manchego',         presentacion:'400g',  precio:'68', comentario:'Rebanado' },
];

const offlineCategorias = {
  'Lacteo':      ['Leche', 'Yogurt'],
  'Bebida':      ['Refresco', 'Jugo', 'Agua'],
  'Snack':       ['Botana', 'Galleta', 'Cereal'],
  'Limpieza':    ['Cloro', 'Detergente', 'Lavatrastes'],
  'FrutaVerdura':['Fruta', 'Verdura'],
  'CarnesFrios': ['Fiambre', 'Queso']
};

const offlineLugares = {
  'Lacteo':       'Anaquel refrigerado — lado izquierdo (A-01)',
  'CarnesFrios':  'Anaquel refrigerado — lado izquierdo (A-01)',
  'FrutaVerdura': 'Seccion de frescos — fila superior (C-01)',
  'Bebida':       'Pasillo central (D-01 y D-02)',
  'Snack':        'Pasillo central (E-01 y E-02)',
  'Limpieza':     'Anaquel derecho — lado derecho (F-01)'
};

/* ── Mapeos ── */
const tipoAZona = {
  'Leche':'lacteos',    'Yogurt':'lacteos',
  'Refresco':'bebidas', 'Jugo':'bebidas',      'Agua':'bebidas',
  'Botana':'snacks',    'Galleta':'galleteria', 'Cereal':'galleteria',
  'Cloro':'limpieza',   'Detergente':'limpieza','Lavatrastes':'limpieza',
  'Fruta':'frutas',     'Verdura':'frutas',
  'Fiambre':'carnes',   'Queso':'carnes'
};

const zonaACategoria = {
  lacteos:'Lacteo',     carnes:'CarnesFrios',  frutas:'FrutaVerdura',
  bebidas:'Bebida',     bebidas2:'Bebida',     snacks:'Snack',
  galleteria:'Snack',   abarrotes:'Snack',     congelados:'Snack',
  limpieza:'Limpieza'
};

/* ── Fetch helper ── */
async function apiGet(path, params = {}) {
  if (!API_BASE) return null;
  const url = new URL(API_BASE + path, location.href);
  Object.entries(params).forEach(([k, v]) => url.searchParams.set(k, v));
  try {
    const r = await fetch(url);
    return await r.json();
  } catch {
    return null;
  }
}

/* ── Cargar todos los productos ── */
let todosProductos = [];

async function cargarProductos() {
  const data = await apiGet('/api/todos');
  todosProductos = data?.productos || offlineProductos;
}