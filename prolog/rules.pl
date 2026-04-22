:- module(rules, [donde/2, productos_de_seccion/3, seccion_a_categoria/2,
                  precio_max/5, mas_barato/3, mas_caro/3,
                  buscar_por_nombre/5, misma_categoria/2,
                  todas_las_secciones/1, todas_las_ofertas/1,
                  info_producto/6]).
                
% ============================================================
%   REGLAS DE NEGOCIO — MiniSuper FrescaVida
%   Todas las reglas derivan de los hechos en db.pl
%   Formato: cabeza :- cuerpo (si cuerpo es verdad, cabeza es verdad)
% ============================================================

% ── donde/2 ────────────────────────────────────────────────
% Pregunta: ¿dónde está un tipo de producto en la tienda?
% Uso: donde('Yogurt', Lugar)
%
% Paso 1: busca en qué Categoria cae el Tipo (ej: Yogurt → Lacteo)
% Paso 2: busca en qué Lugar físico está esa Categoria (ej: Lacteo → A-01)
% Si ambos pasos tienen respuesta, Lugar queda instanciado

donde(Tipo, Lugar) :-
    categoria(Categoria, Tipo),   % Paso 1: Tipo pertenece a Categoria
    lugar(Categoria, Lugar).      % Paso 2: Categoria está en Lugar


% ── productos_de_seccion/3 ─────────────────────────────────
% Pregunta: ¿qué productos hay en una sección del mapa?
% Uso: productos_de_seccion('lacteos', Productos, Lugar)
%
% Paso 1: obtiene la metadata de la sección (nombre, pasillo, etc)
% Paso 2: busca todos los tipos que pertenecen a la categoria
% Paso 3: para cada tipo, recolecta todos los productos
% Paso 4: obtiene el lugar físico de la categoria
% Devuelve una lista de productos y el lugar físico

productos_de_seccion(SeccionId, Productos, Lugar) :-
    % Obtiene la categoría Prolog que corresponde al id de sección HTML
    seccion_a_categoria(SeccionId, Categoria),
    % Recolecta todos los productos de esa categoría en una lista
    findall(
        producto(Tipo, Marca, Nombre, Pres, Precio, Com),
        % Condición: el tipo pertenece a la categoria Y existe ese producto
        (categoria(Categoria, Tipo), producto(Tipo, Marca, Nombre, Pres, Precio, Com)),
        Productos
    ),
    % Obtiene el lugar físico de la categoria (para mostrar en la vista)
    lugar(Categoria, Lugar).


% ── seccion_a_categoria/2 ──────────────────────────────────
% Mapea el id de sección del frontend al átomo de categoría en db.pl
% Necesario porque el frontend usa ids en minúsculas sin acentos
% y la db usa categorías con mayúscula y en español

seccion_a_categoria('lacteos',    'Lacteo').
seccion_a_categoria('bebidas',    'Bebida').
seccion_a_categoria('snacks',     'Snack').
seccion_a_categoria('frutas',     'FrutaVerdura').
seccion_a_categoria('carnes',     'CarnesFrios').
seccion_a_categoria('limpieza',   'Limpieza').
seccion_a_categoria('congelados', 'Congelado').
seccion_a_categoria('abarrotes',  'Abarrote').


% ── precio_max/5 ───────────────────────────────────────────
% Pregunta: ¿qué productos cuestan igual o menos que un precio dado?
% Uso: precio_max(30, Tipo, Marca, Nombre, Precio)
%
% Paso 1: obtiene un producto con su precio (ya es número en db.pl)
% Paso 2: verifica que el precio sea menor o igual al máximo
% Si se cumple, devuelve los datos del producto

precio_max(Max, Tipo, Marca, Nombre, Precio) :-
    % Obtiene un producto de la db (Precio ya es número, no átomo)
    producto(Tipo, Marca, Nombre, _, Precio, _),
    % Verifica que el precio no supere el máximo solicitado
    Precio =< Max.


% ── mas_barato/3 ───────────────────────────────────────────
% Pregunta: ¿cuál es el producto más barato de un tipo dado?
% Uso: mas_barato('Leche', Nombre, Precio)
%
% Paso 1: obtiene un producto del tipo solicitado con su precio
% Paso 2: verifica que NO exista otro producto del mismo tipo más barato
%         (si existiera uno más barato, este no sería el mínimo)
% La negación \+ significa "no es demostrable que..."

