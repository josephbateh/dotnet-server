FROM mcr.microsoft.com/dotnet/core/sdk:3.1 AS build
WORKDIR /app

# Copy Files & Get Dependencies
COPY *.csproj ./
COPY . .
RUN rm -rf bin obj out
RUN dotnet restore

# Build App
RUN dotnet publish -c Release -o out

# Build Image
FROM mcr.microsoft.com/dotnet/core/aspnet:3.1 AS runtime
WORKDIR /app
COPY --from=build /app/out ./
ENTRYPOINT ["dotnet", "Server.dll"]