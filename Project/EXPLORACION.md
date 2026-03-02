# Exploración del Sistema de Pedidos de Restaurante

Repositorios descargados localmente como submódulos de Git desde:

- **Backend:** https://github.com/Maese-Alfred/Sistemas-de-pedidos-restaurante-backend.git  
- **Frontend:** https://github.com/Maese-Alfred/Sistemas-de-pedidos-restaurante-frontend.git

Para inicializar los submódulos después de clonar este repositorio:

```bash
git submodule update --init --recursive
```

---

## Arquitectura General

El sistema implementa una arquitectura de microservicios orientada a eventos para la gestión de pedidos en un restaurante.

```
Cliente Web (React + Vite)  ──REST──►  Order Service (Spring Boot :8080)
Cocina Web  (React + Vite)  ──REST──►  Order Service
                                            │
                                       PostgreSQL (restaurant_db)
                                            │
                                       RabbitMQ ──publish order.placed──►  Kitchen Worker (Spring Boot)
                                                                                    │
                                                                               PostgreSQL (kitchen_db)
```

**Stack tecnológico:**
- **Backend:** Java 17, Spring Boot 3.2, PostgreSQL, RabbitMQ, Maven (multi-módulo)
- **Frontend:** React, TypeScript, Vite, TailwindCSS, shadcn/ui, TanStack Query

---

## Estructura del Backend (`Sistemas-de-pedidos-restaurante-backend/`)

| Directorio/Archivo       | Descripción |
|--------------------------|-------------|
| `order-service/`         | API REST principal: gestión de órdenes, menú, reglas de negocio |
| `kitchen-worker/`        | Consumidor de eventos RabbitMQ; procesa órdenes en cocina |
| `report-service/`        | Servicio de reportes |
| `infrastructure/docker/` | Docker Compose para entorno local completo |
| `openspec/`              | Especificaciones OpenAPI / cambios |
| `docs/`                  | Documentación operativa, auditorías, calidad, deuda técnica |
| `scripts/`               | Scripts de utilidad |
| `pom.xml`                | POM raíz del proyecto multi-módulo Maven |
| `.env.example`           | Variables de entorno de referencia |

### Flujo de un pedido

1. El cliente selecciona mesa y platos en el frontend.
2. El frontend envía `POST /orders` al Order Service.
3. El Order Service persiste la orden como `PENDING` y publica el evento `order.placed` en RabbitMQ.
4. El Kitchen Worker consume el evento y actualiza el estado a `IN_PREPARATION`.
5. La cocina consulta órdenes activas vía `GET /orders?status=PENDING,IN_PREPARATION,READY` con el header `X-Kitchen-Token`.

### Arranque rápido (Docker)

```bash
cd Sistemas-de-pedidos-restaurante-backend
cp .env.example .env
docker compose -f infrastructure/docker/docker-compose.yml up -d --build
```

URLs disponibles:
- API REST: http://localhost:8080
- Swagger UI: http://localhost:8080/swagger-ui.html
- RabbitMQ UI: http://localhost:15672 (guest/guest)

---

## Estructura del Frontend (`Sistemas-de-pedidos-restaurante-frontend/`)

| Directorio/Archivo       | Descripción |
|--------------------------|-------------|
| `src/`                   | Código fuente React/TypeScript |
| `infrastructure/`        | Configuración Docker e infraestructura |
| `docs/`                  | Documentación del frontend |
| `openspec/`              | Especificaciones OpenAPI consumidas |
| `scripts/`               | Scripts de utilidad |
| `Dockerfile`             | Imagen Docker para producción |
| `vite.config.ts`         | Configuración de Vite |
| `tailwind.config.cjs`    | Configuración de TailwindCSS |
| `package.json`           | Dependencias Node.js |
| `.env.example`           | Variables de entorno de referencia |

### Variables de entorno principales

| Variable                    | Descripción |
|-----------------------------|-------------|
| `VITE_API_BASE_URL`         | URL base del backend (default: `http://localhost:8080`) |
| `VITE_USE_MOCK`             | `false` para usar API real (recomendado en producción) |
| `VITE_ALLOW_MOCK_FALLBACK`  | `true` solo en contingencia |
| `VITE_KITCHEN_PIN`          | PIN de acceso a vista de cocina |
| `VITE_KITCHEN_FIXED_TOKEN`  | Token fijo de autenticación de cocina |

---

## Seguridad de Cocina

Las rutas de la vista de cocina están protegidas con un token de autenticación:

- **Header:** `X-Kitchen-Token`
- **Token por defecto:** `cocina123`
- Configurable en backend (`KITCHEN_AUTH_TOKEN`) y frontend (`VITE_KITCHEN_FIXED_TOKEN`).

---

## Puertos Requeridos

| Puerto | Servicio |
|--------|----------|
| 5173   | Frontend (Vite dev / Docker) |
| 8080   | Order Service |
| 5432   | PostgreSQL (restaurant_db) |
| 5433   | PostgreSQL (kitchen_db) |
| 5672   | RabbitMQ (AMQP) |
| 15672  | RabbitMQ Management UI |

---

## Documentación de Referencia

- **Backend:**
  - `Sistemas-de-pedidos-restaurante-backend/docs/development/GUIA_RAPIDA.md`
  - `Sistemas-de-pedidos-restaurante-backend/docs/auditoria/AUDITORIA.md`
  - `Sistemas-de-pedidos-restaurante-backend/docs/quality/CALIDAD.md`
- **Frontend:**
  - `Sistemas-de-pedidos-restaurante-frontend/docs/`
