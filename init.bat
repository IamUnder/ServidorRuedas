#!/bin/bash

echo "\n******* Pone en marcha los contenedores..."
docker-compose up -d

echo "\n******* Copia el fichero de variables del entorno..."
docker exec -ti carshare-server sh -c "cp .env.example .env"

echo "\n******* Recupera las dependencias necesarias de Laravel..."
docker exec -ti carshare-server sh -c "php composer.phar require -n"

echo "\n******* Crea la clave de seguridad..."
docker exec -ti carshare-server sh -c "php artisan key:generate --force"

echo "\n******* Crea las bases de datos..."
docker exec -ti carshare-server sh -c "php artisan migrate"

echo "\n******* Crea las instancias necesarias para passport..."
docker exec -ti carshare-server sh -c "php artisan passport:install --force"

echo "\n******* Rellena las bases de datos..."
docker exec -ti carshare-server sh -c "php artisan db:seed"
echo ""
echo "      ╔════════════════════╗"
echo "      ║                    ║"
echo "      ║  APLICACIÓN LISTA  ║"
echo "      ║                    ║"
echo "      ╚════════════════════╝\n"
echo "Puede acceder a la aplicación desde su navegador en la ruta:  http://carshare.server.local:81"
echo "\nSi la aplicación no funciona compruebe su fichero hosts y agrege la linea:\n127.0.0.1   carshare.server.local"
echo "Para Windows: C:\Windows\System32\drivers\etc\hosts"
echo "Para Linux: /etc/hosts"
echo "Para Mac: /private/etc/hosts"
echo "\n"