# Proyecto: extractor de la subasta de Flyff Legacy (lectura de pantalla) → ejecutable .exe para Windows

## Objetivo
Herramienta local que recorre la casa de subastas de Flyff Legacy (corre en BlueStacks 5 sobre Windows), filtrando por categoría y clase. Lee cada página con captura + OCR + análisis de color y guarda todos los listados en SQLite y CSV.
Entregable: `flyff_subasta.exe` (PyInstaller), `config.json`, README en español y pruebas automáticas.

## Restricciones (obligatorias)
- Solo lectura de pantalla: captura de imagen + OCR + análisis de píxeles. Prohibido leer memoria del juego, inyectar código, interceptar o analizar tráfico de red o tocar archivos del juego.
- Todo local. Sin cuentas, sin login, sin enviar datos a ningún servidor.
- No incluyas funciones para ocultar la automatización ni evadir detección.
- Dos modos de operación:
  - `asistido`: el usuario hace los clics (filtros, scroll, página siguiente); la herramienta detecta el cambio y solo captura y lee.
  - `auto`: la herramienta hace filtros, scroll y cambio de página con `adb shell input tap/swipe`.

## Entorno
- BlueStacks 5, orientación horizontal fija (el juego fuerza horizontal), resolución 1600x900, 240 DPI.
- Captura y entrada por ADB (`adb exec-out screencap -p`, `adb shell input ...`). BlueStacks suele traer `HD-Adb.exe` en su carpeta de instalación y el usuario activa ADB en Ajustes > Avanzado. Autodetecta el ejecutable y el puerto, con ruta configurable en `config.json`. Si no hay ADB, alternativa: captura de la ventana con `mss`/`pywin32` (solo modo asistido).
- Las imágenes adjuntas son recortes a distintas escalas. Deriva el layout de la captura completa en 1600x900 y guarda todo en `config.json` como coordenadas relativas.

## Interfaz de la subasta (según las capturas)
- Barra superior: desplegables Category, Class, Rarity (cada uno con opción "View All") y botón "Cancel Search".
- Tabla con columnas: Item (ícono), Name, Tier, Total Price, Price per Unit.
- Cada página tiene 10 filas, pero solo se ven unas 4 completas y una quinta cortada; hay que hacer scroll dentro de la lista (barra amarilla a la derecha).
- Abajo: flechas de página y un indicador "N/M" (ejemplos: 1/4421, 22/641, 97/641, 1/71, 1/3, 1/8). M cambia según los filtros.
- Columna Name con dos líneas:
  - Línea 1: nombre, con el color de la rareza.
  - Línea 2: "CP 182853" (solo en equipo, siempre en blanco).
- Ícono: en equipo muestra la etiqueta "T7" abajo a la derecha (es el tier). En ítems apilables (orbs, materiales, pociones) ese número es la **cantidad** (ejemplos: 17, 1, 23).
- Precio: ícono de moneda (diamante azul o moneda dorada) + total; el precio por unidad va entre paréntesis en amarillo. Miles con punto (ejemplo: 500.000.000).

## Campos de salida por fila
fecha_hora, escaneo_id, categoria, clase, pagina, total_paginas, fila, nombre_completo, nombre_base, nivel_mejora (+N, null si no hay), bendito (0/1), cp (null si no aplica), tier, cantidad, moneda ("diamante" u "oro"), precio_total, precio_unitario, rareza, rareza_confianza, revisar (0/1), ruta_recorte (solo si revisar=1).

## Reglas de parseo
- **Rareza:** por el color del texto de la línea 1 del nombre (nunca la línea CP). Rosado/magenta = Epic, celeste = Rare, verde = Magic, blanco = Common, naranja = Ultimate. Clasifica por HSV con umbrales calibrados con las capturas y confirma con el color del marco del ícono (rosado, azul, verde, sin marco para Common). Si no coinciden, pon revisar=1.
- **Nivel:** sufijo `+N` en el nombre ("Ancient Staff +1") → nivel_mejora=1 y nombre_base sin el sufijo.
- **Bendito:** si el nombre empieza con "Blessed " → bendito=1 y nombre_base sin el prefijo. El fondo morado del ícono solo sirve de verificación.
- **CP:** línea "CP n"; null si no existe.
- **Tier:** columna Tier, entero.
- **Cantidad:** equipo → 1; apilables → número en la esquina inferior derecha del ícono. Valida que precio_total/cantidad redondeado hacia abajo coincida con precio_unitario; si no, revisar=1.
- **Moneda:** detecta el ícono (diamante vs moneda) por color/plantilla, no por OCR.
- **Números:** quita los puntos de miles; el precio unitario es el valor entre paréntesis.
- **Filas cortadas:** la fila parcial al borde inferior se descarta hasta que quede completa tras el scroll.

