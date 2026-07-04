

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