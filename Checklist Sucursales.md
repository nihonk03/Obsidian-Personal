
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



Searched for "tienePermiso\s*\(\s*['"]avisos_internos['"]"

La función `tienePermiso('avisos_internos', ...` se manda a llamar en los siguientes archivos dentro de tu proyecto, específicamente en la ruta `modulos/supervision/auditorias_original/`:

1. **[index_avisos_publico.php](file:///c:/Users/migue/Desktop/Sistema/Pitaya%20Web/VisualCode/erp.batidospitaya.com/modulos/supervision/auditorias_original/index_avisos_publico.php#L13)** (Línea 13)
   ```php
   if (!tienePermiso('avisos_internos', 'vista', $cargoOperario)) {
   ```

2. **[index_avisos.php](file:///c:/Users/migue/Desktop/Sistema/Pitaya%20Web/VisualCode/erp.batidospitaya.com/modulos/supervision/auditorias_original/index_avisos.php#L21)** (Línea 21 y 129)
   ```php
   // Línea 21
   if (!tienePermiso('avisos_internos', 'vista_admin', $cargoOperario) && !$esAdmin) {
   // ...
   // Línea 129
   $canEdit = tienePermiso('avisos_internos', 'editar', $cargoOperario) || $esAdmin;
   ```

3. **[editarAviso.php](file:///c:/Users/migue/Desktop/Sistema/Pitaya%20Web/VisualCode/erp.batidospitaya.com/modulos/supervision/auditorias_original/editarAviso.php#L20)** (Línea 20)
   ```php
   if (!tienePermiso('avisos_internos', 'editar', $cargoOperario) && !$esAdmin) {
   ```

4. **[agregarAviso.php](file:///c:/Users/migue/Desktop/Sistema/Pitaya%20Web/VisualCode/erp.batidospitaya.com/modulos/supervision/auditorias_original/agregarAviso.php#L19)** (Línea 19)
   ```php
   if (!tienePermiso('avisos_internos', 'crear', $cargoOperario) && !$esAdmin) {
   ```