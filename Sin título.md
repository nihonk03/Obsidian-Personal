

## Preguntas antes de armar el plan

He revisado el documento completo y todos los archivos de referencia (AIService.php, gemini_key.php, auth.php del API, config.py y analyzer.py del Hikvision, setup.sh del proxy, módulos del ERP existentes). Aquí van mis preguntas organizadas por área:Viewed prompt-resumen-reuniones-ia.md:1-214

Excelente, documento muy detallado. Ahora déjame explorar todos los archivos de referencia mencionados en el prompt.

Listed directory sistemas
Listed directory core
Listed directory PitayaWeb
Listed directory HikvisionAnalisisIA
Listed directory api.batidospitaya.com
Listed directory ai
Viewed AIService.php:1-439
Listed directory src
Listed directory install
Viewed config.py:1-36
Listed directory systemd
Listed directory api
Listed directory hikvision
Viewed api_client.py:1-73
Viewed .env.example:1-28
Viewed gemini_key.php:1-56
Viewed auth.php:1-46
Viewed hikvision-worker.service:1-33
Viewed permissions.php:1-152
Viewed auth.php:1-99
Listed directory proxy.batidospitaya.com
Listed directory scripts
Viewed setup.sh:1-190
Viewed analyzer.py:1-380
Viewed correos_corporativos.php:1-794
Listed directory ajax

Ya tengo suficiente contexto. Déjame revisar un par de cosas más importantes: qué puertos ya usa el VPS y la estructura del `.github/workflows` de Hikvision.

Listed directory .github
Viewed README.md:1-254

Ya tengo toda la información necesaria. He revisado exhaustivamente todos los archivos relevantes. Ahora te hago todas las preguntas necesarias:

---

## Preguntas antes de armar el plan

He revisado el documento completo y todos los archivos de referencia (AIService.php, gemini_key.php, auth.php del API, config.py y analyzer.py del Hikvision, setup.sh del proxy, módulos del ERP existentes). Aquí van mis preguntas organizadas por área:

---

### 🔴 Críticas (bloquean el diseño)

**1. Puerto del VPS para la API FastAPI**
Los puertos del Hikvision van de 9554–9561. ¿Tienes algún puerto ya definido en mente para `resumen-reuniones-ia`? Si no, propongo el **8010** (Hikvision usa 8000 o similar internamente, hay que confirmar que esté libre). ¿Puedo elegirlo yo o prefieres confirmarlo mirando el VPS?

**2. Almacenamiento de audio en el VPS**
¿Dónde quieres guardar los fragmentos de audio y el archivo final en el VPS? Propongo `/opt/resumen-reuniones-ia/audio/<id_reunion>/`. ¿Confirmas esa ruta, o hay una convención diferente?

**3. GitHub Actions / Deploy**
¿Este nuevo repo va a tener el mismo patrón de deploy automático que Hikvision (rsync via GitHub Actions → SSH al VPS)? ¿Ya tienes los secrets `DO_SSH_KEY`, `DO_HOST`, `DO_USER` configurados en GitHub, o quieres eso en el plan también?

---

### 🟡 Importantes (afectan el código generado)

**4. Formato de audio del MediaRecorder**
El `MediaRecorder` del navegador puede grabar en `webm/opus`, `ogg/opus`, o en algunos navegadores `mp4`. Para que ffmpeg concatene fragmentos sin problemas, ¿quieres normalizar en el servidor a un formato específico (ej. convertir cada fragmento a `.opus` antes de ensamblar), o prefieres enviar webm y concatenar directamente con ffmpeg?

**5. Gemini audio nativo — formato esperado**
La API de Gemini acepta audio nativo vía `inline_data` (base64) o vía Files API (upload). Para reuniones de 1-2 horas un archivo concatenado puede ser grande (estimado: ~60-120 MB en webm sin comprimir). ¿Prefieres:
  - **Opción A**: Subir via Files API (igual que el video en Hikvision) — más confiable para archivos grandes
  - **Opción B**: Convertir a audio comprimido (ej. opus o mp3) antes de subir para reducir tamaño

**6. Expiración del token y reuniones activas**
El prompt dice +4 horas de expiración al token. ¿Si el usuario está grabando y se venció el token (porque tardó más de 4 horas), qué debe pasar? ¿Renovación automática o error explícito?

**7. Tabla `Operarios` — campos disponibles**
Para la búsqueda de colaboradores (`resumen_reuniones_buscar_colaboradores.php`), ¿qué campos de la tabla `Operarios` debo mostrar? En Hikvision de referencia se usa `CodOperario`. ¿Confirmas que los campos son `CodOperario`, `Nombre1`, `Nombre2`, `Apellido1`, `Apellido2`? (Vi el patrón en auth.php pero quiero confirmarlo).

