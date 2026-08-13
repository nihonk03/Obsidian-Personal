Tardanzas
- Columna Clasificacion  Justiifacdo  Insjutificado  (No Reportada , No Válido, Pendiente de Aprobació) penultima columna
- Columna Estauts No reportado a cerrado autoamtico , No Válido a cerrado revisado , Pendiente de Aprobación  a En Revision , aprobado a cerrado revisado  ultima columna 

botones visibles columnas acciones mostrar todas con leyenda en encabezado
filtro de acciones pendites de solicitud
Elimianr farbar de boton nuevo
verificar 1min tardanza
Exportado con columna de tiempo de tardanza en min
botn enviar justifiacion de lider 

Faltas/AUsencias
elimianr termino de falta regitro queda solo ausencia
actualizar mdoal de editar falta manual
Tipo de Falta: dividido en Clasificacion y subclasificacion
- columna  CLasificacion  Injustificado  + (Clasificacion + subclasificacion)
- columna estado | En Revision Lider  |   En REvision Operaciones | En revision GTH | Cerrado  ( Clasificacion y subclasificacion)
dIVISION Lider   quien hiso 
Division de caso operativos primer segmento solo dias especificos CON OPCION DE VALIDAR GTH quien hiso
division de casos gth quien hiso 
Envio de varias fotos por etapa
Titulod e formulario de lider a Registrar Evidencias 
foto no obligaria en ninguna etapa
editable hasta en revision oepraciones por lider
enrevision rrhh  a gth
**retroalimentar horario planificado  con tipos de falta 
verificar interferencia de registros desde lider y extension de gth de tipo de falta 

  
Registro de Vacaciones/Subsidios  queda vacaciones Programadas 
COlumna Clasificficacion Programada / Por Uausencia
Columa estado : En revision  / AProbado / Rechazado


*Descargable de vacaciones  pendientes * herraeminta nueva  formato excel actual , maestro de colaboradores columna vaciaone spendientes 

Nueva herramietna 
Plan Anual Feriados modo vista de plan de fierado

[Editar Colaborador](boton no aplica para bloquear input

# Contactos de Colaboradores inhabilitar

# Cumpleaños de Colaboradores solo isabell


erp.batidospitaya.com/modulos/rh/ver_marcaciones_todas_nuevo.php  
  
Vamos a reclasificar los casos de faltas en las columnas ya creadas de clasificacion y estado de la siguente manera  
  
Lo que detecta como Flata detectada por sistema en clasificacion es Insjutificado y estado En Revision Lider  
Lo que sale  
Lo que sale Justificacion enviada por lider en clasificacion es Ibjustificado y estado En REvision Operaciones  
Lo que sale AProbado en clasifaicion pondremos el tipo que se agrego y en Estado Cerrado  
  
Adicionalmente agregaremos nuevos campos a la tabla faltas_manual  
  
CREATE TABLE `faltas_manual` ( `id` int(11) NOT NULL AUTO_INCREMENT, `cod_operario` int(11) NOT NULL, `fecha_falta` date NOT NULL, `cod_sucursal` varchar(10) NOT NULL, `tipo_falta` enum('Pendiente','No_Pagado','Vacaciones','Subsidio_3dias','Subsidio_INSS','Subsidio_maternidad','Reposo_hasta_3dias','Compensacion_feria','Compensacion_dia_trabajado','Cuido_materno','Dia_mas_septimo','Omision_marcacion','Atencion_medica','Cita_medica_programada','Ajuste_horario') NOT NULL, `aprobado` tinyint(1) NOT NULL DEFAULT 1 COMMENT '1=aprobado/directo, 0=vacacion pendiente de aprobacion RRHH', `porcentaje_pago` decimal(5,2) DEFAULT NULL, `cantidad_dias` decimal(3,2) NOT NULL DEFAULT 1.00, `observaciones` varchar(500) DEFAULT NULL, `observaciones_rrhh` text DEFAULT NULL, `foto_path` varchar(255) DEFAULT NULL, `registrado_por` int(11) NOT NULL COMMENT 'CodOperario del usuario que registra', `fecha_registro` datetime NOT NULL DEFAULT current_timestamp(), `actualizado_por` int(11) DEFAULT NULL COMMENT 'CodOperario del usuario que actualizó', `fecha_actualizacion` datetime DEFAULT NULL ON UPDATE current_timestamp() COMMENT 'Restar 6 horas', `cod_contrato` int(11) DEFAULT NULL, PRIMARY KEY (`id`), KEY `fk_faltas_manual_operario` (`cod_operario`), KEY `fk_faltas_manual_sucursal` (`cod_sucursal`), KEY `fk_faltas_manual_operario_registrador` (`registrado_por`), KEY `fk_faltas_manual_operario_actualizador` (`actualizado_por`), CONSTRAINT `fk_faltas_manual_operario` FOREIGN KEY (`cod_operario`) REFERENCES `Operarios` (`CodOperario`), CONSTRAINT `fk_faltas_manual_operario_actualizador` FOREIGN KEY (`actualizado_por`) REFERENCES `Operarios` (`CodOperario`), CONSTRAINT `fk_faltas_manual_operario_registrador` FOREIGN KEY (`registrado_por`) REFERENCES `Operarios` (`CodOperario`), CONSTRAINT `fk_faltas_manual_sucursal` FOREIGN KEY (`cod_sucursal`) REFERENCES `sucursales` (`codigo`) ) ENGINE=InnoDB AUTO_INCREMENT=2175 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;|  
  
La logica actual es que lider envia justificacion que es solo el dato observaciones, foto_path reigstrado_por y fecha_registro ; luego RRHH aprobea llenando los datos de tipo_falta, aprobado, porcentaje_pago, observaciones_rrhh, actualizado_por y fecha_actualizacion  
  
Vamos a incorporar un procedimiento intermedio de operaciones osea un filtro antes del final para quienes tengan un nuevo permiso llamado aprobacion_operaciones donde llenara nuevos campos que son :  
  
observaciones_operaciones, actualizado_operaciones, fecha__actualizacion_operaciones y foto_path_operaciones  
  
Este nuevo segmento se llenara con esa informacion de observaciones, poder subir una foto y cuando se haga se registra quien lo hiso y cuando y selecciona el tipo de falta de la tabla tipos_falta , en esta tabla hay un tipo que es de id 17 que se llama validar_rh , la idea es que cuando operaciones selecciona ese tipo entonces recien se activa para la aprobacion de rh donde llena el resto de datos que antes llenaba normalmente

Para el caso de las faltas aplicaremos a la ultima actualizaicon que se hiso para el caso de las tardanzas donde ya se quirto la linea de progeso en la solumna y solo pondremos un boton de ver (ojo) y se abre el modal de linea de progreso con estas 5 etapas, deteccion de falta, solictu de lider, validacion de operaciones y validacion de rh con toda su informaicon respectiva en cada etapa 

TOma de referencia los permisos y acicones como se trabja actualmente las faltas en erp.batidospitaya.com/modulos/lideres/faltas_manual.php, en esta herramienta se revisa en modal dese la columna acciones donde se muestra  la jsutifacion enviada por el lider y se selecciona el tipo de falta , ahi ya esta aplicado los permisos respectivos 