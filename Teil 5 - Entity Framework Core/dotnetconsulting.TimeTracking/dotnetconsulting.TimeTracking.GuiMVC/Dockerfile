FROM microsoft/dotnet:2.1-aspnetcore-runtime-nanoserver-1709 AS base
WORKDIR /app
EXPOSE 60045
EXPOSE 44394

FROM microsoft/dotnet:2.1-sdk-nanoserver-1709 AS build
WORKDIR /src
COPY dotnetconsulting.TimeTracking.GuiMVC/dotnetconsulting.TimeTracking.GuiMVC.csproj dotnetconsulting.TimeTracking.GuiMVC/
RUN dotnet restore dotnetconsulting.TimeTracking.GuiMVC/dotnetconsulting.TimeTracking.GuiMVC.csproj
COPY . .
WORKDIR /src/dotnetconsulting.TimeTracking.GuiMVC
RUN dotnet build dotnetconsulting.TimeTracking.GuiMVC.csproj -c Release -o /app

FROM build AS publish
RUN dotnet publish dotnetconsulting.TimeTracking.GuiMVC.csproj -c Release -o /app

FROM base AS final
WORKDIR /app
COPY --from=publish /app .
ENTRYPOINT ["dotnet", "dotnetconsulting.TimeTracking.GuiMVC.dll"]
