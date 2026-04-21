# 🌿 SuperMarketPL — MiniSuper FrescaVida

Sistema de información para el MiniSuper FrescaVida desarrollado íntegramente en **SWI-Prolog**. Combina una base de conocimiento lógica con un servidor web embebido, permitiendo consultar productos, precios, ubicaciones y reglas de negocio desde el navegador.

---

## 📦 Stack

| Capa | Tecnología |
|------|-----------|
| Backend / Lógica | SWI-Prolog + `http_server` |
| Proxy / Red | nginx + Docker Compose |
| Frontend | HTML · CSS · JS (estático) |

---

## 📁 Estructura del Proyecto

```
SuperMarketPL/
├── prolog/
│   ├── server.pl          ← Punto de entrada; HTTP handlers
│   ├── db.pl              ← Hechos (productos, ubicaciones, precios)
│   ├── rules.pl           ← Reglas de negocio
│   ├── queries.pl         ← Predicados de consulta compuestos
│   └── templates/
│       ├── layout.pl      ← Topbar y wrapper HTML global
│       ├── home.pl        ← Vista principal (grid de secciones)
│       ├── map.pl         ← Mapa interactivo de la tienda
│       ├── section.pl     ← Vista de categoría de productos
│       └── office.pl      ← Información y contacto
├── public/
│   ├── css/               ← Hojas de estilo (tokens, components)
│   └── js/                ← app.js (router SPA, fetch helpers)
├── nginx.conf
└── docker-compose.yml
```

---

## 🚀 Requisitos

- Docker Desktop 4.x o superior (incluye Docker Compose v2)
- Windows 10/11 con WSL 2, macOS 12+ o Linux (Ubuntu 20.04+)
- Puerto **80** disponible en el host
- Conexión a internet solo para la primera build

---

## ⚙️ Instalación

**1. Clonar el repositorio**
```bash
git clone https://github.com/tu-usuario/SuperMarketPL.git
cd SuperMarketPL
```

**2. Build y arranque**
```bash
docker compose up --build
```
La primera ejecución puede tardar 2-3 minutos. Cuando veas esto en consola, está listo:
```
🌿 MiniSuper FrescaVida — servidor iniciado
   http://localhost:8080
```

**3. Abrir en el navegador**
```
http://localhost
```

---

## 🛠️ Comandos Útiles

```bash
# Arrancar sin rebuild (más rápido)
docker compose up

# Detener y eliminar contenedores
docker compose down

# Rebuild completo (obligatorio al cambiar archivos .pl)
docker compose up --build

# Reiniciar solo nginx (al cambiar nginx.conf)
docker compose restart nginx

# Ver logs del servidor Prolog
docker compose logs prolog --tail=30

# Seguir todos los logs en tiempo real
docker compose logs -f
```

---

## 🧠 Base de Conocimiento Prolog

La lógica del sistema está dividida en tres archivos: `db.pl` (hechos), `rules.pl` (reglas derivadas) y `queries.pl` (predicados de consulta).

### Hechos — `db.pl`

#### `producto/6`
Define cada producto de la tienda.
```prolog
producto(Tipo, Marca, Nombre, Presentacion, Precio, Comentario).

% Ejemplos:
producto('Leche', 'Sello Rojo', 'Entera', '1L', 38, 'Pasteurizada').
producto('Refresco', 'Coca-Cola', 'Cola', '600ml', 22, '').
producto('Botana', 'Sabritas', 'Papas Limon', '45g', 15, 'Sabor intenso').
```

#### `lugar/2`
Ubica cada tipo de producto en la tienda.
```prolog
lugar('Leche', 'Refrigerador zona A').
lugar('Refresco', 'Pasillo 2').
lugar('Botana', 'Pasillo 1').
```

#### `categoria/2`
Agrupa tipos de productos en categorías de alto nivel.
```prolog
categoria('Lacteo', 'Leche').
categoria('Lacteo', 'Queso').
categoria('Bebida', 'Refresco').
categoria('Snack', 'Botana').
categoria('FrutaVerdura', 'Verdura').
categoria('FrutaVerdura', 'Fruta').
categoria('CarnesFrios', 'Fiambre').
```

