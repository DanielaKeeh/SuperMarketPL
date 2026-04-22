% ============================================================
%   SECTION TEMPLATE — Vista de productos por sección
% ============================================================

:- module(section, [render_section/2]).
:- use_module('/app/prolog/queries').
:- use_module('/app/prolog/rules').
:- use_module('/app/prolog/templates/layout').

:- discontiguous section:product_svg/2.

render_section(SeccionId, HTML) :-
    query_productos_seccion(SeccionId, Productos, json(Info)),
    member(nombre=Nombre, Info),
    render_section_body(SeccionId, Productos, json(Info), BodyHTML),
    render_layout(Nombre, Nombre, BodyHTML, HTML).

render_section_body(SeccionId, Productos, Info, HTML) :-
    render_section_header(SeccionId, Info, HeaderHTML),
    render_section_filters(Productos, FiltersHTML),
    render_products_grid(Productos, GridHTML),
    atomic_list_concat([
        HeaderHTML,
        FiltersHTML,
        GridHTML
    ], HTML).

render_section_header(_SeccionId, json(Info), HTML) :-
    member(nombre=Nombre,    Info),
    member(descripcion=Desc, Info),
    member(icon=Icon,        Info),
    member(pasillo=Pasillo,  Info),
    member(lugar=Lugar,      Info),
    atomic_list_concat([
        '<div class="section-header">',
        '<div class="section-header-top">',
        '<div class="section-header-info">',
        '<div class="section-header-pasillo">',
        '📍 ', Pasillo,
        '</div>',
        '<h1 class="section-header-title">',
        Icon, ' ', Nombre,
        '</h1>',
        '<p class="section-header-desc">', Desc, '</p>',
        '</div>',
        '</div>',
        '<div class="section-location">',
        '<div class="section-location-dot"></div>',
        Lugar,
        '</div>',
        '</div>'
    ], HTML).

render_section_filters(Productos, HTML) :-
    maplist([json(P), Tipo]>>(member(tipo=Tipo, P)), Productos, Tipos),
    list_to_set(Tipos, TiposUnicos),
    maplist(render_filter_chip, TiposUnicos, ChipsHTML),
    atomic_list_concat(ChipsHTML, ChipsStr),
    atomic_list_concat([
        '<div class="section-filters">',
        '<span class="section-filters-label">Filtrar</span>',
        '<button class="chip chip-active">Todos</button>',
        ChipsStr,
        '</div>'
    ], HTML).

render_filter_chip(Tipo, HTML) :-
    atomic_list_concat([
        '<button class="chip chip-filter"',
        ' onclick="filterProducts(\'', Tipo, '\')">',
        Tipo,
        '</button>'
    ], HTML).

render_products_grid([], HTML) :-
    atomic_list_concat([
        '<div class="empty-state">',
        '<div class="empty-state-icon">🔍</div>',
        '<div class="empty-state-title">Sin productos</div>',
        '<div class="empty-state-desc">',
        'No hay productos registrados en esta sección.',
        '</div>',
        '</div>'
    ], HTML).

render_products_grid([Featured | Rest], HTML) :-
    render_product_card_featured(Featured, FeaturedHTML),
    maplist(render_product_card, Rest, CardsHTML),
    atomic_list_concat(CardsHTML, CardsStr),
    atomic_list_concat([
        '<div class="products-grid">',
        FeaturedHTML,
        CardsStr,
        '</div>'
    ], HTML).

