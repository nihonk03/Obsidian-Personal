# PROMPT PARA Antigravity

## Sistema de Activación NTP en DVRs Hikvision — Nicaragua

---

## CONTEXTO DEL PROYECTO

Tengo una infraestructura de monitoreo de cámaras de seguridad con DVRs marca Hikvision distribuidos en múltiples ubicaciones físicas en Nicaragua (más de 20 DVRs). Todos operan en la zona horaria `America/Managua` (UTC-6, sin horario de verano).

Cada DVR tiene una PC en su misma red local. Esas PCs están conectadas mediante un túnel/puente a mi VPS, lo que permite que desde el VPS pueda acceder directamente a las IPs privadas de los DVRs (ej: `http://192.168.1.110:80`) sin necesidad de port-forwarding ni NAT. El enrutamiento es transparente.

Los datos de cada DVR (IP local, puerto HTTP, puerto RTSP, código de local, usuario, contraseña, etc.) están almacenados en una base de datos existente en el VPS.

El problema que quiero resolver: cuando hay cortes de luz o reinicios, los DVRs pierden la hora configurada y empiezan a grabar con fechas incorrectas, lo que hace difícil recuperar grabaciones por fecha.

---

## OBJETIVO

Construir un script Python que:

1. **Lea la lista de DVRs** desde la base de datos existente DVR_Sucursales.
2. **Se conecte a cada DVR** vía ISAPI de Hikvision usando HTTP Digest Auth.
3. **Active y configure NTP** en cada DVR apuntando a `time.google.com`, con zona horaria `America/Managua` (CST, UTC-6).
4. **Verifique** que la configuración quedó aplicada correctamente consultando el endpoint de tiempo.
5. **Reporte el resultado** de cada DVR: éxito, fallo de conexión, fallo de autenticación, o configuración ya correcta.
6. **Envíe un webhook HTTP** al finalizar con el resumen consolidado de la ejecución.
7. **Guarde logs** tanto en consola (stdout) como en archivo persistente con rotación.

---

## BASE DE DATOS

La base de datos ya existe. La tabla de DVRs tiene al menos estas columnas relevantes ):

```
CREATE TABLE `DVR_Sucursales` (

`cod_sucursal` int(11) NOT NULL,

`nombre_sucursal` varchar(255) DEFAULT NULL,

`modelo` varchar(255) DEFAULT NULL,

`marca` varchar(255) DEFAULT NULL,

`serial` varchar(255) DEFAULT NULL,

`clave_dispositivo` varchar(255) DEFAULT NULL,

`portal_ip_local` varchar(255) DEFAULT NULL,

`portal_usuario` varchar(255) DEFAULT NULL,

`portal_clave` varchar(255) DEFAULT NULL,

`url_imagen` varchar(255) DEFAULT NULL,

`capacidad` varchar(255) DEFAULT NULL,

`canal_caja` int(11) DEFAULT 0 COMMENT 'Canal de caja',

`puerto_rtsp_vps` int(11) DEFAULT NULL COMMENT 'Puerto RTSP expuesto en VPS via túnel SSH inverso',

`tunel_activo` tinyint(1) DEFAULT 0 COMMENT '1=Túnel SSH configurado y activo en producción',

`puerto_http_vps` int(11) DEFAULT NULL COMMENT 'Puerto VPS para tunel HTTP/ISAPI (DVR moderno). NULL o 0 = sin tunel HTTP (usa RTSP). Convencion: puerto_rtsp_vps + 100',

PRIMARY KEY (`cod_sucursal`),

UNIQUE KEY `cod_sucursal_unique` (`cod_sucursal`)

) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

"cod_sucursal","nombre_sucursal","modelo","marca","serial","clave_dispositivo","portal_ip_local","portal_usuario","portal_clave","url_imagen","capacidad","canal_caja","puerto_rtsp_vps","tunel_activo","puerto_http_vps"
2,León,DS-7104HGHI-F1,Hikvision,"586326303",SOLINS,"192.168.1.20",admin,abcd1234,http://admin:abcd1234@192.168.1.20:80/ISAPI/Streaming/channels/201/picture,,101,9552,1,9652

```

