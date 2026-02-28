# appNet Workspace

Este repositorio contiene múltiples proyectos independientes basados en .NET, principalmente APIs web que utilizan el patrón Minimal API. Está diseñado para facilitar el desarrollo, pruebas y despliegue de servicios web modernos y ligeros.

## Estructura del Proyecto

- **MinimalApiProject/**  
  API web minimalista con configuración propia, Dockerfile y archivos de settings.
- **MinimalApiProject.Tests/**  
  Proyecto de pruebas unitarias para `MinimalApiProject`, usando xUnit.
- **NETapp/MiWebAPI/**  
  Otro servicio web minimalista, con su propia configuración y Dockerfile.
- **.github/**  
  Instrucciones y convenciones para el uso de Copilot y actualizaciones de .NET.
- **generador.sh**  
  Script para automatizar la creación y configuración de nuevos proyectos minimal API y sus pruebas.

## Uso Básico

### Construcción
```sh
dotnet build MinimalApiProject/
dotnet build NETapp/MiWebAPI/
```

### Ejecución
```sh
dotnet run --project MinimalApiProject/
dotnet run --project NETapp/MiWebAPI/
```

### Pruebas
```sh
dotnet test MinimalApiProject.Tests/
```

### Docker
Cada API tiene su propio Dockerfile para facilitar la creación de contenedores:
```sh
docker build -t minimalapiproject MinimalApiProject/
docker build -t miwebapi NETapp/MiWebAPI/
```

## Convenciones

- Cada API está en su propia carpeta y es independiente.
- La configuración se gestiona con archivos `appsettings.json` y `appsettings.Development.json`.
- Los proyectos de prueba terminan en `.Tests` y usan xUnit.
- No hay dependencias entre APIs; cada una puede desplegarse y ejecutarse por separado.

## Ejemplo de Minimal API

```csharp
var builder = WebApplication.CreateBuilder(args);
var app = builder.Build();
app.MapGet("/", () => "Hello World!");
app.Run();
```

## Recursos

- Documentación de .NET Minimal API: [Microsoft Docs](https://learn.microsoft.com/aspnet/core/fundamentals/minimal-apis)
- Guía de actualización de .NET: [.github/instructions/dotnet-upgrade.instructions.md](.github/instructions/dotnet-upgrade.instructions.md)

---

Este repositorio es ideal para# appNet Workspace

Este repositorio contiene múltiples proyectos independientes basados en .NET, principalmente APIs web que utilizan el patrón Minimal API. Está diseñado para facilitar el desarrollo, pruebas y despliegue de servicios web modernos y ligeros.

## Estructura del Proyecto

- **MinimalApiProject/**  
  API web minimalista con configuración propia, Dockerfile y archivos de settings.
- **MinimalApiProject.Tests/**  
  Proyecto de pruebas unitarias para `MinimalApiProject`, usando xUnit.
- **NETapp/MiWebAPI/**  
  Otro servicio web minimalista, con su propia configuración y Dockerfile.
- **.github/**  
  Instrucciones y convenciones para el uso de Copilot y actualizaciones de .NET.
- **generador.sh**  
  Script para automatizar la creación y configuración de nuevos proyectos minimal API y sus pruebas.

## Uso Básico

### Construcción
```sh
dotnet build MinimalApiProject/
dotnet build NETapp/MiWebAPI/
```

### Ejecución
```sh
dotnet run --project MinimalApiProject/
dotnet run --project NETapp/MiWebAPI/
```

### Pruebas
```sh
dotnet test MinimalApiProject.Tests/
```

### Docker
Cada API tiene su propio Dockerfile para facilitar la creación de contenedores:
```sh
docker build -t minimalapiproject MinimalApiProject/
docker build -t miwebapi NETapp/MiWebAPI/
```

## Convenciones

- Cada API está en su propia carpeta y es independiente.
- La configuración se gestiona con archivos `appsettings.json` y `appsettings.Development.json`.
- Los proyectos de prueba terminan en `.Tests` y usan xUnit.
- No hay dependencias entre APIs; cada una puede desplegarse y ejecutarse por separado.

## Ejemplo de Minimal API

```csharp
var builder = WebApplication.CreateBuilder(args);
var app = builder.Build();
app.MapGet("/", () => "Hello World!");
app.Run();
```

## Recursos

- Documentación de .NET Minimal API: [Microsoft Docs](https://learn.microsoft.com/aspnet/core/fundamentals/minimal-apis)
- Guía de actualización de .NET: [.github/instructions/dotnet-upgrade.instructions.md](.github/instructions/dotnet-upgrade.instructions.md)

---

Este repositorio es ideal para aprender, experimentar y desplegar APIs minimalistas en .NET de forma rápida y sencilla. aprender, experimentar y desplegar APIs minimalistas en .NET de forma rápida y sencilla.