render_product_card_featured(json(Producto), HTML) :-
    member(nombre=Nombre,       Producto),
    member(marca=Marca,         Producto),
    member(presentacion=Pres,   Producto),
    member(precio=Precio,       Producto),
    member(comentario=Com,      Producto),
    member(tipo=Tipo,           Producto),
    render_producto_tag(Com, TagHTML),
    product_svg(Tipo, SVG),
    atomic_list_concat([
        '<div class="product-card" data-tipo="', Tipo, '">',
        '<div class="product-card-tags">', TagHTML, '</div>',
        '<div class="product-card-image">',
        '<div class="icon-circle icon-circle-lg">', SVG, '</div>',
        '</div>',
        '<div class="product-card-brand">', Marca, '</div>',
        '<div class="product-card-name">', Nombre, '</div>',
        '<div class="product-card-meta">', Pres, '</div>',
        '<div class="product-card-footer">',
        '<span class="product-card-price">$', Precio, '</span>',
        '<button class="btn-icon"',
        ' data-add-cart',
        ' data-nombre="', Nombre, '"',
        ' data-marca="',  Marca,  '"',
        ' data-precio="', Precio, '">',
        '<svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="9" cy="21" r="1"/><circle cx="20" cy="21" r="1"/><path d="M1 1h4l2.68 13.39a2 2 0 0 0 2 1.61h9.72a2 2 0 0 0 2-1.61L23 6H6"/></svg>',
        '</button>',
        '</div>',
        '</div>'
    ], HTML).

render_product_card(json(Producto), HTML) :-
    member(nombre=Nombre,     Producto),
    member(marca=Marca,       Producto),
    member(presentacion=Pres, Producto),
    member(precio=Precio,     Producto),
    member(comentario=Com,    Producto),
    member(tipo=Tipo,         Producto),
    render_producto_tag(Com, TagHTML),
    product_svg(Tipo, SVG),
    atomic_list_concat([
        '<div class="product-card" data-tipo="', Tipo, '">',
        '<div class="product-card-tags">', TagHTML, '</div>',
        '<div class="product-card-image">',
        '<div class="icon-circle icon-circle-lg">', SVG, '</div>',
        '</div>',
        '<div class="product-card-brand">', Marca, '</div>',
        '<div class="product-card-name">', Nombre, '</div>',
        '<div class="product-card-meta">', Pres, '</div>',
        '<div class="product-card-footer">',
        '<span class="product-card-price">$', Precio, '</span>',
        '<button class="btn-icon"',
        ' data-add-cart',
        ' data-nombre="', Nombre, '"',
        ' data-marca="',  Marca,  '"',
        ' data-precio="', Precio, '">',
        '<svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="9" cy="21" r="1"/><circle cx="20" cy="21" r="1"/><path d="M1 1h4l2.68 13.39a2 2 0 0 0 2 1.61h9.72a2 2 0 0 0 2-1.61L23 6H6"/></svg>',
        '</button>',
        '</div>',
        '</div>'
    ], HTML).

% ── SVGs por tipo de producto ────────────────────────────────
product_svg('Leche',
    '<svg xmlns="http://www.w3.org/2000/svg" width="32" height="32" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M8 2h8l1 6H7L8 2z"/><path d="M7 8c0 0-2 1.5-2 6s2 8 2 8h10s2-3 2-8-2-6-2-6"/><line x1="7" y1="13" x2="17" y2="13"/></svg>').

product_svg('Yogurt',
    '<svg xmlns="http://www.w3.org/2000/svg" width="32" height="32" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M8 2h8v3H8z"/><path d="M7 5h10l1 15H6L7 5z"/><line x1="9" y1="11" x2="15" y2="11"/></svg>').

product_svg('Queso',
    '<svg xmlns="http://www.w3.org/2000/svg" width="32" height="32" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M3 11L12 3l9 8v10H3V11z"/><circle cx="9" cy="14" r="1.5"/><circle cx="15" cy="12" r="1"/></svg>').

product_svg('Mantequilla',
    '<svg xmlns="http://www.w3.org/2000/svg" width="32" height="32" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><rect x="3" y="7" width="18" height="12" rx="2"/><path d="M3 11h18"/><path d="M7 7V5a2 2 0 0 1 4 0v2"/></svg>').

