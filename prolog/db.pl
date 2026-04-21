:- module(db, [producto/6, categoria/2, seccion/6, lugar/2, oferta/4]).

% ============================================================
%   BASE DE DATOS — MiniSuper FrescaVida
%   Separada del servidor para mantener limpieza de código
% ============================================================

% ── Productos ──────────────────────────────────────────────
% producto(Tipo, Marca, Nombre, Presentacion, Precio, Comentario)

% Lácteos
producto('Leche',      'Lala',        'Entera',           '1L',    22, '').
producto('Leche',      'Alpura',      'Deslactosada',     '1L',    25, 'Sin lactosa').
producto('Leche',      'Silk',        'Leche de Almendra','946ml', 48, 'Sin azúcar').
producto('Yogurt',     'Yoplait',     'Natural',          '900g',  38, 'Refrigerado').
producto('Yogurt',     'Alpura',      'Yogurt Griego',    '450g',  45, 'Natural').
producto('Queso',      'Lala',        'Queso Panela',     '400g',  62, 'Reducido en sal').
producto('Queso',      'Chilchota',   'Manchego',         '400g',  68, 'Rebanado').
producto('Mantequilla','Lurpak',      'Con Sal',          '200g',  85, '').
producto('Crema',      'Lala',        'Crema Ácida',      '500ml', 32, 'Refrigerado').

% Bebidas
producto('Refresco',   'Coca-Cola',   'Cola',             '600ml', 18, 'Botella PET').
producto('Refresco',   'Coca-Cola',   'Cola Familiar',    '2L',    32, 'Botella PET').
producto('Refresco',   'Pepsi',       'Original',         '600ml', 16, '').
producto('Agua',       'Bonafont',    'Natural',          '1.5L',  14, 'Sin gas').
producto('Agua',       'Topo Chico',  'Mineral',          '355ml', 22, 'Con gas').
producto('Jugo',       'Del Valle',   'Naranja',          '1L',    30, 'Sin azúcar').
producto('Jugo',       'Jumex',       'Naranja 100%',     '1L',    35, 'Natural').
producto('Energetica', 'Monster',     'Original',         '473ml', 45, 'Cafeína').
producto('Energetica', 'Gatorade',    'Lima-Limón',       '600ml', 28, 'Hidratación').

% Snacks y Botanas
producto('Botana',     'Sabritas',    'Papas Limón',      '45g',   15, 'Bolsa chica').
producto('Botana',     'Doritos',     'Nacho',            '60g',   18, '').
producto('Galleta',    'Gamesa',      'Marías',           '200g',  22, 'Clásico').
producto('Galleta',    'Oreo',        'Original',         '174g',  35, '').
producto('Cereal',     'Kelloggs',    'Granola Miel',     '300g',  45, 'Desayuno').
producto('Cereal',     'Zucaritas',   'Original',         '410g',  68, '').

% Frutas y Verduras
producto('Fruta',      'A granel',    'Plátano',          '1kg',   18, 'Fresco').
producto('Fruta',      'A granel',    'Manzana',          '1kg',   35, 'Fresco').
producto('Fruta',      'A granel',    'Aguacate',         '1kg',   55, 'Fresco').
producto('Verdura',    'A granel',    'Jitomate',         '1kg',   22, 'Fresco').
producto('Verdura',    'A granel',    'Brócoli',          '1kg',   35, 'Orgánico').
producto('Verdura',    'A granel',    'Espinaca',         '500g',  28, 'Fresco').

% Carnes y Frío
producto('Fiambre',    'San Rafael',  'Jamón de Pavo',    '200g',  35, 'Rebanado').
producto('Fiambre',    'FUD',         'Salchicha Viena',  '500g',  42, '').
producto('Fiambre',    'Bafar',       'Chorizo',          '300g',  38, 'Español').

% Limpieza
producto('Cloro',      'Cloralex',    'Líquido',          '1L',    19, 'Multiusos').
producto('Detergente', 'Ariel',       'Polvo',            '1kg',   55, 'Ropa blanca').
producto('Detergente', 'Ariel',       'Líquido',          '1L',    65, 'Concentrado').
producto('Lavatrastes','Axion',       'Crema Limón',      '500g',  28, '').
producto('Limpiador',  'Fabuloso',    'Lavanda',          '1L',    32, 'Multiusos').

