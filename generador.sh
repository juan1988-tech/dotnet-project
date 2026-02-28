#!/bin/bash

# ...existing code...

# Nombre base del proyecto (por defecto: MinimalApiProject)
PROJECT_NAME="${1:-MinimalApiProject}"

echo "Creando proyecto de minimal api de .net..."
dotnet new webapi -n "$PROJECT_NAME"

echo "Creando proyecto de pruebas para el proyecto de minimal api de .net..."
dotnet new xunit -n "${PROJECT_NAME}.Tests"

echo "Asociando los proyectos..."
dotnet add "${PROJECT_NAME}.Tests/${PROJECT_NAME}.Tests.csproj" reference "${PROJECT_NAME}/${PROJECT_NAME}.csproj"

echo "Creando archivo de solución..."
dotnet new sln -n "${PROJECT_NAME}.Solution"

echo "Agregando proyectos a la solución..."
dotnet sln "${PROJECT_NAME}.Solution.sln" add "${PROJECT_NAME}/${PROJECT_NAME}.csproj"
dotnet sln "${PROJECT_NAME}.Solution.sln" add "${PROJECT_NAME}.Tests/${PROJECT_NAME}.Tests.csproj"

echo "Agregando paquetes necesarios para el proyecto de test de minimal api de .net..."
dotnet add "${PROJECT_NAME}.Tests/${PROJECT_NAME}.Tests.csproj" package Microsoft.AspNetCore.Mvc.Testing
dotnet add "${PROJECT_NAME}.Tests/${PROJECT_NAME}.Tests.csproj" package Microsoft.NET.Test.
dotnet add "${PROJECT_NAME}.Tests/${PROJECT_NAME}.Tests.csproj" package Micdrosoft.AspNetCore.Mvc.Validation

echo "Agregando archivo de docker en el proyecto de minimal api de .net..."
cat <<EOL > "${PROJECT_NAME}/Dockerfile"
FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS base
WORKDIR /app

COPY *.csproj ./
RUN dotnet restore

# Copia el resto de los archivos del proyecto
FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /app
COPY --from=build /app/out

# Expone el puerto 80 para la aplicación
EXPOSE 80

# Ejecuta la aplicación
ENTRYPOINT ["dotnet", "${PROJECT_NAME}.dll"]
EOL

echo "Archivo de docker agregado en el proyecto de minimal api de .net."