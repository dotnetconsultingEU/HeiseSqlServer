FROM microsoft/dotnet:2.1-aspnetcore-runtime-nanoserver-1709 AS base
WORKDIR /app
EXPOSE 80

FROM microsoft/dotnet:2.1-sdk-nanoserver-1709 AS build
WORKDIR /src
COPY ../dotnetconsulting.TimeTracking.WebApi/dotnetconsulting.TimeTracking.WebApi.csproj ../dotnetconsulting.TimeTracking.WebApi/
RUN dotnet restore ../dotnetconsulting.TimeTracking.WebApi/dotnetconsulting.TimeTracking.WebApi.csproj
COPY . .
WORKDIR /src/../dotnetconsulting.TimeTracking.WebApi
RUN dotnet build dotnetconsulting.TimeTracking.WebApi.csproj -c Release -o /app

FROM build AS publish
RUN dotnet publish dotnetconsulting.TimeTracking.WebApi.csproj -c Release -o /app

FROM base AS final
WORKDIR /app
COPY --from=publish /app .
ENTRYPOINT ["dotnet", "dotnetconsulting.TimeTracking.WebApi.dll"]
