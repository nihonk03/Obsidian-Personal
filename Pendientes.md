David

1. Activar/desactivar la visibilidad de tiendas en ventas meta.
2. Agregar la columna con el nombre de la promoción aplicada a la DB de ventas que alimenta Locker.
3. Dejar de anclar la gráfica de proyección de despacho a la semana 553, porque las proyecciones de stock mínimo de ese momento no son realistas.

4. Habilitar el nombre de la tienda, y no solo el código, en la consulta de compras de caja.
5. Agregar la cuenta y la subcuenta a la DB de despachos costeados.
6. no mapea producto despacho de presentacion_producto para costo en el caso de la naranja entera 
7. Claudia, puedes investigar con miguel porque hay 2 OC con la misma numeracion 6837

Edvi
1. Modificacion de factura a como esta en contabilidad

Miguel
1. Migracion de orden de compra  y facturas a erp
2. Convertir a eretail ferreterias
3. Estandarizacion de herramientas

 
Facturacion de bolonia hecho mal 
asignacion lideres y anc sincronizados en edicion

Revisar pedido 180 en revision de conteo ciclico eliminar pendientes

MOdifcar proceso de ferias y apeturas
Despacho hacia centor de costos y no locales


MIguel
- Comandas de tripleberry y limonada con calala al seleccionar normal de azúcar indica agregar 4 1/2 onz de azúcar
- Listado de acceso a operaciones a katehrine



- incluir vasos en conteo ciclico





migracion Orden de comrpa y compra



Nuevo número para Whatsapp Api: 76453067


pos.batidospitaya.com/modulos/pos/facturas_nueva.php  
  
Vamos a restructurar los menus a un nuevo nivel con las siguientes consideraciones

1. EL catalogo se guarda en catalogo_menu_pos donde cada item se enlaza a un sbgrupo y grupo mayor



Reunion katherine
- mermas
- mantenimiento
- modifcacion de estrcutura de tabla para registro de productos joshua



batidospitaya.com: ##### Ya somos mas de 5mil miembros!! por contador dinamico real
- desde panel de edicion pitaya.com


Claude
Orden de compra + factura  + ingreso

procedimiento de aprtura y cirerre de turno


Versionado: un registro de OC y otra anexa de versiones , detalle de OC con tabla nexa para versiones
realcion factura OC : una misma tabl o tablas distintas 


El registro de pagos e ingresos esta bloqueado y limitado a la OC, no se peude registrar mas por lo tanto no habria ocpion de version de OC auntomatico

Un solo maestro de OC permisos para ver informacion y acciones distintas areas


estandar de diseno como cupones 


instalar servicio propio de convertir voz a texto 





1. SI
2. No puede registrar la factura aun mientr exuste una version en tramite, lo unicoq ue admite es rececpcion y pagos esto es porque despues de una oc aprobada ya se activan los envios del provedor y por ende los pagos pero si hay neceisdad de acambiar la oc por ende la fatcura es un tramite administrativo solmente
3. No, hasta que se haga unc OC versionada aprobada se registra la factura nuevamente porque descartar una version no implica nos quedamos conla anterior si no que a fuerzas tiene que registrar una version valida auque sea la misma de una verison anterior o de 2 versiones anteriores no importa
4. si correcto
5. No, al final todo debe de nacer de la OC poruqe es el unico documento firmado fisicamente por lo tanto es la fuente de la verdad , si permitimos que editen factures de datos que viene de la OC en una auditoria habr problemas de informacion
6. SI y SI

