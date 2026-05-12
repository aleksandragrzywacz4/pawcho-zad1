#ETAP 1: Builder 
FROM busybox:musl AS builder

WORKDIR /build

# Kopiowanie plikow i nadajemy uprawnienia do wykonania skryptowi startowemu
COPY index.html start.sh ./
RUN chmod +x start.sh

# ETAP 2: Obraz docelowy 
# Lżejsza wersja BusyBoxa
FROM busybox:musl

LABEL org.opencontainers.image.authors="Aleksandra Grzywacz"
LABEL org.opencontainers.image.title="Pogoda"

WORKDIR /www

# Kopiujemy pliki z pierwszego etapu
COPY --from=builder /build/index.html .
COPY --from=builder /build/start.sh .

#Healthcheck z użyciem narzędzia wget
HEALTHCHECK --interval=30s --timeout=5s --start-period=3s --retries=3 \
  CMD wget -qO- http://localhost:8080/ || exit 1

EXPOSE 8080/tcp

#uruchomienie skryptu ktory wypisuje logi i uruchamia serwer
CMD ["./start.sh"]

#docker build -t zad1 .
#docker images zad1
#docker run -d --name pogoda -p 8080:8080 zad1
#docker logs pogoda