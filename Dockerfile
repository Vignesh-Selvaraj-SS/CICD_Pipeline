# Build Stage
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build

WORKDIR /src

# Copy everything
COPY . .

# Move into project folder
WORKDIR "/src/CICD Pipeline"

# Restore dependencies
RUN dotnet restore

# Publish application
RUN dotnet publish -c Release -o /app/publish

# Runtime Stage
FROM mcr.microsoft.com/dotnet/aspnet:8.0

WORKDIR /app

# Copy published files
COPY --from=build /app/publish .

EXPOSE 80

ENTRYPOINT ["dotnet", "CICD Pipeline.dll"]