Cabe reslatar que este procedimiento en la practuica de Pitaya y de manera resumida es que se crea una OC y puede tener iteraciones hasta que porfin lo aproeban , solo se confirma la aprobacion conuna foto del documento fisico firmado, ese es el disparador y enllavado de la oc para que se accionene las 2 areas en paraleleo seugn las caracteristicas de la OC , uno de receibir producto y otro de gesitonar pagos; si durantes la recepcion o gestion de pago hay incongruencias ocmbios internos o del aldo del provedor entonces se activa un procedimiento admimistrativo de versionado siempre manteniendo el codigo de la primera versio como OC padre y las demas versiones solo se ven al suuario como OC padre v1, v2 , v3 etc que neuvamente pasna por la aprobacion para que permita finalmente registrar la factura corrctmente pero nunca se detienen los procedimientos de pagos ni de recepcion porque desde el primer disparador ya se coorina con proveedor eoss envios lo demas son solo temas admnistrativos a solucionarse , el proceso acaba ya con la factura registrada que va en sintonia con la OC version x que este aprobada y todos los pagos hehcos y rececpciones hechas, asi que la fuente de la verdad siempre ser la OC Vx aprobada y el numero de procedimiento es simepre la primera version aprobada

Revisa si hay alguna duda mas o contradiccion o ambiguedad




Revisé el documento y los tres bloques de preguntas y respuestas. Las incongruencias de fondo ya están resueltas, pero quedan dos cosas: texto del documento que contradice tus decisiones y siete decisiones nuevas que tus respuestas dejaron abiertas.

## 1. Texto del documento que hay que reescribir

Aquí tu decisión ya está tomada y solo falta aplicarla:

- **Devolución:** pasa de EN_APROBACION a PENDIENTE sobre la misma fila y la hace el cargo 19. El estado DEVUELTA deja de existir, el comentario va a `oc_historial`, y cambian 5.1, 7.7, la regla 23, el criterio 14 y la fila de 8.1. Se devuelve cualquier versión (V1 o posterior) mientras no esté aprobada.
- **Cierre de recepción:** desaparece `recepcion_cierre`. Hay que quitar la reapertura de 5.6.5, el cierre de 5.3, 7.4 y 8.1 a 8.3, el alcance de la sección 3, la Fase 3 y el criterio 17. `estado_recepcion` pasa a ser puramente calculado.
- **Código visible:** `OC-n-Vn-Rn`, con el número de impresión.
- **Líneas en 5.6.2 y 5.6.3:** hoy dicen que no se pueden quitar y que se dejan en cantidad 0. Ahora se pueden borrar (sin recepciones) pero no agregar.
- **IVA:** el costo se captura sin IVA, `aplica_iva` suma el 15% y manda el total digitado, que es con IVA. Hay que corregir la regla 9, que hoy dice lo contrario.
- **Tolerancia de 0.01:** solo en montos, nunca en cantidades. Aclarar en la regla 15 y el criterio 18 que una diferencia de 0.01 o menos se acepta.
- **Facturas:**
  - Los pagos se permiten con la factura PENDIENTE, lo que cambia la regla 22, 5.2, 7.6, el criterio 25 y el listado de CxP, que hoy dice "solo APROBADAS".
  - APROBADA significa que ya se capturaron los datos reales, así que `datos_reales_capturados` sobra. El criterio 27 pasa a pedir factura APROBADA y ninguna versión en trámite.
  - Se elimina la cancelación para facturas con OC, porque ahora se reemplazan.
  - Recepción, factura y pagos cuelgan del `oc_padre_id`.
- **Pago a una sola factura:** `pago.factura_id` reemplaza a `pago_aplicacion`, y cambian 5.2, 5.4, la regla 16 y el criterio 9.
- **Moneda y vencimiento:** el tipo de cambio se guarda siempre, incluso en OC en NIO. Falta `total_cordobas` en la factura y sus líneas (lo pediste para costos). `fecha_vencimiento_pago` queda vacía hasta que se capture la factura física.
- **ALTER nuevos:** `centro_costo_id` en `pos_facturas_detalle` y los días de crédito en `tipo_pago_proveedores`.
- **Referencias y detalles:**
  - Fase 6 apunta a "9.2", que no existe.
  - La regla 9 de la sección 1 todavía habla de recrear `pos_facturas`.
  - Hay que fijar que el peso va en libras, que los nombres de archivo llevan un identificador aleatorio además de la OC, y que el duplicado de factura se valida por proveedor y número (excluyendo la propia factura al reemplazarla).

