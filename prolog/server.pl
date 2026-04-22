% ============================================================
%   SERVIDOR HTTP — MiniSuper FrescaVida
% ============================================================

:- use_module(library(http/thread_httpd)).
:- use_module(library(http/http_dispatch)).
:- use_module(library(http/http_json)).
:- use_module(library(http/http_parameters)).
:- use_module(library(http/http_cors)).
:- use_module(library(http/http_files)).

% ── Carga módulos del proyecto ───────────────────────────────
:- use_module('/app/prolog/db').
:- use_module('/app/prolog/rules').
:- use_module('/app/prolog/queries').
:- use_module('/app/prolog/templates/layout').
:- use_module('/app/prolog/templates/home').
:- use_module('/app/prolog/templates/map').
:- use_module('/app/prolog/templates/section').
:- use_module('/app/prolog/templates/office').

% ── Rutas SSR ────────────────────────────────────────────────
:- http_handler(root(.),             view_home,    []).
:- http_handler(root(map),           view_map,     []).
:- http_handler(root(office),        view_office,  []).
:- http_handler(root(section),       view_section, []).
:- http_handler(root(views/home),    view_home,    []).
:- http_handler(root(views/map),     view_map,     []).
:- http_handler(root(views/office),  view_office,  []).
:- http_handler(root(views/section), view_section, []).

% ── Rutas API ────────────────────────────────────────────────
:- http_handler(root(api/secciones),      api_secciones,           []).
:- http_handler(root(api/seccion),        api_seccion,             []).
:- http_handler(root(api/seccion/filtro), api_seccion_filtro,      []).
:- http_handler(root(api/buscar),         api_buscar,              []).
:- http_handler(root(api/precio),         api_precio_max,          []).
:- http_handler(root(api/barato),         api_mas_barato,          []).
:- http_handler(root(api/caro),           api_mas_caro,            []).
:- http_handler(root(api/producto),       api_info_producto,       []).
:- http_handler(root(api/ofertas),        api_ofertas,             []).
:- http_handler(root(api/oficina),        api_oficina,             []).

% ── Estáticos ────────────────────────────────────────────────
:- http_handler(root(css), serve_static, [prefix]).
:- http_handler(root(js),  serve_static, [prefix]).

% ── Arranque ─────────────────────────────────────────────────
:- initialization(main, main).

main :-
    format("~n🌿 MiniSuper FrescaVida — servidor iniciado~n"),
    format("   http://localhost:8080~n~n"),
    http_server(http_dispatch, [port(8080)]),
    thread_get_message(_).

serve_static(Request) :-
    http_reply_from_files('/app/public', [], Request).

cors_enable :-
    set_setting(http:cors, [*]).

% ════════════════════════════════════════════════════════════
%   HANDLERS SSR
% ════════════════════════════════════════════════════════════

view_home(Request) :-
    cors_enable,
    (   memberchk(method(get), Request)
    ->  render_home(HTML),
        format("Content-Type: text/html~n~n~w", [HTML])
    ;   reply_json(json([ok=false, error='Method not allowed']))
    ).

view_map(Request) :-
    cors_enable,
    (   memberchk(method(get), Request)
    ->  render_map(HTML),
        format("Content-Type: text/html~n~n~w", [HTML])
    ;   reply_json(json([ok=false, error='Method not allowed']))
    ).

view_office(Request) :-
    cors_enable,
    (   memberchk(method(get), Request)
    ->  render_office(HTML),
        format("Content-Type: text/html~n~n~w", [HTML])
    ;   reply_json(json([ok=false, error='Method not allowed']))
    ).

view_section(Request) :-
    cors_enable,
    http_parameters(Request, [id(Id, [])]),
    (   render_section(Id, HTML)
    ->  format("Content-Type: text/html~n~n~w", [HTML])
    ;   format("Content-Type: text/html~n~n"),
        format("<div class='empty-state'>Sección no encontrada</div>")
    ).

% ════════════════════════════════════════════════════════════
%   HANDLERS API
% ════════════════════════════════════════════════════════════

api_secciones(_Request) :-
    cors_enable,
    query_secciones(Secciones),
    reply_json(json([ok=true, secciones=Secciones])).

api_seccion(Request) :-
    cors_enable,
    http_parameters(Request, [id(Id, [])]),
    (   query_productos_seccion(Id, Productos, Info)
    ->  reply_json(json([ok=true, info=Info, productos=Productos]))
    ;   reply_json(json([ok=false, error='Sección no encontrada']))
    ).

api_seccion_filtro(Request) :-
    cors_enable,
    http_parameters(Request, [id(Id, []), tipo(Tipo, [])]),
    (   query_productos_seccion_filtrado(Id, Tipo, Productos, Info)
    ->  reply_json(json([ok=true, info=Info, productos=Productos]))
    ;   reply_json(json([ok=false, error='Sin resultados']))
    ).

api_buscar(Request) :-
    cors_enable,
    http_parameters(Request, [q(Query, [])]),
    query_buscar(Query, Resultados),
    reply_json(json([ok=true, resultados=Resultados])).

api_precio_max(Request) :-
    cors_enable,
    http_parameters(Request, [max(MaxAtom, [])]),
    atom_number(MaxAtom, Max),
    query_precio_max(Max, Resultados),
    reply_json(json([ok=true, productos=Resultados])).

api_mas_barato(Request) :-
    cors_enable,
    http_parameters(Request, [tipo(Tipo, [])]),
    (   query_mas_barato(Tipo, Resultado)
    ->  reply_json(json([ok=true, producto=Resultado]))
    ;   reply_json(json([ok=false, error='Sin resultados']))
    ).

api_mas_caro(Request) :-
    cors_enable,
    http_parameters(Request, [tipo(Tipo, [])]),
    (   query_mas_caro(Tipo, Resultado)
    ->  reply_json(json([ok=true, producto=Resultado]))
    ;   reply_json(json([ok=false, error='Sin resultados']))
    ).

api_info_producto(Request) :-
    cors_enable,
    http_parameters(Request, [nombre(Nombre, [])]),
    (   query_info_producto(Nombre, Resultado)
    ->  reply_json(json([ok=true, producto=Resultado]))
    ;   reply_json(json([ok=false, error='Producto no encontrado']))
    ).

api_ofertas(_Request) :-
    cors_enable,
    query_ofertas(Ofertas),
    reply_json(json([ok=true, ofertas=Ofertas])).

api_oficina(_Request) :-
    cors_enable,
    query_oficina(Info),
    reply_json(json([ok=true, oficina=Info])).