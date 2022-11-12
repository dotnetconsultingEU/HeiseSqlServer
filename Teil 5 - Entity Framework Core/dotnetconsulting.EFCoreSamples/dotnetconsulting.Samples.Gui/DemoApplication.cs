// Disclaimer
// Dieser Quellcode ist als Vorlage oder als Ideengeber gedacht. Er kann frei und ohne 
// Auflagen oder Einschränkungen verwendet oder verändert werden.
// Jedoch wird keine Garantie übernommen, dass eine Funktionsfähigkeit mit aktuellen und 
// zukünftigen API-Versionen besteht. Der Autor übernimmt daher keine direkte oder indirekte 
// Verantwortung, wenn dieser Code gar nicht oder nur fehlerhaft ausgeführt wird.
// Für Anregungen und Fragen stehe ich jedoch gerne zur Verfügung.

// Thorsten Kansy, www.dotnetconsulting.eu

using dotnetconsulting.Samples.EFContext;
using dotnetconsulting.Samples.Gui.DemoJobs;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Logging;

namespace dotnetconsulting.Samples.Gui
{
    public class DemoApplication
    {
        private readonly IServiceProvider iocContainer;

        public DemoApplication(IServiceProvider iocContainer)
        {
            this.iocContainer = iocContainer;
        }

        public void Run()
        {
            ILogger logger = iocContainer.GetService<ILogger<DemoApplication>>();
            logger.LogInformation("== Running ==");

            // Data Seeding
            var efContext = iocContainer.GetService<SamplesContext1>();
            efContext.SeedDemoData();

            // Demos
            IDemoJob demoJob;
            demoJob = iocContainer.GetRequiredService<CreateEntities>();
            // demoJob = iocContainer.GetRequiredService<QueryEntities>();
            // demoJob = iocContainer.GetRequiredService<ModifyEntities>();
            // demoJob = iocContainer.GetRequiredService<DeleteEntities>();
            // demoJob = iocContainer.GetRequiredService<DbFunction>();
            // demoJob = iocContainer.GetRequiredService<ChangeTracker>();
            // demoJob = iocContainer.GetRequiredService<DirectSql>();
            // demoJob = iocContainer.GetRequiredService<QueryTypes>();
            // demoJob = iocContainer.GetRequiredService<Concurrency>();
            // demoJob = iocContainer.GetRequiredService<GlobalQueryFilter>();
            // demoJob = iocContainer.GetRequiredService<ShadowProperties>();
            // demoJob = iocContainer.GetRequiredService<ExplicitlyCompiledQueries>();
            // demoJob = iocContainer.GetRequiredService<LoadingStrategies>();
            // demoJob = iocContainer.GetRequiredService<GraphUpdate>();
            // demoJob = iocContainer.GetRequiredService<Transactions>();
            // demoJob = iocContainer.GetRequiredService<TemporalTable>();

            // Und Action!
            Console.WriteLine($"=== {demoJob.Title} ===");
            demoJob.Run();

            logger.LogInformation("== Fertig ==");
            Console.ReadKey();
        }
    }
}