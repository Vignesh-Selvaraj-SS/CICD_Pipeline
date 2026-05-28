# Build Stage
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build

WORKDIR /src

# Copy all files
COPY . .

# Restore dependencies
RUN dotnet restore

# Publish application
RUN dotnet publish -c Release -o /app/publish

# Runtime Stage
FROM mcr.microsoft.com/dotnet/aspnet:8.0

WORKDIR /app

# Copy published output
COPY --from=build /app/publish .

# Expose container port
EXPOSE 80

# Start application
ENTRYPOINT ["dotnet", "CICD Pipeline.dll"]