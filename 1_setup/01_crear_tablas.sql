-- PulsoFarma · Paso 1 de 3: estructura y carga
-- Lo decide el modelador: tablas, tipos y reglas (PK/FK, NOT NULL, CHECK).
-- Los significados NO van aquí: van en 02_aplicar_diccionario.sql.
-- Antes de correr la parte 2: subir los 4 CSV de 1_setup/data/ al
-- volumen /Volumes/workspace/taller_pulsofarma/raw (ver README).

-- Parte 1. Esquema y volumen
CREATE SCHEMA IF NOT EXISTS workspace.taller_pulsofarma;
CREATE VOLUME IF NOT EXISTS workspace.taller_pulsofarma.raw;

-- Parte 2. Tablas (se recrean desde cero; primero las que tienen FK)
DROP TABLE IF EXISTS workspace.taller_pulsofarma.encuestas_nps;
DROP TABLE IF EXISTS workspace.taller_pulsofarma.pedido_estados;
DROP TABLE IF EXISTS workspace.taller_pulsofarma.pedidos;
DROP TABLE IF EXISTS workspace.taller_pulsofarma.supuestos_negocio;

CREATE TABLE workspace.taller_pulsofarma.pedidos (
  pedido_id          STRING        NOT NULL,
  cliente_id         STRING        NOT NULL,
  distrito           STRING        NOT NULL,
  monto_productos    DECIMAL(10,2) NOT NULL,
  costo_envio        DECIMAL(10,2) NOT NULL,
  minutos_prometidos INT           NOT NULL,
  estado_final       STRING        NOT NULL,
  CONSTRAINT pk_pedidos PRIMARY KEY (pedido_id)
);
ALTER TABLE workspace.taller_pulsofarma.pedidos
  ADD CONSTRAINT chk_estado_final CHECK (estado_final IN ('entregado', 'cancelado'));

CREATE TABLE workspace.taller_pulsofarma.pedido_estados (
  pedido_id  STRING    NOT NULL,
  estado     STRING    NOT NULL,
  fecha_hora TIMESTAMP NOT NULL,
  CONSTRAINT fk_estados_pedidos FOREIGN KEY (pedido_id)
    REFERENCES workspace.taller_pulsofarma.pedidos (pedido_id)
);
ALTER TABLE workspace.taller_pulsofarma.pedido_estados
  ADD CONSTRAINT chk_estado CHECK (estado IN ('creado', 'confirmado', 'preparado', 'despachado', 'entregado', 'cancelado'));

CREATE TABLE workspace.taller_pulsofarma.encuestas_nps (
  encuesta_id          STRING    NOT NULL,
  pedido_id            STRING    NOT NULL,
  fecha_hora_respuesta TIMESTAMP NOT NULL,
  puntaje              INT       NOT NULL,
  comentario           STRING,
  CONSTRAINT pk_encuestas PRIMARY KEY (encuesta_id),
  CONSTRAINT fk_encuestas_pedidos FOREIGN KEY (pedido_id)
    REFERENCES workspace.taller_pulsofarma.pedidos (pedido_id)
);
ALTER TABLE workspace.taller_pulsofarma.encuestas_nps
  ADD CONSTRAINT chk_puntaje CHECK (puntaje BETWEEN 0 AND 10);

CREATE TABLE workspace.taller_pulsofarma.supuestos_negocio (
  concepto STRING NOT NULL,
  valor    STRING NOT NULL,
  unidad   STRING,
  nota     STRING,
  CONSTRAINT pk_supuestos PRIMARY KEY (concepto)
);

-- Parte 3. Carga desde el volumen
INSERT INTO workspace.taller_pulsofarma.pedidos
SELECT CAST(pedido_id AS STRING), CAST(cliente_id AS STRING), CAST(distrito AS STRING),
       CAST(monto_productos AS DECIMAL(10,2)), CAST(costo_envio AS DECIMAL(10,2)),
       CAST(minutos_prometidos AS INT), CAST(estado_final AS STRING)
FROM read_files('/Volumes/workspace/taller_pulsofarma/raw/pedidos.csv',
                format => 'csv', header => true);

INSERT INTO workspace.taller_pulsofarma.pedido_estados
SELECT CAST(pedido_id AS STRING), CAST(estado AS STRING), CAST(fecha_hora AS TIMESTAMP)
FROM read_files('/Volumes/workspace/taller_pulsofarma/raw/pedido_estados.csv',
                format => 'csv', header => true);

INSERT INTO workspace.taller_pulsofarma.encuestas_nps
SELECT CAST(encuesta_id AS STRING), CAST(pedido_id AS STRING),
       CAST(fecha_hora_respuesta AS TIMESTAMP), CAST(puntaje AS INT),
       NULLIF(CAST(comentario AS STRING), '')
FROM read_files('/Volumes/workspace/taller_pulsofarma/raw/encuestas_nps.csv',
                format => 'csv', header => true);

INSERT INTO workspace.taller_pulsofarma.supuestos_negocio
SELECT CAST(concepto AS STRING), CAST(valor AS STRING), CAST(unidad AS STRING), CAST(nota AS STRING)
FROM read_files('/Volumes/workspace/taller_pulsofarma/raw/supuestos_negocio.csv',
                format => 'csv', header => true);

-- Parte 4. Verificación de carga: debe dar 16030 pedidos, 79807 estados,
-- 4633 encuestas y 11 supuestos
SELECT 'pedidos' AS tabla, COUNT(*) AS filas FROM workspace.taller_pulsofarma.pedidos
UNION ALL SELECT 'pedido_estados', COUNT(*) FROM workspace.taller_pulsofarma.pedido_estados
UNION ALL SELECT 'encuestas_nps', COUNT(*) FROM workspace.taller_pulsofarma.encuestas_nps
UNION ALL SELECT 'supuestos_negocio', COUNT(*) FROM workspace.taller_pulsofarma.supuestos_negocio;
