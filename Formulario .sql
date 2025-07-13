WITH RECURSIVE formulario_grafo AS (
    -- Nivel raíz: Secciones
    SELECT 
        n.id,
        n.name,
        t.type AS node_type,
        NULL AS parent_id,
        0 AS depth
    FROM nodes n
    JOIN types t ON n.type_id = t.id
    WHERE t.type = 'Section'

    UNION ALL

    -- Recursivamente seguir relaciones
    SELECT 
        child.id,
        child.name,
        t.type AS node_type,
        parent.id AS parent_id,
        fg.depth + 1
    FROM formulario_grafo fg
    JOIN edges e ON e.source_node_id = fg.id
    JOIN nodes child ON child.id = e.target_node_id
    JOIN types t ON t.id = child.type_id
    JOIN nodes parent ON parent.id = fg.id
)

SELECT 
    fg.id,
    fg.name,
    fg.node_type,
    fg.parent_id,
    fg.depth,

    -- Config de input_text
    cit.max_length,
    cit.placeholder,

    -- Config de input_date
    cid.min_date,
    cid.max_date,

    -- Config de opción (valor)
    co.value AS option_value

FROM formulario_grafo fg

LEFT JOIN config_input_text cit ON cit.node_id = fg.id
LEFT JOIN config_input_date cid ON cid.node_id = fg.id
LEFT JOIN config_options co ON co.node_id = fg.id

ORDER BY fg.depth, fg.parent_id, fg.id;
