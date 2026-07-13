# 🌿 SuperMarketPL — MiniSuper FrescaVida

An information system for the MiniSuper FrescaVida grocery store, built entirely in **SWI-Prolog**. It combines a logic-based knowledge base with an embedded web server, letting you browse products, prices, locations, and business rules straight from the browser.

## 📸 Screenshots

<img width="1891" height="902" alt="image" src="https://github.com/user-attachments/assets/a3852a6b-0478-4222-9cc0-d98a86bc6acc" />

<img width="1872" height="902" alt="image" src="https://github.com/user-attachments/assets/ab4093c5-ba21-4d89-80c4-6e39db6fb273" />

<img width="1895" height="901" alt="image" src="https://github.com/user-attachments/assets/d5c778d6-4953-43e4-95e1-323f7326cf14" />

<img width="1881" height="897" alt="image" src="https://github.com/user-attachments/assets/c2899ead-b367-4b79-932b-8e10116e1130" />


---

## 📦 Stack

| Layer | Technology |
|------|-----------|
| Backend / Logic | SWI-Prolog + `http_server` |
| Proxy / Networking | nginx + Docker Compose |
| Frontend | Static HTML · CSS · JS |

---

## 📁 Project Structure

```
SuperMarketPL/
├── prolog/
│   ├── server.pl          ← Entry point; HTTP handlers
│   ├── db.pl               ← Facts (products, locations, prices, sections, offers)
│   ├── rules.pl             ← Business rules
│   ├── queries.pl           ← Composite query predicates (JSON-ready)
│   └── templates/
│       ├── layout.pl        ← Topbar and global HTML wrapper
│       ├── home.pl           ← Main view (section grid)
│       ├── map.pl            ← Interactive store map
│       ├── section.pl        ← Product-category view
│       └── office.pl         ← Info and contact
├── public/
│   ├── css/                  ← Stylesheets (tokens, components)
│   └── js/                    ← app.js (SPA router, fetch helpers)
├── nginx.conf
└── docker-compose.yml
```

---

## 🚀 Requirements

- Docker Desktop 4.x or later (includes Docker Compose v2)
- Windows 10/11 with WSL 2, macOS 12+, or Linux (Ubuntu 20.04+)
- Port **80** available on the host
- Internet connection only needed for the first build

---

## ⚙️ Installation

**1. Clone the repository**
```bash
git clone https://github.com/your-username/SuperMarketPL.git
cd SuperMarketPL
```

**2. Build and start**
```bash
docker compose up --build
```
The first run can take 2-3 minutes. When you see this in the console, it's ready:
```
🌿 MiniSuper FrescaVida — server started
   http://localhost:8080
```

**3. Open in your browser**
```
http://localhost
```

---

## 🛠️ Useful Commands

```bash
# Start without rebuilding (faster)
docker compose up

# Stop and remove containers
docker compose down

# Full rebuild (required after changing .pl files)
docker compose up --build

# Restart only nginx (after changing nginx.conf)
docker compose restart nginx

# View the Prolog server logs
docker compose logs prolog --tail=30

# Follow all logs in real time
docker compose logs -f
```

---

## 🧠 Prolog Knowledge Base

The system's logic is split into three files: `db.pl` (facts), `rules.pl` (derived rules), and `queries.pl` (query predicates that shape the JSON responses served by the API).

### Facts — `db.pl`

#### `producto/6`
Defines each product in the store.
```prolog
producto(Tipo, Marca, Nombre, Presentacion, Precio, Comentario).

% Examples:
producto('Leche', 'Lala', 'Entera', '1L', 33, 'Entera cremosa fresca').
producto('Refresco', 'Coca-Cola', 'Original', '600ml', 18, 'Sabor clásico dulce').
producto('Queso', 'Chilchota', 'Manchego', '400g', 68, 'Rebanado curado').
```

#### `lugar/2`
Maps each product category to a location within the store.
```prolog
lugar('Lacteo', 'Refrigerador zona A').
lugar('Bebida', 'Pasillo D').
```

#### `categoria/2`
Groups product types into higher-level categories.
```prolog
categoria('Lacteo', 'Leche').
categoria('Lacteo', 'Queso').
categoria('Bebida', 'Refresco').
```

#### `seccion/6`
Defines each storefront section shown on the home page and the map (id, name, description, icon, color, aisle).
```prolog
seccion('lacteos', 'Lácteos', 'Frescos de granja seleccionados', '🥛', '#eaf6f0', 'A-01').
seccion('bebidas', 'Bebidas', 'Refrescantes y energizantes', '🧃', '#dbeeff', 'D-01').
```

#### `oferta/4`
Current promotions shown on the home page (id, description, badge, related section).
```prolog
oferta(1, 'Yogures — hasta agotar existencias', '2×1', 'lacteos').
oferta(3, 'Refresco 2L + botana desde $38', 'Combo', 'bebidas').
```

---

### Rules — `rules.pl`

#### `donde/2` — Locate a product
```prolog
donde(Tipo, Lugar) :-
    categoria(Categoria, Tipo),
    lugar(Categoria, Lugar).
```
Returns the aisle where a product type is located.
```prolog
donde('Leche', Lugar).
% Lugar = 'Refrigerador zona A'
```

