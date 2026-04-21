% ============================================================
%   OFFICE TEMPLATE — Vista de oficina y administración
% ============================================================

:- module(office, [render_office/1]).
:- use_module('/app/prolog/queries').
:- use_module('/app/prolog/templates/layout').

render_office(HTML) :-
    query_oficina(json(Info)),
    render_office_body(json(Info), BodyHTML),
    render_layout('Oficina', 'OFFICE', BodyHTML, HTML).

render_office_body(json(Info), HTML) :-
    render_office_hero(json(Info), HeroHTML),
    render_office_horario(json(Info), HorarioHTML),
    render_office_services_header(ServicesHeaderHTML),
    render_office_services(json(Info), ServicesHTML),
    render_office_banner(BannerHTML),
    atomic_list_concat([
        HeroHTML,
        HorarioHTML,
        ServicesHeaderHTML,
        ServicesHTML,
        BannerHTML
    ], HTML).

render_office_hero(json(Info), HTML) :-
    member(encargado=Encargado, Info),
    member(cargo=Cargo,         Info),
    member(correo=Correo,       Info),
    member(telefono=Telefono,   Info),
    member(status=Status,       Info),
    atomic_list_concat([
        '<div class="office-hero">',
        '<div class="office-hero-avatar">KD</div>',
        '<div class="office-hero-info">',
        '<span class="office-hero-role">', Cargo, '</span>',
        '<h1 class="office-hero-name">', Encargado, '</h1>',
        '<p class="office-hero-bio">',
        'Overseeing the botanical excellence and operational integrity ',
        'of FrescaVida. Dedicated to delivering premium fresh experiences ',
        'through curated management.',
        '</p>',
        '<div class="office-hero-contacts">',
        '<a class="office-contact-item" href="mailto:', Correo, '">',
        '<span class="office-contact-icon">✉️</span>',
        Correo,
        '</a>',
        '<a class="office-contact-item" href="tel:', Telefono, '">',
        '<span class="office-contact-icon">📞</span>',
        Telefono,
        '</a>',
        '</div>',
        '</div>',
        '<div class="office-hero-status">',
        '<div class="office-status-card">',
        '<span class="office-status-label">TODAY\'S STATUS</span>',
        '<span class="office-status-value office-status-active">',
        '<div class="office-status-dot"></div>',
        Status,
        '</span>',
        '</div>',
        '<div class="office-status-card">',
        '<span class="office-status-label">NEXT MEETING</span>',
        '<span class="office-status-value">14:30 · Supplier Review</span>',
        '</div>',
        '</div>',
        '</div>'
    ], HTML).

render_office_horario(json(Info), HTML) :-
    member(horario=Horario, Info),
    atomic_list_concat([
        '<div class="office-horario">',
        '🕘 ', Horario,
        '</div>'
    ], HTML).

render_office_services_header(HTML) :-
    atomic_list_concat([
        '<div class="office-services-header">',
        '<h2 class="office-services-title">Administrative Services</h2>',
        '<p class="office-services-desc">',
        'Manage your corporate relationships and retail operations.',
        '</p>',
        '</div>'
    ], HTML).

render_office_services(json(Info), HTML) :-
    member(servicios=Servicios, Info),
    maplist(render_service_card, Servicios, CardsHTML),
    atomic_list_concat(CardsHTML, CardsStr),
    atomic_list_concat([
        '<div class="office-services-grid">',
        CardsStr,
        '</div>'
    ], HTML).

render_service_card(json(Servicio), HTML) :-
    member(icon=Icon,     Servicio),
    member(nombre=Nombre, Servicio),
    member(desc=Desc,     Servicio),
    atomic_list_concat(['Access ', Nombre, ' →'], LinkText),
    atomic_list_concat([
        '<div class="service-card">',
        '<div class="service-card-icon">', Icon, '</div>',
        '<div class="service-card-title">', Nombre, '</div>',
        '<div class="service-card-desc">', Desc, '</div>',
        '<a class="service-card-link" href="#">', LinkText, '</a>',
        '</div>'
    ], HTML).

render_office_banner(HTML) :-
    atomic_list_concat([
        '<div class="office-banner">',
        '<div class="office-banner-content">',
        '<h3 class="office-banner-title">Operational Excellence</h3>',
        '<p class="office-banner-desc">',
        'Our office ensures that the journey from field to shelf ',
        'is handled with the utmost precision and care.',
        '</p>',
        '</div>',
        '</div>'
    ], HTML).