## 2. Puntos abiertos

Pongo mi propuesta en cada uno; puedes responder "ok" o corregirme.

1. **Factura PENDIENTE después de descartar una versión.** Descartar no restaura la factura y exige otra versión aprobada. Pero entonces una factura PENDIENTE recién creada, que sí se puede capturar, y una PENDIENTE por versión solicitada, que está bloqueada, se ven iguales. *Propuesta:* una bandera `bloqueada_por_version` que se activa al solicitar la versión y se apaga al aprobar la siguiente.
2. **Recepciones y pagos durante una versión en trámite.** El borrador puede quedar inválido, por ejemplo si se baja a "lo recibido" y el almacén sigue recibiendo, o si el total queda por debajo de lo ya pagado. Con la foto ya firmada, el problema aparece recién al aprobar. *Propuesta:* revalidar ambos límites al imprimir y al aprobar, con bloqueo de filas. Si se violan, se rechaza la aprobación y hay que devolver o descartar y rehacer.
3. **Datos reales al pasar la factura a PENDIENTE.** ¿Se conservan número, fecha y vencimiento hasta la nueva captura, archivando los anteriores en `oc_historial` al reemplazarlos? Y cuando la captura difiere y dispara la versión prellenada, ¿se guardan el número y la fecha digitados para no re-teclearlos? *Propuesta:* sí a ambas.
4. **Factura sin OC.** ¿Nace APROBADA al guardarla, ya con datos reales? Con la nueva definición, "aprobar" para facturas con OC es solo capturar datos. *Propuesta:* nace APROBADA, se elimina la acción separada "Aprobar factura" y la segregación B4 queda sin objeto.
5. **Reimpresión y foto firmada.** Si se reimprime sin cambios (se perdió el papel) y el código sube a R2, la foto ya firmada de R1 sería rechazada aunque el contenido sea idéntico. *Propuesta:* la IA acepta cualquier impresión posterior a la última devolución, y las anteriores a ella se rechazan.
6. **Pago desde cuenta de otra moneda.** ¿Guardamos también la moneda y el monto que realmente sale de la cuenta (`moneda_cuenta`, `monto_cuenta`)? El bancario real puede diferir del convertido con el tipo de cambio de la OC. *Propuesta:* sí, las dos columnas.
7. **Modalidades.** Para limitar a las 3 modalidades hace falta una columna que las identifique, no depender de nombres. ¿Se copian también los días de crédito a la OC al aprobar, como las banderas? *Propuesta:* columna `modalidad` (CONTADO, CONTRAENTREGA, CREDITO) y copia de los días al aprobar.
8. **Valor de `pos_facturas.estado` en filas nuevas.** 7.3 dice "activa", lo que choca con que esté en desuso: las herramientas viejas las verían. *Propuesta:* decidirlo en la Fase 0 según el código que lea esa tabla.
9. **Reportes (Fase 6).** 9.1 son pantallas, no reportes. *Propuesta:* definir un 9.2 mínimo (OC por estado, CxP por vencimiento, recepciones pendientes, historial de versiones) o quitar la mención.
10. **IA caída.** Sin validación manual, la OC queda en EN_APROBACION y recepción y pagos esperan. ¿Se acepta como riesgo, con reintento? *Propuesta:* sí, documentado.

Hay dos menores con propuesta que puedo aplicar sin preguntarte: `cantidad_facturada` queda en 0 hasta que la factura esté APROBADA, y `recepcion` guarda además la versión en que se registró (`oc_version_id`, informativo).

Si me confirmas estos puntos, aplico todo y te devuelvo el documento corregido.
