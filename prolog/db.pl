:- module(db, [producto/6, categoria/2, seccion/6, lugar/2, oferta/4]).

% ============================================================
%   BASE DE DATOS — MiniSuper FrescaVida
%   Separada del servidor para mantener limpieza de código
% ============================================================

% ── Productos ──────────────────────────────────────────────
% producto(Tipo, Marca, Nombre, Presentacion, Precio, Comentario)

% ── Lácteos ────────────────────────────────────────────────
producto('Leche', 'Lala',        'Entera',                  '1L',   33, 'Entera cremosa fresca').
producto('Leche', 'Lala',        'Deslactosada',            '1L',   35, 'Sin lactosa ligera').
producto('Leche', 'Lala',        'Deslactosada Light',      '1L',   35, 'Light sin lactosa').
producto('Leche', 'Lala 100',    'Sin Lactosa',             '1L',   48, 'Proteína alta sin lactosa').
producto('Leche', 'Lala 100',    'Sin Lactosa Light',       '1L',   52, 'Alta proteína light').
producto('Leche', 'Lala 100',    'Low Carb Light',          '1L',   49, 'Bajo carbohidrato light').
producto('Leche', 'Alpura',      'Entera',                  '1L',   30, 'Entera sabor natural').
producto('Leche', 'Alpura',      'Deslactosada',            '1L',   32, 'Ligera sin lactosa').
producto('Leche', 'Alpura',      'Semidescremada',          '1L',   30, 'Menos grasa ligera').
producto('Leche', 'Alpura Pro',  'Deslactosada',            '1L',   45, 'Proteína alta ligera').
producto('Leche', 'Alpura Pro',  'Fibra',                   '1L',   40, 'Fibra digestiva ligera').
producto('Leche', 'Alpura Pro',  'Baja en Grasa',           '1L',   38, 'Baja grasa ligera').
producto('Leche', 'Sello Rojo',  'Entera',                  '1L',   33, 'Entera fresca cremosa').
producto('Leche', 'Sello Rojo',  'Sin Grasa',               '1L',   33, 'Sin grasa ligera').
producto('Leche', 'Sello Rojo',  'Sin Grasa Deslactosada',  '1L',   33, 'Sin grasa sin lactosa').
producto('Leche', 'Sello Rojo',  'Light',                   '1L',   33, 'Light suave fresca').
producto('Leche', 'Sello Rojo',  'Light Deslactosada',      '1L',   33, 'Light sin lactosa').
producto('Leche', 'Silk',        'Leche de Almendra',       '946ml',48, 'Sin azúcar vegetal').

producto('Yogurt', 'Lala',   'Natural',        '1L',   35, 'Natural cremoso suave').
producto('Yogurt', 'Lala',   'Fresa',          '1L',   38, 'Fresa dulce cremoso').
producto('Yogurt', 'Lala',   'Griego Natural', '900g', 45, 'Griego espeso natural').
producto('Yogurt', 'Danone', 'Natural',        '1L',   34, 'Natural ligero cremoso').
producto('Yogurt', 'Danone', 'Fresa',          '1L',   37, 'Fresa suave dulce').
producto('Yogurt', 'Yoplait','Natural',        '900g', 38, 'Refrigerado suave').

producto('Queso', 'Lala',      'Panela',   '400g', 55, 'Blanco suave fresco').
producto('Queso', 'Lala',      'Oaxaca',   '400g', 60, 'Hebra suave fresca').
producto('Queso', 'Lala',      'Amarillo', '200g', 30, 'Rebanado suave funde').
producto('Queso', 'Alpura',    'Panela',   '400g', 58, 'Blanco fresco suave').
producto('Queso', 'Chilchota', 'Manchego', '400g', 68, 'Rebanado curado').

producto('Crema', 'Lala',   'Acida', '250ml', 22, 'Ácida suave cremosa').
producto('Crema', 'Alpura', 'Acida', '250ml', 23, 'Cremosa sabor suave').

producto('Mantequilla', 'Lala',   'Con Sal', '90g',  20, 'Salada suave untable').
producto('Mantequilla', 'Lala',   'Sin Sal', '90g',  20, 'Natural suave untable').
producto('Mantequilla', 'Lurpak', 'Con Sal', '200g', 85, 'Importada premium').

