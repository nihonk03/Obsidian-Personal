ALtura demuebel para vitrina abajo 50cm  sin moldura 46cm
caja con doble pared 61.5
mieubel vitrina con doble pared 170
comparten pared de 2cm
grosor de forro marron oscuro 2.4cm
mueble solo vitrina con doble pared de 2cm  152
interno de muble deonde va mesas de tabajo y pasadzo parte de abajo marron 265.5, sobresale 5cm la parte blanco a los lados
altura de caja factruacion 91
pared de mueble de mesa de traajo mas pasadizo 53cm de fondo sin groso de pared de fondo
pared de donde va vitrina 47.5 sin fondo de madera de fondo

276 lateral largoc  x 297.5 trasero x  267 entrada x 294 frente

tuberia de agua desague a 147 de pared ede entrada y alfondo
cometida electrica a 230 de pared de entrada  y alfondo 



hostinger respondio  
  
Hay una nueva actualización en tu ticket ¡Hola! Hemos verificado la dirección IP del VPS 198.211.97.243 y confirmamos que no está bloqueada por nuestro firewall. Por lo tanto, actualmente no existe ninguna restricción de firewall por nuestra parte que deba impedir que el VPS se conecte a [api.batidospitaya.com](http://api.batidospitaya.com/). Por favor, prueba la conexión de nuevo directamente desde la terminal de tu VPS ejecutando el siguiente comando: curl -v --resolve api.batidospitaya.com:443:145.223.105.42 [https://api.batidospitaya.com](https://api.batidospitaya.com/) -X POST --max-time 15 Si la conexión sigue fallando, por favor comparte el resultado completo que aparece en tu terminal después de ejecutar el comando. Esto nos ayudará a investigar más a fondo dónde está fallando la conexión. Si necesitas más ayuda, no dudes en contactarnos. ¡Siempre estamos aquí para ayudar! Saludos cordiales, Wahid Equipo de Éxito del Cliente  
  
  
el htaccess de erp quedo:  
  
# Página de error 404 personalizada para el ERP ErrorDocument 404 /404.php # Desactivar listado de directorios por seguridad Options -Indexes  
  
  
api,batidospitaya quedo sin archivo htaccess  
  
  
Probando desd el vps  
root@ubuntu-s-1vcpu-1gb-nyc1-01:~# curl -Iv https://api.batidospitaya.com/api/ping.php * Host api.batidospitaya.com:443 was resolved. * IPv6: 2a02:4780:b:1159:0:3207:d831:f * IPv4: 145.223.105.42 * Trying 145.223.105.42:443... * Connected to api.batidospitaya.com (145.223.105.42) port 443 * ALPN: curl offers h2,http/1.1 * TLSv1.3 (OUT), TLS handshake, Client hello (1): * CAfile: /etc/ssl/certs/ca-certificates.crt * CApath: /etc/ssl/certs * Recv failure: Connection reset by peer * OpenSSL SSL_connect: Connection reset by peer in connection to api.batidospitaya.com:443 * Closing connection curl: (35) Recv failure: Connection reset by peer root@ubuntu-s-1vcpu-1gb-nyc1-01:~#  
  
Ya tengo el access apuntando a api diretamente sin pasar por wl vps por ahora hasta arreaglar esto

