erp.batidospitaya.com/modulos/despacho/historial_despachos.php  
  
Haremos los siguientes ajustes:  
- CUando esta en SOlciitado no debe de hacer la comparacion para calcular los cambios qu se indican en la columna de observaciones y sale por error por ejemplo Preparado: 56 cambios cuando aun esta solicitado qu es una etapa antes  
- Cambiar Fecha Programada por Fecha planeada  
- El encabezado Observaciones cambialo a Observaciones por cambios realizados , asi quitamos el temrino cambios despues de las cantidades  
- Cambiar Nuevo Despacho a Nuevo Despacho Especial
  
erp.batidospitaya.com/modulos/despacho/detalle_despacho.php  
  
Haremos los siguientes cambios visuales:  
  
-Cambiar el texto del boton Imprimir y validar solicitud a Imprimir e Iniciar Validacion y ese boton lo moveremos arriba a la derecha del input de buscador global que esta arriba de la tabla , el modal que sale cuado se le da a aese boton dice Validar Solicitud, lo cambiaremos a Iniciar Validacion y el texto abajo Se imprimira el ticket para iniciar la validacion  
- En todos los imprimibles no se mostrara la version de cdocumento sino la hora de impresion solamente  
- EN la etapa de En Valdiacion cuando se cambia la cantidad de la columna Cant. Preparada a un numero mayor se regresa a la cantidad orgiinal autmaticament eporque no esta permitido, antes de que se cambie a la cantidad original que salga un mensaje que se ingreso una cantidad superior a los ocliitado y ese tipo de cambio no esta permitido (algo asi), solo como comunicatvo con un boton ok y recien se aplica la reversion al nuemro original  
- En los cotculos de estado colocaremos la informacion que ahora sale en

Solicitado por: Miguel Gotea 15-Jul-26 08:24AM

Validado por: Miguel Gotea 15-Jul-26 08:39AM

Preparado por: N/A

Recibido por: N/A  
  
Cuando haya datos en una linea nombre y en otra la fecha y en otra la hora y si no hay datos que no salga N/A solamente en blanco asi eliminamos ese segmentoto de la parte de arriba  
- Estado: EN_VALIDACION que diga EN VALIDACION  
- Agregaremos una columna mas a la tabla con los grupos y su nombre de grupo al inicio osea antes del nombre cn su respectivo filtro de encabezado  
- EL boton Imprimir y pasar a preparado lo moveremos arriba a la derecha de la caja input de busqeda global , y le cambiaremos el nombre a Imprimir Despacho y pasar a Preparado  
- EN el imprimible del pre despacho en lugar de Enviado que diga Preparado  
- El texto del modal que dice ¿Confirmar reducción? cambiar a ¿Confirmar Cambio?  
- EN los globos de estado cambiar el termino a Pre-Despacho SOlicitao, Pre-Despacho En Validacion, Despacho Preparado y Despacho Recibido  
- El mensaje del modal ¿Confirmar discrepancia? cambiar a ¿Confirmar Cambio?