mas_barato(Tipo, Nombre, Precio) :-
    % Obtiene un candidato a más barato
    producto(Tipo, _, Nombre, _, Precio, _),
    % Verifica que no exista ningún otro producto del mismo tipo
    % con precio estrictamente menor
    \+ (
        producto(Tipo, _, _, _, OtroPrecio, _),
        OtroPrecio < Precio
    ).


% ── mas_caro/3 ─────────────────────────────────────────────
% Pregunta: ¿cuál es el producto más caro de un tipo dado?
% Uso: mas_caro('Queso', Nombre, Precio)
% Mismo principio que mas_barato pero invertido

mas_caro(Tipo, Nombre, Precio) :-
    producto(Tipo, _, Nombre, _, Precio, _),
    % Verifica que no exista ningún otro producto del mismo tipo
    % con precio estrictamente mayor
    \+ (
        producto(Tipo, _, _, _, OtroPrecio, _),
        OtroPrecio > Precio
    ).


% ── buscar_por_nombre/5 ────────────────────────────────────
% Pregunta: ¿existe un producto cuyo nombre contenga cierto texto?
% Uso: buscar_por_nombre('Coca', Tipo, Marca, Nombre, Precio)
%
% Usa sub_atom/5 para buscar subcadenas dentro del nombre
% sub_atom(Atomo, _, _, _, SubCadena) es verdad si SubCadena
% aparece en cualquier posición dentro de Atomo

buscar_por_nombre(Query, Tipo, Marca, Nombre, Precio) :-
    downcase_atom(Query, QueryLower),
    producto(Tipo, Marca, Nombre, _, Precio, _),
    downcase_atom(Nombre, NombreLower),
    downcase_atom(Tipo, TipoLower),
    (
        sub_atom(NombreLower, _, _, _, QueryLower)
    ;
        sub_atom(TipoLower, _, _, _, QueryLower)
    ).


% ── misma_categoria/2 ──────────────────────────────────────
% Pregunta: ¿dos productos pertenecen al mismo tipo?
% Uso: misma_categoria('Marías', 'Oreo')
%
% Paso 1: obtiene el tipo del primer producto
% Paso 2: verifica que el segundo producto tenga el mismo tipo
% Paso 3: verifica que no sean el mismo producto (nombres distintos)

misma_categoria(Nombre1, Nombre2) :-
    % Obtiene el tipo del primer producto
    producto(Tipo, _, Nombre1, _, _, _),
    % Verifica que el segundo pertenezca al mismo tipo
    producto(Tipo, _, Nombre2, _, _, _),
    % Evita que un producto se compare consigo mismo
    Nombre1 \= Nombre2.


% ── todas_las_secciones/1 ──────────────────────────────────
% Obtiene la lista completa de secciones para renderizar el home
% Uso: todas_las_secciones(Secciones)
%
% findall/3 recolecta TODAS las soluciones de un goal en una lista
% Primer arg:  qué queremos guardar en cada elemento de la lista
% Segundo arg: el goal que debe ser verdad para incluirlo
% Tercer arg:  la lista resultante

todas_las_secciones(Secciones) :-
    findall(
        % Cada elemento de la lista será un término seccion/6
        seccion(Id, Nombre, Desc, Icon, Color, Pasillo),
        % Condición: que exista ese hecho en db.pl
        seccion(Id, Nombre, Desc, Icon, Color, Pasillo),
        Secciones
    ).


% ── todas_las_ofertas/1 ────────────────────────────────────
% Obtiene la lista completa de ofertas activas
% Uso: todas_las_ofertas(Ofertas)

todas_las_ofertas(Ofertas) :-
    findall(
        oferta(Id, Desc, Badge, Seccion),
        oferta(Id, Desc, Badge, Seccion),
        Ofertas
    ).


% ── info_producto/6 ────────────────────────────────────────
% Obtiene toda la información de un producto por su nombre exacto
% Uso: info_producto('Marías', Tipo, Marca, Pres, Precio, Com)

info_producto(Nombre, Tipo, Marca, Presentacion, Precio, Comentario) :-
    % Busca directamente el producto por nombre en la db
    producto(Tipo, Marca, Nombre, Presentacion, Precio, Comentario).