% ── Bebidas ────────────────────────────────────────────────
producto('Refresco', 'Coca-Cola',    'Original',  '235ml', 15, 'Presentación práctica').
producto('Refresco', 'Coca-Cola',    'Light',     '235ml', 15, 'Ligera portátil').
producto('Refresco', 'Coca-Cola',    'Zero',      '235ml', 15, 'Compacta sin azúcar').
producto('Refresco', 'Coca-Cola',    'Original',  '600ml', 18, 'Sabor clásico dulce').
producto('Refresco', 'Coca-Cola',    'Light',     '600ml', 18, 'Bajas calorías').
producto('Refresco', 'Coca-Cola',    'Zero',      '600ml', 18, 'Sin azúcar sabor').
producto('Refresco', 'Coca-Cola',    'Original',  '1L',    25, 'Ideal compartir').
producto('Refresco', 'Coca-Cola',    'Light',     '1L',    25, 'Ligera familiar').
producto('Refresco', 'Coca-Cola',    'Zero',      '1L',    25, 'Sin azúcar familiar').
producto('Refresco', 'Coca-Cola',    'Original',  '1.75L', 30, 'Tamaño familiar').
producto('Refresco', 'Coca-Cola',    'Light',     '1.75L', 30, 'Familiar ligera').
producto('Refresco', 'Coca-Cola',    'Zero',      '1.75L', 30, 'Familiar sin azúcar').
producto('Refresco', 'Coca-Cola',    'Original',  '2.5L',  38, 'Mayor cantidad').
producto('Refresco', 'Coca-Cola',    'Light',     '2.5L',  38, 'Grande ligera').
producto('Refresco', 'Coca-Cola',    'Zero',      '2.5L',  38, 'Grande sin azúcar').
producto('Refresco', 'Coca-Cola',    'Original',  '3L',    48, 'Fiestas grandes').
producto('Refresco', 'Coca-Cola',    'Light',     '3L',    63, 'Evento ligera').
producto('Refresco', 'Coca-Cola',    'Zero',      '3L',    63, 'Evento sin azúcar').
producto('Refresco', 'Sprite',       'Original',  '600ml', 17, 'Limón fresco gas').
producto('Refresco', 'Sprite',       'Sin Azúcar','600ml', 17, 'Limón sin azúcar').
producto('Refresco', 'Sprite',       'Original',  '2L',    33, 'Familiar refrescante').
producto('Refresco', 'Fanta',        'Naranja',   '600ml', 17, 'Naranja dulce fresca').
producto('Refresco', 'Fanta',        'Fresa',     '600ml', 17, 'Fresa dulce intensa').
producto('Refresco', 'Fanta',        'Naranja',   '2L',    33, 'Familiar cítrica dulce').
producto('Refresco', 'Sidral Mundet','Manzana',   '600ml', 17, 'Manzana dulce fresca').
producto('Refresco', 'Sidral Mundet','Manzana',   '2L',    33, 'Familiar sabor manzana').
producto('Refresco', 'Fresca',       'Toronja',   '600ml', 17, 'Toronja ligera fresca').
producto('Refresco', 'Fresca',       'Toronja',   '2L',    33, 'Familiar cítrica ligera').
producto('Refresco', 'Pepsi',        'Original',  '600ml', 17, 'Cola dulce intensa').
producto('Refresco', 'Pepsi',        'Light',     '600ml', 17, 'Menos calorías').
producto('Refresco', 'Pepsi',        'Black',     '600ml', 17, 'Sin azúcar intensa').
producto('Refresco', 'Pepsi',        'Original',  '2L',    33, 'Reunión familiar').
producto('Refresco', 'Pepsi',        'Light',     '2L',    33, 'Grande ligera').
producto('Refresco', 'Pepsi',        'Black',     '2L',    33, 'Grande sin azúcar').
producto('Refresco', '7Up',          'Original',  '600ml', 17, 'Limón suave fresco').
producto('Refresco', '7Up',          'Original',  '2L',    33, 'Familiar refrescante').
producto('Refresco', 'Mirinda',      'Naranja',   '600ml', 17, 'Naranja dulce intensa').
producto('Refresco', 'Mirinda',      'Naranja',   '2L',    33, 'Familiar naranja dulce').

producto('Agua', 'Ciel',     'Natural', '600ml', 10, 'Agua pura ligera').
producto('Agua', 'Ciel',     'Mineral', '600ml', 12, 'Agua gasificada fresca').
producto('Agua', 'Ciel',     'Natural', '2L',    18, 'Uso familiar diario').
producto('Agua', 'Bonafont', 'Natural', '600ml', 11, 'Agua ligera pura').
producto('Agua', 'Bonafont', 'Natural', '1.5L',  14, 'Sin gas').
producto('Agua', 'Bonafont', 'Natural', '2L',    19, 'Consumo familiar').
producto('Agua', 'Epura',    'Natural', '600ml', 11, 'Agua purificada ligera').
producto('Agua', 'Epura',    'Natural', '2L',    19, 'Hidratación diaria').
producto('Agua', 'Peñafiel', 'Mineral', '600ml', 14, 'Mineral burbujas suaves').
producto('Agua', 'Peñafiel', 'Mineral', '2L',    20, 'Mineral familiar fresca').
producto('Agua', 'Topo Chico','Mineral','355ml', 22, 'Con gas premium').

producto('Jugo', 'Jumex',     'Mango',       '1L', 28, 'Mango dulce natural').
producto('Jugo', 'Jumex',     'Durazno',     '1L', 28, 'Durazno suave dulce').
producto('Jugo', 'Jumex',     'Guayaba',     '1L', 28, 'Guayaba dulce fresca').
producto('Jugo', 'Jumex',     'Naranja 100%','1L', 35, 'Natural exprimido').
producto('Jugo', 'Del Valle', 'Naranja',     '1L', 30, 'Naranja dulce natural').
producto('Jugo', 'Del Valle', 'Manzana',     '1L', 30, 'Manzana suave fresca').

producto('Isotonica', 'Gatorade', 'Naranja', '600ml', 22, 'Rehidratación rápida').
producto('Isotonica', 'Gatorade', 'Frutas',  '600ml', 22, 'Electrolitos frescos').
producto('Isotonica', 'Gatorade', 'Lima-Limón','600ml',28,'Hidratación deportiva').
producto('Isotonica', 'Powerade', 'Mora',    '600ml', 21, 'Hidratación deportiva').
producto('Isotonica', 'Powerade', 'Uva',     '600ml', 21, 'Energía hidratante').

