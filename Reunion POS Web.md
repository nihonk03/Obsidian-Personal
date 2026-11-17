Procedimiento para Nuevo club pitaya
1. Modal: membresia + telefono 
2. ENvio de mensaje wsp a cliente con link con preformulario 
3. Formulario preregistro de cliente y atencion al cliente
	1. Foto de cedula/residencia/pasaporte para extraer fechas /numero 
	2. Llenado manual de correo 


procedimiento de cambio de Ingredientes de receta
1. validacion por precio las opciones menor o igual precio + cambio 1 x 1 unidades   

Promociones:
- Lista de promociones muestra check para aplicables y visualemnte no sobresaliente

Combos
- Personalizacion de combo facturado mostrar elecciones de combo par apoder cambiar
- ERP: Mostrar lista de cmbos inactivos  
- ERP: activo/inactivo cambiar por fecha desde y hasta

Menu
- Titulo de menu con color por itpo de cliente 
- Mostrar menu  por nombre real del menu y color de fondo tipo cliente
- Agregar dato de orden de grupo en menu numerico

Modulo de personalizacion de producto
- Elimianr subtitulo de nombre de producto repetitivo
- "sin cambio" a cmabiar a cambio
- una vez eelgido un producto de cambio mostrar  icono de flechas y reslatado nombre del cambio 
- estandarizar nombre de ingrdientes con contenido
- mantener eliminacion de ingredientes
- Extras ordenado por alfabetico y no por precio
- cambiar saborizantes por nuevo nombre de grupo 
- Revisar nuevos precios de extras a plantear

POanel de cliente:
- cambiar nombre de cliente casual a cliente general
- Historial de compras de cllientes: 3 ultimas facturas 
- Check de preregistro lleno con cedula
- Mover boton de nueva membresia a este panel

Global
- CAMBIAR termino FACTURA A TICKET 
- comas en para numero miles y punto para decimales


Panel de productos facturados
- Membresia sin opcion de cambio de cantidad ni notas
- Nuevo campo de numero de memebresia
- No se mostrara validacion de prergistro lleno durante la facturacion
 

Propuestas a elaborar:
- Item de cupon de regalo para venta
- Item de puntos de membresia para venta

Panel de Pago:
- Boton de activar propina arriba de botones de metodo de pago 
- Cambiar nro de codigo de ticket pos banco o codigo de trasnferencia a obligatorio




C:\Users\migue\Desktop\Sistema\Pitaya Web\VisualCode\pos.batidospitaya.com  
  
haremos los siguientes cambios

- Moveremos el boton de nueva membresia al panel de Tipo de Cliente en el encabezado
- Cuando le demos agregar se abira un modal donde registraremos 2 datos de la tabla clientesclub que seran membresia (previa validacion si no esta registrado ya) y celular, adjunto tabla

CREATE TABLE `clientesclub` (  
`id_clienteclub` int(11) NOT NULL AUTO_INCREMENT,  
`sucursal` int(11) NOT NULL,  
`membresia` int(11) NOT NULL,  
`nombre` varchar(100) DEFAULT NULL,  
`apellido` varchar(100) DEFAULT NULL,  
`cedula` varchar(20) DEFAULT NULL,  
`celular` varchar(100) DEFAULT NULL,  
`fecha_nacimiento` date DEFAULT NULL,  
`correo` varchar(100) DEFAULT NULL,  
`fecha_registro` date DEFAULT NULL,  
`puntos_iniciales` int(11) DEFAULT NULL,  
`nombre_sucursal` varchar(100) DEFAULT NULL,  
PRIMARY KEY (`id_clienteclub`),  
KEY `idx_club` (`membresia`),  
KEY `idx_club_membresia` (`membresia`),  
KEY `idx_club_sucursal` (`sucursal`),  
KEY `idx_club_registro` (`fecha_registro`)  
) ENGINE=InnoDB AUTO_INCREMENT=13508211 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;  
  
EL procediiento posterior a que se llene ese modal con esos datos son

1. Se registre el item de membresia, vamos a agregar un campo nuevo a la tabla de pos ventas lineas para agregar un campo de membresia o reutilizar el campo de notas y que solo cuando sea este producto notas aparezca a la derecha del nombre del producto que es membresia y en notas pondremos el codigo de la membresia y no aparecera abajo como las notas de tros productos sino en la misma linea del producto, o un campo nuevo en la tabla llamado membresia_venta
2. La membresia automaticamente se pondra en el campo N° MEMBRESÍA del panel Tipo de CLiente
3. Se enviara un wsp al cliente con un url de un preregistro de membresia , para esto aplicaremos el metodo ya implementado de wsp clientes que se registra en erp.batidospitaya.com/modulos/marketing/campanas_wsp.php y ejecuta constantemente a traves de C:\Users\migue\Desktop\Sistema\Pitaya Web\VisualCode\PitayaBot\wsp-clientes via api C:\Users\migue\Desktop\Sistema\Pitaya Web\VisualCode\api.batidospitaya.com\api\MS_Access\clientes_club\notificacion_puntos.php , usaremos el mismo bot y el mismo procedimiento con otro archivo que sera notificacion nuevo club

- La membresía facturada no permitirá cambio de cantidad ni notas.
- Cambiar el texto inline de ejemplo que dice Escribe nombre del cliente casula a .... cliente general
- El formulario de preregistro vivira en club.batidospitaya.com que esta en el repo