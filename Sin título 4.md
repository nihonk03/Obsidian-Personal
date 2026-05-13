Perfecto, ya tengo toda la info. Te explico todo claramente:

---

## 🔍 Diagnóstico de tu situación

### ✅ Lo que está correcto:

1. **El worker en el VPS está activo** — `hikvision-worker` corriendo, diciendo "Cola vacía" = espera trabajos. Eso es normal y correcto.
    
2. **El comando `ssh root@198.211.97.243 -N` parpadeando sin salida** = **PERFECTO**, significa que la conexión SSH está establecida y mantenida. Eso es lo esperado con `-N` (no ejecuta comandos, solo mantiene el túnel).
    

---

### 📡 ¿En qué puerto está trabajando Villa Fontana?

Revisando el archivo `tunel_dvr_villafontana.bat`, línea 24:

-R 0.0.0.0:9579:192.168.1.90:554

> **Puerto VPS: `9579`** (el README dice 9559, pero el `.bat` real usa **9579** — usa el del `.bat`, ese es el que importa)
> 
> **DVR local IP:** `192.168.1.90` puerto `554` (RTSP)

---

### 🔎 ¿Cómo verificar si el túnel desde Villa Fontana ya llegó al VPS?

Ejecuta esto **en el VPS** (vía SSH al `198.211.97.243`):

bash

# Ver si el puerto 9579 está escuchando (tunnel activo de Villa Fontana)

ss -tlnp | grep 9579

**Si el túnel está activo**, verás algo como:

LISTEN 0  128  0.0.0.0:9579  0.0.0.0:*

**Si no aparece nada** = el túnel de Villa Fontana NO ha llegado al VPS todavía.

---

### 🧪 Para probar que el DVR de Villa Fontana responde a través del túnel:

bash

# En el VPS, probar si el DVR responde (reemplaza CLAVE con la del DVR)

ffmpeg -rtsp_transport tcp -i "rtsp://admin:CLAVE@127.0.0.1:9579/PSIA/Streaming/tracks/101" -t 5 -f null - 2>&1 | tail -5

---

### 📋 Ver todos los túneles activos de todas las sucursales:

bash

ss -tlnp | grep -E "957[0-9]|955[0-9]"

---

### ⚠️ Nota importante

El README dice que Villa Fontana usa puerto `9559`, pero el `.bat` real tiene `9579`. Deberías actualizar la documentación o la BD para que sean consistentes. Verifica cuál está en `DVR_Sucursales`:

sql

SELECT cod_sucursal, nombre, puerto_rtsp_vps, tunel_activo 

FROM DVR_Sucursales 

WHERE cod_sucursal = 9;

6:58 AM