producto('Energetica', 'Red Bull', 'Original', '250ml', 35, 'Energía rápida intensa').
producto('Energetica', 'Monster',  'Original', '473ml', 38, 'Energía grande intensa').
producto('Energetica', 'Vive100',  'Original', '500ml', 20, 'Energía económica rápida').

producto('Cerveza', 'Corona',   'Extra',    '355ml', 20, 'Clara ligera fría').
producto('Cerveza', 'Corona',   'Light',    '355ml', 20, 'Ligera suave fría').
producto('Cerveza', 'Modelo',   'Especial', '355ml', 22, 'Sabor balanceado suave').
producto('Cerveza', 'Modelo',   'Negra',    '355ml', 24, 'Oscura intensa suave').
producto('Cerveza', 'Victoria', 'Lager',    '355ml', 22, 'Ámbar sabor suave').
producto('Cerveza', 'Tecate',   'Original', '355ml', 21, 'Fuerte sabor clásico').
producto('Cerveza', 'Tecate',   'Light',    '355ml', 21, 'Ligera suave fría').
producto('Cerveza', 'Heineken', 'Original', '355ml', 28, 'Premium sabor intenso').
producto('Cerveza', 'Sol',      'Original', '355ml', 20, 'Ligera refrescante clara').

% ── Snacks y Botanas ───────────────────────────────────────
producto('Botana', 'Sabritas', 'Papas Original',    '45g',  15, 'Clásicas saladas').
producto('Botana', 'Sabritas', 'Papas Limón',       '45g',  15, 'Ácidas crujientes').
producto('Botana', 'Sabritas', 'Papas Adobadas',    '45g',  15, 'Picante suave').
producto('Botana', 'Sabritas', 'Papas Original',    '170g', 45, 'Bolsa grande').
producto('Botana', 'Sabritas', 'Papas Limón',       '170g', 45, 'Grande limón').
producto('Botana', 'Sabritas', 'Papas Adobadas',    '170g', 45, 'Grande adobadas').
producto('Botana', 'Sabritas', 'Ruffles Queso',     '50g',  17, 'Queso intenso onduladas').
producto('Botana', 'Sabritas', 'Ruffles Original',  '50g',  17, 'Onduladas saladas').
producto('Botana', 'Sabritas', 'Doritos Nacho',     '56g',  18, 'Queso fuerte').
producto('Botana', 'Sabritas', 'Doritos Incógnita', '56g',  18, 'Sabor misterio').
producto('Botana', 'Sabritas', 'Doritos Flamin Hot','56g',  18, 'Picante intenso').
producto('Botana', 'Sabritas', 'Cheetos Torciditos','52g',  17, 'Queso crujiente').
producto('Botana', 'Sabritas', 'Cheetos Flamin Hot','52g',  17, 'Picante queso').
producto('Botana', 'Barcel',   'Papas Sal',         '45g',  14, 'Clásicas saladas').
producto('Botana', 'Barcel',   'Papas Jalapeño',    '45g',  14, 'Picante suave').
producto('Botana', 'Barcel',   'Papas Adobadas',    '45g',  14, 'Sabor intenso').
producto('Botana', 'Barcel',   'Takis Fuego',       '56g',  18, 'Picante limón').
producto('Botana', 'Barcel',   'Takis Blue Heat',   '56g',  18, 'Picante azul').
producto('Botana', 'Barcel',   'Takis Original',    '56g',  18, 'Crujiente enrollado').
producto('Botana', 'Barcel',   'Chips Jalapeño',    '55g',  17, 'Picante crujiente').
producto('Botana', 'Barcel',   'Chips Fuego',       '55g',  17, 'Picante intenso').
producto('Botana', 'Kacang',   'Cacahuate Japonés', '100g', 20, 'Crujiente dulce').
producto('Botana', 'Mafer',    'Cacahuate Salado',  '100g', 22, 'Salado clásico').

producto('Dulce', 'Ricolino',   'Panditas',       '100g', 20, 'Gomitas dulces').
producto('Dulce', 'Ricolino',   'Gomilocas',      '100g', 20, 'Ácidas enchiladas').
producto('Dulce', 'Ricolino',   'Paleta Payaso',  '1pza', 12, 'Chocolate malvavisco').
producto('Dulce', 'Sonrics',    'Bubbaloo Fresa', '1pza',  2, 'Chicle relleno fresa').
producto('Dulce', 'Sonrics',    'Bubbaloo Mora',  '1pza',  2, 'Chicle dulce mora').
producto('Dulce', 'De la Rosa', 'Mazapan',        '1pza',  8, 'Dulce cacahuate').
producto('Dulce', 'De la Rosa', 'Pulparindo',     '1pza', 10, 'Tamarindo picante').

producto('Chocolate', 'Nestle',  'Carlos V',         '1pza', 15, 'Chocolate clásico').
producto('Chocolate', 'Nestle',  'Crunch',           '1pza', 18, 'Chocolate crujiente').
producto('Chocolate', 'Hershey', 'Barra Chocolate',  '1pza', 20, 'Chocolate dulce').
producto('Chocolate', 'Hershey', 'Kisses',           '50g',  25, 'Chocolates pequeños').
producto('Chocolate', 'Ferrero', 'Kinder Sorpresa',  '1pza', 35, 'Chocolate con juguete').
producto('Chocolate', 'Ferrero', 'Kinder Delice',    '1pza', 20, 'Pastel chocolate').

