# 🌿 MiniSuper FrescaVida

Producto Integrador · Ingeniería de Software · CUCEI  
Sistema de mapa interactivo + base de conocimiento en Prolog

---

## Archivos del proyecto

```
minisuper/
├── minisuper.html          ← Interfaz web (responsiva)
├── minisuper_server.pl     ← Servidor HTTP + base de conocimiento Prolog
├── start.sh                ← Script de arranque (Mac/Linux)
└── README.md
```

---

## Requisitos

**SWI-Prolog** — el único requisito.

| Sistema    | Instalación                                               |
|------------|-----------------------------------------------------------|
| macOS      | `brew install swi-prolog`                                 |
| Ubuntu/Debian | `sudo apt install swi-prolog`                          |
| Windows    | Descargar en https://www.swi-prolog.org/download/stable  |

---

## Levantar el proyecto

### Mac / Linux

```bash
# 1. Entrar a la carpeta del proyecto
cd ruta/al/proyecto

# 2. Dar permisos al script (solo la primera vez)
chmod +x start.sh

# 3. Arrancar
./start.sh
```

### Windows

```bat
swipl minisuper_server.pl
```

### O directo con swipl

```bash
swipl minisuper_server.pl
```

Luego abre tu navegador en: **http://localhost:8080**

---

## Endpoints de la API

El servidor expone una mini API REST que el HTML consume:

| Endpoint | Parámetro | Ejemplo |
|----------|-----------|---------|
| `GET /api/todos` | — | Todos los productos |
| `GET /api/buscar` | `?cat=Lacteo` | Productos por categoría |
| `GET /api/donde` | `?tipo=Yogurt` | Ubicación en tienda |
| `GET /api/precio` | `?max=25` | Productos con precio ≤ max |
| `GET /api/barato` | `?tipo=Leche` | El más barato de un tipo |
| `GET /api/info` | `?nombre=Manchego` | Info completa de un producto |

### Categorías válidas
`Lacteo` · `Bebida` · `Snack` · `Limpieza` · `FrutaVerdura` · `CarnesFrios`

---

## Modo offline

Si abres `minisuper.html` directamente (doble click, sin servidor),  
el sistema funciona en **modo offline** con los datos embebidos en el HTML.  
La búsqueda y el mapa interactivo siguen funcionando — solo los precios  
y datos de productos vienen del archivo JS en lugar de Prolog.

---

## Queries útiles en SWI-Prolog (consola)

```prolog
% Cargar la base de conocimiento
?- [minisuper_server].

% ¿Dónde están los yogures?
?- donde('Yogurt', Lugar).

% Todos los productos de categoría Lacteo
?- buscar('Lacteo', Tipo, Marca, Nombre, Precio).

% Productos que cuestan $20 o menos
?- precio_max(20, Tipo, Marca, Nombre, Pres, Precio).

% El refresco más barato
?- mas_barato('Refresco', Nombre, Precio).
```

---

## Detener el servidor

`Ctrl + C` en la terminal donde corre `swipl`.