% Congelados
producto('Helado',     'Holanda',     'Vainilla',         '1L',    65, 'Familiar').
producto('Congelado',  'McCain',      'Papas Fritas',     '700g',  55, '').
producto('Congelado',  'Dr. Oetker',  'Pizza Pepperoni',  '360g',  85, '').

% Abarrotes
producto('Lata',       'Herdez',      'Frijoles Negros',  '400g',  18, '').
producto('Lata',       'Dolores',     'Atún en Agua',     '140g',  22, '').
producto('Pasta',      'Barilla',     'Espagueti',        '500g',  24, '').
producto('Salsa',      'Valentina',   'Picante',          '370ml', 22, 'Clásica').
producto('Aceite',     'Nutrioli',    'Vegetal',          '1L',    45, '').


% ── Categorías ─────────────────────────────────────────────
% categoria(Categoria, Tipo)

categoria('Lacteo',       'Leche').
categoria('Lacteo',       'Yogurt').
categoria('Lacteo',       'Queso').
categoria('Lacteo',       'Mantequilla').
categoria('Lacteo',       'Crema').
categoria('Bebida',       'Refresco').
categoria('Bebida',       'Agua').
categoria('Bebida',       'Jugo').
categoria('Bebida',       'Energetica').
categoria('Snack',        'Botana').
categoria('Snack',        'Galleta').
categoria('Snack',        'Cereal').
categoria('FrutaVerdura', 'Fruta').
categoria('FrutaVerdura', 'Verdura').
categoria('CarnesFrios',  'Fiambre').
categoria('Limpieza',     'Cloro').
categoria('Limpieza',     'Detergente').
categoria('Limpieza',     'Lavatrastes').
categoria('Limpieza',     'Limpiador').
categoria('Congelado',    'Helado').
categoria('Congelado',    'Congelado').
categoria('Abarrote',     'Lata').
categoria('Abarrote',     'Pasta').
categoria('Abarrote',     'Salsa').
categoria('Abarrote',     'Aceite').


% ── Secciones (metadata para el mapa y home) ───────────────
% seccion(Id, Nombre, Descripcion, Icon, Color, Pasillo)

seccion('lacteos',    'Lácteos',           'Frescos de granja seleccionados',     '🥛', '#eaf6f0', 'A-01').
seccion('bebidas',    'Bebidas',           'Refrescantes y energizantes',          '🧃', '#dbeeff', 'D-01').
seccion('snacks',     'Snacks & Botanas',  'Dulces y salados para todo momento',  '🍿', '#fff3e0', 'E-01').
seccion('frutas',     'Frutas & Verduras', 'Producto fresco directo del campo',   '🥦', '#e8f5e9', 'C-01').
seccion('carnes',     'Carnes & Frío',     'Charcutería y cortes seleccionados',  '🥩', '#fce4e4', 'B-01').
seccion('limpieza',   'Limpieza',          'Hogar y cuidado personal',             '🧹', '#f0ebff', 'F-01').
seccion('congelados', 'Congelados',        'Helados, pizzas y más',                '🧊', '#e8f4fd', 'E-02').
seccion('abarrotes',  'Abarrotes',         'Despensa completa para tu hogar',     '🥫', '#fef9e7', 'D-02').


% ── Lugares ────────────────────────────────────────────────
% lugar(Categoria, Lugar)

lugar('Lacteo',       'Anaquel refrigerado — lado izquierdo (A-01)').
lugar('CarnesFrios',  'Anaquel refrigerado — lado izquierdo (B-01)').
lugar('FrutaVerdura', 'Sección de frescos — fila superior (C-01)').
lugar('Bebida',       'Pasillo central (D-01 y D-02)').
lugar('Snack',        'Pasillo central (E-01 y E-02)').
lugar('Limpieza',     'Anaquel derecho — lado derecho (F-01)').
lugar('Congelado',    'Anaquel refrigerado — fondo (E-02)').
lugar('Abarrote',     'Pasillo central (D-02)').


% ── Ofertas activas ─────────────────────────────────────────
% oferta(Id, Descripcion, Badge, Seccion)

oferta(1, 'Yogures — hasta agotar existencias', '2×1',   'lacteos').
oferta(2, 'Frutas de temporada los miércoles',  '−15%',  'frutas').
oferta(3, 'Refresco 2L + botana desde $38',     'Combo', 'bebidas').