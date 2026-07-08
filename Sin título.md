# Proyecto: Módulo de marcación de personal por huella dactilar (WebUSB + NBIS)

## Contexto del hardware

Tengo un lector de huellas "Microsoft Fingerprint Reader" (chip Digital Persona U.are.U 4000,
USB VID 0x045e, PID 0x00bd) cuyo protocolo ya reverse-engineerié y validé funcionando en Python
con pyusb. Necesito portar esta lógica a WebUSB (JavaScript) para usarlo directo desde el
navegador (Chrome/Edge) en una PC de escritorio o en una tablet Android, sin apps nativas.

### Protocolo USB validado (confirmado funcionando, basado en libfprint driver "uru4000"):

- Endpoints: Interrupt IN = 0x81 (eventos), Bulk IN = 0x82 (datos de imagen)
- Control transfers: bRequest = 0x04
  - Lectura de registro: bmRequestType vendor/IN (0xC0), wValue = dirección del registro
  - Escritura de registro: bmRequestType vendor/OUT (0x40), wValue = dirección del registro, data = 1 byte
- Registros clave:
  - REG_HWSTAT = 0x07 (estado de hardware/energía)
  - REG_MODE = 0x4e (modo de operación)
- Valores de modo: 0x10 = esperar dedo, 0x20 = capturar
- Eventos por endpoint de interrupción (64 bytes, primeros 2 bytes = tipo, big-endian):
  - 0x56aa = sensor listo, 0x0101 = dedo colocado, 0x0200 = dedo retirado
- Imagen: 384 (ancho) x 289 (alto), escala de grises, 8 bits por píxel
  - Captura bulk total: 111,040 bytes = 64 bytes de cabecera + 110,976 bytes de imagen (384x289)
  - Se pide con dev.read(0x82, 0x1b340) en pyusb; en WebUSB usar transferIn con tamaño equivalente

### Secuencia de flujo confirmada y probada en Python:
1. Leer REG_HWSTAT.
2. Escribir REG_MODE = 0x10 (esperar dedo).
3. Escuchar endpoint 0x81 hasta recibir evento 0x0101 (dedo puesto).
4. Escribir REG_MODE = 0x20 (modo captura).
5. Leer endpoint 0x82 (bulk) para obtener los 111,040 bytes.
6. Descartar los primeros 64 bytes (cabecera), el resto son los 384x289 píxeles en escala de grises.

## Objetivo del proyecto

Implementar un sistema de marcación de personal por huella dactilar con identificación 1:N
(reconoce al empleado solo con la huella, sin login previo), integrado a mi stack existente:

- **Frontend/Backend PHP**: alojado en Hostinger (hosting compartido) — [Claude: revisa la
  estructura real de mi repositorio de Hostinger en GitHub para integrarte a los archivos,
  convenciones de nombres y estilo ya existentes]
- **Base de datos**: MySQL en Hostinger — [Claude: revisa el esquema actual antes de proponer
  nuevas tablas, para mantener consistencia con las tablas de empleados ya existentes]
- **VPS (DigitalOcean droplet)**: para el servicio de matching biométrico — [Claude: revisa mi
  repositorio del droplet para ver qué stack ya corre ahí (Node/Python/Docker/nginx, etc.) y
  encajar el nuevo servicio con el resto de la infraestructura existente]

### Componentes a construir:

**1. Módulo WebUSB (JavaScript, para integrar en el frontend PHP existente)**
   - Botón "Conectar lector" que llama a `navigator.usb.requestDevice()` filtrando por
     vendorId 0x045e, productId 0x00bd.
   - Implementación de las funciones equivalentes a mi script Python: readReg, writeReg,
     waitForFinger, captureImage — usando controlTransferIn/Out y transferIn de la API WebUSB.
   - Conversión de los bytes crudos a un canvas/imagen visible en el navegador (para feedback
     visual al usuario) y a un Blob/base64 para enviar al backend.
   - Manejo de errores claro: dispositivo no encontrado, timeout esperando dedo, navegador
     incompatible (detectar si `navigator.usb` no existe y mostrar mensaje).
   - Debe funcionar igual en escritorio (Chrome/Edge Windows) y en tablet Android (Chrome +
     adaptador USB-OTG).

**2. Servicio de matching biométrico (en el VPS)**
   - Usar NBIS (NIST Biometric Image Software): `mindtct` para extracción de minucias desde
     la imagen (formato que requiere — ajustar si es necesario a PGM u otro compatible) y
     `bozorth3` para comparar minucias entre dos huellas y obtener un puntaje de similitud.
   - Exponer esto como una API HTTP simple (Flask/Node/lo que ya uses en el droplet):
     - `POST /enroll` — recibe imagen + employee_id, extrae minucias, las guarda.
     - `POST /identify` — recibe imagen, extrae minucias, compara (bozorth3) contra todas las
       plantillas ya enroladas, devuelve employee_id + score si supera un umbral configurable,
       o "sin coincidencia".
   - Guardar las plantillas de minucias (no las imágenes crudas, por espacio y privacidad) en
     el propio VPS o en la MySQL de Hostinger si se prefiere centralizar — a definir según lo
     que sea más simple con mi infraestructura actual.

**3. Integración en PHP (Hostinger)**
   - Endpoint que recibe la imagen capturada desde el frontend WebUSB, la reenvía al VPS para
     identificación, y registra la marcación (empleado, timestamp, tipo entrada/salida) en
     MySQL.
   - Pantalla de administración para enrolar empleados (capturar 2-3 muestras de huella por
     persona para mejorar precisión).
   - Pantalla de marcación: solo botón "Marcar" + feedback de quién fue identificado.
   - Reportes básicos de asistencia (esto puede aprovechar tablas/lógica ya existente si ya
     tengo algo de gestión de empleados).

**4. Documentación de despliegue (para incluir en el repo)**
   - Instrucciones para instalar el driver WinUSB en cada PC/tablet donde se conecte el lector,
     usando Zadig (Windows): descargar Zadig, Options > List All Devices, seleccionar
     "Microsoft Fingerprint Reader" (VID_045E, PID_00BD), reemplazar el driver por WinUSB.
   - Notas de requisitos: Chrome o Edge (no Firefox/Safari), HTTPS obligatorio (Hostinger ya
     tiene SSL), user gesture requerido para requestDevice().
   - Para tablet Android: requiere adaptador USB-OTG, Chrome para Android soporta WebUSB igual
     que en escritorio.

## Instrucciones para Claude Code

1. Primero, explora mis repositorios existentes (Hostinger y droplet de DigitalOcean) para
   entender la estructura de carpetas, convenciones de código, stack ya usado en el VPS, y el
   esquema actual de la base de datos MySQL antes de proponer cualquier archivo nuevo.
2. Propón el esquema de las tablas nuevas necesarias (empleados_huellas, marcaciones, etc.)
   ajustándote a las que ya existan si hay coincidencia semántica.
3. Empieza por el módulo WebUSB de forma aislada (un HTML/JS de prueba) para validar que la
   captura funciona igual que en Python antes de integrarlo al resto del sistema.
4. Luego arma el servicio de matching en el VPS, y por último la integración PHP + MySQL.
5. Pregúntame antes de instalar dependencias nuevas en el droplet si eso implica cambios
   grandes en su configuración actual (nginx, firewall, etc.).