% ============================================================
%   MAP TEMPLATE — Vista del mapa de la tienda
% ============================================================

:- module(map, [render_map/1]).
:- use_module('/app/prolog/queries').
:- use_module('/app/prolog/templates/layout').

render_map(HTML) :-
    query_secciones(Secciones),
    render_map_body(Secciones, BodyHTML),
    render_layout('Mapa de Tienda', 'MAPA DE LA TIENDA', BodyHTML, HTML).

render_map_body(Secciones, HTML) :-
    render_map_header(HeaderHTML),
    render_map_search(SearchHTML),
    render_map_toggle(ToggleHTML),
    render_directory(Secciones, DirectoryHTML),
    render_map_svg(Secciones, SvgHTML),
    render_map_legend(Secciones, LegendHTML),
    atomic_list_concat([
        HeaderHTML,
        SearchHTML,
        ToggleHTML,
        DirectoryHTML,
        SvgHTML,
        LegendHTML
    ], HTML).

render_map_header(HTML) :-
    atomic_list_concat([
        '<div class="page-header">',
        '<div class="page-header-label">Navigation Hub</div>',
        '<h1 class="page-header-title">Mapa de la Tienda</h1>',
        '<p class="page-header-desc">',
        'Encuentra productos y secciones fácilmente.',
        '</p>',
        '</div>'
    ], HTML).

render_map_search(HTML) :-
    atomic_list_concat([
        '<div class="map-search-wrapper">',
        '<div class="search-wrapper">',
        '<span class="search-icon">🔍</span>',
        '<input class="search-input" id="search-input"',
        ' placeholder="Buscar productos, pasillos o categorías..."',
        ' autocomplete="off">',
        '<button class="search-clear" id="search-clear">✕</button>',
        '<div class="search-results" id="search-results"></div>',
        '</div>',
        '</div>'
    ], HTML).

render_map_toggle(HTML) :-
    atomic_list_concat([
        '<div class="map-view-toggle">',
        '<button class="chip chip-active" id="btn-directory"',
        ' onclick="toggleMapView(\'directory\')">',
        '☰ Directorio',
        '</button>',
        '<button class="chip chip-default" id="btn-map"',
        ' onclick="toggleMapView(\'map\')">',
        '🗺️ Mapa',
        '</button>',
        '</div>'
    ], HTML).

render_directory(Secciones, HTML) :-
    maplist(render_directory_item, Secciones, ItemsHTML),
    atomic_list_concat(ItemsHTML, ItemsStr),
    atomic_list_concat([
        '<div class="directory-list" id="view-directory">',
        ItemsStr,
        '</div>'
    ], HTML).

render_directory_item(json(Seccion), HTML) :-
    member(id=Id,           Seccion),
    member(nombre=Nombre,   Seccion),
    member(icon=Icon,       Seccion),
    member(color=Color,     Seccion),
    member(pasillo=Pasillo, Seccion),
    atomic_list_concat([
        '<div class="directory-item" data-link="/section/', Id, '">',
        '<div class="directory-item-icon"',
        ' style="background:', Color, '">',
        Icon,
        '</div>',
        '<div class="directory-item-info">',
        '<span class="directory-item-name">', Nombre, '</span>',
        '<span class="directory-item-status">',
        '<span class="tag tag-green">', Pasillo, '</span>',
        '</span>',
        '</div>',
        '<span class="directory-item-arrow">›</span>',
        '</div>'
    ], HTML).

render_map_svg(Secciones, HTML) :-
    render_map_svg_zones(Secciones, ZonesHTML),
    atomic_list_concat([
        '<div class="map-container" id="view-map" style="display:none">',
        '<svg class="map-svg" viewBox="0 0 800 600"',
        ' xmlns="http://www.w3.org/2000/svg">',
        '<rect x="100" y="50" width="600" height="500"',
        ' rx="20" fill="#f2f7f4" stroke="rgba(1,45,29,0.1)"',
        ' stroke-width="2"/>',
        ZonesHTML,
        '</svg>',
        '<div class="map-density">',
        '<div class="map-density-dot"></div>',
        'Store Live Density: Low',
        '</div>',
        '</div>'
    ], HTML).

zona_pos('lacteos',    120,  80, 100, 200).
zona_pos('carnes',     240,  80, 140, 100).
zona_pos('frutas',     240, 200, 140, 100).
zona_pos('bebidas',    400,  80, 140, 100).
zona_pos('snacks',     400, 200, 140, 100).
zona_pos('limpieza',   560,  80, 100, 200).
zona_pos('congelados', 240, 320, 140, 100).
zona_pos('abarrotes',  400, 320, 140, 100).

render_map_svg_zones(Secciones, HTML) :-
    maplist(render_svg_zone, Secciones, ZonesHTML),
    atomic_list_concat(ZonesHTML, HTML).

render_svg_zone(json(Seccion), HTML) :-
    member(id=Id,       Seccion),
    member(nombre=Nombre, Seccion),
    member(icon=Icon,   Seccion),
    member(color=Color, Seccion),
    (zona_pos(Id, X, Y, W, H) -> true ; X=300, Y=300, W=120, H=80),
    CX is X + W // 2,
    CY is Y + H // 2,
    atomic_list_concat([
        '<g class="map-zone" data-link="/section/', Id, '">',
        '<rect x="', X, '" y="', Y, '"',
        ' width="', W, '" height="', H, '"',
        ' rx="16" fill="', Color, '"',
        ' stroke="rgba(1,45,29,0.08)" stroke-width="1.5"/>',
        '<text x="', CX, '" y="', CY, '"',
        ' text-anchor="middle" dominant-baseline="middle"',
        ' font-size="24">', Icon, '</text>',
        '<text x="', CX, '" y="', CY, '"',
        ' dy="22" text-anchor="middle"',
        ' class="map-label-text">', Nombre, '</text>',
        '</g>'
    ], HTML).

render_map_legend(Secciones, HTML) :-
    maplist(render_legend_item, Secciones, ItemsHTML),
    atomic_list_concat(ItemsHTML, ItemsStr),
    atomic_list_concat([
        '<div class="map-legend">',
        ItemsStr,
        '</div>'
    ], HTML).

render_legend_item(json(Seccion), HTML) :-
    member(nombre=Nombre, Seccion),
    member(color=Color,   Seccion),
    member(id=Id,         Seccion),
    atomic_list_concat([
        '<div class="map-legend-item" data-link="/section/', Id, '">',
        '<div class="map-legend-dot" style="background:', Color, '"></div>',
        Nombre,
        '</div>'
    ], HTML).