Actúa como un Ingeniero de Software Senior especializado en PHP (PDO), Javascript (Vanilla/jQuery) y MySQL, experto en depuración de sistemas ERP de inventarios y logística. 

Tu objetivo es resolver una discrepancia de sincronización de datos entre una tabla de pronóstico de inventario y un gráfico interactivo (Chart.js) de Kardex.

#### Contexto del Sistema
1. **El Modelo de Negocio:** El sistema cuenta con productos base (ej. ID 54) y presentaciones/empaques (ej. ID 152 que equivale a 20 unidades del 54). El sistema mapea estos valores automáticamente usando un motor llamado `cascadeMap`.
2. **El Problema Principal:** Un usuario reporta que en la tabla "Pronóstico de Abastecimiento", el "Stock Pronóstico D-1" muestra un valor correcto (ej. 117.2) tras un despacho reciente (120 unidades). Sin embargo, al abrir el gráfico interactivo del Kardex para el producto 152:
   - La línea verde (Stock Teórico Real) no grafica el ingreso de esas 120 unidades en la fecha del despacho (ej. 20 de Julio).
   - La línea azul (Proyección) parece ignorar el plan de despachos de la presentación 152 y realiza un cálculo de proyección lineal básico.
3. **Manejo del Tiempo:** El ERP utiliza semanas operativas (ej. Semana 551). El usuario desde la interfaz selecciona `semDesde` (ej. 548) y `semHasta` (ej. 551). La semana de corte (`semCorte`) suele ser igual a `semHasta`.

#### Archivos Involucrados
- `modulos/productos/js/pronostico_abastecimiento.js`: Orquesta el frontend, extrae `semHasta` del DOM y ejecuta peticiones AJAX a los scripts de pronóstico.
- `modulos/productos/js/pronostico_charts.js`: Renderiza los gráficos de Kardex y Proyecciones (`renderKardexCore` y `calcularPronosticoAbastKardex`). Construye los arreglos de fechas (`allDays`).
- `modulos/productos/ajax/pedido_sugerido_pronostico_v2.php`: Calcula el stock exacto para la tabla. Usa datos "intradía" para el día actual.
- `modulos/productos/ajax/balance_inventario_get_detalle.php`: Devuelve el historial de movimientos puros para construir la gráfica del Kardex.

#### Pistas de Depuración y Tareas a Ejecutar
Ejecuta tu análisis paso a paso y aplica las siguientes 3 correcciones necesarias en el código para resolver definitivamente el problema:

**TAREA 1: Normalización de Fechas SQL (Backend)**
La tabla `despacho_tiendas` utiliza una columna DateTime (`fecha_despacho`). El frontend envía fechas normalizadas en formato `YYYY-MM-DD` (`$phFec`). 
- **Acción:** Revisa las sentencias SQL en `balance_inventario_get_detalle.php` y `pedido_sugerido_pronostico_v2.php` (específicamente la consulta `stDesIntra2` y `stmt5_b`). Asegúrate de usar la función `DATE(dt.fecha_despacho)` al comparar, hacer `IN()` o extraer registros, para evitar que las horas (ej. `06:00:00`) causen que el registro sea ignorado.

**TAREA 2: Propagación del Identificador Correcto (Frontend)**
En `pronostico_charts.js`, el gráfico traza una línea azul utilizando una función de proyección. Si un producto 152 es consultado, el backend a veces devuelve en el nodo principal el ID de su producto base (54) para cálculos generales. El producto 54 no tiene plan de despachos asignado, el 152 sí. 
- **Acción:** Inspecciona la función `renderKardexCore`. Verifica si está invocando la función de proyección usando un genérico `res.id_pp` o si está utilizando correctamente el `idPP` original enviado desde `cargarChartKardex`. Corrige el flujo de parámetros para que la función reciba estrictamente `idPP` y cargue el plan de despachos del empaque (152), solucionando la línea azul.

**TAREA 3: El Límite de las Semanas Incompletas (Filtro SQL)**
Este es el "Core" del bug del Kardex. En `pronostico_abastecimiento.js` y `pronostico_charts.js`, la variable `semHasta` enviada al backend se extrae directamente del input HTML (ej. 551). Sin embargo, si hoy es lunes 20 de Julio (Semana 552), la semana está en curso. El frontend inteligentemente dibuja los días vacíos en el gráfico hasta llegar al "día de ayer", pero **el backend jamás devuelve los despachos ocurridos en la semana 552** porque sus consultas SQL usan un estricto `WHERE ss.numero_semana BETWEEN ? AND semHasta (551)`. Al ignorarse por el motor de BD, nunca entran a `movsPorFecha`.
- **Acción:** Implementa un mecanismo de "Overdrive" en los archivos Javascript antes de enviar los FormData. Define una variable `reqSemHasta = parseInt(semHasta)`. Lee la semana actual real del sistema desde el DOM (`.pa-badge-current-week strong`). Si `semanaActual > reqSemHasta` y `reqSemHasta === semCorte`, sobrescribe `reqSemHasta = semanaActual`. 
- **Ubicación:** Aplica esto en `calcularDatosParaSucursal()` justo antes del `fetch` a `pedido_sugerido_pronostico_v2.php`, y en `cargarChartKardex()` justo antes del `fetch` a `balance_inventario_get_detalle.php`. Envía `reqSemHasta` como parámetro `semana_hasta` al backend.

Proporciona el código modificado con la solución final, respetando estrictamente la arquitectura existente.
