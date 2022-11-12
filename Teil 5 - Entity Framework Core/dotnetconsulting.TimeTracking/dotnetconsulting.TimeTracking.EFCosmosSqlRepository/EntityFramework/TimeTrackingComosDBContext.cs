// Disclaimer
// Dieser Quellcode ist als Vorlage oder als Ideengeber gedacht. Er kann frei und ohne 
// Auflagen oder Einschränkungen verwendet oder verändert werden.
// Jedoch wird keine Garantie übernommen, dass eine Funktionsfähigkeit mit aktuellen und 
// zukünftigen API-Versionen besteht. Der Autor übernimmt daher keine direkte oder indirekte 
// Verantwortung, wenn dieser Code gar nicht oder nur fehlerhaft ausgeführt wird.
// Für Anregungen und Fragen stehe ich jedoch gerne zur Verfügung.

// Thorsten Kansy, www.dotnetconsulting.eu

using Microsoft.EntityFrameworkCore;

namespace dotnetconsulting.TimeTracking.EFCosmosSqlRepository.EntityFramework;

public class TimeTrackingComosDBContext : DbContext
{
    public TimeTrackingComosDBContext(DbContextOptions Options) : base(Options)
    {
    }

    public TimeTrackingComosDBContext()
    {
    }

    internal DbSet<Entry> Entries { get; set; } = null!;

    internal DbSet<Order> Orders { get; set; } = null!;

    internal DbSet<Customer> Customers { get; set; } = null!;

    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
    {
        if (!optionsBuilder.IsConfigured)
        {
            string endPoint = @"https://localhost:8081";
            string authKey = @"C2y6yDjf5/R+ob0N8A7Cgv30VRDJIWEHLM+4QDU5DE2nQ9nDuVTqobD4b8mGGyPMbIZnqyMsEcaGQy67XIw/Jw==";
            string databaseName = @"TimeTracking";
            optionsBuilder
                .EnableSensitiveDataLogging(true)
                .UseCosmos(endPoint, authKey, databaseName);
        }
        base.OnConfiguring(optionsBuilder);
    }

    protected override void OnModelCreating(ModelBuilder mb)
    {
        const string collectionName = "Elements";

        mb.Entity<Customer>(e =>
        {
            e.HasKey(k => k.Id);
            e.ToContainer(collectionName);
        });

        mb.Entity<Order>(e =>
        {
            e.HasKey(k => k.Id);
            e.ToContainer(collectionName);
        });

        mb.Entity<Entry>(e =>
        {
            e.HasKey(k => k.Id);
            e.ToContainer(collectionName);
        });

        base.OnModelCreating(mb);
    }
}