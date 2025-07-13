CREATE VIEW IF NOT EXISTS vista_formulario_expandido AS
WITH RECURSIVE formulario_grafo AS (
    -- Nodo raíz: secciones
    SELECT 
        n.id,
        n.name,
        t.type AS node_type,
        NULL AS parent_id,
        0 AS depth
    FROM nodes n
    JOIN types t ON t.id = n.type_id
    WHERE t.type = 'Section'

    UNION ALL

    -- Recorremos el grafo hacia hijos
    SELECT 
        child.id,
        child.name,
        t.type AS node_type,
        fg.id AS parent_id,
        fg.depth + 1
    FROM formulario_grafo fg
    JOIN edges e ON e.source_node_id = fg.id
    JOIN nodes child ON child.id = e.target_node_id
    JOIN types t ON t.id = child.type_id
)

SELECT 
    fg.id,
    fg.name,
    fg.node_type,
    fg.parent_id,
    fg.depth,

    -- Configuraciones opcionales
    cit.max_length,
    cit.placeholder,
    cid.min_date,
    cid.max_date,
    co.value AS option_value

FROM formulario_grafo fg
LEFT JOIN config_input_text cit ON cit.node_id = fg.id
LEFT JOIN config_input_date cid ON cid.node_id = fg.id
LEFT JOIN config_options co ON co.node_id = fg.id;