product_svg('Crema',
    '<svg xmlns="http://www.w3.org/2000/svg" width="32" height="32" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M8 3h8v4H8z"/><path d="M7 7h10l1 14H6L7 7z"/><path d="M10 12c0 1.1.9 2 2 2s2-.9 2-2"/></svg>').

product_svg('Refresco',
    '<svg xmlns="http://www.w3.org/2000/svg" width="32" height="32" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M8 2h8l2 4H6L8 2z"/><path d="M6 6l1 14h10l1-14"/><line x1="9" y1="11" x2="15" y2="11"/></svg>').

product_svg('Agua',
    '<svg xmlns="http://www.w3.org/2000/svg" width="32" height="32" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M12 2L6 10a6 6 0 1 0 12 0L12 2z"/></svg>').

product_svg('Jugo',
    '<svg xmlns="http://www.w3.org/2000/svg" width="32" height="32" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M9 2h6v3H9z"/><path d="M8 5h8l1 15H7L8 5z"/><path d="M10 10c0 1.1.9 2 2 2s2-.9 2-2"/></svg>').

product_svg('Energetica',
    '<svg xmlns="http://www.w3.org/2000/svg" width="32" height="32" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><polygon points="13 2 3 14 12 14 11 22 21 10 12 10 13 2"/></svg>').

product_svg('Botana',
    '<svg xmlns="http://www.w3.org/2000/svg" width="32" height="32" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M3 9h18v10a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V9z"/><path d="M3 9l2-5h14l2 5"/><line x1="12" y1="9" x2="12" y2="21"/></svg>').

product_svg('Galleta',
    '<svg xmlns="http://www.w3.org/2000/svg" width="32" height="32" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="9"/><circle cx="9" cy="10" r="1" fill="currentColor"/><circle cx="14" cy="8" r="1" fill="currentColor"/><circle cx="15" cy="13" r="1" fill="currentColor"/><circle cx="10" cy="15" r="1" fill="currentColor"/></svg>').

product_svg('Cereal',
    '<svg xmlns="http://www.w3.org/2000/svg" width="32" height="32" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M6 2h12v6l2 4v8a2 2 0 0 1-2 2H6a2 2 0 0 1-2-2v-8l2-4V2z"/><line x1="4" y1="12" x2="20" y2="12"/></svg>').

product_svg('Fruta',
    '<svg xmlns="http://www.w3.org/2000/svg" width="32" height="32" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M12 2a9 9 0 0 1 9 9c0 5-4 11-9 11S3 16 3 11a9 9 0 0 1 9-9z"/><path d="M12 2c0 0 2-1 4 1"/><line x1="12" y1="7" x2="12" y2="2"/></svg>').

product_svg('Verdura',
    '<svg xmlns="http://www.w3.org/2000/svg" width="32" height="32" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M12 22V12"/><path d="M12 12C12 12 7 10 7 5a5 5 0 0 1 10 0c0 5-5 7-5 7z"/><path d="M12 12c0 0-3 1-5 5"/></svg>').

product_svg('Fiambre',
    '<svg xmlns="http://www.w3.org/2000/svg" width="32" height="32" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><ellipse cx="12" cy="12" rx="9" ry="5"/><path d="M3 12v5c0 2.8 4 5 9 5s9-2.2 9-5v-5"/></svg>').

product_svg('Cloro',
    '<svg xmlns="http://www.w3.org/2000/svg" width="32" height="32" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M9 3h6v4H9z"/><path d="M7 7h10l1 14H6L7 7z"/><path d="M12 11v4"/><path d="M10 13h4"/></svg>').

product_svg('Detergente',
    '<svg xmlns="http://www.w3.org/2000/svg" width="32" height="32" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M8 3h8v4H8z"/><path d="M6 7h12l1 14H5L6 7z"/><circle cx="12" cy="14" r="3"/></svg>').