producto('Galleta', 'Gamesa',   'Emperador Chocolate','109g', 18, 'Relleno chocolate dulce').
producto('Galleta', 'Gamesa',   'Emperador Vainilla', '109g', 18, 'Relleno vainilla suave').
producto('Galleta', 'Gamesa',   'Marías',             '170g', 20, 'Clásicas dulces crujientes').
producto('Galleta', 'Gamesa',   'Chokis',             '57g',  20, 'Chispas chocolate suave').
producto('Galleta', 'Gamesa',   'Arcoiris',           '75g',  15, 'Cubierta dulce colorida').
producto('Galleta', 'Nabisco',  'Oreo Original',      '117g', 20, 'Chocolate crema clásica').
producto('Galleta', 'Nabisco',  'Oreo Doble Crema',   '117g', 22, 'Extra crema dulce').
producto('Galleta', 'Nabisco',  'Oreo Mini',          '50g',  12, 'Pequeñas crujientes dulces').
producto('Galleta', 'Marinela', 'Príncipe Chocolate', '117g', 18, 'Relleno chocolate fuerte').
producto('Galleta', 'Marinela', 'Príncipe Vainilla',  '117g', 18, 'Relleno vainilla dulce').
producto('Galleta', 'Cuétara',  'Galletas Surtidas',  '300g', 35, 'Variedad dulces surtidas').
producto('Galleta', 'Cuétara',  'Canela',             '150g', 18, 'Canela dulce crujiente').

% ── Panadería ──────────────────────────────────────────────
producto('Panaderia', 'FrescaVida', 'Bolillo',          '1pza', 3,  'Crujiente fresco diario').
producto('Panaderia', 'FrescaVida', 'Telera',           '1pza', 4,  'Suave sandwich fresco').
producto('Panaderia', 'FrescaVida', 'Concha Vainilla',  '1pza', 10, 'Dulce suave clásica').
producto('Panaderia', 'FrescaVida', 'Concha Chocolate', '1pza', 10, 'Chocolate dulce suave').
producto('Panaderia', 'FrescaVida', 'Cuernito',         '1pza', 12, 'Hojaldre suave mantequilla').
producto('Panaderia', 'FrescaVida', 'Oreja',            '1pza', 11, 'Hojaldre crujiente dulce').
producto('Panaderia', 'FrescaVida', 'Bigote',           '1pza', 11, 'Pan dulce suave').
producto('Panaderia', 'FrescaVida', 'Dona Azúcar',      '1pza', 10, 'Dulce suave esponjoso').
producto('Panaderia', 'FrescaVida', 'Dona Chocolate',   '1pza', 12, 'Chocolate suave esponjoso').
producto('Panaderia', 'FrescaVida', 'Empanada Piña',    '1pza', 12, 'Relleno dulce fruta').
producto('Panaderia', 'FrescaVida', 'Empanada Cajeta',  '1pza', 12, 'Cajeta dulce suave').
producto('Panaderia', 'FrescaVida', 'Empanada Manzana', '1pza', 12, 'Manzana dulce horneada').
producto('Panaderia', 'FrescaVida', 'Panque',           '1pza', 15, 'Suave dulce casero').
producto('Panaderia', 'FrescaVida', 'Rebanada Pastel',  '1pza', 25, 'Pastel dulce fresco').
producto('Panaderia', 'FrescaVida', 'Roles Canela',     '1pza', 18, 'Canela dulce glaseado').
producto('Panaderia', 'FrescaVida', 'Muffin Chocolate', '1pza', 15, 'Chocolate suave esponjoso').
producto('Panaderia', 'FrescaVida', 'Muffin Vainilla',  '1pza', 15, 'Vainilla suave esponjoso').

% ── Cereales, Harinas y Granola ────────────────────────────
producto('Cereal', 'Kelloggs', 'Zucaritas',     '240g', 45, 'Hojuelas azúcar dulce').
producto('Cereal', 'Kelloggs', 'Corn Flakes',   '250g', 42, 'Hojuelas maíz clásico').
producto('Cereal', 'Kelloggs', 'Choco Krispis', '290g', 48, 'Chocolate crujiente dulce').
producto('Cereal', 'Kelloggs', 'Froot Loops',   '300g', 50, 'Aros frutales dulces').
producto('Cereal', 'Kelloggs', 'Granola Miel',  '300g', 45, 'Granola miel desayuno').
producto('Cereal', 'Nestle',   'Fitness',        '300g', 52, 'Integral ligero saludable').
producto('Cereal', 'Nestle',   'Chocapic',       '300g', 48, 'Chocolate crujiente intenso').
producto('Cereal', 'Nestle',   'Trix',           '300g', 50, 'Frutal dulce colores').
producto('Cereal', 'Quaker',   'Avena Natural',  '400g', 28, 'Avena natural saludable').
producto('Cereal', 'Quaker',   'Avena Canela',   '400g', 30, 'Canela dulce caliente').
producto('Cereal', 'Zucaritas','Original',       '410g', 68, 'Tigre dulce clásico').

producto('Harina', 'Maseca',        'Maíz',      '1kg',  28, 'Tortillas maíz caseras').
producto('Harina', 'Minsa',         'Maíz',      '1kg',  26, 'Maíz molido tradicional').
producto('Harina', 'Gamesa',        'Trigo',     '1kg',  22, 'Harina trigo básica').
producto('Harina', 'Selecta',       'Trigo',     '1kg',  24, 'Repostería suave fina').
producto('Harina', 'Quaker',        'Hot Cakes', '500g', 35, 'Mezcla hotcakes fácil').
producto('Harina', 'Tres Estrellas','Hot Cakes', '500g', 32, 'Hotcakes esponjosos dulces').

