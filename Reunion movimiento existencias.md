solitado picking validado de almacen (planificado) recibido (finalizado) estado linea de etapa con cambios Desbloquear oicking aprobar + impresion version impresiones lista de cambios imrpeso entineda orden defecto estado hora de salisa de central o tienda hora de picking visible quien y hora de despachos  
3 conteos  
auditoria top de productos con diferencia conteo 1 amarillos conteo 2 rojo alerta productos pasaran auditoria lista segund conteo solo las que se ingresara nuevamente tolerancia por grupo conteo auditor cpn daot o sin datos sin ajuste sobre diferncia de conteo ajuste




Viewed historial_despacho.js:622-645
Ran command: `& 'c:\Users\migue\Desktop\Sistema\Pitaya Web\VisualCode\erp.batidospitaya.com\.scripts\gitpush_erp.ps1'`
Ran command: `& 'c:\Users\migue\Desktop\Sistema\Pitaya Web\VisualCode\erp.batidospitaya.com\.scripts\gitpush_erp.ps1'`

Actualmente, la lógica que implementé para los textos separados por coma en el buscador global es un **"O" (OR)**. 

Es decir, al escribir `sandia, esteli`, el sistema busca en cada fila y dice: *"Si encuentro la palabra 'sandia' **O** la palabra 'esteli', muestro esta fila"*. Por eso en tu captura ves que te trajo las sandías de otras sucursales (Granada, Masaya) y a su vez todos los demás productos de Estelí.

Este comportamiento (OR) suele ser el estándar cuando se busca una lista de cosas específicas (ej. "quiero ver todo lo de masaya, granada, y leon").

**¿Te gustaría que lo cambie a un "Y" (AND)?** 
Si lo cambiamos a **AND**, al escribir `sandia, esteli`, el sistema te exigiría que **ambas** palabras estén en la misma fila (por lo que **solo** te mostraría la Sandia de Estelí). 

¡Tú dime cuál de los dos comportamientos prefieres para este módulo!