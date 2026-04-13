% ============================================================
%   SERVIDOR HTTP — MiniSuper FrescaVida
%   Levanta en http://localhost:8080
%   Uso: swipl minisuper_server.pl
% ============================================================

:- use_module(library(http/thread_httpd)).
:- use_module(library(http/http_dispatch)).
:- use_module(library(http/http_json)).
:- use_module(library(http/http_cors)).
:- use_module(library(http/http_files)).
:- use_module(library(json)).

% ────────────────────────────────────────────
% RUTAS
% ────────────────────────────────────────────
:- http_handler(root(.),          serve_index,       []).
:- http_handler(root(api/buscar), api_buscar,        []).
:- http_handler(root(api/donde),  api_donde,         []).
:- http_handler(root(api/precio), api_precio_max,    []).
:- http_handler(root(api/barato), api_mas_barato,    []).
:- http_handler(root(api/info),   api_info,          []).
:- http_handler(root(api/todos),  api_todos,         []).

% ────────────────────────────────────────────
% ARRANQUE
% ────────────────────────────────────────────
:- initialization(main, main).
main :-
    format("~n🌿 MiniSuper FrescaVida — servidor iniciado~n"),
    format("   http://localhost:8080~n~n"),
    http_server(http_dispatch, [port(8080)]),
    thread_get_message(_).   % mantiene vivo el servidor

% ────────────────────────────────────────────
% SERVIR INDEX.HTML
% ────────────────────────────────────────────
serve_index(Request) :-
    http_reply_file('minisuper.html', [], Request).

% ────────────────────────────────────────────
% CORS helper
% ────────────────────────────────────────────
cors_enable :-
    set_setting(http:cors, [*]).

% ════════════════════════════════════════════
% BASE DE CONOCIMIENTO
% ════════════════════════════════════════════

% producto('Tipo', 'Marca', 'Nombre', 'Presentacion', 'Precio', 'Comentario')
producto('Leche',      'Lala',       'Entera',          '1L',    '22', '').
producto('Leche',      'Alpura',     'Deslactosada',    '1L',    '25', 'Sin lactosa').
producto('Yogurt',     'Yoplait',    'Natural',          '900g',  '38', 'Refrigerado').
producto('Refresco',   'Coca-Cola',  'Cola',             '600ml', '18', 'Botella PET').
producto('Jugo',       'Del Valle',  'Naranja',          '1L',    '30', 'Sin azucar').
producto('Agua',       'Bonafont',   'Natural',          '1.5L',  '14', 'Sin gas').
producto('Botana',     'Sabritas',   'Papas Limon',      '45g',   '15', 'Bolsa chica').
producto('Galleta',    'Gamesa',     'Marias',            '200g',  '22', 'Clasico').
producto('Cereal',     'Kelloggs',   'Granola Miel',     '300g',  '45', 'Desayuno').
producto('Cloro',      'Cloralex',   'Liquido',           '1L',    '19', 'Multiusos').
producto('Detergente', 'Ariel',      'Polvo',             '1kg',   '55', 'Ropa blanca').
producto('Lavatrastes','Axion',      'Crema Limon',      '500g',  '28', '').
producto('Fruta',      'A granel',   'Platano',           '1kg',   '18', 'Fresco').
producto('Verdura',    'A granel',   'Jitomate',          '1kg',   '22', 'Fresco').
producto('Verdura',    'A granel',   'Brocoli',           '1kg',   '35', 'Organico').
producto('Fiambre',    'San Rafael', 'Jamon de Pavo',    '200g',  '35', 'Rebanado').
producto('Fiambre',    'FUD',        'Salchicha Viena',  '500g',  '42', '').
producto('Queso',      'Chilchota',  'Manchego',          '400g',  '68', 'Rebanado').

% categoria('Categoria', 'Tipo')
categoria('Lacteo',       'Leche').
categoria('Lacteo',       'Yogurt').
categoria('Bebida',       'Refresco').
categoria('Bebida',       'Jugo').
categoria('Bebida',       'Agua').
categoria('Snack',        'Botana').
categoria('Snack',        'Galleta').
categoria('Snack',        'Cereal').
categoria('Limpieza',     'Cloro').
categoria('Limpieza',     'Detergente').
categoria('Limpieza',     'Lavatrastes').
categoria('FrutaVerdura', 'Fruta').
categoria('FrutaVerdura', 'Verdura').
categoria('CarnesFrios',  'Fiambre').
categoria('CarnesFrios',  'Queso').

