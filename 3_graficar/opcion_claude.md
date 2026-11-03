# Opción B: Claude Dashboards

Requisito: conector de Databricks agregado y probado (`1_setup/05_claude_conector.md`).

1. En Claude escribe **/** y elige **Dashboard**.
2. Arriba a la izquierda, cambia "Untitled dashboard" por **PulsoFarma**.
3. A la derecha deja el formato **Dashboard** (viene marcado).
4. En **¿De dónde vienen tus números?**, elige **Usar un conector → Databricks**.
5. En **Escribe un mensaje…** pega completo tu `prompt.md` (desde **Rol** hasta **Control**).
6. Si al inicio el dashboard aparece sin datos, pídele que vuelva a cargar los datos desde Databricks y revisa que los números coincidan con tus `2_interpretar/consultas.sql`.
7. Pasa al chequeo: `chequeo.md`.

Sin Databricks también funciona: sube los CSV de `1_setup/data/` a Claude o Gemini y pega el mismo prompt.
