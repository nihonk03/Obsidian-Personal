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



