
Actualizar horas de depsoitos tiendas
- [x] Leon
- [x] Matagalpa
- [x] Esteli
- [x] Altamira
- [x] Villa Fontana 
- [x] Granada
- [x] Las Colinas
- [x] Masaya
- [x] Natura
- [x] Las Brisas
- [x] Rivas
- [ ] Unica
- [ ] Ticuantepe
- [ ] Calli

Agregar columna hora a facturas, actualizar hora con script en comrpas , actualizar sistema (Falta Unica) ejecutar call SyncKardexComprasMasivo() call SyncDepositosMasivo, actualizar depositos via python

- [x] Leon
- [x] Matagalpa
- [x] Esteli
- [x] Altamira
- [x] Villa Fontana 
- [x] Granada
- [x] Las Colinas
- [x] Masaya
- [x] Natura
- [x] Las Brisas
- [x] Rivas
- [ ] Unica
- [x] Ticuantepe
- [x] Calli

UPDATE Compras
INNER JOIN CierreDiario
    ON DateValue(Compras.Fecha) = DateValue(CierreDiario.Fecha)
    AND Compras.CodOperario = CierreDiario.CodOperario
SET Compras.Hora = DateAdd("n", -5, CierreDiario.HoraFinal)
WHERE Compras.Hora IS NULL
  AND CierreDiario.HoraFinal IS NOT NULL
  AND CierreDiario.HoraInicial IS NOT NULL
  AND DateDiff("n", CierreDiario.HoraInicial, CierreDiario.HoraFinal) > 30;



Indexaciond etabla subpedido
- [x] Leon
- [x] Matagalpa
- [x] Esteli
- [x] Altamira
- [x] Villa Fontana 
- [x] Granada
- [ ] Las Colinas
- [ ] Masaya
- [ ] Natura
- [ ] Las Brisas
- [ ] Rivas
- [ ] Unica
- [x] Ticuantepe
- [x] Calli

nueva promocion
- [x] Leon
- [x] Matagalpa
- [x] Esteli
- [x] Altamira
- [x] Villa Fontana 
- [x] Granada
- [x] Las Colinas
- [x] Masaya
- [x] Natura
- [x] Las Brisas
- [ ] Rivas
- [ ] Unica
- [x] Ticuantepe
- [x] Calli

Excluir con notas acalratorias:
index_almacen
index_atencioncliente
index_auxiliaradministrativo
index_cds
index_compras
index_contabilidad
index_mantenimiento
index_marketing

herramientas acabo de eliminarlas:
compra_local_planificador_stock
compra_local_gestion_perfiles
planificacion_mantenimiento

eliminados, aun queda permiso en base datos
porcentajes_inventario

Excluir herramientas desarrollo
historial_solicitudes_cotizacion
reembolsos_ia_plantilla
gestion_tareas_reuniones
gestion_tareas_reuniones_detalle
historial_activos
registro_equipos
movimientos_equipos
calendario_mantenimiento
dashboard_equipos
solicitudes_mantenimiento
puntos_reglas
puntos_catalogo
promociones
calendario_horarios
registro_vacaciones
ia_graficos_ventas
gestion_proyectos