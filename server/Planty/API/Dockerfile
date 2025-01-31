# Etapa base, onde você define o servidor do ASP.NET
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS base
WORKDIR /app
EXPOSE 8080
EXPOSE 8081

# Etapa de build onde o SDK do .NET será instalado
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

# Adicionar o SDK do .NET ao PATH
ENV PATH="$PATH:/root/.dotnet/tools"

# Copie o arquivo do projeto e restaure as dependências
COPY API.csproj .
RUN dotnet restore API.csproj
COPY . .

# Instalar a ferramenta dotnet-ef globalmente
RUN dotnet tool install --global dotnet-ef

# Verificar a versão do .NET SDK
RUN dotnet --version

# Construir o projeto
RUN dotnet build API.csproj -c Release -o /app/build

# Etapa de publicação
FROM build AS publish
RUN dotnet publish API.csproj -c Release -o /app/publish /p:UseAppHost=false

# Etapa final, onde copiamos a publicação e executamos o app
FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "API.dll"]
