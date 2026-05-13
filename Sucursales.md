
Worker dvr 
- [ ] Leon
- [ ] Matagalpa
- [ ] Esteli
- [ ] Altamira
- [x] Villa Fontana 
- [ ] Granada
- [ ] Las Colinas
- [ ] Masaya
- [ ] Natura
- [ ] Las Brisas
- [ ] Rivas
- [ ] Unica
- [ ] Ticuantepe
- [ ] Calli

c5b155ba8f6877a2eefca0183ab18e37fe9a6accde340cf5c88af724822cbf50

TOKEN=$(grep c5b155ba8f6877a2eefca0183ab18e37fe9a6accde340cf5c88af724822cbf50 /opt/hikvision-ia/.env | cut -d'=' -f2)

echo "Token: $TOKEN"

curl -X POST http://127.0.0.1:8765/snapshot \

-H "X-WSP-Token: $TOKEN" \

-H "Content-Type: application/json" \

-d '{"usuario":"admin","clave":"Nihonk03","puerto_rtsp":9579,"canal":101}' \

-o /tmp/snap_test2.jpg && file /tmp/snap_test2.jpg