La conexion a la base de datos se hace via api a traves de api.batidospitaya.com

---

## ENDPOINTS ISAPI DE HIKVISION A USAR

### 1. Leer configuración actual de tiempo

```
GET /ISAPI/System/time
Authorization: Digest (HTTP Digest Auth)
```

### 2. Configurar NTP y zona horaria

```
PUT /ISAPI/System/time
Content-Type: application/xml

<?xml version="1.0" encoding="UTF-8"?>
<Time version="2.0" xmlns="http://www.hikvision.com/ver20/XMLSchema">
  <timeMode>NTP</timeMode>
  <timeZone>CST+6:00:00</timeZone>
</Time>
```

> Nota: Hikvision usa la convención inversa para timezone. UTC-6 se escribe como `CST+6:00:00`.

### 3. Configurar servidor NTP

```
PUT /ISAPI/System/time/NtpServers/1
Content-Type: application/xml

<?xml version="1.0" encoding="UTF-8"?>
<NTPServer version="2.0" xmlns="http://www.hikvision.com/ver20/XMLSchema">
  <id>1</id>
  <addressingFormatType>hostname</addressingFormatType>
  <hostName>time.google.com</hostName>
  <portNo>123</portNo>
  <synchronizeInterval>60</synchronizeInterval>
</NTPServer>
```

### 4. Verificar que quedó aplicado

```
GET /ISAPI/System/time/NtpServers/1
```

Confirmar que `<timeMode>` es `NTP` y `<hostName>` es `time.google.com`.

---

## ESTRUCTURA DEL PROYECTO

```
dvr_ntp_setup/
├── main.py               # Entry point, orquesta todo
├── config.py             # Variables de entorno y constantes
├── db.py                 # Conexión y consulta a la BD
├── hikvision.py          # Cliente ISAPI: get_time, set_ntp, verify_ntp
├── notifier.py           # Envío de webhook HTTP con resumen
├── logger.py             # Configuración de logging (consola + archivo)
├── requirements.txt      # requests, psycopg2-binary (o el driver que corresponda)
├── .env.example          # Plantilla de variables de entorno
└── logs/
    └── ntp_setup.log     # Log persistente con rotación (max 5MB x 3 archivos)
```

---

---

## COMPORTAMIENTO ESPERADO

### Ejecución

```bash
python main.py
# Opcionalmente con filtro:
python main.py --codigo-local MI_SUCURSAL   # procesar solo 1 DVR
python main.py --dry-run                    # simular sin hacer cambios
```

### Procesamiento

- Leer todos los DVRs activos de la BD.
- Procesar en paralelo con un pool de workers (configurable, default 5) para no tardar horas con 20+ DVRs.
- Por cada DVR:
    1. Intentar GET `/ISAPI/System/time` — si falla conexión, marcar como `UNREACHABLE`.
    2. Verificar si ya tiene NTP con `time.google.com` — si ya está correcto, marcar `ALREADY_OK` y saltar.
    3. Si no, hacer PUT para configurar tiempo en modo NTP + zona horaria.
    4. Hacer PUT para configurar el servidor NTP.
    5. Hacer GET de verificación.
    6. Marcar resultado: `SUCCESS`, `PARTIAL` (algo falló en el proceso), o `FAILED`.

### Log por DVR (ejemplo)

