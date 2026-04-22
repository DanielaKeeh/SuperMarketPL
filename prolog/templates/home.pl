% ============================================================
%   HOME TEMPLATE — Vista principal con mapa + section cards
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
    render_store_map(MapHTML),
    render_ofertas_bar(Ofertas, OfertasHTML),
    render_home_grid(Secciones, GridHTML),
    atomic_list_concat([
        '<div class="page-body">',
        HeaderHTML,
        MapHTML,
        OfertasHTML,
        GridHTML,
        '</div>'
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

% ── render_store_map/1 ───────────────────────────────────────
% Layout: fondo x=30 w=800 → área útil x=50..810
% Fila superior: 4 zonas x=50,240,430,620 width=180 gap=10 → última termina en 800 ✓
% Fila inferior: 5 zonas x=50,198,346,494,642 width=138 gap=10 → última termina en 780 ✓
render_store_map(HTML) :-
    atomic_list_concat([
        '<div class="store-map-container">',
        '<svg viewBox="0 0 860 500" xmlns="http://www.w3.org/2000/svg" class="store-map-svg">',

        % Fondo
        '<rect x="30" y="18" width="800" height="462" rx="22" fill="#f2f7f4" stroke="#c8ddd2" stroke-width="1.5"/>',

        % Titulo
        '<text x="430" y="46" text-anchor="middle" font-family="Plus Jakarta Sans,sans-serif" font-size="12" font-weight="600" fill="#4a6358" letter-spacing="2">PLANTA BAJA \u2014 FRESCAVIDA</text>',

        % ── FILA SUPERIOR: 4 zonas width=180 gap=10 ──

        % LACTEOS x=50
        '<g class="map-zone" onclick="window.location.href=\'/section/lacteos\'" style="cursor:pointer">',
        '<rect x="50" y="62" width="180" height="115" rx="14" fill="#b7e4c7" stroke="#52b788" stroke-width="1.5"/>',
        '<text x="140" y="105" text-anchor="middle" font-family="Plus Jakarta Sans,sans-serif" font-size="18" fill="#1b4332">&#x1F9C0;</text>',
        '<text x="140" y="128" text-anchor="middle" font-family="Plus Jakarta Sans,sans-serif" font-size="12" font-weight="700" fill="#1b4332">L&#xE1;cteos</text>',
        '<text x="140" y="146" text-anchor="middle" font-family="Plus Jakarta Sans,sans-serif" font-size="10" fill="#2d6a4f">Pasillo A-01</text>',
        '</g>',

        % CARNES x=240
        '<g class="map-zone" onclick="window.location.href=\'/section/carnes\'" style="cursor:pointer">',
        '<rect x="240" y="62" width="180" height="115" rx="14" fill="#ffd6d6" stroke="#e07070" stroke-width="1.5"/>',
        '<text x="330" y="105" text-anchor="middle" font-family="Plus Jakarta Sans,sans-serif" font-size="18" fill="#7b1d1d">&#x1F969;</text>',
        '<text x="330" y="128" text-anchor="middle" font-family="Plus Jakarta Sans,sans-serif" font-size="12" font-weight="700" fill="#7b1d1d">Carnes &amp; Fr&#xED;o</text>',
        '<text x="330" y="146" text-anchor="middle" font-family="Plus Jakarta Sans,sans-serif" font-size="10" fill="#9b2c2c">Pasillo B-01</text>',
        '</g>',

        % FRUTAS x=430
        '<g class="map-zone" onclick="window.location.href=\'/section/frutas\'" style="cursor:pointer">',
        '<rect x="430" y="62" width="180" height="115" rx="14" fill="#d8f3dc" stroke="#74c69d" stroke-width="1.5"/>',
        '<text x="520" y="105" text-anchor="middle" font-family="Plus Jakarta Sans,sans-serif" font-size="18" fill="#1b4332">&#x1F966;</text>',
        '<text x="520" y="128" text-anchor="middle" font-family="Plus Jakarta Sans,sans-serif" font-size="12" font-weight="700" fill="#1b4332">Frutas &amp; Verduras</text>',
        '<text x="520" y="146" text-anchor="middle" font-family="Plus Jakarta Sans,sans-serif" font-size="10" fill="#2d6a4f">Pasillo C-01</text>',
        '</g>',

        % BEBIDAS x=620 width=180 → termina en 800 ✓
        '<g class="map-zone" onclick="window.location.href=\'/section/bebidas\'" style="cursor:pointer">',
        '<rect x="620" y="62" width="180" height="115" rx="14" fill="#c9e8ff" stroke="#5aafef" stroke-width="1.5"/>',
        '<text x="710" y="105" text-anchor="middle" font-family="Plus Jakarta Sans,sans-serif" font-size="18" fill="#1a3a5c">&#x1F9C3;</text>',
        '<text x="710" y="128" text-anchor="middle" font-family="Plus Jakarta Sans,sans-serif" font-size="12" font-weight="700" fill="#1a3a5c">Bebidas</text>',
        '<text x="710" y="146" text-anchor="middle" font-family="Plus Jakarta Sans,sans-serif" font-size="10" fill="#1d4e89">Pasillo D-01</text>',
        '</g>',

        % PASILLO CENTRAL
        '<rect x="50" y="197" width="750" height="28" rx="8" fill="#e8f4ee" stroke="#a8d5b5" stroke-width="1" stroke-dasharray="6,4"/>',
        '<text x="425" y="216" text-anchor="middle" font-family="Plus Jakarta Sans,sans-serif" font-size="10" fill="#4a6358" letter-spacing="1">PASILLO CENTRAL</text>',

        % ── FILA INFERIOR: 5 zonas x=50,198,346,494,642 width=138 gap=10 ──

        % SNACKS x=50
        '<g class="map-zone" onclick="window.location.href=\'/section/snacks\'" style="cursor:pointer">',
        '<rect x="50" y="243" width="138" height="115" rx="14" fill="#ffe8cc" stroke="#f4a261" stroke-width="1.5"/>',
        '<text x="119" y="286" text-anchor="middle" font-family="Plus Jakarta Sans,sans-serif" font-size="18" fill="#7c3d00">&#x1F37F;</text>',
        '<text x="119" y="309" text-anchor="middle" font-family="Plus Jakarta Sans,sans-serif" font-size="11" font-weight="700" fill="#7c3d00">Snacks &amp; Botanas</text>',
        '<text x="119" y="327" text-anchor="middle" font-family="Plus Jakarta Sans,sans-serif" font-size="10" fill="#9c4a00">Pasillo E-01</text>',
        '</g>',

        % HARINAS x=198
        '<g class="map-zone" onclick="window.location.href=\'/section/panaderia\'" style="cursor:pointer">',
        '<rect x="198" y="243" width="138" height="115" rx="14" fill="#fff3cd" stroke="#e6b800" stroke-width="1.5"/>',
        '<text x="267" y="286" text-anchor="middle" font-family="Plus Jakarta Sans,sans-serif" font-size="18" fill="#5c4a00">&#x1F35E;</text>',
        '<text x="267" y="309" text-anchor="middle" font-family="Plus Jakarta Sans,sans-serif" font-size="11" font-weight="700" fill="#5c4a00">Harinas &amp; Panadera</text>',
        '<text x="267" y="327" text-anchor="middle" font-family="Plus Jakarta Sans,sans-serif" font-size="10" fill="#7a6200">Pasillo F-01</text>',
        '</g>',

        % ABARROTES x=346
        '<g class="map-zone" onclick="window.location.href=\'/section/abarrotes\'" style="cursor:pointer">',
        '<rect x="346" y="243" width="138" height="115" rx="14" fill="#ede9fe" stroke="#a78bfa" stroke-width="1.5"/>',
        '<text x="415" y="286" text-anchor="middle" font-family="Plus Jakarta Sans,sans-serif" font-size="18" fill="#3b0764">&#x1F96B;</text>',
        '<text x="415" y="309" text-anchor="middle" font-family="Plus Jakarta Sans,sans-serif" font-size="11" font-weight="700" fill="#3b0764">Abarrotes</text>',
        '<text x="415" y="327" text-anchor="middle" font-family="Plus Jakarta Sans,sans-serif" font-size="10" fill="#5b21b6">Pasillo D-02</text>',
        '</g>',

        % LIMPIEZA x=494
        '<g class="map-zone" onclick="window.location.href=\'/section/limpieza\'" style="cursor:pointer">',
        '<rect x="494" y="243" width="138" height="115" rx="14" fill="#e0f0ff" stroke="#7ab8f5" stroke-width="1.5"/>',
        '<text x="563" y="286" text-anchor="middle" font-family="Plus Jakarta Sans,sans-serif" font-size="18" fill="#1e3a5f">&#x1F9F9;</text>',
        '<text x="563" y="309" text-anchor="middle" font-family="Plus Jakarta Sans,sans-serif" font-size="11" font-weight="700" fill="#1e3a5f">Limpieza</text>',
        '<text x="563" y="327" text-anchor="middle" font-family="Plus Jakarta Sans,sans-serif" font-size="10" fill="#1d4e89">Pasillo F-02</text>',
        '</g>',

        % CONGELADOS x=642 → termina en 780 ✓
        '<g class="map-zone" onclick="window.location.href=\'/section/congelados\'" style="cursor:pointer">',
        '<rect x="642" y="243" width="138" height="115" rx="14" fill="#dff4ff" stroke="#38bdf8" stroke-width="1.5"/>',
        '<text x="711" y="286" text-anchor="middle" font-family="Plus Jakarta Sans,sans-serif" font-size="18" fill="#0c4a6e">&#x1F9CA;</text>',
        '<text x="711" y="309" text-anchor="middle" font-family="Plus Jakarta Sans,sans-serif" font-size="11" font-weight="700" fill="#0c4a6e">Congelados</text>',
        '<text x="711" y="327" text-anchor="middle" font-family="Plus Jakarta Sans,sans-serif" font-size="10" fill="#0369a1">Pasillo E-02</text>',
        '</g>',

        % CAJAS
        '<rect x="220" y="382" width="420" height="58" rx="12" fill="#e5e7eb" stroke="#9ca3af" stroke-width="1.5"/>',
        '<text x="430" y="406" text-anchor="middle" font-family="Plus Jakarta Sans,sans-serif" font-size="11" font-weight="600" fill="#374151">&#x1F4B0; CAJAS</text>',
        '<text x="430" y="426" text-anchor="middle" font-family="Plus Jakarta Sans,sans-serif" font-size="10" fill="#6b7280">3 cajas disponibles</text>',

        % ENTRADA
        '<rect x="360" y="452" width="140" height="20" rx="6" fill="#012d1d"/>',
        '<text x="430" y="467" text-anchor="middle" font-family="Plus Jakarta Sans,sans-serif" font-size="10" font-weight="600" fill="#ffffff" letter-spacing="1">ENTRADA</text>',

        '</svg>',

        % Leyenda
        '<div class="store-map-legend">',
        '<div class="store-map-legend-item"><span style="background:#b7e4c7;border:1.5px solid #52b788"></span>L&#xE1;cteos</div>',
        '<div class="store-map-legend-item"><span style="background:#ffd6d6;border:1.5px solid #e07070"></span>Carnes &amp; Fr&#xED;o</div>',
        '<div class="store-map-legend-item"><span style="background:#d8f3dc;border:1.5px solid #74c69d"></span>Frutas &amp; Verduras</div>',
        '<div class="store-map-legend-item"><span style="background:#c9e8ff;border:1.5px solid #5aafef"></span>Bebidas</div>',
        '<div class="store-map-legend-item"><span style="background:#ffe8cc;border:1.5px solid #f4a261"></span>Snacks &amp; Botanas</div>',
        '<div class="store-map-legend-item"><span style="background:#fff3cd;border:1.5px solid #e6b800"></span>Harinas &amp; Panadera</div>',
        '<div class="store-map-legend-item"><span style="background:#ede9fe;border:1.5px solid #a78bfa"></span>Abarrotes</div>',
        '<div class="store-map-legend-item"><span style="background:#e0f0ff;border:1.5px solid #7ab8f5"></span>Limpieza</div>',
        '<div class="store-map-legend-item"><span style="background:#dff4ff;border:1.5px solid #38bdf8"></span>Congelados</div>',
        '</div>',
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
        '<div class="section-card-link">Browse Selection &#8594;</div>',
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