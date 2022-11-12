// Disclaimer
// Dieser Quellcode ist als Vorlage oder als Ideengeber gedacht. Er kann frei und ohne 
// Auflagen oder Einschränkungen verwendet oder verändert werden.
// Jedoch wird keine Garantie übernommen, dass eine Funktionsfähigkeit mit aktuellen und 
// zukünftigen API-Versionen besteht. Der Autor übernimmt daher keine direkte oder indirekte 
// Verantwortung, wenn dieser Code gar nicht oder nur fehlerhaft ausgeführt wird.
// Für Anregungen und Fragen stehe ich jedoch gerne zur Verfügung.

// Thorsten Kansy, www.dotnetconsulting.eu

using dotnetconsulting.TimeTracking.Interfaces;
using dotnetconsulting.TimeTracking.AppLogic;

using efRepo = dotnetconsulting.TimeTracking.EFRepository;
using efRepoCosmosSql = dotnetconsulting.TimeTracking.EFCosmosSqlRepository;
using comosRepo = dotnetconsulting.TimeTracking.CosmosDBDocumentSQLRepository;
using Microsoft.EntityFrameworkCore;
using dotnetconsulting.TimeTracking.EFRepository.EntityFramework;
using dotnetconsulting.TimeTracking.EFCosmosSqlRepository.EntityFramework;

var builder = WebApplication.CreateBuilder(args);

builder.Services.AddControllersWithViews();
builder.Services.AddRazorPages();

// AutoMapper einrichten
builder.Services.AddAutoMapper(AppDomain.CurrentDomain.GetAssemblies());

// Logging einrichten
builder.Services.AddLogging(l =>
{
    l.AddConsole();
    l.AddDebug();
});

// Anwendungslogic
builder.Services.AddTransient<IAppLogic, AppLogicV1>();

// Welches Repository?
string repo = builder.Configuration["Repository"].ToLower();

switch (repo)
{
    case "comosdb":
        // Connection String für DocumentDB
        builder.Services.AddScoped(c =>
        {
            var config = new comosRepo.AppRepositoryCosmosSqlConfig(
                builder.Configuration["CosmosDBSql:Endpoint"],
                builder.Configuration["CosmosDBSql:Key"],
                builder.Configuration["CosmosDBSql:DatabaseId"],
                builder.Configuration["CosmosDBSql:CollectionId"]
                );

            return config;
        });
        builder.Services.AddTransient<IAppRepository, comosRepo.AppRepository>();
        break;
    case "efcore":
        // Connection String für EF Core
        builder.Services.AddDbContext<TimeTrackingContext>(o =>
        {
            o.UseSqlServer(builder.Configuration.GetValue<string>("ConnectionString:Main"));
            o.ConfigureWarnings(w =>
            {
                // Unterdrückt nicht die Modelwarnungen
                w.Default(WarningBehavior.Ignore);
            });
        });
        builder.Services.AddTransient<IAppRepository, efRepo.AppRepository>();
        break;
    case "efcorecosmossql":
        // Connection Informationen für EF Core mit CosmosDB
        builder.Services.AddDbContext<TimeTrackingComosDBContext>(o =>
        {
            string endPoint = builder.Configuration["EfCoreCosmosSql:EndPoint"];
            string authKey = builder.Configuration["EfCoreCosmosSql:AuthKey"];
            string databaseName = builder.Configuration["EfCoreCosmosSql:Database"];

            o.UseCosmos(endPoint, authKey, databaseName);
        });
        builder.Services.AddTransient<IAppRepository, efRepoCosmosSql.AppRepository>();
        break;
    case "memory":
        // Connection String für EF Core
        builder.Services.AddDbContext<TimeTrackingContext>(o =>
        {
            o.UseInMemoryDatabase("time");
        });
        builder.Services.AddTransient<IAppRepository, efRepo.AppRepository>();
        break;
    default:
        throw new ArgumentOutOfRangeException(nameof(repo));
}

// App erstellen und HTTP request pipeline konfigurieren
var app = builder.Build();

if (app.Environment.IsDevelopment())
{
    app.UseWebAssemblyDebugging();
}
else
{
    app.UseExceptionHandler("/Error");
    // The default HSTS value is 30 days. You may want to change this for production scenarios, see https://aka.ms/aspnetcore-hsts.
    app.UseHsts();
}

app.UseHttpsRedirection();
app.UseBlazorFrameworkFiles();
app.UseStaticFiles();

app.UseRouting();

app.MapRazorPages();
app.MapControllers();
app.MapFallbackToFile("index.html");

app.Run();