---

#### `productos_de_seccion/3` — Products in a storefront section
```prolog
productos_de_seccion(SeccionId, Productos, Lugar) :-
    seccion_a_categoria(SeccionId, Categoria),
    findall(
        producto(Tipo, Marca, Nombre, Pres, Precio, Com),
        (categoria(Categoria, Tipo), producto(Tipo, Marca, Nombre, Pres, Precio, Com)),
        Productos
    ),
    lugar(Categoria, Lugar).
```
Bridges the frontend's section id (e.g. `'lacteos'`) to the underlying category and returns every matching product plus its location.

---

#### `seccion_a_categoria/2` — Frontend section → domain category
```prolog
seccion_a_categoria('lacteos',    'Lacteo').
seccion_a_categoria('bebidas',    'Bebida').
seccion_a_categoria('snacks',     'Snack').
seccion_a_categoria('frutas',     'FrutaVerdura').
seccion_a_categoria('carnes',     'Carnes').
seccion_a_categoria('harinas',    'Harinas').
seccion_a_categoria('limpieza',   'Limpieza').
seccion_a_categoria('congelados', 'Congelado').
seccion_a_categoria('abarrotes',  'Abarrote').
```
A lookup table that maps the short ids used in URLs and the UI to the category atoms used in `db.pl`.

---

#### `precio_max/5` — Filter by budget
```prolog
precio_max(Max, Tipo, Marca, Nombre, Precio) :-
    producto(Tipo, Marca, Nombre, _, Precio, _),
    Precio =< Max.
```
Returns every product priced at or below the given maximum.
```prolog
precio_max(20, Tipo, Marca, Nombre, Precio).
% Every product priced $20 or less
```

---

#### `mas_barato/3` — Cheapest of its type
```prolog
mas_barato(Tipo, Nombre, Precio) :-
    producto(Tipo, _, Nombre, _, Precio, _),
    \+ (
        producto(Tipo, _, _, _, OtroPrecio, _),
        OtroPrecio < Precio
    ).
```
Uses **negation as failure** (`\+`): a product is the cheapest if no other product of the same type has a lower price. The idiomatic way to express a minimum in Prolog.
```prolog
mas_barato('Leche', Nombre, Precio).
```

---

#### `mas_caro/3` — Most expensive of its type
```prolog
mas_caro(Tipo, Nombre, Precio) :-
    producto(Tipo, _, Nombre, _, Precio, _),
    \+ (
        producto(Tipo, _, _, _, OtroPrecio, _),
        OtroPrecio > Precio
    ).
```
Same idea as `mas_barato/3`, but negating the opposite comparison to find a maximum instead.

---

#### `buscar_por_nombre/5` — Search by name
```prolog
buscar_por_nombre(Query, Tipo, Marca, Nombre, Precio) :-
    downcase_atom(Query, QueryLower),
    producto(Tipo, Marca, Nombre, _, Precio, _),
    downcase_atom(Nombre, NombreLower),
    sub_atom(NombreLower, _, _, _, QueryLower).
```
Case-insensitive substring search over product names — powers the search bar.
```prolog
buscar_por_nombre('cola', Tipo, Marca, Nombre, Precio).
```

---

#### `misma_categoria/2` — Compare two products
```prolog
misma_categoria(Nombre1, Nombre2) :-
    producto(Tipo, _, Nombre1, _, _, _),
    producto(Tipo, _, Nombre2, _, _, _),
    Nombre1 \= Nombre2.
```
Checks whether two products are of the same type. `Nombre1 \= Nombre2` keeps a product from matching itself.
```prolog
misma_categoria('Entera', 'Deslactosada').  % true
misma_categoria('Entera', 'Cola').          % false
```

---

#### `todas_las_secciones/1` and `todas_las_ofertas/1`
Collect every `seccion/6` and `oferta/4` fact into a list, ready to be turned into JSON for the home page.

---

#### `info_producto/6` — Full product detail
```prolog
info_producto(Nombre, Tipo, Marca, Presentacion, Precio, Comentario) :-
    producto(Tipo, Marca, Nombre, Presentacion, Precio, Comentario).
```
Looks up a product by name and returns all of its stored fields; `query_info_producto/2` in `queries.pl` then attaches its location via `donde/2`.
```prolog
info_producto('Manchego', Tipo, Marca, Presentacion, Precio, Comentario).
```

---

### Quick Reference

