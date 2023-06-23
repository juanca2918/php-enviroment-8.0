# php-enviroment-8

## Enviroment para desarrollo con php 8

### Imagenes usadas
---
- **ubuntu:latest**
Esta fue usada en el Dockerfile

- **postgres:latest**
Esta es la imagen de postgres

- **redis:latest**
Imagen de redis

- **dpage/pgadmin4:latest**
Imagen del cliente administrador de base de datos
---

### Cambiar la informacion del dockerfile
- **Cambiar del dockerfile todos los argumentos con changeme**
---

### Comandos para el deploy
- **docker compose build**
Para construir la imagen del Dockerfile

- **docker compose up -d**
Para montar los contenedores, el **-d** es para que ejecute el comando en segundo plano.

- **docker compose down**
Para desmontar los contenedores