## Captura de una página
Hacen falta unas 3 capturas: filas 1-4, scroll, filas 5-8, scroll, filas 7-10.
- Une las capturas alineándolas por solapamiento (hash de los recortes de fila), no por contenido: puede haber listados idénticos legítimos.
- Detecta el final de la lista cuando el scroll ya no mueve la imagen.
- Se esperan 10 filas por página, salvo la última. Si no salen 10, reintenta una vez y marca la página como incompleta.

## Recorrido
- Categorías con clase: Weapon, Helmet, Suit, Gauntlets, Boots, Shield. Para cada una se recorren las clases Mercenary, Acrobat y Magician.
- Categorías sin clase: Necklace, Ring, Earrings, Upgrade Materials, Penya, Potions, Orbs, Marble, Crafting Materials, Pet. Se recorren una sola vez con Class = "View All".
- Rarity siempre en "View All": la rareza se obtiene del color.
- Para cada combinación: aplicar filtros, leer M del indicador, recorrer 1..M con la flecha siguiente, comprobando que el indicador cambió antes de capturar.
- Los nombres exactos de las opciones y el orden salen de las capturas de los desplegables; déjalos en `config.json`. La lista de Category puede requerir scroll dentro del desplegable.

## Asistente de calibración
Comando `calibrar`: toma una captura, la muestra y pide al usuario que haga clic sobre cada elemento (botones Category/Class/Rarity, cada opción de los desplegables, flechas de página, zona de scroll, recuadros del primer registro y sus columnas). Guarda las coordenadas en `config.json`. Incluye una vista que dibuje las cajas sobre una captura para verificar.

## OCR
- Evalúa con las imágenes adjuntas y elige el motor que mejor funcione al empaquetar (RapidOCR/onnxruntime o Tesseract). Evita EasyOCR/torch si el .exe queda demasiado pesado.
- Para dígitos y precios prueba clasificación por plantillas, ya que la fuente es fija.
- Meta: al menos 99% de acierto en campos numéricos sobre las imágenes de prueba.
- Corrige nombres por similitud (rapidfuzz) contra los nombres ya vistos en el escaneo.

## Persistencia y robustez
- SQLite `subasta.db` + exportación a CSV (UTF-8 con BOM, para Excel). Tablas: `escaneo` (id, inicio, fin, filtros) y `listados`.
- Reanudación: guarda el progreso (categoría, clase, página) y permite continuar.
- Guarda el recorte de cada fila con revisar=1.
- Log a archivo. Detecta pantallas inesperadas (popup, desconexión, pantalla que no es la subasta) y pausa avisando al usuario; no sigas haciendo clics a ciegas.
- Pausa entre acciones configurable (por defecto 0,7 s) y verificación tras cada acción. Los listados cambian mientras se escanea; es esperable y debe quedar documentado.

## Interfaz de línea de comandos (en español)
`flyff_subasta.exe calibrar`
`flyff_subasta.exe probar imagen.png` (parsea una captura y muestra las filas leídas)
`flyff_subasta.exe escanear --modo auto|asistido [--categoria Weapon] [--clase Mercenary] [--max-paginas 5]`
`flyff_subasta.exe exportar`

## Casos de prueba (valores esperados según las capturas)
| Nombre base | +N | Blessed | CP | Tier | Cant. | Moneda | Total | Unitario | Rareza |
|---|---|---|---|---|---|---|---|---|---|
| Ancient Axe | – | no | 182853 | 7 | 1 | oro | 89999999 | 89999999 | Epic |
| Ancient Axe | – | no | 182853 | 7 | 1 | diamante | 600 | 600 | Epic |
| Ancient Axe | – | no | 90051 | 7 | 1 | oro | 99999999 | 99999999 | Common |
| Ancient Crossbow | – | no | 130336 | 7 | 1 | diamante | 450 | 450 | Rare |
| Angel Staff | – | no | 6362 | 4 | 1 | oro | 2500000 | 2500000 | Rare |
| Angel Axe | – | no | 4495 | 4 | 1 | oro | 9999999 | 9999999 | Magic |
| Ancient Staff | +1 | no | 187450 | 7 | 1 | diamante | 100 | 100 | Epic |
| Angel Staff | – | sí (Blessed) | 9094 | 4 | 1 | diamante | 500 | 500 | Epic |
| Aibatt Orb | – | no | null | 1 | 17 | diamante | 150 | 8 | Common |
| Aibatt Orb | – | no | null | 1 | 23 | oro | 500000000 | 21739130 | Common |

Indicadores de página esperados: 1/4421, 22/641, 97/641, 1/71, 1/3, 1/8.

## Entregables
1. Código fuente en Python 3.11+ con estructura clara.
2. Script de build con PyInstaller y el `.exe` resultante.
3. `config.json` de ejemplo y README en español (activar ADB en BlueStacks, resolución, calibrar, escanear).
4. Pruebas automáticas con las imágenes adjuntas en `tests/`.

Pregunta solo si algo es bloqueante. Si falta una captura (por ejemplo la rareza Ultimate en naranja), implementa con un valor provisional y déjalo marcado en el README.