producto('Granola', 'Nature Valley', 'Avena Miel',   '350g', 60, 'Granola dulce crujiente').
producto('Granola', 'Quaker',        'Granola Frutas','300g', 55, 'Avena frutas seca').

% ── Frutas y Verduras ──────────────────────────────────────
producto('Verdura', 'A granel', 'Jitomate',      '1kg',    24, 'Rojo jugoso fresco').
producto('Verdura', 'A granel', 'Cebolla',       '1kg',    20, 'Blanca fresca crujiente').
producto('Verdura', 'A granel', 'Papa',          '1kg',    22, 'Versátil suave fresca').
producto('Verdura', 'A granel', 'Zanahoria',     '1kg',    18, 'Dulce crujiente fresca').
producto('Verdura', 'A granel', 'Calabacita',    '1kg',    26, 'Verde suave fresca').
producto('Verdura', 'A granel', 'Chayote',       '1kg',    19, 'Ligero verde fresco').
producto('Verdura', 'A granel', 'Pepino',        '1kg',    17, 'Refrescante verde crujiente').
producto('Verdura', 'A granel', 'Brócoli',       '1kg',    35, 'Orgánico verde fresco').
producto('Verdura', 'A granel', 'Espinaca',      'Manojo', 12, 'Hojas verdes frescas').
producto('Verdura', 'A granel', 'Acelga',        'Manojo', 12, 'Verde hojas frescas').
producto('Verdura', 'A granel', 'Cilantro',      'Manojo',  8, 'Verde aroma fresco').
producto('Verdura', 'A granel', 'Perejil',       'Manojo',  8, 'Aroma suave fresco').
producto('Verdura', 'A granel', 'Chile serrano', '1kg',    30, 'Picante verde fresco').
producto('Verdura', 'A granel', 'Chile jalapeño','1kg',    28, 'Picante medio fresco').
producto('Verdura', 'A granel', 'Berenjena',     '1kg',    32, 'Morada suave fresca').
producto('Verdura', 'A granel', 'Pimiento rojo', '1kg',    45, 'Dulce rojo fresco').
producto('Verdura', 'A granel', 'Pimiento verde','1kg',    40, 'Verde intenso fresco').
producto('Verdura', 'A granel', 'Ajo',           '1kg',    90, 'Intenso aromático fresco').
producto('Verdura', 'A granel', 'Tomate verde',  '1kg',    26, 'Ácido verde fresco').

producto('Fruta', 'A granel', 'Plátano',       '1kg', 18, 'Dulce maduro fresco').
producto('Fruta', 'A granel', 'Manzana roja',  '1kg', 38, 'Dulce roja fresca').
producto('Fruta', 'A granel', 'Manzana verde', '1kg', 40, 'Ácida verde fresca').
producto('Fruta', 'A granel', 'Naranja',       '1kg', 20, 'Jugosa cítrica fresca').
producto('Fruta', 'A granel', 'Limón',         '1kg', 22, 'Ácido verde fresco').
producto('Fruta', 'A granel', 'Papaya',        '1kg', 28, 'Dulce suave fresca').
producto('Fruta', 'A granel', 'Sandía',        '1kg', 15, 'Refrescante roja dulce').
producto('Fruta', 'A granel', 'Melón',         '1kg', 18, 'Dulce jugoso fresco').
producto('Fruta', 'A granel', 'Piña',          '1kg', 25, 'Tropical dulce fresca').
producto('Fruta', 'A granel', 'Mango',         '1kg', 30, 'Dulce tropical fresco').
producto('Fruta', 'A granel', 'Aguacate',      '1kg', 55, 'Fresco cremoso natural').
producto('Fruta', 'A granel', 'Uva verde',     '1kg', 55, 'Dulce ligera fresca').
producto('Fruta', 'A granel', 'Uva roja',      '1kg', 58, 'Dulce intensa fresca').
producto('Fruta', 'A granel', 'Fresa',         '1kg', 65, 'Dulce roja fresca').
producto('Fruta', 'A granel', 'Guayaba',       '1kg', 28, 'Aromática dulce fresca').
producto('Fruta', 'A granel', 'Pera',          '1kg', 35, 'Suave dulce fresca').
producto('Fruta', 'A granel', 'Durazno',       '1kg', 42, 'Jugoso dulce fresco').
producto('Fruta', 'A granel', 'Kiwi',          '1kg', 70, 'Ácido dulce fresco').
producto('Fruta', 'A granel', 'Granada',       '1kg', 60, 'Semillas rojas dulces').

% ── Carnes ─────────────────────────────────────────────────
producto('Carne', 'Res',     'Bistec',       '1kg', 180, 'Corte delgado fresco').
producto('Carne', 'Res',     'Molida',       '1kg', 160, 'Molida fresca diaria').
producto('Carne', 'Res',     'Costilla',     '1kg', 170, 'Corte jugoso con hueso').
producto('Carne', 'Cerdo',   'Chuleta',      '1kg', 120, 'Corte suave fresco').
producto('Carne', 'Cerdo',   'Costilla',     '1kg', 130, 'Costilla jugosa fresca').
producto('Carne', 'Cerdo',   'Maciza',       '1kg', 125, 'Carne magra fresca').
producto('Carne', 'Pollo',   'Entero',       '1kg',  75, 'Pollo fresco entero').
producto('Carne', 'Pollo',   'Pechuga',      '1kg', 110, 'Pechuga limpia fresca').
producto('Carne', 'Pollo',   'Pierna Muslo', '1kg',  85, 'Jugoso fresco diario').
producto('Carne', 'Pescado', 'Tilapia',      '1kg', 120, 'Filete blanco fresco').
producto('Carne', 'Pescado', 'Mojarra',      '1kg',  90, 'Entero fresco limpio').
producto('Carne', 'Pescado', 'Atún',         '1kg', 140, 'Rojo fresco corte').

