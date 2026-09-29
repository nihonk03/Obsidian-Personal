erp.batidospitaya.com\docs\DESARROLLO_LOCAL.md  
  
aqui se documento la instalacion del procedimiento para instalar un servidor local con la base de datos y su uso para desarrollo local  
  
Agrega en la aprte de montaje del sql los siguientes cambios que se tuvieron que hacer par aque funcione ya que los archivos sql descargados de hostinger pesan hasta 400mb:  
  
- Edita C:\xampp\php\php.ini (Config de Apache → PHP (php.ini)) y cambia:  
upload_max_filesize = 512M post_max_size = 512M max_execution_time = 1800 max_input_time = 1800 memory_limit = 1024M  
  
- En C:\xampp\mysql\bin\my.ini, bajo [mysqld]:  
max_allowed_packet = 256M  
- En C:\xampp\phpMyAdmin\config.inc.php, al final:  
$cfg['ExecTimeLimit'] = 0;  
  
  
Bajo [mysqld], en C:\xampp\mysql\bin\my.ini:  
innodb_buffer_pool_size = 512M max_allowed_packet = 256M innodb_flush_log_at_trx_commit = 2  
  
  
Reiniciar apache y mysql  
  
  
La base de datos que se descarga de hostinger tiene un problem:  
La importación sí está subiendo el archivo, así que los cambios de php.ini funcionaron. El fallo es otro: el dump usa el collation utf8mb4_uca1400_ai_ci, que solo existe en MariaDB 11.3 o superior. Tu XAMPP 8.2.12 trae MariaDB 10.4.32, que no lo conoce. Es normal en exports recientes de Hostinger.  
La solución es reemplazar ese collation en el archivo por uno equivalente que sí existe en 10.4 (utf8mb4_unicode_ci, el mismo que usaste al crear erp_local).  
Abre PowerShell y pega el bloque completo. Lee y escribe línea por línea, así que no carga los 300 MB en memoria:  
$src = "C:\Users\migue\Downloads\u839374897_erp.sql" $dst = "C:\Users\migue\Downloads\u839374897_erp_local.sql" $enc = New-Object System.Text.UTF8Encoding($false) $reader = New-Object System.IO.StreamReader($src, $enc) $writer = New-Object System.IO.StreamWriter($dst, $false, $enc) $writer.NewLine = "`n" while (($line = $reader.ReadLine()) -ne $null) { if ($line.Contains('uca1400')) { $line = $line -replace 'utf8mb4_uca1400_\w+', 'utf8mb4_unicode_ci' ` -replace 'utf8mb3_uca1400_\w+', 'utf8mb3_unicode_ci' } $writer.WriteLine($line) } $reader.Close(); $writer.Close()  


$src = "C:\Users\migue\Downloads\u839374897_erp_local.sql"
$dst = "C:\Users\migue\Downloads\u839374897_erp_clean.sql"
$enc = New-Object System.Text.UTF8Encoding($false)
$reader = New-Object System.IO.StreamReader($src, $enc)
$writer = New-Object System.IO.StreamWriter($dst, $false, $enc)
$writer.NewLine = "`n"
while (($line = $reader.ReadLine()) -ne $null) {
  if ($line -match 'SQL_LOG_BIN|GTID_PURGED') { continue }
  if ($line.Contains('DEFINER')) {
    $line = $line -replace '/\*!\d+\s+DEFINER=`[^`]+`@`[^`]+`\s*\*/', '' `
                  -replace 'DEFINER=`[^`]+`@`[^`]+`\s*', ''
  }
  $writer.WriteLine($line)
}
$reader.Close(); $writer.Close()


$src = "C:\Users\migue\Downloads\u839374897_erp_clean.sql"
$dst = "C:\Users\migue\Downloads\vistas_fix.sql"
$enc = New-Object System.Text.UTF8Encoding($false)
$writer = New-Object System.IO.StreamWriter($dst, $false, $enc)
$writer.NewLine = "`n"
$i = 0
foreach ($l in [System.IO.File]::ReadLines($src)) {
  $i++
  if ($i -lt 3360100) { continue }
  $l = $l -replace '(?i)(\S)(union\s+all)(select)', '$1 $2 $3'
  $l = $l -replace '(?i)(\S)(union\s+all)\s', '$1 $2 '
  $l = $l -replace '(?i)\s(union\s+all)(select)', ' $1 $2'
  $writer.WriteLine($l)
}
$writer.Close()


Verifica que no quedó ninguna referencia:  
   Select-String -Path "ruta\archivo.sql" -Pattern "uca1400" -List
   Select-String -Path "ruta\archivo.sql" -Pattern "DEFINER=" -List
   Select-String -Path "ruta\archivo.sql" -Pattern "CREATE DATABASE|^USE " -List
No debe imprimir nada.  
  
  
Revisa si son validas estos ajustes que se tuvieron que hacer o si existe otro metodo para evitar problemas en la importacion del sql