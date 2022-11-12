// Disclaimer
// Dieser Quellcode ist als Vorlage oder als Ideengeber gedacht. Er kann frei und ohne 
// Auflagen oder Einschränkungen verwendet oder verändert werden.
// Jedoch wird keine Garantie übernommen, dass eine Funktionsfähigkeit mit aktuellen und 
// zukünftigen API-Versionen besteht. Der Autor übernimmt daher keine direkte oder indirekte 
// Verantwortung, wenn dieser Code gar nicht oder nur fehlerhaft ausgeführt wird.
// Für Anregungen und Fragen stehe ich jedoch gerne zur Verfügung.

// Thorsten Kansy, www.dotnetconsulting.eu

using dotnetconsulting.Samples.EFContext;
using dotnetconsulting.Samples.Gui;
using dotnetconsulting.Samples.Gui.DemoJobs;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Diagnostics;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Logging;

// Konfiguration vorbereiten
var config = CreateConfigurationRoot();

// Konfiguration und IoC initialisieren
var iocContainer = CreateDependencyInjectionContainer(config);

// DemoApp starten
DemoApplication app = new(iocContainer);
app.Run();

static IConfigurationRoot CreateConfigurationRoot()
{
    var configBuilder = new ConfigurationBuilder()
        .SetBasePath(Directory.GetCurrentDirectory())
        .AddJsonFile("appsettings.json");

    return configBuilder.Build();
}

static IServiceProvider CreateDependencyInjectionContainer(IConfigurationRoot Configuration)
{
    IServiceCollection iocContainer = new ServiceCollection();

    // Logging einrichtgen
    iocContainer.AddLogging((builder) =>
    {
        builder.SetMinimumLevel(LogLevel.Trace)
               .AddDebug()
               .AddConsole();
    })

    // Konfiguration
    .AddSingleton(Configuration);

    // LoggerFactory für EF einrichten
    // EFLoggerFactory.SetupFactory(LogLevel.Trace);
    EFLoggerFactory.SetupFactory(iocContainer.BuildServiceProvider());

    // EF Context konfigurieren
    iocContainer.AddDbContext<SamplesContext1>(o => o
        // .UseLazyLoadingProxies()
        .UseSqlServer(Configuration["ConnectionStrings:EFConString"], b =>
        {
            b.UseQuerySplittingBehavior(QuerySplittingBehavior.SplitQuery);
        })
        //.UseModel(CompiledModel.Instance)
        .EnableDetailedErrors()
        .EnableSensitiveDataLogging()
        .UseLoggerFactory(EFLoggerFactory.Instance)
        .ConfigureWarnings(w =>
        {
            w.Throw(RelationalEventId.QueryPossibleExceptionWithAggregateOperatorWarning);
        })
        .EnableSensitiveDataLogging(true)
    )

    .AddDbContextPool<SamplesContext3>(
            o => o.UseSqlServer(Configuration["ConnectionStrings:EFConString"])
                  .UseLoggerFactory(EFLoggerFactory.Instance)
    )

    // Demos hinzufügen
    .AddTransient<CreateEntities>()
    .AddTransient<QueryEntities>()
    .AddTransient<ModifyEntities>()
    .AddTransient<DeleteEntities>()
    .AddTransient<ChangeTracker>()
    .AddTransient<DbFunction>()
    .AddTransient<Concurrency>()
    .AddTransient<DirectSql>()
    .AddTransient<QueryTypes>()
    .AddTransient<GlobalQueryFilter>()
    .AddTransient<ShadowProperties>()
    .AddTransient<ExplicitlyCompiledQueries>()
    .AddTransient<LoadingStrategies>()
    .AddTransient<GraphUpdate>()
    .AddTransient<Transactions>()
    .AddTransient<TemporalTable>();

    // Rückgabe
    IServiceProvider serviceProvider = iocContainer.BuildServiceProvider();

    return serviceProvider;
}