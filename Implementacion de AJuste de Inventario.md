erp.batidospitaya.com/modulos/inventario/conteo_ciclico.php Vamos a implementar la creacion automatica de registros en erp.batidospitaya.com/modulos/supervision/auditorias_original/auditinternas/auditoria_inventario.php con la siguiente trasncripcion de datos en la auditoria Fecha = fecha + hora del conteo ciclico el ultimo conteo si llego hasta el conteo 3 o 2 o 1 Sucursal= tienda del conteo ciclico Tabla de produtos : - productos : envia el id del producto id_producto_presentacion - Inv.SIstema : Stock Teórico - Inv. Fisico : En Unidades + En Paquetes * conversion  
- Diferencia : Diferencia  
- COsto Unitario : ya la heramienta de auditoria lo busca segun el id de producto  
  
El resto de campos quedaria en epsera para ser llenados manualmente  
  
La migracion se haria atraves del boton Aprobar AJustes de conteo_ciclico.php y hasta que no se le da al boton Guardar auditoria no se registra en la abse de datos todos los datos de esa herramienta  
  
Que opciones tenemos para identificar y relacionar los conteo ciclicos con la auditoria creada, esto es apra que en la herramienta conteo_ciclico.php coloquemos un boton de ver aduoria cuando ya se le haya dado al boton de aprobar ajustes y se haya dado al boton de guardar audotira, entonces en ese boton de ver auditoria me redirige a https://erp.batidospitaya.com/modulos/supervision/auditorias_original/auditinternas/ver_auditorias_inventario.php?id=70 con el id relacionado, entonces ese di se tiene qeu gaurdar en algun lago  
  
La herramienta de auditoria podra seguir funcionando manualmente no necesariwmnte amarrado aque solo nazca desde conteo ciclico
Arma el plan