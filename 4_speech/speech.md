# Speech: preparar lo que vas a decir (pitch de 2 minutos)

El dashboard prueba la idea; el speech la cuenta. Un dashboard, dos minutos, una decisión. **Primero la conclusión, después el porqué.**

## La estructura
| Tiempo | Momento | Qué dices | Nuestro texto |
|---|---|---|---|
| 0:00 – 0:15 | 1. La conclusión | Qué pasó y qué proponemos, en una frase | |
| 0:15 – 0:45 | 2. El porqué | El número que lo prueba, con su definición | |
| 0:45 – 1:15 | 3. Qué significa | Qué pasa si no hacemos nada | |
| 1:15 – 1:45 | 4. La acción | Qué, quién, cuándo, cuánto cuesta y qué pasa si no funciona | |
| 1:45 – 2:00 | 5. La pregunta | Una pregunta de sí o no | |

Si te cortan en el minuto 1, el comité ya escuchó qué hacer.

## Herramienta: Scrollyteller de Claude
El formato **Scrollyteller** de Claude arma una historia que se lee bajando la página, paso a paso. Lo usamos para ordenar el speech con los mismos datos del dashboard.

1. En Claude escribe **/** y elige **Dashboard**.
2. A la derecha, cambia el formato a **Scrollyteller**.
3. En **¿De dónde vienen tus números?**, elige **Usar un conector → Databricks** (el mismo de `1_setup/05_claude_conector.md`).
4. En **Escribe un mensaje…** pega completo tu `3_graficar/prompt.md` y, debajo, el pedido de abajo.
5. Revisa que los números coincidan con tus consultas y que cada sección responda a un momento de la tabla.

### Pedido para el Scrollyteller
> Con esas definiciones y ese criterio, arma un scrollyteller de 5 secciones para un pitch de 2 minutos ante el comité de PulsoFarma:
> 1. **La conclusión** (15 s): qué pasó y qué proponemos, en una frase.
> 2. **El porqué** (30 s): el número que lo prueba, con un solo gráfico.
> 3. **Qué significa** (30 s): qué pasa si no hacemos nada.
> 4. **La acción** (30 s): qué proponemos, cuánto cuesta, cuándo y qué pasa si no funciona.
> 5. **La pregunta** (15 s): una pregunta de sí o no.
> En cada sección, escribe debajo el texto que diría en voz alta (máximo 2 frases). Usa solo los números de las consultas, sin inventar.

El texto de cada sección es tu **borrador**: ajústalo con tus palabras. Guarda el pedido que usaste en tu carpeta de `entregas/`.

## Chequeo del speech
- [ ] ¿La primera frase ya dice qué hacer?
- [ ] ¿Cada número que dices está en el dashboard y tiene su definición?
- [ ] ¿La acción dice qué, quién, cuándo, cuánto cuesta y qué pasa si no funciona?
- [ ] ¿Termina en una pregunta de sí o no?
