#See https://aka.ms/customizecontainer to learn how to customize your debug container and how Visual Studio uses this Dockerfile to build your images for faster debugging.

FROM mcr.microsoft.com/dotnet/aspnet:7.0 AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443

# Add labels here
LABEL org.opencontainers.image.source=https://github.com/mabubakarriaz/teamtreats
LABEL org.opencontainers.image.description="A web app to maintain the team's recreational fund."
LABEL org.opencontainers.image.licenses=Apache

FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build
WORKDIR /src
COPY ["teamtreats-webapp/teamtreats-webapp.csproj", "teamtreats-webapp/"]
RUN dotnet restore "teamtreats-webapp/teamtreats-webapp.csproj"
COPY . .
WORKDIR "/src/teamtreats-webapp"
RUN dotnet build "teamtreats-webapp.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "teamtreats-webapp.csproj" -c Release -o /app/publish /p:UseAppHost=false

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "teamtreats-webapp.dll"]