% lugar('Categoria', 'Lugar en tienda')
lugar('Lacteo',       'Anaquel refrigerado — lado izquierdo (A-01)').
lugar('CarnesFrios',  'Anaquel refrigerado — lado izquierdo (A-01)').
lugar('FrutaVerdura', 'Seccion de frescos — fila superior (C-01)').
lugar('Bebida',       'Pasillo central (D-01 y D-02)').
lugar('Snack',        'Pasillo central (E-01 y E-02)').
lugar('Limpieza',     'Anaquel derecho — lado derecho (F-01)').

% ════════════════════════════════════════════
% REGLAS
% ════════════════════════════════════════════

donde(X, Z) :- categoria(Y, X), lugar(Y, Z).

buscar(Cat, Tipo, Marca, Nombre, Precio) :-
    categoria(Cat, Tipo),
    producto(Tipo, Marca, Nombre, _, Precio, _).

precio_max(Max, Tipo, Marca, Nombre, Presentacion, Precio) :-
    producto(Tipo, Marca, Nombre, Presentacion, PrecioAtom, _),
    atom_number(PrecioAtom, Precio),
    Precio =< Max.

mas_barato(Tipo, Nombre, Precio) :-
    producto(Tipo, _, Nombre, _, PrecioAtom, _),
    atom_number(PrecioAtom, Precio),
    \+ (producto(Tipo, _, _, _, OtroAtom, _),
        atom_number(OtroAtom, Otro),
        Otro < Precio).

% ════════════════════════════════════════════
% HANDLERS DE API  →  responden JSON
% ════════════════════════════════════════════

% GET /api/todos
% Devuelve todos los productos
api_todos(_Request) :-
    cors_enable,
    findall(
        json([tipo=Tipo, marca=Marca, nombre=Nombre,
              presentacion=Pres, precio=Precio, comentario=Com]),
        producto(Tipo, Marca, Nombre, Pres, Precio, Com),
        Lista
    ),
    reply_json(json([ok=true, productos=Lista])).

% GET /api/buscar?cat=Lacteo
api_buscar(Request) :-
    cors_enable,
    http_parameters(Request, [cat(Cat, [])]),
    findall(
        json([tipo=Tipo, marca=Marca, nombre=Nombre, precio=Precio]),
        buscar(Cat, Tipo, Marca, Nombre, Precio),
        Lista
    ),
    reply_json(json([ok=true, categoria=Cat, productos=Lista])).

% GET /api/donde?tipo=Yogurt
api_donde(Request) :-
    cors_enable,
    http_parameters(Request, [tipo(Tipo, [])]),
    (   donde(Tipo, Lugar)
    ->  reply_json(json([ok=true, tipo=Tipo, lugar=Lugar]))
    ;   reply_json(json([ok=false, error='Tipo no encontrado']))
    ).

% GET /api/precio?max=25
api_precio_max(Request) :-
    cors_enable,
    http_parameters(Request, [max(MaxAtom, [])]),
    atom_number(MaxAtom, Max),
    findall(
        json([tipo=Tipo, marca=Marca, nombre=Nombre,
              presentacion=Pres, precio=Precio]),
        precio_max(Max, Tipo, Marca, Nombre, Pres, Precio),
        Lista
    ),
    reply_json(json([ok=true, max=MaxAtom, productos=Lista])).

% GET /api/barato?tipo=Leche
api_mas_barato(Request) :-
    cors_enable,
    http_parameters(Request, [tipo(Tipo, [])]),
    (   mas_barato(Tipo, Nombre, Precio)
    ->  reply_json(json([ok=true, tipo=Tipo, nombre=Nombre, precio=Precio]))
    ;   reply_json(json([ok=false, error='Sin resultados']))
    ).

% GET /api/info?nombre=Manchego
api_info(Request) :-
    cors_enable,
    http_parameters(Request, [nombre(Nombre, [])]),
    (   producto(Tipo, Marca, Nombre, Pres, Precio, Com)
    ->  reply_json(json([ok=true, tipo=Tipo, marca=Marca, nombre=Nombre,
                         presentacion=Pres, precio=Precio, comentario=Com]))
    ;   reply_json(json([ok=false, error='Producto no encontrado']))
    ).
