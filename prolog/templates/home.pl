% ============================================================
%   HOME TEMPLATE — Vista principal con sección cards
% ============================================================

:- module(home, [render_home/1]).

:- use_module('/app/prolog/queries').
:- use_module('/app/prolog/rules').
:- use_module('/app/prolog/templates/layout').

:- discontiguous home:render_home_header/1.
:- discontiguous home:render_home_grid/2.
:- discontiguous home:render_section_card_featured/2.
:- discontiguous home:render_section_card_secondary/2.
:- discontiguous home:render_section_card_small/2.
:- discontiguous home:render_ofertas_bar/2.
:- discontiguous home:render_oferta_badge/2.

% ── render_home/1 ────────────────────────────────────────────
render_home(HTML) :-
    query_secciones(Secciones),
    query_ofertas(Ofertas),
    render_home_body(Secciones, Ofertas, BodyHTML),
    render_layout('Store Map', 'NAVIGATION HUB', BodyHTML, HTML).

% ── render_home_body/3 ───────────────────────────────────────
render_home_body(Secciones, Ofertas, HTML) :-
    render_home_header(HeaderHTML),
    render_home_grid(Secciones, GridHTML),
    render_ofertas_bar(Ofertas, OfertasHTML),
    atomic_list_concat([
        HeaderHTML,
        OfertasHTML,
        GridHTML
    ], HTML).

% ── render_home_header/1 ─────────────────────────────────────
render_home_header(HTML) :-
    atomic_list_concat([
        '<div class="page-header">',
        '<div class="page-header-label">Navigation Hub</div>',
        '<h1 class="page-header-title">Store Map</h1>',
        '<p class="page-header-desc">',
        'Navigate our botanical halls through curated sections. ',
        'Every aisle is a discovery of freshness and artisan quality.',
        '</p>',
        '</div>'
    ], HTML).

% ── render_home_grid/2 ───────────────────────────────────────
render_home_grid(Secciones, HTML) :-
    Secciones = [Featured, Secondary | Rest],
    render_section_card_featured(Featured, FeaturedHTML),
    render_section_card_secondary(Secondary, SecondaryHTML),
    maplist(render_section_card_small, Rest, RestHTMLs),
    atomic_list_concat(RestHTMLs, RestHTML),
    atomic_list_concat([
        '<div class="home-grid">',
        FeaturedHTML,
        SecondaryHTML,
        RestHTML,
        '</div>'
    ], HTML).

% ── render_section_card_featured/2 ───────────────────────────
render_section_card_featured(json(Seccion), HTML) :-
    member(id=Id,            Seccion),
    member(nombre=Nombre,    Seccion),
    member(descripcion=Desc, Seccion),
    member(icon=Icon,        Seccion),
    member(color=Color,      Seccion),
    atomic_list_concat([
        '<div class="section-card section-card-featured"',
        ' style="background:', Color, '; color: var(--on-surface)"',
        ' data-link="/section/', Id, '">',
        '<div class="section-card-icon">', Icon, '</div>',
        '<div class="section-card-label">Featured Section</div>',
        '<div class="section-card-title">', Nombre, '</div>',
        '<div class="section-card-desc">', Desc, '</div>',
        '<div class="section-card-link">Browse Selection \342\206\222</div>',
        '</div>'
    ], HTML).

% ── render_section_card_secondary/2 ─────────────────────────
render_section_card_secondary(json(Seccion), HTML) :-
    member(id=Id,            Seccion),
    member(nombre=Nombre,    Seccion),
    member(descripcion=Desc, Seccion),
    member(icon=Icon,        Seccion),
    member(color=Color,      Seccion),
    atomic_list_concat([
        '<div class="section-card section-card-secondary"',
        ' style="background:', Color, '"',
        ' data-link="/section/', Id, '">',
        '<div class="section-card-icon">', Icon, '</div>',
        '<div class="section-card-title">', Nombre, '</div>',
        '<div class="section-card-desc">', Desc, '</div>',
        '</div>'
    ], HTML).

% ── render_section_card_small/2 ──────────────────────────────
render_section_card_small(json(Seccion), HTML) :-
    member(id=Id,            Seccion),
    member(nombre=Nombre,    Seccion),
    member(icon=Icon,        Seccion),
    member(color=Color,      Seccion),
    member(descripcion=Desc, Seccion),
    atomic_list_concat([
        '<div class="section-card section-card-small"',
        ' style="background:', Color, '"',
        ' data-link="/section/', Id, '">',
        '<div class="section-card-icon">', Icon, '</div>',
        '<div class="section-card-title">', Nombre, '</div>',
        '<div class="section-card-desc">', Desc, '</div>',
        '</div>'
    ], HTML).

% ── render_ofertas_bar/2 ─────────────────────────────────────
render_ofertas_bar(Ofertas, HTML) :-
    maplist(render_oferta_badge, Ofertas, BadgesHTML),
    atomic_list_concat(BadgesHTML, BadgesStr),
    atomic_list_concat([
        '<div style="display:flex;gap:var(--space-3);',
        'flex-wrap:wrap;margin-bottom:var(--space-6);">',
        BadgesStr,
        '</div>'
    ], HTML).

% ── render_oferta_badge/2 ────────────────────────────────────
render_oferta_badge(json(Oferta), HTML) :-
    member(badge=Badge,      Oferta),
    member(descripcion=Desc, Oferta),
    atomic_list_concat([
        '<div class="oferta-badge">',
        '<strong>', Badge, '</strong> ', Desc,
        '</div>'
    ], HTML).