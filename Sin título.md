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

- **Frontend/Backend PHP**: la herramienta actual de marcacion es erp.batidospitaya.com\modulos\sucursales\marcacion_express.php , haremos una primera version de herraienta solo que me permita capturar la huella y comprara con la huella almacenada por colaborador para testarlo , en esa herrmaienta de desteo tambien debe estar el segmento que me permita registrar las 3 minucias de un colaborador y en una segunda etapa moveremos todo ese codigo a la herrmaienta de marcacion para tener ambos metodos por ingreso de clave como es ahora o por captura de huella y la de captura de datos la moveremos a otro modulo ya existente donde se registra datos de colaborador, esta primera herramienta no tendra ningun tipo de restriccion por permiso tienepermiso()
- **Base de datos**: MySQL en Hostinger — la tabla donde guardaremos las minucias de cada colaborador sera en operarios, revisa la estructura de esa tabla en dbpitaya para tener genera el script sql que me enviaras para ejcutarlo directamente y crear esa columna, la columna sera para guardar el json con las 3 minucias de cada colaborador 
- **VPS (DigitalOcean droplet)**: para el servicio de matching biométrico vamos a replicar la herramienta que se hiso en ResumenReunionesIA que vive en el droplet de digitalocean muy independiente de las otras herramientas existentes con todas sus librerias propias , en este proyecto de ejemplo tambien se detalla la comunicacion con ero via api.batidospitaya.com api.batidospitaya.com\api\resumen_reuniones_ia entonces crearemos un nuevo respositorio para esta herrameinta , el repositorio lo llamaremos LectorHuellaMarcacion y crearemos la carpeta en el drooplet llamado lector-huella-marcacion donde subiremos todos los archivos 

### Componentes a construir:

**1. Módulo WebUSB (JavaScript, para integrar en el frontend PHP testlectorhuella.php)**
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
     identificación, y rverifica la validez con registro en
     MySQL.
   - Pantalla de administración para enrolar empleados (capturar 3 muestras de huella por
     persona para mejorar precisión). igual en testlectorhuella.php
   - Pantalla de validacion: solo botón "Validar" + feedback de quién fue identificado.


**4. Documentación de despliegue (para incluir en el repo)**
   - Instrucciones para instalar el driver WinUSB en cada PC/tablet donde se conecte el lector,
     usando Zadig (Windows): descargar Zadig, Options > List All Devices, seleccionar
     "Microsoft Fingerprint Reader" (VID_045E, PID_00BD), reemplazar el driver por WinUSB.
   - Notas de requisitos: Chrome o Edge (no Firefox/Safari), HTTPS obligatorio (Hostinger ya
     tiene SSL), user gesture requerido para requestDevice().
   - Para tablet Android: requiere adaptador USB-OTG, Chrome para Android soporta WebUSB igual
     que en escritorio.

## Instrucciones para Antigravity

1. Primero, explora mis repositorios existentes (api.batidospitaya.com, erp.batidospitaya.com y ResumenReunionesIA) para
   entender la estructura de carpetas, convenciones de código, stack ya usado en el VPS, y el
   esquema actual de la base de datos MySQL (dbpitaya) antes de proponer cualquier archivo nuevo.
2. Propón el script sql de laedicion necesaria  de la tablas operarios
3. Empieza por el módulo WebUSB de forma aislada (un HTML/JS de prueba) para validar que la
   captura funciona igual que en Python antes de integrarlo al resto del sistema.
4. Luego arma el servicio de matching en el VPS, y por último la integración PHP + MySQL.
5. Pregúntame antes de instalar dependencias nuevas en el droplet si eso implica cambios
   grandes en su configuración actual (nginx, firewall, etc.).