---

### Reglas — `rules.pl`

#### `donde/2` — Localizar un producto
```prolog
donde(Tipo, Lugar) :-
    lugar(Tipo, Lugar).
```
Devuelve el pasillo donde se encuentra un tipo de producto.
```prolog
donde('Leche', Lugar).
% Lugar = 'Refrigerador zona A'
```

---

#### `buscar/5` — Buscar por categoría
```prolog
buscar(Cat, Tipo, Marca, Nombre, Precio) :-
    categoria(Cat, Tipo),
    producto(Tipo, Marca, Nombre, _, Precio, _).
```
Encadena `categoria/2` y `producto/6` para listar todos los productos de una categoría de un solo golpe.
```prolog
buscar('Lacteo', Tipo, Marca, Nombre, Precio).
% Devuelve todas las leches, quesos...
```

---

#### `precio_max/3` — Filtrar por presupuesto
```prolog
precio_max(Max, Nombre, Precio) :-
    producto(_, _, Nombre, _, Precio, _),
    Precio =< Max.
```
Retorna todos los productos cuyo precio es menor o igual al máximo indicado.
```prolog
precio_max(20, Nombre, Precio).
% Todos los productos de $20 o menos
```

---

#### `mas_barato/3` — El más económico de su tipo
```prolog
mas_barato(Tipo, Nombre, Precio) :-
    producto(Tipo, _, Nombre, _, Precio, _),
    \+ (producto(Tipo, _, _, _, Precio2, _), Precio2 < Precio).
```
Usa **negación por fallo** (`\+`): un producto es el más barato si no existe otro del mismo tipo con precio menor. Forma idiomática de expresar un mínimo en Prolog.
```prolog
mas_barato('Leche', Nombre, Precio).
% Nombre = 'Entera', Precio = 38
```

---

#### `misma_categoria/2` — Comparar dos productos
```prolog
misma_categoria(Nombre1, Nombre2) :-
    producto(Tipo, _, Nombre1, _, _, _),
    producto(Tipo, _, Nombre2, _, _, _),
    Nombre1 \= Nombre2.
```
Verifica si dos productos son del mismo tipo. `Nombre1 \= Nombre2` evita que un producto se compare consigo mismo.
```prolog
misma_categoria('Entera', 'Deslactosada').  % true
misma_categoria('Entera', 'Cola').           % false
```

---

#### `info/1` — Vista detallada de un producto
```prolog
info(Nombre) :-
    producto(Tipo, Marca, Nombre, Pres, Precio, Com),
    lugar(Tipo, Lugar),
    format("Producto: ~w~nMarca: ~w~nTipo: ~w~n...", [...]).
```
Consolida toda la información de un producto (datos + ubicación) en una sola consulta. Útil para depuración desde la terminal.
```prolog
info('Manchego').
info('Cola').
```

---

### Referencia Rápida

| Predicado | Aridad | Archivo | Descripción |
|-----------|--------|---------|-------------|
| `producto` | 6 | `db.pl` | Hecho. Un producto con tipo, marca, nombre, presentación, precio y comentario. |
| `lugar` | 2 | `db.pl` | Hecho. Pasillo o zona de cada tipo de producto. |
| `categoria` | 2 | `db.pl` | Hecho. Agrupa tipos en categorías de alto nivel. |
| `donde` | 2 | `rules.pl` | Regla. Devuelve el pasillo de un tipo. Puente a `lugar/2`. |
| `buscar` | 5 | `rules.pl` | Regla. Lista productos de una categoría encadenando `categoria/2` + `producto/6`. |
| `precio_max` | 3 | `rules.pl` | Regla. Filtra productos con precio ≤ al máximo dado. |
| `mas_barato` | 3 | `rules.pl` | Regla. El producto más barato de su tipo (negación por fallo). |
| `misma_categoria` | 2 | `rules.pl` | Regla. Comprueba si dos productos son del mismo tipo. |
| `info` | 1 | `queries.pl` | Predicado de impresión. Muestra todos los datos de un producto. |

