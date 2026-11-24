David

1. Activar/desactivar la visibilidad de tiendas en ventas meta.
2. Agregar la columna con el nombre de la promoción aplicada a la DB de ventas que alimenta Locker.
3. Dejar de anclar la gráfica de proyección de despacho a la semana 553, porque las proyecciones de stock mínimo de ese momento no son realistas.

4. Habilitar el nombre de la tienda, y no solo el código, en la consulta de compras de caja.
5. Agregar la cuenta y la subcuenta a la DB de despachos costeados.
6. no mapea producto despacho de presentacion_producto para costo en el caso de la naranja entera 
7. Claudia, puedes investigar con miguel porque hay 2 OC con la misma numeracion 6837

Edvi
1. Modificacion de factura a como esta en contabilidad

Miguel
1. Migracion de orden de compra  y facturas a erp
2. Convertir a eretail ferreterias
3. Estandarizacion de herramientas

 
Facturacion de bolonia hecho mal 
asignacion lideres y anc sincronizados en edicion

Revisar pedido 180 en revision de conteo ciclico eliminar pendientes

MOdifcar proceso de ferias y apeturas
Despacho hacia centor de costos y no locales


MIguel
- Comandas de tripleberry y limonada con calala al seleccionar normal de azúcar indica agregar 4 1/2 onz de azúcar
- Listado de acceso a operaciones a katehrine



- incluir vasos en conteo ciclico





migracion Orden de comrpa y compra



Nuevo número para Whatsapp Api: 76453067


pos.batidospitaya.com/modulos/pos/facturas_nueva.php  
  
Vamos a restructurar los menus a un nuevo nivel con las siguientes consideraciones

1. EL catalogo se guarda en catalogo_menu_pos donde cada item se enlaza a un sbgrupo y grupo mayor



Reunion katherine
- mermas
- mantenimiento
- modifcacion de estrcutura de tabla para registro de productos joshua



batidospitaya.com: ##### Ya somos mas de 5mil miembros!! por contador dinamico real
- desde panel de edicion pitaya.com


Claude
procedimiento de aprtura y cirerre de turno
instalar servicio propio de convertir voz a texto 


Edvi epndientes
- Prueba foto de voucher depositos 
- Modificar descargable de marcaciones_nuevo (Descargar Marcaciones Excel) con columnas de version anterior
- Cmabio de turno de Leon manual
- Pruebas de cambio de peurtos para los 2 DVR Altamira
- Lista de archivos que aun usan Operaioes.operativo




Listo ahora si:  
  

- Solo salio un warning

warning: unused dependency `rand`

