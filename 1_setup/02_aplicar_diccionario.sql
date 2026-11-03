-- PulsoFarma · Paso 2 de 3: aplicar el diccionario
-- Lo gobierna el diccionario: el significado de cada tabla y columna.
-- Este archivo es la ÚNICA fuente de las descripciones (ver diccionario_datos.md).
--
-- TAREA DEL EQUIPO: hay 4 descripciones vacías, marcadas con TODO.
-- Explora los datos, decide qué significa cada columna y escríbelo.
-- Hasta que no las completes, 03_validar_diccionario.sql mostrará 4 pendientes.

-- Esquema y volumen
COMMENT ON SCHEMA workspace.taller_pulsofarma IS
  'Taller PulsoFarma: delivery de farmacia en Lima, agosto a octubre 2026';
COMMENT ON VOLUME workspace.taller_pulsofarma.raw IS
  'Archivos CSV originales';

-- Tabla pedidos
COMMENT ON TABLE workspace.taller_pulsofarma.pedidos IS
  'Un registro por pedido hecho en la app, de agosto a octubre 2026, con su estado final.';
ALTER TABLE workspace.taller_pulsofarma.pedidos ALTER COLUMN pedido_id
  COMMENT 'Identificador del pedido';
ALTER TABLE workspace.taller_pulsofarma.pedidos ALTER COLUMN cliente_id
  COMMENT 'Cliente que hizo el pedido';
ALTER TABLE workspace.taller_pulsofarma.pedidos ALTER COLUMN distrito
  COMMENT 'Distrito de Lima donde se entrega el pedido';
ALTER TABLE workspace.taller_pulsofarma.pedidos ALTER COLUMN monto_productos
  COMMENT 'Valor de los productos en soles, sin el costo de envío';
ALTER TABLE workspace.taller_pulsofarma.pedidos ALTER COLUMN costo_envio
  COMMENT '';  -- TODO (pista: supuestos_negocio)
ALTER TABLE workspace.taller_pulsofarma.pedidos ALTER COLUMN minutos_prometidos
  COMMENT '';  -- TODO (pista: supuestos_negocio)
ALTER TABLE workspace.taller_pulsofarma.pedidos ALTER COLUMN estado_final
  COMMENT '';  -- TODO (pista: pedido_estados)

-- Tabla pedido_estados
COMMENT ON TABLE workspace.taller_pulsofarma.pedido_estados IS
  'Historial de cada pedido: una fila por cada cambio de estado (creado, confirmado, preparado, despachado, entregado o cancelado).';
ALTER TABLE workspace.taller_pulsofarma.pedido_estados ALTER COLUMN pedido_id
  COMMENT 'Pedido al que pertenece el cambio de estado';
ALTER TABLE workspace.taller_pulsofarma.pedido_estados ALTER COLUMN estado
  COMMENT 'creado: el cliente pide · confirmado: la farmacia acepta · preparado: listo para salir · despachado: sale con el motorizado · entregado · cancelado';
ALTER TABLE workspace.taller_pulsofarma.pedido_estados ALTER COLUMN fecha_hora
  COMMENT '';  -- TODO (pista: supuestos_negocio)

-- Tabla encuestas_nps
COMMENT ON TABLE workspace.taller_pulsofarma.encuestas_nps IS
  'Encuesta que recibe el cliente después de su pedido (entregado o cancelado). No todos responden.';
ALTER TABLE workspace.taller_pulsofarma.encuestas_nps ALTER COLUMN encuesta_id
  COMMENT 'Identificador de la respuesta';
ALTER TABLE workspace.taller_pulsofarma.encuestas_nps ALTER COLUMN pedido_id
  COMMENT 'Pedido sobre el que opina el cliente';
ALTER TABLE workspace.taller_pulsofarma.encuestas_nps ALTER COLUMN fecha_hora_respuesta
  COMMENT 'Cuándo respondió el cliente, en UTC';
ALTER TABLE workspace.taller_pulsofarma.encuestas_nps ALTER COLUMN puntaje
  COMMENT '¿Qué tan probable es que nos recomiendes? de 0 a 10. 9-10 promotor, 7-8 pasivo, 0-6 detractor';
ALTER TABLE workspace.taller_pulsofarma.encuestas_nps ALTER COLUMN comentario
  COMMENT 'Texto libre opcional del cliente. Puede estar vacío';

-- Tabla supuestos_negocio
COMMENT ON TABLE workspace.taller_pulsofarma.supuestos_negocio IS
  'Supuestos y costos del negocio para dimensionar mejoras. Los define el área de finanzas.';
ALTER TABLE workspace.taller_pulsofarma.supuestos_negocio ALTER COLUMN concepto
  COMMENT 'Nombre del supuesto';
ALTER TABLE workspace.taller_pulsofarma.supuestos_negocio ALTER COLUMN valor
  COMMENT 'Valor del supuesto (texto: convertir a número cuando corresponda)';
ALTER TABLE workspace.taller_pulsofarma.supuestos_negocio ALTER COLUMN unidad
  COMMENT 'Unidad del valor';
ALTER TABLE workspace.taller_pulsofarma.supuestos_negocio ALTER COLUMN nota
  COMMENT 'Explicación del supuesto';
