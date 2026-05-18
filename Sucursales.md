
Worker dvr 
- [x] Leon
- [x] Matagalpa
- [x] Esteli
- [ ] Altamira
- [x] Villa Fontana 
- [ ] Granada
- [x] Las Colinas
- [x] Masaya
- [ ] Natura
- [x] Las Brisas
- [ ] Rivas
- [ ] Unica
- [ ] Ticuantepe
- [ ] Calli


melon 131.67   mango -61.77  limon -158  leche coco 122.53

https://erp.batidospitaya.com/modulos/productos/dashboard_consumo.php 
En las tablas de Historial de consumo y proyecicon y planificacion vamos a agregar junto al input de filtro de producctos 2 inputs de fecha de pronostico y semana de corte que haran la misma funcion que las que existe ahorita para el grafico de movimiento de existencias 

Estos nuevos inputs unicamente serviran para clcular el stock promosticado que es lo imsmo que se ven en la grafica Movimiento de Existencia (Kardex) 

En la linea morada en la fecha que se pronsotica, ese dato son las existencias pronosticadas 

Estos nuevos inputs serviran apra hacer el calculo de esa cnatidad de stock pronosticado y se agregaran en una nueva columna en la pestana de Proyecicon y Planificacion 

Replica las mismas funciones y logica que se usa en la grafica, no uses las que existe apra el caclulo en la del grafico ya que esa calcula especificamente apra un solo item mientras que para la tabla tiene que salir el dato apra todos items en esa tabla 

Asegurate de que coincidan, osea de que si pongo unos parametros en la grafica de insumos y los mismos parametros en la tabla global entonces deberia coincidir el final de la grafica de pronsotico con el valor de la tabla que calcule hasme todas las preguntas necesarias para esta herrameinta antes de ejecutarla

### 1. ¿Dónde exactamente van los nuevos inputs?

El request dice "junto al input de filtro de productos" en ambas tabs (Historial y Proyección). Veo que hay **un solo input compartido** `#buscarHistorial` que filtra las dos tablas simultáneamente, ubicado encima de las tabs.

Los nuevos inputs de Fecha Pronóstico y Sem. Corte van: Junto al input `buscarHistorial` (en la misma barra, al lado del buscador), afectando a ambas tabs a la vez
### 2. ¿La nueva columna "Stock Pronosticado" va solo en Proyección o también en Historial?

La columna nueva va únicamente en el tab de Proyección, no en Historial

### 3. ¿Cómo se llama la columna nueva en la tabla de Proyección?

Stock Pronosticado
### 4. ¿El cálculo debe respetar la Semana de Corte?

La gráfica usa la semana de corte para calibrar el nivel del inventario (toma `InventarioCotizacion` de la semana anterior al corte como stock inicial), y luego aplica los movimientos de Kardex hasta el final del rango. Después, desde ese punto final, proyecta **solo consumo** hasta la fecha objetivo.

Para calcular esto en la tabla global **para todos los items a la vez**, necesitaría hacer una llamada AJAX que traiga los inventarios de corte de todos los productos simultáneamente.

La semana de corte y fecha pronóstico de la tabla deben funcionar exactamente igual que los de la gráfica (mismo endpoint, misma lógica de inventario) pero independiente , las graficas se mueven con sus inputs y las tablas con los nuevos inputs no se combina variables entre ellos

### 5. ¿Qué pasa si un item no tiene datos de inventario Kardex?

En la gráfica, si no hay datos de Kardex para un item, simplemente no muestra la línea morada. Para la tabla: `—` (dash, sin dato)

### 6. ¿Necesita un botón "Calcular" separado o debe recalcular automáticamente?

**¿Al cambiar la fecha de pronóstico o semana de corte en la tabla debería:**

Tener su propio botón "Calcular stock" para disparar el recálculo

### 7. ¿El endpoint AJAX existente `balance_inventario_get_detalle.php` puede recibir múltiples items?

Actualmente ese endpoint recibe un solo `id_pp`. Para calcular para **todos los items de la tabla** en paralelo habría que:

Crear un nuevo endpoint que reciba todos los `id_pp` a la vez y devuelva todos los stocks pronosticados juntos