producto('CarnesFrias', 'Fud',       'Jamón Pierna',   '250g', 35, 'Rebanado suave fresco').
producto('CarnesFrias', 'Fud',       'Jamón Pavo',     '250g', 38, 'Pavo ligero saludable').
producto('CarnesFrias', 'San Rafael','Jamón Pavo',     '250g', 45, 'Pavo premium suave').
producto('CarnesFrias', 'Fud',       'Salchicha Viena','500g', 32, 'Clásica suave cocida').
producto('CarnesFrias', 'Zwan',      'Salchicha Viena','500g', 30, 'Rendidora suave clásica').
producto('CarnesFrias', 'Fud',       'Chorizo',        '250g', 28, 'Condimentado picante fresco').
producto('CarnesFrias', 'Bafar',     'Chorizo',        '300g', 38, 'Español condimentado').
producto('CarnesFrias', 'Fud',       'Tocino',         '250g', 55, 'Ahumado crujiente intenso').

producto('Preparado', 'Carniceria', 'Carne Asada',     '1kg', 190, 'Lista asar sazonada').
producto('Preparado', 'Carniceria', 'Alitas Adobadas', '1kg', 120, 'Pollo adobado listo').
producto('Preparado', 'Carniceria', 'Brochetas',       '1kg', 150, 'Mixto listo asar').

% ── Limpieza ───────────────────────────────────────────────
producto('Cloro', 'Cloralex', 'Líquido', '1L',  19, 'Desinfectante potente').
producto('Cloro', 'Cloralex', 'Líquido', '2L',  32, 'Limpieza profunda').
producto('Cloro', 'Pinol',    'Clorado', '1L',  22, 'Desinfectante aroma pino').

producto('Detergente', 'Ariel', 'Polvo',   '1kg', 55, 'Ropa blanca limpia').
producto('Detergente', 'Ariel', 'Líquido', '1L',  65, 'Limpieza profunda ropa').
producto('Detergente', 'Roma',  'Polvo',   '1kg', 28, 'Económico ropa limpia').
producto('Detergente', 'Ace',   'Polvo',   '1kg', 40, 'Ropa color limpia').

producto('Suavizante', 'Suavitel', 'Clásico',   '850ml', 35, 'Suavidad aroma fresco').
producto('Suavizante', 'Suavitel', 'Primavera', '850ml', 35, 'Aroma floral suave').
producto('Suavizante', 'Downy',    'Brisa',     '800ml', 45, 'Fragancia duradera').

producto('Lavatrastes', 'Axion', 'Crema Limón',  '500g',  28, 'Grasa difícil elimina').
producto('Lavatrastes', 'Axion', 'Líquido Limón','750ml', 30, 'Limpieza grasa fuerte').
producto('Lavatrastes', 'Salvo', 'Líquido',      '750ml', 32, 'Platos limpios brillantes').

producto('Limpiador', 'Pinol',    'Original', '1L', 30, 'Aroma pino fresco').
producto('Limpiador', 'Fabuloso', 'Lavanda',  '1L', 28, 'Aroma floral limpio').
producto('Limpiador', 'Fabuloso', 'Cítrico',  '1L', 28, 'Aroma cítrico fresco').

producto('Papel', 'Regio',   'Higiénico', '4rollos', 35, 'Suave resistente doble').
producto('Papel', 'Pétalo',  'Higiénico', '4rollos', 32, 'Suave económico rendidor').
producto('Papel', 'Kleenex', 'Facial',    '90pza',   18, 'Suave uso diario').

producto('Aromatizante', 'Glade',   'Aerosol',    '300ml', 40, 'Fragancia ambiente duradera').
producto('Aromatizante', 'Air Wick','Automático',  '250ml', 65, 'Aroma continuo hogar').

producto('Desinfectante', 'Lysol', 'Spray',   '354ml', 55, 'Elimina bacterias hogar').
producto('Desinfectante', 'Lysol', 'Líquido', '900ml', 50, 'Desinfección superficies').

producto('Esponja', 'Scotch-Brite', 'Clásica',    '1pza', 12, 'Limpieza cocina práctica').
producto('Esponja', 'Scotch-Brite', 'Fibra Verde', '1pza', 15, 'Talla fuerte cocina').

% ── Congelados ─────────────────────────────────────────────
producto('Helado', 'Holanda',       'Vainilla',        '1L',   65, 'Familiar cremoso suave').
producto('Helado', 'Holanda',       'Chocolate',       '1L',   65, 'Familiar chocolate intenso').
producto('Helado', 'Holanda',       'Fresa',           '1L',   65, 'Familiar fresa dulce').
producto('Helado', 'Holanda',       'Napolitano',      '1L',   68, 'Tres sabores clásico').
producto('Helado', 'Nestlé',        'Vainilla',        '900ml',72, 'Cremoso suave premium').
producto('Helado', 'Nestlé',        'Chocolate',       '900ml',72, 'Chocolate premium intenso').
producto('Helado', 'La Michoacana', 'Limón',           '1L',   58, 'Sorbete ácido fresco').
producto('Helado', 'La Michoacana', 'Mango',           '1L',   58, 'Sorbete tropical dulce').

