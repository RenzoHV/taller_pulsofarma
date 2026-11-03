-- PulsoFarma · Paso 2 de 3: aplicar el diccionario
-- Lo gobierna el diccionario: el significado de cada tabla y columna.
-- Este archivo es la ÚNICA fuente de las descripciones (ver diccionario_datos.md).

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
  COMMENT 'Lo que paga el cliente por el envío, en soles. S/5.90 hasta el 14-set-2026 y S/8.90 desde el 15-set-2026';
ALTER TABLE workspace.taller_pulsofarma.pedidos ALTER COLUMN minutos_prometidos
  COMMENT 'Tiempo de entrega que la app le promete al cliente, en minutos. Es el mismo para todos los distritos y horas';
ALTER TABLE workspace.taller_pulsofarma.pedidos ALTER COLUMN estado_final
  COMMENT 'entregado o cancelado. Un cancelado no tiene hora de entrega, pero sí hora de cancelación en pedido_estados';

-- Tabla pedido_estados
COMMENT ON TABLE workspace.taller_pulsofarma.pedido_estados IS
  'Historial de cada pedido: una fila por cada cambio de estado (creado, confirmado, preparado, despachado, entregado o cancelado).';
ALTER TABLE workspace.taller_pulsofarma.pedido_estados ALTER COLUMN pedido_id
  COMMENT 'Pedido al que pertenece el cambio de estado';
ALTER TABLE workspace.taller_pulsofarma.pedido_estados ALTER COLUMN estado
  COMMENT 'creado: el cliente pide · confirmado: la farmacia acepta · preparado: listo para salir · despachado: sale con el motorizado · entregado · cancelado';
ALTER TABLE workspace.taller_pulsofarma.pedido_estados ALTER COLUMN fecha_hora
  COMMENT 'Momento del cambio de estado, en UTC. Lima = UTC-5: restar 5 horas para la hora local';

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