```
[2025-05-15 10:32:01] [LOCAL_001] 192.168.1.110 — Iniciando configuración NTP
[2025-05-15 10:32:02] [LOCAL_001] 192.168.1.110 — GET /ISAPI/System/time → 200 OK
[2025-05-15 10:32:02] [LOCAL_001] 192.168.1.110 — timeMode actual: manual. Requiere cambio.
[2025-05-15 10:32:03] [LOCAL_001] 192.168.1.110 — PUT /ISAPI/System/time → 200 OK
[2025-05-15 10:32:03] [LOCAL_001] 192.168.1.110 — PUT /ISAPI/System/time/NtpServers/1 → 200 OK
[2025-05-15 10:32:04] [LOCAL_001] 192.168.1.110 — Verificación OK → SUCCESS
```

### Webhook al finalizar

```json
POST {WEBHOOK_URL}
Content-Type: application/json

{
  "evento": "ntp_setup_completado",
  "timestamp": "2025-05-15T10:35:00-06:00",
  "resumen": {
    "total": 23,
    "success": 18,
    "already_ok": 2,
    "unreachable": 2,
    "failed": 1
  },
  "detalle": [
    {
      "codigo_local": "LOCAL_001",
      "ip": "192.168.1.110",
      "resultado": "SUCCESS"
    },
    {
      "codigo_local": "LOCAL_007",
      "ip": "192.168.2.45",
      "resultado": "UNREACHABLE",
      "error": "Connection timeout"
    }
  ]
}
```

---

## MANEJO DE ERRORES

- **Timeout de conexión**: usar el valor de `TIMEOUT_SEGUNDOS` (default 10s). No reintentar, marcar `UNREACHABLE`.
- **401 Unauthorized**: marcar `AUTH_ERROR`, loggear sin exponer la contraseña.
- **Respuesta XML inválida o inesperada**: marcar `FAILED`, loggear el body de la respuesta.
- **Error de BD**: abortar ejecución con mensaje claro, no enviar webhook.
- El script debe terminar con **exit code 0** si todos los DVRs son SUCCESS o ALREADY_OK, **exit code 1** si alguno falló o fue UNREACHABLE.

---

## CONSIDERACIONES TÉCNICAS IMPORTANTES

1. **Autenticación**: Hikvision usa **HTTP Digest Auth**, NO Basic Auth. Usar `requests.auth.HTTPDigestAuth`.
2. **XML namespace**: siempre incluir `xmlns="http://www.hikvision.com/ver20/XMLSchema"` en el XML del PUT.
3. **Zona horaria en Hikvision**: la convención es invertida. UTC-6 (Nicaragua) = `CST+6:00:00`.
4. **Acceso de red**: el VPS tiene rutas directas a las IPs `192.168.x.x` de los DVRs vía túnel. No hay que hacer ninguna configuración de red especial en el código; simplemente usar la IP local del DVR como destino HTTP.
5. **Paralelismo**: usar `concurrent.futures.ThreadPoolExecutor`, no asyncio, para mantener el código simple.
6. **Logs**: usar el módulo `logging` estándar de Python con `RotatingFileHandler` (5MB max, 3 backups).

---

## ENTREGABLES ESPERADOS DE Antigravity

1. Todos los archivos del proyecto listos para ejecutar.
2. `requirements.txt` con versiones fijadas.
3. `.env.example` con todas las variables documentadas.
4. Instrucciones breves de instalación y ejecución en un `README.md`.
5. Al menos un test básico en `test_hikvision.py` que mockee las llamadas HTTP y verifique la lógica de decisión (ya tiene NTP → skip, no tiene → configurar).

---

## PREGUNTAS QUE Antigravity DEBE HACERME ANTES DE EMPEZAR

Antes de escribir código, Antigravity debe preguntarme:

1. ¿Qué motor de base de datos es? (PostgreSQL, MySQL, SQLite, otro)
2. ¿Cuáles son los nombres exactos de la tabla y columnas relevantes, o puedo hacer un `\d tabla` para verlos?
3. ¿El webhook requiere algún header de autenticación específico (Bearer token, HMAC, etc.)?
4. ¿Querés que el script se pueda instalar como servicio systemd para correr periódicamente, o solo se ejecuta manualmente/cron?