producto('Congelado', 'McCain',     'Papas Fritas',    '700g', 55, 'Crujientes al horno').
producto('Congelado', 'McCain',     'Papas Gajos',     '650g', 58, 'Gajos crujientes sazonados').
producto('Congelado', 'McCain',     'Aros de Cebolla', '400g', 62, 'Crujientes dorados fritos').
producto('Congelado', 'Dr. Oetker', 'Pizza Pepperoni', '360g', 85, 'Pizza lista horneada').
producto('Congelado', 'Dr. Oetker', 'Pizza Hawaiana',  '360g', 85, 'Piña jamón horneada').
producto('Congelado', 'Dr. Oetker', 'Pizza Queso',     '360g', 80, 'Queso fundido horneada').
producto('Congelado', 'Birdseye',   'Verduras Mixtas', '500g', 45, 'Mezcla nutritiva lista').
producto('Congelado', 'Birdseye',   'Brócoli',         '500g', 42, 'Floretes listos cocinar').
producto('Congelado', 'Del Real',   'Carnitas',        '400g', 95, 'Listas calentar servir').
producto('Congelado', 'Del Real',   'Tamales Verdes',  '6pza', 88, 'Tradicional listo calentar').
producto('Congelado', 'Del Real',   'Tamales Rojos',   '6pza', 88, 'Picante listo calentar').

% ── Abarrotes ──────────────────────────────────────────────
producto('Lata', 'Herdez',    'Frijoles Negros',    '400g', 18, 'Listos calentar').
producto('Lata', 'Herdez',    'Frijoles Bayos',     '400g', 18, 'Suaves listos calentar').
producto('Lata', 'Herdez',    'Salsa Verde',        '400g', 22, 'Tomatillo ácido listo').
producto('Lata', 'Herdez',    'Chipotle',           '200g', 20, 'Ahumado picante listo').
producto('Lata', 'Dolores',   'Atún en Agua',       '140g', 22, 'Ligero proteína').
producto('Lata', 'Dolores',   'Atún en Aceite',     '140g', 24, 'Suave aceite girasol').
producto('Lata', 'Calmex',    'Atún en Agua',       '140g', 25, 'Premium ligero fresco').
producto('Lata', 'Del Monte', 'Duraznos en Almíbar','820g', 38, 'Dulce suave postre').
producto('Lata', 'Del Monte', 'Piña en Almíbar',    '820g', 35, 'Tropical dulce rebanada').
producto('Lata', 'Campbell',  'Sopa Tomate',        '305g', 28, 'Clásica reconfortante').
producto('Lata', 'Campbell',  'Sopa Pollo',         '305g', 30, 'Caldo suave pollo').

producto('Pasta', 'Barilla',    'Espagueti',   '500g', 24, 'Clásica italiana').
producto('Pasta', 'Barilla',    'Penne',       '500g', 24, 'Corte tubo italiano').
producto('Pasta', 'Barilla',    'Fettuccine',  '500g', 26, 'Plana cremosa italiana').
producto('Pasta', 'Barilla',    'Fusilli',     '500g', 24, 'Espiral salsa agarra').
producto('Pasta', 'La Moderna', 'Espagueti',   '200g', 12, 'Económica clásica rápida').
producto('Pasta', 'La Moderna', 'Codito',      '200g', 12, 'Sopa tradicional mexicana').
producto('Pasta', 'La Moderna', 'Tornillo',    '200g', 12, 'Versátil sopa ensalada').

producto('Salsa', 'Valentina', 'Picante',       '370ml', 22, 'Clásica picante').
producto('Salsa', 'Valentina', 'Extra Picante', '370ml', 22, 'Muy picante intensa').
producto('Salsa', 'Cholula',   'Original',      '150ml', 35, 'Árbol piquín suave').
producto('Salsa', 'Tapatío',   'Original',      '300ml', 38, 'Picante clásico rojo').
producto('Salsa', 'Herdez',    'Verde',         '240ml', 28, 'Tomatillo fresco ácido').
producto('Salsa', 'Herdez',    'Roja',          '240ml', 28, 'Chile rojo cocida lista').
producto('Salsa', 'Búfalo',    'Chipotle',      '370ml', 30, 'Ahumado dulce picante').

producto('Aceite', 'Nutrioli', 'Vegetal',  '1L',   45, 'Cocina ligera').
producto('Aceite', 'Nutrioli', 'Vegetal',  '3L',  110, 'Familiar rendidor').
producto('Aceite', '1-2-3',    'Vegetal',  '1L',   38, 'Económico cocina diaria').
producto('Aceite', 'Capullo',  'Canola',   '1L',   52, 'Ligero corazón sano').
producto('Aceite', 'Bertolli', 'Oliva',    '500ml',95, 'Extra virgen premium').

producto('Arroz', 'SOS',       'Morelos',     '1kg', 28, 'Grano largo esponjoso').
producto('Arroz', 'SOS',       'Integral',    '1kg', 32, 'Nutritivo fibra natural').
producto('Arroz', 'Milagroso', 'Extra Largo', '1kg', 25, 'Suelto cocción fácil').

