#!/bin/sh

PORT=8080
AUTHOR="Aleksandra Grzywacz"
CURRENT_TIME=$(date '+%Y-%m-%d %H:%M:%S')

# Wypisanie informacji w logach
echo " Uruchomienie aplikacji: [$CURRENT_TIME]"
echo "Autor programu: $AUTHOR"
echo "Serwer nasłuchuje na porcie TCP: $PORT"

# Uruchomienieserwera HTTP
exec httpd -f -p $PORT -h /www