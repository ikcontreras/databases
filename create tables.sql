-- Activar claves foráneas
PRAGMA foreign_keys = ON;

-- Tabla: types
CREATE TABLE IF NOT EXISTS types (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    type TEXT NOT NULL
);

-- Tabla: nodes
CREATE TABLE IF NOT EXISTS nodes (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    type_id INTEGER NOT NULL,
    FOREIGN KEY (type_id) REFERENCES types(id)
);

-- Tabla: edges
CREATE TABLE IF NOT EXISTS edges (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    source_node_id INTEGER NOT NULL,
    target_node_id INTEGER NOT NULL,
    FOREIGN KEY (source_node_id) REFERENCES nodes(id),
    FOREIGN KEY (target_node_id) REFERENCES nodes(id)
);

-- Tabla: config_input_text
CREATE TABLE IF NOT EXISTS config_input_text (
    node_id INTEGER PRIMARY KEY,
    max_length INTEGER,
    placeholder TEXT,
    FOREIGN KEY (node_id) REFERENCES nodes(id)
);

-- Tabla: config_input_date
CREATE TABLE IF NOT EXISTS config_input_date (
    node_id INTEGER PRIMARY KEY,
    min_date TEXT,
    max_date TEXT,
    FOREIGN KEY (node_id) REFERENCES nodes(id)
);


-- Configuración de opciones (value de cada opción)
CREATE TABLE IF NOT EXISTS config_options (
    node_id INTEGER PRIMARY KEY,      -- nodo tipo Option
    value TEXT NOT NULL,
    FOREIGN KEY (node_id) REFERENCES nodes(id)
);