producto('Frijol', 'Isadora',  'Negros Refritos', '440g', 22, 'Cremosos listos calentar').
producto('Frijol', 'Isadora',  'Bayos Refritos',  '440g', 22, 'Suaves listos calentar').
producto('Frijol', 'A granel', 'Negro',           '1kg',  28, 'Seco cocción casera').
producto('Frijol', 'A granel', 'Bayo',            '1kg',  26, 'Seco suave casero').

producto('Azucar', 'Zulka',    'Morena',    '1kg', 22, 'Natural sin refinar').
producto('Azucar', 'La Abeja', 'Estándar',  '1kg', 20, 'Blanca cocina básica').

producto('Cafe', 'Nescafé',        'Clásico', '200g', 65, 'Soluble clásico intenso').
producto('Cafe', 'Nescafé',        'Decaf',   '200g', 68, 'Sin cafeína suave').
producto('Cafe', 'Cielito Lindo',  'Molido',  '250g', 75, 'Molido aromático mexicano').
producto('Cafe', 'La Llave',       'Molido',  '500g', 55, 'Tradicional fuerte oscuro').


% ── Categorías ─────────────────────────────────────────────
% categoria(Categoria, Tipo)

categoria('Lacteo',       'Leche').
categoria('Lacteo',       'Yogurt').
categoria('Lacteo',       'Queso').
categoria('Lacteo',       'Crema').
categoria('Lacteo',       'Mantequilla').

categoria('Bebida',       'Refresco').
categoria('Bebida',       'Agua').
categoria('Bebida',       'Jugo').
categoria('Bebida',       'Isotonica').
categoria('Bebida',       'Energetica').
categoria('Bebida',       'Cerveza').

categoria('Snack',        'Botana').
categoria('Snack',        'Dulce').
categoria('Snack',        'Chocolate').
categoria('Snack',        'Galleta').

categoria('Harinas',      'Cereal').
categoria('Harinas',      'Harina').
categoria('Harinas',      'Granola').
categoria('Harinas',      'Panaderia').

categoria('FrutaVerdura', 'Fruta').
categoria('FrutaVerdura', 'Verdura').

categoria('Carnes',       'Carne').
categoria('Carnes',       'CarnesFrias').
categoria('Carnes',       'Preparado').

categoria('Limpieza',     'Cloro').
categoria('Limpieza',     'Detergente').
categoria('Limpieza',     'Suavizante').
categoria('Limpieza',     'Lavatrastes').
categoria('Limpieza',     'Limpiador').
categoria('Limpieza',     'Papel').
categoria('Limpieza',     'Aromatizante').
categoria('Limpieza',     'Desinfectante').
categoria('Limpieza',     'Esponja').

categoria('Congelado',    'Helado').
categoria('Congelado',    'Congelado').

categoria('Abarrote',     'Lata').
categoria('Abarrote',     'Pasta').
categoria('Abarrote',     'Salsa').
categoria('Abarrote',     'Aceite').
categoria('Abarrote',     'Arroz').
categoria('Abarrote',     'Frijol').
categoria('Abarrote',     'Azucar').
categoria('Abarrote',     'Cafe').


% ── Secciones ──────────────────────────────────────────────
% seccion(Id, Nombre, Descripcion, Icon, Color, Pasillo)

seccion('lacteos',    'Lácteos',           'Frescos de granja seleccionados',         '🥛', '#eaf6f0', 'A-01').
seccion('bebidas',    'Bebidas',           'Refrescantes y energizantes',              '🧃', '#dbeeff', 'D-01').
seccion('snacks',     'Snacks & Botanas',  'Dulces y salados para todo momento',      '🍿', '#fff3e0', 'E-01').
seccion('frutas',     'Frutas & Verduras', 'Producto fresco directo del campo',       '🥦', '#e8f5e9', 'C-01').
seccion('carnes',     'Carnes & Frío',     'Charcutería, cortes y preparados',        '🥩', '#fce4e4', 'B-01').
seccion('harinas',    'Harinas & Panadería','Cereales, harinas y pan del día',        '🥐', '#fdf3e0', 'E-03').
seccion('limpieza',   'Limpieza',          'Hogar y cuidado personal',                '🧹', '#f0ebff', 'F-01').
seccion('congelados', 'Congelados',        'Helados, pizzas y más',                   '🧊', '#e8f4fd', 'E-02').
seccion('abarrotes',  'Abarrotes',         'Despensa completa para tu hogar',         '🥫', '#fef9e7', 'D-02').


% ── Lugares ────────────────────────────────────────────────
% lugar(Categoria, Lugar)

lugar('Lacteo',       'Anaquel refrigerado — lado izquierdo (A-01)').
lugar('Carnes',       'Anaquel refrigerado — lado izquierdo (B-01)').
lugar('FrutaVerdura', 'Sección de frescos — fila superior (C-01)').
lugar('Bebida',       'Pasillo central (D-01 y D-02)').
lugar('Snack',        'Pasillo central (E-01 y E-02)').
lugar('Harinas',      'Pasillo central (E-03)').
lugar('Limpieza',     'Anaquel derecho — lado derecho (F-01)').
lugar('Congelado',    'Anaquel refrigerado — fondo (E-02)').
lugar('Abarrote',     'Pasillo central (D-02)').


% ── Ofertas activas ─────────────────────────────────────────
% oferta(Id, Descripcion, Badge, Seccion)

oferta(1, 'Yogures — hasta agotar existencias', '2×1',   'lacteos').
oferta(2, 'Frutas de temporada los miércoles',  '−15%',  'frutas').
oferta(3, 'Refresco 2L + botana desde $38',     'Combo', 'bebidas').