---

### 🟢 De diseño / UX (afectan el resultado final pero son más fáciles de ajustar)

**8. UI de la página de grabación en el VPS (`reuniones.batidospitaya.com`)**
¿Quieres que tenga los colores corporativos de Pitaya (`#51B8AC`, tono teal), o algo más neutro/distinto dado que es una página pública (accesible con token, fuera del ERP)?

**9. Visualización del resumen en el ERP**
El resumen es "un bloque de texto plano con encabezados simples". ¿Quieres que en la vista del ERP se renderice preservando saltos de línea en un `<pre>` o en un `<div>` con `white-space: pre-wrap`, o prefieres algo más elaborado (ej. el módulo detecta encabezados y los formatea)?

**10. Notificación cuando el resumen está listo**
Cuando el VPS termina de procesar y el estado pasa a `completada`, ¿cómo se entera el usuario en el ERP? ¿Polling automático del listado cada X segundos mientras hay reuniones en estado `procesando`, o el usuario refresca manualmente?

**11. Nombre exacto del servicio systemd**
¿`resumen-reuniones-ia.service` (como sugiere el prompt) o prefieres otro nombre más corto como `reuniones-ia.service`?

---

Con tus respuestas puedo armar el plan de implementación completo sin ambigüedades. Las preguntas 1, 2, 4, 5 y 6 son las más importantes.

### 🟡 Importantes (afectan el código generado)

**4. Formato de audio del MediaRecorder**
El `MediaRecorder` del navegador puede grabar en `webm/opus`, `ogg/opus`, o en algunos navegadores `mp4`. Para que ffmpeg concatene fragmentos sin problemas, ¿quieres normalizar en el servidor a un formato específico (ej. convertir cada fragmento a `.opus` antes de ensamblar), o prefieres enviar webm y concatenar directamente con ffmpeg?

**5. Gemini audio nativo — formato esperado**
La API de Gemini acepta audio nativo vía `inline_data` (base64) o vía Files API (upload). Para reuniones de 1-2 horas un archivo concatenado puede ser grande (estimado: ~60-120 MB en webm sin comprimir). ¿Prefieres:
  - **Opción A**: Subir via Files API (igual que el video en Hikvision) — más confiable para archivos grandes
  - **Opción B**: Convertir a audio comprimido (ej. opus o mp3) antes de subir para reducir tamaño

**6. Expiración del token y reuniones activas**
El prompt dice +4 horas de expiración al token. ¿Si el usuario está grabando y se venció el token (porque tardó más de 4 horas), qué debe pasar? ¿Renovación automática o error explícito?

**7. Tabla `Operarios` — campos disponibles**
Para la búsqueda de colaboradores (`resumen_reuniones_buscar_colaboradores.php`), ¿qué campos de la tabla `Operarios` debo mostrar? En Hikvision de referencia se usa `CodOperario`. ¿Confirmas que los campos son `CodOperario`, `Nombre1`, `Nombre2`, `Apellido1`, `Apellido2`? (Vi el patrón en auth.php pero quiero confirmarlo).

---

### 🟢 De diseño / UX (afectan el resultado final pero son más fáciles de ajustar)

**8. UI de la página de grabación en el VPS (`reuniones.batidospitaya.com`)**
¿Quieres que tenga los colores corporativos de Pitaya (`#51B8AC`, tono teal), o algo más neutro/distinto dado que es una página pública (accesible con token, fuera del ERP)?

**9. Visualización del resumen en el ERP**
El resumen es "un bloque de texto plano con encabezados simples". ¿Quieres que en la vista del ERP se renderice preservando saltos de línea en un `<pre>` o en un `<div>` con `white-space: pre-wrap`, o prefieres algo más elaborado (ej. el módulo detecta encabezados y los formatea)?

**10. Notificación cuando el resumen está listo**
Cuando el VPS termina de procesar y el estado pasa a `completada`, ¿cómo se entera el usuario en el ERP? ¿Polling automático del listado cada X segundos mientras hay reuniones en estado `procesando`, o el usuario refresca manualmente?

**11. Nombre exacto del servicio systemd**
¿`resumen-reuniones-ia.service` (como sugiere el prompt) o prefieres otro nombre más corto como `reuniones-ia.service`?

---

Con tus respuestas puedo armar el plan de implementación completo sin ambigüedades. Las preguntas 1, 2, 4, 5 y 6 son las más importantes.