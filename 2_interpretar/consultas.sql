-- PulsoFarma · Consultas del dashboard
-- Cada consulta alimenta un elemento del dashboard. Se prueban ANTES de armarlo.
-- Escribe debajo de cada una qué elemento alimenta y qué debe dar (-- Esperado:).

-- C0. Ejemplo para arrancar: pedidos por estado final
-- Alimenta: (ninguno, es solo para conocer los datos)
-- Esperado: 16030 pedidos en total
SELECT estado_final, COUNT(*) AS pedidos
FROM workspace.taller_pulsofarma.pedidos
GROUP BY estado_final;

-- C1.
-- Alimenta:
-- Esperado:


-- C2.
-- Alimenta:
-- Esperado:


-- C3.
-- Alimenta:
-- Esperado:
