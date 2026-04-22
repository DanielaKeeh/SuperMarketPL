% ============================================================
%   SECTION TEMPLATE — Vista de productos por sección
% ============================================================

:- module(section, [render_section/2]).
:- use_module('/app/prolog/queries').
:- use_module('/app/prolog/rules').
:- use_module('/app/prolog/templates/layout').

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
    atomic_list_concat([
        '<div class="product-card" data-tipo="', Tipo, '">',
        '<div class="product-card-tags">', TagHTML, '</div>',
        '<div class="product-card-image">🛍️</div>',
        '<div class="product-card-brand">', Marca, '</div>',
        '<div class="product-card-name">', Nombre, '</div>',
        '<div class="product-card-meta">', Pres, '</div>',
        '<div class="product-card-footer">',
        '<span class="product-card-price">$', Precio, '</span>',
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
    atomic_list_concat([
        '<div class="product-card" data-tipo="', Tipo, '">',
        '<div class="product-card-tags">', TagHTML, '</div>',
        '<div class="product-card-image">🛍️</div>',
        '<div class="product-card-brand">', Marca, '</div>',
        '<div class="product-card-name">', Nombre, '</div>',
        '<div class="product-card-meta">', Pres, '</div>',
        '<div class="product-card-footer">',
        '<span class="product-card-price">$', Precio, '</span>',
        '</div>',
        '</div>'
    ], HTML).

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