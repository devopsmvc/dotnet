# Use official .NET runtime image as a base
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS base
WORKDIR /app

# Use official .NET SDK image for building
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

# Copy the project and restore dependencies
COPY ["dotnet.csproj", "./"]
RUN dotnet restore

# Copy everything else and build the app
COPY . .
RUN dotnet publish -c Release -o /app/publish

# Use the runtime base image to run the app
FROM base AS final
WORKDIR /app
COPY --from=build /app/publish .
ENTRYPOINT ["dotnet", "dotnet.dll"]
