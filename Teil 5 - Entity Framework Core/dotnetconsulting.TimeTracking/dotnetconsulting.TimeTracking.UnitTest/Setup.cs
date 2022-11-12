// Disclaimer
// Dieser Quellcode ist als Vorlage oder als Ideengeber gedacht. Er kann frei und ohne 
// Auflagen oder Einschränkungen verwendet oder verändert werden.
// Jedoch wird keine Garantie übernommen, dass eine Funktionsfähigkeit mit aktuellen und 
// zukünftigen API-Versionen besteht. Der Autor übernimmt daher keine direkte oder indirekte 
// Verantwortung, wenn dieser Code gar nicht oder nur fehlerhaft ausgeführt wird.
// Für Anregungen und Fragen stehe ich jedoch gerne zur Verfügung.

// Thorsten Kansy, www.dotnetconsulting.eu

using dotnetconsulting.TimeTracking.AppLogic;
using dotnetconsulting.TimeTracking.EFRepository.EntityFramework;
using dotnetconsulting.TimeTracking.Interfaces;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using efRepo = dotnetconsulting.TimeTracking.EFRepository;

namespace dotnetconsulting.TimeTracking.UnitTests;

[TestClass]
public class Setup
{
    public static IServiceProvider serviceProvider { get; private set; } = null!;

    [AssemblyInitialize]
    public static void Initialize(TestContext tc)
    {
        IServiceCollection services = new ServiceCollection();
        ConfigureServices(services);
        serviceProvider = services.BuildServiceProvider();
    }

    private static void ConfigureServices(IServiceCollection services)
    {
        services.AddTransient<IAppLogic, AppLogicV1>();

        services.AddDbContext<TimeTrackingContext>(o =>
        {
                // Install-Package Microsoft.EntityFrameworkCore.InMemory
                o.UseInMemoryDatabase("time");
        });
        services.AddTransient<IAppRepository, efRepo.AppRepository>();
    }
}