[](https://github.com/MiguelGotea/ai_keyvault/actions/runs/45500588321/job/138822600906#step:6:381)--> server/Cargo.toml:30:1

[](https://github.com/MiguelGotea/ai_keyvault/actions/runs/45500588321/job/138822600906#step:6:382)|

[](https://github.com/MiguelGotea/ai_keyvault/actions/runs/45500588321/job/138822600906#step:6:383)30 | rand = "0.8"

[](https://github.com/MiguelGotea/ai_keyvault/actions/runs/45500588321/job/138822600906#step:6:384)| ^^^^^^^^^^^^

[](https://github.com/MiguelGotea/ai_keyvault/actions/runs/45500588321/job/138822600906#step:6:385)|

[](https://github.com/MiguelGotea/ai_keyvault/actions/runs/45500588321/job/138822600906#step:6:386)= note: `cargo::unused_dependencies` is set to `warn` by default

[](https://github.com/MiguelGotea/ai_keyvault/actions/runs/45500588321/job/138822600906#step:6:387)help: consider removing the dependency on `rand`

[](https://github.com/MiguelGotea/ai_keyvault/actions/runs/45500588321/job/138822600906#step:6:388)warning: `ai-keyvault-server` (manifest) generated 1 warning

[](https://github.com/MiguelGotea/ai_keyvault/actions/runs/45500588321/job/138822600906#step:6:389)Finished `dev` profile [unoptimized + debuginfo] target(s) in 55.51s

- En cargo eudit del deploy salio esto:
  Crate: libsqlite3-sys

[](https://github.com/MiguelGotea/ai_keyvault/actions/runs/45500588321/job/138822600906#step:9:15)error: 2 vulnerabilities found!

[](https://github.com/MiguelGotea/ai_keyvault/actions/runs/45500588321/job/138822600906#step:9:16)Version: 0.30.1

[](https://github.com/MiguelGotea/ai_keyvault/actions/runs/45500588321/job/138822600906#step:9:17)warning: 1 allowed warning found

[](https://github.com/MiguelGotea/ai_keyvault/actions/runs/45500588321/job/138822600906#step:9:18)Title: `libsqlite3-sys` via C SQLite CVE-2026-119375

[](https://github.com/MiguelGotea/ai_keyvault/actions/runs/45500588321/job/138822600906#step:9:19)Date: 2026-10-30

[](https://github.com/MiguelGotea/ai_keyvault/actions/runs/45500588321/job/138822600906#step:9:20)ID: RUSTSEC-2026-0459

[](https://github.com/MiguelGotea/ai_keyvault/actions/runs/45500588321/job/138822600906#step:9:21)URL: [https://rustsec.org/advisories/RUSTSEC-2026-0459](https://rustsec.org/advisories/RUSTSEC-2026-0459)

[](https://github.com/MiguelGotea/ai_keyvault/actions/runs/45500588321/job/138822600906#step:9:22)Severity: 6.8 (medium)

[](https://github.com/MiguelGotea/ai_keyvault/actions/runs/45500588321/job/138822600906#step:9:23)Solution: Upgrade to >=0.39.0 (patched)

[](https://github.com/MiguelGotea/ai_keyvault/actions/runs/45500588321/job/138822600906#step:9:24)Crate: rsa

[](https://github.com/MiguelGotea/ai_keyvault/actions/runs/45500588321/job/138822600906#step:9:25)Version: 0.9.10

[](https://github.com/MiguelGotea/ai_keyvault/actions/runs/45500588321/job/138822600906#step:9:26)Title: Marvin Attack: potential key recovery through timing sidechannels

[](https://github.com/MiguelGotea/ai_keyvault/actions/runs/45500588321/job/138822600906#step:9:27)Date: 2023-11-22

[](https://github.com/MiguelGotea/ai_keyvault/actions/runs/45500588321/job/138822600906#step:9:28)ID: RUSTSEC-2023-0071

[](https://github.com/MiguelGotea/ai_keyvault/actions/runs/45500588321/job/138822600906#step:9:29)URL: [https://rustsec.org/advisories/RUSTSEC-2023-0071](https://rustsec.org/advisories/RUSTSEC-2023-0071)

[](https://github.com/MiguelGotea/ai_keyvault/actions/runs/45500588321/job/138822600906#step:9:30)Severity: 5.9 (medium)

[](https://github.com/MiguelGotea/ai_keyvault/actions/runs/45500588321/job/138822600906#step:9:31)Solution: Upgrade to >=0.10.0 (patched)

[](https://github.com/MiguelGotea/ai_keyvault/actions/runs/45500588321/job/138822600906#step:9:32)Crate: chrono

[](https://github.com/MiguelGotea/ai_keyvault/actions/runs/45500588321/job/138822600906#step:9:33)Version: 0.4.45

[](https://github.com/MiguelGotea/ai_keyvault/actions/runs/45500588321/job/138822600906#step:9:34)Warning: unmaintained

[](https://github.com/MiguelGotea/ai_keyvault/actions/runs/45500588321/job/138822600906#step:9:35)Title: chrono is unmaintained

[](https://github.com/MiguelGotea/ai_keyvault/actions/runs/45500588321/job/138822600906#step:9:36)Date: 2026-09-14

[](https://github.com/MiguelGotea/ai_keyvault/actions/runs/45500588321/job/138822600906#step:9:37)ID: RUSTSEC-2026-0543

[](https://github.com/MiguelGotea/ai_keyvault/actions/runs/45500588321/job/138822600906#step:9:38)URL: [https://rustsec.org/advisories/RUSTSEC-2026-0543](https://rustsec.org/advisories/RUSTSEC-2026-0543)

[](https://github.com/MiguelGotea/ai_keyvault/actions/runs/45500588321/job/138822600906#step:9:39)Solution: No fixed upgrade is available!

[](https://github.com/MiguelGotea/ai_keyvault/actions/runs/45500588321/job/138822600906#step:9:40)Error: Process completed with exit code 1.
- Todo lo demas del deploy en verde
- Varififca si ya tenemos todo completo la fase 3 y documentemos todos los cambios que se hacen en el vps directaemnte y de arhcivos que no estan dentro del repo que se deploya asi como las configuraciones
- SI ya tenemos completa la fase 3 procedamos con la fase 4

























