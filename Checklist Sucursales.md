
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
- [ ] Ticuantepe
- [ ] Calli