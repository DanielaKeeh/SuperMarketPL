:- module(queries, [query_secciones/1, query_productos_seccion/3,
                    query_buscar/2, query_precio_max/2,
                    query_mas_barato/2, query_mas_caro/2,
                    query_ofertas/1, query_info_producto/2,
                    query_oficina/1]).

:- use_module('/app/prolog/db').
:- use_module('/app/prolog/rules').

query_secciones(JsonList) :-
    todas_las_secciones(Secciones),
    maplist(seccion_a_json, Secciones, JsonList).

seccion_a_json(
    seccion(Id, Nombre, Desc, Icon, Color, Pasillo),
    json([id=Id, nombre=Nombre, descripcion=Desc,
          icon=Icon, color=Color, pasillo=Pasillo])
).

query_productos_seccion(SeccionId, JsonProductos, InfoSeccion) :-
    productos_de_seccion(SeccionId, Productos, Lugar),
    maplist(producto_a_json, Productos, JsonProductos),
    seccion(SeccionId, Nombre, Desc, Icon, Color, Pasillo),
    InfoSeccion = json([
        id=SeccionId, nombre=Nombre, descripcion=Desc,
        icon=Icon, color=Color, pasillo=Pasillo, lugar=Lugar
    ]).

producto_a_json(
    producto(Tipo, Marca, Nombre, Presentacion, Precio, Comentario),
    json([tipo=Tipo, marca=Marca, nombre=Nombre,
          presentacion=Presentacion, precio=Precio,
          comentario=Comentario])
).

query_buscar(Query, Resultados) :-
    findall(
        json([tipo=Tipo, marca=Marca, nombre=Nombre,
              precio=Precio, seccion=SeccionId]),
        (
            buscar_por_nombre(Query, Tipo, Marca, Nombre, Precio),
            categoria(Cat, Tipo),
            seccion_a_categoria(SeccionId, Cat)
        ),
        Resultados
    ).

query_precio_max(Max, Resultados) :-
    findall(
        json([tipo=Tipo, marca=Marca, nombre=Nombre, precio=Precio]),
        precio_max(Max, Tipo, Marca, Nombre, Precio),
        Resultados
    ).

query_mas_barato(Tipo, json([nombre=Nombre, precio=Precio])) :-
    mas_barato(Tipo, Nombre, Precio).

query_mas_caro(Tipo, json([nombre=Nombre, precio=Precio])) :-
    mas_caro(Tipo, Nombre, Precio).

query_ofertas(JsonList) :-
    todas_las_ofertas(Ofertas),
    maplist(oferta_a_json, Ofertas, JsonList).

oferta_a_json(
    oferta(Id, Desc, Badge, Seccion),
    json([id=Id, descripcion=Desc, badge=Badge, seccion=Seccion])
).

query_info_producto(Nombre, json([
    tipo=Tipo, marca=Marca, nombre=Nombre,
    presentacion=Pres, precio=Precio,
    comentario=Com, lugar=Lugar
])) :-
    info_producto(Nombre, Tipo, Marca, Pres, Precio, Com),
    (donde(Tipo, Lugar) -> true ; Lugar = 'Consulta en tienda').

query_oficina(json([
    encargado = 'Karol Daniela Maldonado Lopez',
    cargo     = 'General Manager',
    correo    = 'daniela_keeeh@outlook.com',
    telefono  = '+52 (33) 1234-5678',
    horario   = '9:00 AM – 3:00 PM · Lunes a Viernes',
    status    = 'On-Site & Active',
    servicios = [
        json([icon='🧾', nombre='Facturación electrónica',
              desc='Emisión de CFDI en menos de 5 minutos']),
        json([icon='↩️', nombre='Devoluciones',
              desc='Cambios y devoluciones con ticket de compra']),
        json([icon='📋', nombre='Atención a clientes',
              desc='Quejas, sugerencias y aclaraciones']),
        json([icon='💼', nombre='Proveedores',
              desc='Recepción de propuestas y cotizaciones']),
        json([icon='🎁', nombre='Programa de lealtad',
              desc='Alta y consulta de puntos FrescaVida'])
    ]
])).