---

## 🌐 Rutas del Servidor

| Ruta | Descripción |
|------|-------------|
| `/` | Página principal — grid de secciones y ofertas |
| `/map` | Mapa interactivo de la tienda |
| `/section/:id` | Vista de categoría con lista de productos |
| `/office` | Información, horarios y contacto |
| `/api/products` | API JSON — todos los productos |
| `/api/search` | API JSON — búsqueda por nombre o marca |

---

## 💻 Consultas desde la Terminal

Para probar sin Docker, carga los archivos directamente en SWI-Prolog (escribe sin el `?-`, Prolog lo pone solo):

```prolog
% Cargar
consult('/ruta/al/proyecto/prolog/db.pl').
consult('/ruta/al/proyecto/prolog/rules.pl').

% Por tipo
producto('Leche', Marca, Nombre, Pres, Precio, Com).

% Ubicación
donde('Botana', Lugar).

% Por categoría
buscar('Lacteo', Tipo, Marca, Nombre, Precio).

% Por presupuesto
precio_max(25, Nombre, Precio).

% El más barato
mas_barato('Refresco', Nombre, Precio).

% Info completa
info('Manchego').
```

> Presiona `;` para ver el siguiente resultado, `.` para parar.

---

## 🐛 Troubleshooting

| Síntoma | Solución |
|---------|----------|
| Error 403 al abrir `localhost` | `nginx.conf` no redirige `/` a Prolog. Ver Fix 3. |
| Variables `_G1234` en pantalla | Template SSR con predicado incompleto. Revisar `format/2` en `home.pl`. |
| Warning `deprecated source_search_working_directory` | `consult` usa rutas relativas. Cambiar a `/app/prolog/...`. Ver Fix 1. |
| `ERROR: Exported procedure X/N is not defined` | Aridad en `:- module(..., [pred/N])` no coincide con la definición. Ver Fix 2. |
| Puerto 80 en uso | Cambiar en `docker-compose.yml`: `ports: ["8090:80"]` y abrir `localhost:8090`. |
| Cambios en `.pl` no se reflejan | Usar `docker compose up --build` para rebuild. |

---

## 📋 Fixes Aplicados

| # | Descripción | Archivo | Estado |
|---|-------------|---------|--------|
| Fix 1 | Rutas relativas deprecadas en `consult` | `server.pl` | ✅ Resuelto |
| Fix 2 | `render_topbar/3` exportado pero definido como `/2` | `layout.pl` | ✅ Resuelto |
| Fix 3 | Error 403 — nginx sin proxy a Prolog | `nginx.conf` | ✅ Resuelto |
| Fix 4 | `render_home_body` sin wrapper `page-body` | `home.pl` | ⏳ Pendiente |
| Fix 5 | Predicados discontiguos en `home.pl` | `home.pl` | ✅ Resuelto |
| Fix 6 | Navegación SPA con `data-link` | `app.js` | ✅ Verificado |
| Fix 7 | `--sidebar-width` demasiado angosto (200px → 220-240px) | `tokens.css` | ⏳ Pendiente |
| Fix 8 | Íconos como emojis en lugar de SVG monocromáticos | `home.pl`, `section.pl` | ⏳ Pendiente |

---

## 🗺️ Roadmap

- [ ] Fix 4 — wrapper `page-body` en `render_home_body`
- [ ] Fix 7 — ajustar `--sidebar-width`
- [ ] Fix 8 — reemplazar emojis por íconos SVG
- [ ] Modo oscuro (variables CSS ya preparadas)
- [ ] Buscador con highlight de sección en el mapa
- [ ] Panel de administración para editar productos sin tocar código

---

*🌿 MiniSuper FrescaVida — SuperMarketPL v1.0*
*-By: Daniela Keeh*