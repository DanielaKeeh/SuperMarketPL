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
donde(Tipo, Lugar) :-
    categoria(Categoria, Tipo),
    lugar(Categoria, Lugar).


% ── productos_de_seccion/3 ─────────────────────────────────
productos_de_seccion(SeccionId, Productos, Lugar) :-
    seccion_a_categoria(SeccionId, Categoria),
    findall(
        producto(Tipo, Marca, Nombre, Pres, Precio, Com),
        (categoria(Categoria, Tipo), producto(Tipo, Marca, Nombre, Pres, Precio, Com)),
        Productos
    ),
    lugar(Categoria, Lugar).


% ── seccion_a_categoria/2 ──────────────────────────────────
% Mapea el id de sección del frontend al átomo de categoría en db.pl

seccion_a_categoria('lacteos',    'Lacteo').
seccion_a_categoria('bebidas',    'Bebida').
seccion_a_categoria('snacks',     'Snack').
seccion_a_categoria('frutas',     'FrutaVerdura').
seccion_a_categoria('carnes',     'Carnes').
seccion_a_categoria('harinas',    'Harinas').
seccion_a_categoria('limpieza',   'Limpieza').
seccion_a_categoria('congelados', 'Congelado').
seccion_a_categoria('abarrotes',  'Abarrote').


% ── precio_max/5 ───────────────────────────────────────────
precio_max(Max, Tipo, Marca, Nombre, Precio) :-
    producto(Tipo, Marca, Nombre, _, Precio, _),
    Precio =< Max.


% ── mas_barato/3 ───────────────────────────────────────────
mas_barato(Tipo, Nombre, Precio) :-
    producto(Tipo, _, Nombre, _, Precio, _),
    \+ (
        producto(Tipo, _, _, _, OtroPrecio, _),
        OtroPrecio < Precio
    ).


% ── mas_caro/3 ─────────────────────────────────────────────
mas_caro(Tipo, Nombre, Precio) :-
    producto(Tipo, _, Nombre, _, Precio, _),
    \+ (
        producto(Tipo, _, _, _, OtroPrecio, _),
        OtroPrecio > Precio
    ).


% ── buscar_por_nombre/5 ────────────────────────────────────
buscar_por_nombre(Query, Tipo, Marca, Nombre, Precio) :-
    downcase_atom(Query, QueryLower),
    producto(Tipo, Marca, Nombre, _, Precio, _),
    downcase_atom(Nombre, NombreLower),
    sub_atom(NombreLower, _, _, _, QueryLower).


% ── misma_categoria/2 ──────────────────────────────────────
misma_categoria(Nombre1, Nombre2) :-
    producto(Tipo, _, Nombre1, _, _, _),
    producto(Tipo, _, Nombre2, _, _, _),
    Nombre1 \= Nombre2.


% ── todas_las_secciones/1 ──────────────────────────────────
todas_las_secciones(Secciones) :-
    findall(
        seccion(Id, Nombre, Desc, Icon, Color, Pasillo),
        seccion(Id, Nombre, Desc, Icon, Color, Pasillo),
        Secciones
    ).


% ── todas_las_ofertas/1 ────────────────────────────────────
todas_las_ofertas(Ofertas) :-
    findall(
        oferta(Id, Desc, Badge, Seccion),
        oferta(Id, Desc, Badge, Seccion),
        Ofertas
    ).


% ── info_producto/6 ────────────────────────────────────────
info_producto(Nombre, Tipo, Marca, Presentacion, Precio, Comentario) :-
    producto(Tipo, Marca, Nombre, Presentacion, Precio, Comentario).