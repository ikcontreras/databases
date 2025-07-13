
-- ===========================
-- 2. Insertar tipos
-- ===========================

INSERT INTO types (type) VALUES
('Section'),
('Input'),
('Option');

-- ===========================
-- 3. Insertar nodos
-- ===========================
INSERT INTO nodes (name, type_id)
SELECT 'Sección A', id FROM types WHERE type = 'Section';

INSERT INTO nodes (name, type_id)
SELECT 'Dropdown A', id FROM types WHERE type = 'Input';

INSERT INTO nodes (name, type_id)
SELECT 'Option A1', id FROM types WHERE type = 'Option';

INSERT INTO nodes (name, type_id)
SELECT 'Option A2', id FROM types WHERE type = 'Option';

INSERT INTO nodes (name, type_id)
SELECT 'Campo texto A1', id FROM types WHERE type = 'Input';

INSERT INTO nodes (name, type_id)
SELECT 'Campo fecha A1', id FROM types WHERE type = 'Input';


-- ===========================
-- 4. Insertar relaciones
-- ===========================
INSERT INTO edges (source_node_id, target_node_id)
SELECT 
  (SELECT id FROM nodes WHERE name = 'Sección A'),
  (SELECT id FROM nodes WHERE name = 'Dropdown A');

INSERT INTO edges (source_node_id, target_node_id)
SELECT 
  (SELECT id FROM nodes WHERE name = 'Dropdown A'),
  (SELECT id FROM nodes WHERE name = 'Option A1');

INSERT INTO edges (source_node_id, target_node_id)
SELECT 
  (SELECT id FROM nodes WHERE name = 'Dropdown A'),
  (SELECT id FROM nodes WHERE name = 'Option A2');

INSERT INTO edges (source_node_id, target_node_id)
SELECT 
  (SELECT id FROM nodes WHERE name = 'Option A1'),
  (SELECT id FROM nodes WHERE name = 'Campo texto A1');

INSERT INTO edges (source_node_id, target_node_id)
SELECT 
  (SELECT id FROM nodes WHERE name = 'Option A1'),
  (SELECT id FROM nodes WHERE name = 'Campo fecha A1');


-- ===========================
-- 5. Insertar configuración
-- ===========================
INSERT INTO config_options (node_id, value)
SELECT (SELECT id FROM nodes WHERE name = 'Option A1'), 'dropdownA_opt1';

INSERT INTO config_options (node_id, value)
SELECT (SELECT id FROM nodes WHERE name = 'Option A2'), 'dropdownA_opt2';

INSERT INTO config_input_text (node_id, max_length, placeholder)
SELECT 
  (SELECT id FROM nodes WHERE name = 'Campo texto A1'),
  200,
  'Escribe un texto';

INSERT INTO config_input_date (node_id, min_date, max_date)
SELECT 
  (SELECT id FROM nodes WHERE name = 'Campo fecha A1'),
  '2023-01-01',
  '2025-12-31';