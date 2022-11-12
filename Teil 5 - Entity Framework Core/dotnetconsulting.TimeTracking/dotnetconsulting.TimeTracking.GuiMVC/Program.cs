// Disclaimer
// Dieser Quellcode ist als Vorlage oder als Ideengeber gedacht. Er kann frei und ohne 
// Auflagen oder Einschränkungen verwendet oder verändert werden.
// Jedoch wird keine Garantie übernommen, dass eine Funktionsfähigkeit mit aktuellen und 
// zukünftigen API-Versionen besteht. Der Autor übernimmt daher keine direkte oder indirekte 
// Verantwortung, wenn dieser Code gar nicht oder nur fehlerhaft ausgeführt wird.
// Für Anregungen und Fragen stehe ich jedoch gerne zur Verfügung.

// Thorsten Kansy, www.dotnetconsulting.eu

using dotnetconsulting.TimeTracking.AppLogic;
using dotnetconsulting.TimeTracking.EFCosmosSqlRepository.EntityFramework;
using dotnetconsulting.TimeTracking.EFRepository.EntityFramework;
using dotnetconsulting.TimeTracking.GuiMVC.Code;
using dotnetconsulting.TimeTracking.GuiMVC.Data;
using dotnetconsulting.TimeTracking.Interfaces;
using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;
using efRepo = dotnetconsulting.TimeTracking.EFRepository;
using efRepoCosmosSql = dotnetconsulting.TimeTracking.EFCosmosSqlRepository;
using comosRepo = dotnetconsulting.TimeTracking.CosmosDBDocumentSQLRepository;

var builder = WebApplication.CreateBuilder(args);

builder.Services.Configure<CookiePolicyOptions>(options =>
{
    // This lambda determines whether user consent for non-essential cookies is needed for a given request.
    options.CheckConsentNeeded = context => true;
    options.MinimumSameSitePolicy = SameSiteMode.None;
});

builder.Services.AddDbContext<ApplicationDbContext>(options =>
    options.UseSqlServer(builder.Configuration.GetConnectionString("DefaultConnection")));
builder.Services.AddDefaultIdentity<IdentityUser>()
    .AddEntityFrameworkStores<ApplicationDbContext>();

builder.Services.AddMvc(o =>
{
    o.MaxModelValidationErrors = 10;
    o.Filters.Add<OperationCancelledExceptionFilter>();
});

// AutoMapper einrichten
builder.Services.AddAutoMapper(AppDomain.CurrentDomain.GetAssemblies());

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
        throw new System.ArgumentOutOfRangeException("Configuration['Repository']");
}


var mvcviews = builder.Services.AddControllersWithViews();

// Runtime compiling for refreshable pages during development
if (builder.Environment.IsDevelopment())
    mvcviews.AddRazorRuntimeCompilation();

builder.Services.AddDatabaseDeveloperPageExceptionFilter();

// Build app
var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseDeveloperExceptionPage();
    app.UseMigrationsEndPoint();
}
else
{
    app.UseExceptionHandler("/Home/Error");
    app.UseHsts();
}

app.UseHttpsRedirection();
app.UseStaticFiles();
app.UseCookiePolicy();

app.UseRouting();

app.UseAuthentication();

app.UseEndpoints(endpoints =>
{
    endpoints.MapControllerRoute(
        name: "default",
        pattern: "{controller=Home}/{action=Index}/{id?}");
    endpoints.MapRazorPages();
});

app.Run();