product_svg('Lavatrastes',
    '<svg xmlns="http://www.w3.org/2000/svg" width="32" height="32" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M8 3h8v5H8z"/><path d="M7 8h10l1 13H6L7 8z"/><path d="M10 13c0 1.1.9 2 2 2s2-.9 2-2-.9-2-2-2-2 .9-2 2z"/></svg>').

product_svg('Limpiador',
    '<svg xmlns="http://www.w3.org/2000/svg" width="32" height="32" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M9 3h6v4H9z"/><path d="M9 7c0 0-4 2-4 8s2 6 2 6h10s2 0 2-6-4-8-4-8"/><line x1="12" y1="12" x2="12" y2="16"/><line x1="10" y1="14" x2="14" y2="14"/></svg>').

product_svg('Helado',
    '<svg xmlns="http://www.w3.org/2000/svg" width="32" height="32" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M7 11l5 9 5-9"/><path d="M5 8a7 7 0 0 1 14 0v3H5V8z"/></svg>').

product_svg('Congelado',
    '<svg xmlns="http://www.w3.org/2000/svg" width="32" height="32" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><line x1="12" y1="2" x2="12" y2="22"/><line x1="2" y1="12" x2="22" y2="12"/><line x1="5" y1="5" x2="19" y2="19"/><line x1="19" y1="5" x2="5" y2="19"/><circle cx="12" cy="12" r="2"/></svg>').

product_svg('Lata',
    '<svg xmlns="http://www.w3.org/2000/svg" width="32" height="32" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M6 2h12a2 2 0 0 1 2 2v16a2 2 0 0 1-2 2H6a2 2 0 0 1-2-2V4a2 2 0 0 1 2-2z"/><line x1="8" y1="8" x2="16" y2="8"/><line x1="8" y1="12" x2="16" y2="12"/><line x1="8" y1="16" x2="12" y2="16"/></svg>').

product_svg('Pasta',
    '<svg xmlns="http://www.w3.org/2000/svg" width="32" height="32" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M3 12h18"/><path d="M3 8c0 0 4-4 9-4s9 4 9 4"/><path d="M3 16c0 0 4 4 9 4s9-4 9-4"/></svg>').

product_svg('Salsa',
    '<svg xmlns="http://www.w3.org/2000/svg" width="32" height="32" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M9 2h6v4l2 2v12a2 2 0 0 1-2 2H9a2 2 0 0 1-2-2V8l2-2V2z"/><line x1="7" y1="12" x2="17" y2="12"/></svg>').

product_svg('Aceite',
    '<svg xmlns="http://www.w3.org/2000/svg" width="32" height="32" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M10 2h4v3l3 3v12a2 2 0 0 1-2 2H9a2 2 0 0 1-2-2V8l3-3V2z"/><path d="M9 12c0 1.7 1.3 3 3 3s3-1.3 3-3"/></svg>').

% Fallback para tipos no mapeados
product_svg(_,
    '<svg xmlns="http://www.w3.org/2000/svg" width="32" height="32" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M6 2h12l3 7H3L6 2z"/><path d="M3 9h18v11a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V9z"/></svg>').

render_producto_tag('', '').
render_producto_tag(Com, HTML) :-
    Com \= '',
    tag_class(Com, Class),
    atomic_list_concat([
        '<span class="tag ', Class, '">', Com, '</span>'
    ], HTML).

tag_class(Com, 'tag-blue')   :- sub_atom(Com, _, _, _, 'frío'),       !.
tag_class(Com, 'tag-blue')   :- sub_atom(Com, _, _, _, 'Refrigerado'), !.
tag_class(Com, 'tag-green')  :- sub_atom(Com, _, _, _, 'Orgánico'),   !.
tag_class(Com, 'tag-green')  :- sub_atom(Com, _, _, _, 'Natural'),    !.
tag_class(Com, 'tag-amber')  :- sub_atom(Com, _, _, _, 'azúcar'),     !.
tag_class(Com, 'tag-purple') :- sub_atom(Com, _, _, _, 'lactosa'),    !.
tag_class(_,   'tag-green').