erp.batidospitaya.com\modulos\operaciones\tardanzas_manual.php  
  
vamos a implementar la estructura de permisos como en erp.batidospitaya.com\modulos\marketing\cupones.php con la funcion tienePermiso  
  
revisa ben la estructura de las tablas donde se registra los permisos  
  

CREATE TABLE `tools_erp` (

`id` int(11) NOT NULL AUTO_INCREMENT,

`nombre` varchar(255) NOT NULL,

`titulo` varchar(100) NOT NULL,

`tipo_componente` enum('herramienta','indicador','balance','alerta') NOT NULL DEFAULT 'herramienta' COMMENT 'Tipo de componente del sistema',

`class_name` varchar(100) DEFAULT NULL,

`config_json` text DEFAULT NULL,

`grupo` varchar(255) NOT NULL,

`descripcion` varchar(255) DEFAULT NULL,

`url_real` varchar(255) DEFAULT NULL,

`url_alias` varchar(255) DEFAULT NULL,

`icono` varchar(255) DEFAULT NULL,

`orden` int(11) DEFAULT 0,

`created_at` timestamp NULL DEFAULT current_timestamp(),

`updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),

`activo` tinyint(4) NOT NULL DEFAULT 1,

PRIMARY KEY (`id`),

KEY `idx_tipo_componente` (`tipo_componente`,`activo`)

) ENGINE=InnoDB AUTO_INCREMENT=123 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;  
  
  

CREATE TABLE `permisos_tools_erp` (

`id` int(11) NOT NULL AUTO_INCREMENT,

`accion_tool_erp_id` int(11) NOT NULL,

`CodNivelesCargos` int(11) NOT NULL,

`permiso` enum('allow','deny') NOT NULL DEFAULT 'allow',

`created_at` timestamp NULL DEFAULT current_timestamp(),

`updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),

PRIMARY KEY (`id`),

KEY `fk_accion_tool_erp` (`accion_tool_erp_id`),

CONSTRAINT `fk_accion_tool_erp` FOREIGN KEY (`accion_tool_erp_id`) REFERENCES `acciones_tools_erp` (`id`) ON DELETE CASCADE

) ENGINE=InnoDB AUTO_INCREMENT=11580 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;  
  
  

CREATE TABLE `acciones_tools_erp` (

`id` int(11) NOT NULL AUTO_INCREMENT,

`tool_erp_id` int(11) NOT NULL,

`nombre_accion` varchar(50) NOT NULL,

`descripcion` varchar(255) DEFAULT NULL,

`created_at` timestamp NULL DEFAULT current_timestamp(),

`updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),

PRIMARY KEY (`id`),

KEY `fk_acciones_tools_erp` (`tool_erp_id`),

CONSTRAINT `fk_acciones_tools_erp` FOREIGN KEY (`tool_erp_id`) REFERENCES `tools_erp` (`id`) ON DELETE CASCADE

) ENGINE=InnoDB AUTO_INCREMENT=280 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;