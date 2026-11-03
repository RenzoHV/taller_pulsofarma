# Taller: PulsoFarma


## El encargo del comité
PulsoFarma es un delivery de farmacia en Lima.
Entre agosto y octubre de 2026 **el tiempo promedio de entrega bajó** mes a mes.
En el mismo periodo **el NPS cayó**.

El comité les pide una recomendación:

### ¿Qué acciones priorizamos para recuperar el NPS?

Ustedes son el equipo de datos. Tienen 2 minutos para convencer al comité.

## Cómo trabajamos (1 hora)
| Min | Paso | Carpeta | Resultado |
|---|---|---|---|
| Antes de clase | Setup | `1_setup/` | Datos cargados y Genie o Claude conectados |
| 0 – 15 | Interpretar | `1_setup/` y `2_interpretar/` | Diccionario completo (0 pendientes), hallazgo en una frase y consultas que lo prueban |
| 15 – 35 | Graficar | `3_graficar/` | Dashboard de una página hecho con IA |
| 35 – 45 | Speech | `4_speech/` | Pitch de 2 minutos |
| 45 – 60 | Pitches | | 2 minutos por equipo ante el comité |

## Qué entregan
En `entregas/equipo_<nombre>/` (ver `entregas/README.md`):
- El **dashboard**
- El **speech**
- Los **prompts** que usaron

**Se evalúan el speech y el dashboard.**

## Los datos
| Tabla | Qué tiene |
|---|---|
| `pedidos` | Un pedido por fila, con distrito, montos y estado final |
| `pedido_estados` | Cada cambio de estado del pedido, con su fecha y hora |
| `encuestas_nps` | Puntaje de 0 a 10 y comentario del cliente |
| `supuestos_negocio` | Promesa de entrega, tarifas y costos para dimensionar mejoras |

---

## 1. Setup (antes de clase, unos 15 min)
Llega a clase con los pasos 1, 2, 3 y 6 listos. El paso 4 (diccionario) y el 5 (validar) se hacen en clase.

0. **Cuenta**: si aún no tienes, crea tu cuenta gratis en [Databricks Free Edition](https://www.databricks.com/learn/free-edition).
1. **Esquema y volumen**: en **SQL Editor**, con un SQL warehouse seleccionado, corre solo la parte 1 de `1_setup/01_crear_tablas.sql`:
   ```sql
   CREATE SCHEMA IF NOT EXISTS workspace.taller_pulsofarma;
   CREATE VOLUME IF NOT EXISTS workspace.taller_pulsofarma.raw;
   ```
2. **Subir los CSV**: **Catalog** → **My organization** → `workspace` → `taller_pulsofarma` → **Volumes** → `raw` → **Upload to this volume**. Sube los 4 archivos de `1_setup/data/`.
3. **Tablas**: corre el resto de `1_setup/01_crear_tablas.sql`. Debe dar **16030** pedidos, **79807** estados, **4633** encuestas y **11** supuestos.
4. **Diccionario**: completa los 4 `TODO` de `1_setup/02_aplicar_diccionario.sql` y córrelo. Cómo se mantiene: `1_setup/diccionario_datos.md`.
5. **Validar**: corre `1_setup/03_validar_diccionario.sql`. Debe dar **23 objetos y 0 pendientes**.
6. **Herramienta**: Genie (`1_setup/04_genie.md`) o Claude (`1_setup/05_claude_conector.md`, sin token).

Si el paso 3 falla, revisa que los CSV estén en `/Volumes/workspace/taller_pulsofarma/raw/`.

## 2. Interpretar (15 min)
Completa el diccionario (pasos 4 y 5 del setup). Luego, primero qué queremos comunicar, después el dashboard: `2_interpretar/problema.md` y `2_interpretar/consultas.sql`.

## 3. Graficar (20 min)
1. Pregunta directa, sin instrucciones: `3_graficar/pregunta_directa.md`.
2. Tu prompt: `3_graficar/prompt.md` (el mismo para Genie y Claude).
3. Genie (`opcion_genie.md`) o Claude Dashboards (`opcion_claude.md`).
4. Chequeo con las cinco preguntas: `3_graficar/chequeo.md`.

Sin Databricks también funciona: sube los CSV de `1_setup/data/` a Claude o Gemini y pega el mismo prompt.

## 4. Speech (10 min)
El pitch de 2 minutos con el Scrollyteller de Claude: `4_speech/speech.md`.

## Estructura de un buen prompt
- **Rol**: quién es la IA en esta conversación.
- **Contexto**: el negocio, la pregunta y la decisión que hay que tomar.
- **Definiciones**: qué significa cada número.
- **Pedido**: qué queremos recibir (cálculo, gráfico, dashboard).
- **Control**: que muestre los cálculos y diga qué supuestos hizo.