| Predicate | Arity | File | Description |
|-----------|--------|---------|-------------|
| `producto` | 6 | `db.pl` | Fact. A product with type, brand, name, packaging, price, and comment. |
| `lugar` | 2 | `db.pl` | Fact. Aisle or zone for each category. |
| `categoria` | 2 | `db.pl` | Fact. Groups product types into higher-level categories. |
| `seccion` | 6 | `db.pl` | Fact. A storefront section (id, name, description, icon, color, aisle). |
| `oferta` | 4 | `db.pl` | Fact. A current promotion tied to a section. |
| `donde` | 2 | `rules.pl` | Rule. Returns a product type's aisle. |
| `productos_de_seccion` | 3 | `rules.pl` | Rule. Lists every product in a storefront section. |
| `seccion_a_categoria` | 2 | `rules.pl` | Rule. Maps a section id to its domain category. |
| `precio_max` | 5 | `rules.pl` | Rule. Filters products priced at or below a given maximum. |
| `mas_barato` | 3 | `rules.pl` | Rule. The cheapest product of its type (negation as failure). |
| `mas_caro` | 3 | `rules.pl` | Rule. The most expensive product of its type. |
| `buscar_por_nombre` | 5 | `rules.pl` | Rule. Case-insensitive search by product name. |
| `misma_categoria` | 2 | `rules.pl` | Rule. Checks if two products share a type. |
| `todas_las_secciones` | 1 | `rules.pl` | Rule. Collects all storefront sections. |
| `todas_las_ofertas` | 1 | `rules.pl` | Rule. Collects all current offers. |
| `info_producto` | 6 | `rules.pl` | Rule. Full detail of a single product. |

---

## 🌐 Server Routes

### Views (server-rendered)

| Route | Description |
|------|-------------|
| `/` and `/views/home` | Home page — section grid and offers |
| `/map` and `/views/map` | Interactive store map |
| `/section` and `/views/section` | Category view with its product list |
| `/office` and `/views/office` | Info, hours, and contact |

### JSON API

| Route | Description |
|------|-------------|
| `/api/secciones` | All storefront sections |
| `/api/seccion` | Products for a given section |
| `/api/seccion/filtro` | Products for a section, filtered by product type |
| `/api/buscar` | Search products by name |
| `/api/precio` | Filter products by maximum price |
| `/api/barato` | Cheapest product of a given type |
| `/api/caro` | Most expensive product of a given type |
| `/api/producto` | Full detail of a single product |
| `/api/ofertas` | Current promotions |
| `/api/oficina` | Office / contact information |

---

## 💻 Querying from the Terminal

To try it without Docker, load the files directly in SWI-Prolog (type queries without the `?-`, Prolog adds it for you):

```prolog
% Load
consult('/path/to/project/prolog/db.pl').
consult('/path/to/project/prolog/rules.pl').

% By type
producto('Leche', Marca, Nombre, Pres, Precio, Com).

% Location
donde('Botana', Lugar).

% Products in a storefront section
productos_de_seccion('lacteos', Productos, Lugar).

% By budget
precio_max(25, Tipo, Marca, Nombre, Precio).

% The cheapest one
mas_barato('Refresco', Nombre, Precio).

% Full detail
info_producto('Manchego', Tipo, Marca, Presentacion, Precio, Comentario).
```

> Press `;` to see the next result, `.` to stop.

---

## 🐛 Troubleshooting

| Symptom | Fix |
|---------|----------|
| 403 error when opening `localhost` | `nginx.conf` isn't proxying `/` to Prolog. See Fix 3. |
| `_G1234` variables showing on screen | SSR template with an incomplete predicate. Check `format/2` in `home.pl`. |
| `deprecated source_search_working_directory` warning | `consult` is using relative paths. Switch to `/app/prolog/...`. See Fix 1. |
| `ERROR: Exported procedure X/N is not defined` | The arity in `:- module(..., [pred/N])` doesn't match the actual definition. See Fix 2. |
| Port 80 already in use | Change it in `docker-compose.yml`: `ports: ["8090:80"]` and open `localhost:8090`. |
| Changes in `.pl` files don't show up | Use `docker compose up --build` to rebuild. |

---

## 📋 Fixes Applied

| # | Description | File | Status |
|---|-------------|---------|--------|
| Fix 1 | Deprecated relative paths in `consult` | `server.pl` | ✅ Resolved |
| Fix 2 | `render_topbar/3` exported but defined as `/2` | `layout.pl` | ✅ Resolved |
| Fix 3 | 403 error — nginx not proxying to Prolog | `nginx.conf` | ✅ Resolved |
| Fix 4 | `render_home_body` missing a `page-body` wrapper | `home.pl` | ⏳ Pending |
| Fix 5 | Discontiguous predicates in `home.pl` | `home.pl` | ✅ Resolved |
| Fix 6 | SPA navigation with `data-link` | `app.js` | ✅ Verified |
| Fix 7 | `--sidebar-width` too narrow (200px → 220-240px) | `tokens.css` | ⏳ Pending |
| Fix 8 | Emoji icons instead of monochrome SVG | `home.pl`, `section.pl` | ⏳ Pending |

---

## 🗺️ Roadmap

- [ ] Fix 4 — `page-body` wrapper in `render_home_body`
- [ ] Fix 7 — adjust `--sidebar-width`
- [ ] Fix 8 — replace emojis with SVG icons
- [ ] Dark mode (CSS variables already in place)
- [ ] Search with section highlighting on the map
- [ ] Admin panel to edit products without touching code

---

*🌿 MiniSuper FrescaVida — SuperMarketPL v1.0*
*-By: Daniela Keeh*
