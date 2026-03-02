# Historias de Usuario — Sistema de Pedidos de Restaurante

A partir de la exploración del repositorio [Sistemas-de-pedidos-restaurante-backend](https://github.com/Maese-Alfred/Sistemas-de-pedidos-restaurante-backend) y [Sistemas-de-pedidos-restaurante-frontend](https://github.com/Maese-Alfred/Sistemas-de-pedidos-restaurante-frontend), se identificaron las siguientes 3 historias de usuario prioritarias:

---

## HU-01: Creación de Pedido por el Cliente

**Como** cliente del restaurante,  
**Quiero** poder seleccionar mi mesa y los platos del menú para crear un pedido,  
**Para** que mi orden sea registrada y enviada a la cocina de forma ágil y sin errores.

### Criterios de Aceptación

- El cliente puede visualizar el menú disponible con nombre, descripción y precio de cada plato.
- El cliente puede seleccionar el número de mesa.
- El cliente puede agregar uno o más productos al pedido especificando la cantidad de cada uno.
- Al confirmar el pedido, el sistema lo registra con estado `PENDING` y lo comunica a la cocina mediante un evento asíncrono (RabbitMQ).
- El cliente recibe el identificador del pedido creado para poder hacer seguimiento.

---

## HU-02: Gestión del Estado del Pedido en Cocina

**Como** personal de cocina,  
**Quiero** poder ver los pedidos activos y actualizar su estado (PENDING → IN_PREPARATION → READY),  
**Para** organizar la preparación de cada orden y reflejar el avance en tiempo real.

### Criterios de Aceptación

- La vista de cocina muestra todos los pedidos con estado `PENDING`, `IN_PREPARATION` o `READY`.
- El personal de cocina puede cambiar el estado de un pedido al siguiente paso del flujo.
- El acceso a las operaciones de cocina está protegido con un token de seguridad (`X-Kitchen-Token`).
- Los cambios de estado quedan persistidos en la base de datos y son visibles de inmediato.

---

## HU-03: Consulta del Estado del Pedido por el Cliente

**Como** cliente del restaurante,  
**Quiero** poder consultar el estado actual de mi pedido en cualquier momento,  
**Para** saber si está pendiente, en preparación o listo, sin necesidad de preguntar al personal.

### Criterios de Aceptación

- El cliente puede consultar el estado de su pedido usando su identificador.
- Los estados visibles son: `PENDING`, `IN_PREPARATION` y `READY`.
- La información mostrada incluye la mesa, los productos pedidos y el estado actual.
- Si el pedido no existe, el sistema responde con un mensaje de error claro.

---

## Referencias

- Backend: `order-service` (Spring Boot 3.2, PostgreSQL, RabbitMQ)
- Frontend: React + TypeScript + Vite + TailwindCSS
- Endpoints relevantes:
  - `GET /menu` — Consultar menú
  - `POST /orders` — Crear pedido
  - `GET /orders/{id}` — Consultar estado del pedido
  - `PATCH /orders/{id}/status` — Actualizar estado (cocina)
  - `GET /orders?status=PENDING,IN_PREPARATION,READY` — Listar pedidos activos (cocina)
