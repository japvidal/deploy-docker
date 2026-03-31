# Deploy Docker

Despliegue base de `tikitakas` con Docker Compose.

## Servicios incluidos

- `mysql`
- `eureka`
- `competitions`
- `zuul`
- `frontend`

## Preparacion

1. Copia `.env.example` a `.env`
2. Ajusta las imagenes a los tags publicados por Jenkins

```bash
cp .env.example .env
```

## Arranque

```bash
docker compose pull
docker compose up -d
```

## Actualizacion

```bash
./update.sh
```

El script hace:

- `docker compose pull`
- `docker compose up -d`
- `docker compose ps`

## URLs utiles

- Frontend: `http://localhost:4200`
- Zuul: `http://localhost:8090`
- Eureka: `http://localhost:8761`
- MySQL: `localhost:3306`

## Notas

- El frontend llama al gateway en `http://localhost:8090`
- `competitions` usa MySQL y Eureka por nombre de servicio dentro de la red Docker
- Si cambias los nombres o tags de imagen en Jenkins, actualiza tambien `.env`
