# deploy-docker

`deploy-docker` contains the Docker Compose deployment stack for the Tikitakas `v0.1.0` platform. It is the operational entry point used to run the complete environment with MySQL, Eureka, the gateway, the domain microservices, and the Angular frontend.

The repository is designed to work with container images produced by the Jenkins pipelines of the backend and frontend repositories. Instead of building source code locally, this project focuses on orchestration: selecting the correct image tags, wiring services together on the Docker network, mounting the frontend image assets from a host volume, and exposing the main public ports of the stack.

Typical setup:

```bash
cp .env.example .env
docker compose pull
docker compose up -d
```

Main public endpoints:

- Frontend: `http://localhost:4200`
- Gateway: `http://localhost:8090`
- Eureka: `http://localhost:8761`
- MySQL from host: `localhost:3333`

Important implementation details:

- backend services connect to MySQL internally through `mysql:3306`
- the MySQL host port `3333` is only for access from the host machine
- frontend static image assets are mounted from `FRONTEND_ASSETS_HOST_PATH`
- the helper script `update.sh` performs `pull`, `up -d`, and `ps`

This repository should be updated whenever a new image tag, deployment variable, mounted volume, or network-level integration becomes part of the platform release. In short, it is the infrastructure companion of Tikitakas and the fastest way to bring the whole environment up in a reproducible way.
