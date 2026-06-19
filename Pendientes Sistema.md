1. *Depurar bases de datos para dar mayor rapidez a sistema de tiendas : Testeo en Leon DOmingo
2. [FInalizado]Cambio de recetas de 4oz a 2oz, incorporacion de yogurt y nueva presentacion de Mmebresia: Listo Pedidos, Balances e Inventario, Pendiente actualizar recetas reales el yogurt
3. Plataforma de pronostico de pedidos para despacho: Reunion Jueves 18 para testeo herramienta
4. [Finalizado]Cierres de caja de tiendas no jala el nombre de líder. Solo poner “LIDER DE TIENDA”: Se cambio a LIDER DE TIENDA ya no busca lider vigente
5. **ERP-RH hace movimientos de personal que no se reflejan en plataforma de deducciones/auditorias de OPE: se hiso pruebas semana pasada y corroboro movimiento inmediato de personal en funcion de registros hechos
6. *Plataforma para planificación de vacaciones (RH confirmara formato): Hoy reunion para testeo de herramienta.
7. [Finalizado]Panel de edición de cargos vigentes para registros de ERP – RH (Hay varios cargos no vigentes en listas): Se habilito a RRHH en el panel de cargos la columna para habilitar inhabilitar cargos
8. Plataforma de histórico de demanda para planificación de producción y compras: Reunion Jueves 18 para testeo herramienta 4:00pm
9. *Estandarizacion de reportes físicos y digitales en unidad de presentación de CDS y OPE : En Proceso revisando formato por formato
10. OC automática desde compras para contabilidad : Reunion Viernes para probar herrameinta
11. [Finalizado]Plataforma de mantenimiento. Cuando le da cerrado, que se agregue foto, quien hizo la tarea, día, y descripción opcinal : Se cambio el campo Descripcion a Opcional y se optimizo la pagina para vista celular y eliminando el control de kilometraje como obligatorio, se creo un reporte semanal de todos los informes
12. [Finalizado]Exportar Excel con faltantes sobrante de cierres, Herramienta web para revisar balance de cierres : Pagina web de historial de cierres y balance de cierre diario con opcion de descargar excel por rango de fecha
13. Bypass de entrevistas a solicitud de empleo
14. ENvio de correo saldia de perosnal e ingreso de personal
15. [Finalizado]Instalacion de aplicativo para TV futbol
16. [Revisar]Modal para registrar postulante directo a solicitud de empleo
17. [Revisar]Mover candidato de cargo y sucursal
18. En la página colaboradores.php agrega una nueva columna con el dato de fecha de vencimiento de certificado de salud
19. En la página colaboradores.php agrega una nueva columna mes contratado 
20. Crear ejecutable para abrir camaras y pagina de produccion
21. Mantenimiento Epson impresora Canon
22. Test impresion con microservicio en pd para TM 20III
23. mantenimiento de laptop de Marketing



https://erp.batidospitaya.com/modulos/productos/pronostico_abastecimiento.php El calculo de Pronóstico Inventario considera unciamente hasta ayer todos los movimientos , pero cuando tenemos un despacho hoy jsutamente no incluye los movimientos reales de hoy , haremos una excepcion controlada unicamente de los preingresos que existen hoy osea de la tabla de msaccess_masivo_PreIngresoPitaya con un toggle que se vera en el encabezado de esa columna llamada Despacho en Curso y cuando active el toggle se mostraran losd atos y a lo que ya estacalculado en Pronóstico Inventario lo aumentara para que el calculo Despahco ya sea con ese dato adicional  
  
Tener en cuenta que los pregingresos ya estan incluidos dentro de la formula de Pronóstico Inventario incluyendo compras, ajustes mermas, etc pero no vamos a considerar anda de eso de hoy sino unicamente si existe preingreso hoy eld ia que toca despacho solo ese vamos a considerar cunado se active el toogle osea la formula de Pronóstico Inventario no se toca para nada solo es coo un dato adicional con la opcion de incluir o no via toggle  
  
Entonces el caso que vamos a mitigar erroes es cuando por ejemplo hoy viernes toca despacho y el siguiente despacho es lunes, en esta ehrramienta no me sale hoy