
pitaya claude 20

Searched for "expected_m"
Searched for "ice"
Searched for "base_val"
Viewed dashboard_consumo.js:406-1205
Searched for "calcularProyeccionWLS"
Viewed pedido_sugerido_calcular_v2.php:1-800

He analizado exhaustivamente todo el flujo matemático del cálculo del pronóstico y la forma en la que se aplican los factores de crecimiento (ICE). 

La solución es sorprendentemente elegante y afecta en cadena a todo lo que pides. 

### La Lógica a Implementar
Actualmente, el sistema ya ancla el punto de inicio al **máximo de las últimas 2 semanas** solo cuando la tendencia es **negativa** (para evitar proyecciones a 0). 

Para cumplir tu requerimiento, haremos que **incluso cuando la tendencia (m) sea positiva**, se "mueva" la recta matemáticamente. Lo lograremos desplazando el **intercepto (`b`)** de la recta original para que, en la "semana actual", el punto de anclaje (`base_val`) sea forzosamente el pico de las últimas 2 semanas.

> **Magia matemática:** Al aplicar este pequeño desplazamiento de la base directamente desde la raíz, el bloque de código de Crecimiento Esperado (ICE) no necesitará tocarse, ya que este lee dinámicamente el `base_val` y automáticamente forzará su porcentaje por encima de este nuevo punto alto anclado.

---

### Lista Detallada de Archivos Implicados (Para tu Aprobación)

Para que el ajuste sea completo en todo el ERP (Gráficas de pronóstico, Gráficas de Kardex dinámico, Tabla principal de abastecimiento, Tablas de dashboard y Exportaciones Excel), tocaré estos 4 archivos:

**1. Backend (Donde se genera el WLS primario):**
* `modulos/productos/ajax/pedido_sugerido_calcular_v2.php`
* `modulos/productos/ajax/dashboard_consumo_get_datos.php`
> **Acción:** En la función principal `calcularProyeccionWLS`, modificaremos el cálculo del intercepto `$intercept`. Añadiremos la condición de que si `$slope >= 0`, se calcule `$intercept = $max_ultimas2 - ($slope * $n)`.

**2. Frontend (Donde se genera el OLS de respaldo y se dibujan las gráficas):**
* `modulos/productos/js/pronostico_charts.js` 
> **Acción:** En la función `renderChartTendencia`, modificaremos el fallback OLS para que `regIntercept = maxUlt2 - (regSlope * ultimaSem)`. Esto garantiza que si falla el backend o no hay datos WLS, el JS siga haciendo el anclaje correctamente.
* `modulos/productos/js/dashboard_consumo.js`
> **Acción:** Modificaremos `renderGrafico` (Gráfica del Dashboard) y `renderTablaProyeccion` (Tabla inferior del Dashboard) para que usen exactamente el mismo anclaje y las cifras cuadren al 100% con la vista de abastecimiento.

*(No hace falta modificar `pronostico_abastecimiento.js` ni `alertas_agotamiento.js` ya que estos heredan las variables `wls_b` del backend y con el desplazamiento del intercepto, harán el trabajo de forma automática).*

¿Estás de acuerdo con el alcance de esta solución? **Confírmame para proceder con la inyección del código.**