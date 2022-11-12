// Disclaimer
// Dieser Quellcode ist als Vorlage oder als Ideengeber gedacht. Er kann frei und ohne 
// Auflagen oder Einschränkungen verwendet oder verändert werden.
// Jedoch wird keine Garantie übernommen, dass eine Funktionsfähigkeit mit aktuellen und 
// zukünftigen API-Versionen besteht. Der Autor übernimmt daher keine direkte oder indirekte 
// Verantwortung, wenn dieser Code gar nicht oder nur fehlerhaft ausgeführt wird.
// Für Anregungen und Fragen stehe ich jedoch gerne zur Verfügung.

// Thorsten Kansy, www.dotnetconsulting.eu

using dotnetconsulting.EFCore.Domains;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Logging.Console;

namespace dotnetconsulting.EFCore.CosmosDb
{
    public class CosmosDbContextOwnedTypes : DbContext
    {
        public CosmosDbContextOwnedTypes(DbContextOptions Options) : base(Options)
        {
        }

        public CosmosDbContextOwnedTypes()
        {

        }

        internal DbSet<Order> Orders { get; set; }

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            if (!optionsBuilder.IsConfigured)
            {
                // Konfiguration auf Azure Comos DB Emulator
                string endPoint = @"https://localhost:8081";
                string authKey = @"C2y6yDjf5/R+ob0N8A7Cgv30VRDJIWEHLM+4QDU5DE2nQ9nDuVTqobD4b8mGGyPMbIZnqyMsEcaGQy67XIw/Jw==";
                string databaseName = @"EFDatabaseOrders";
                optionsBuilder
                    .EnableSensitiveDataLogging(true)
                    .ConfigureWarnings(c =>
                    {
                        // c.Throw(???);
                    })
                    .UseCosmos(endPoint, authKey, databaseName);
            }

            base.OnConfiguring(optionsBuilder);
        }

        protected override void OnModelCreating(ModelBuilder mb)
        {
            mb.Entity<Order>(e =>
            {
                e.ToContainer("Orders");
                // e.Metadata.Cosmos().ContainerName = "Orders";
                
                // Eine Lieferadresse
                e.OwnsOne(o => o.ShippingAddress);

                // Beliebig viele Bestellpositionen mit jeweils 
                // einem Status
                e.OwnsMany(o1 => o1.OrderLines, o2 =>
                {
                    o2.OwnsOne(o3 => o3.Status);
                });

                // EF Core 2.2 Preview 3 hat ein Problem mit Enums
                // https://github.com/aspnet/EntityFrameworkCore/issues/13164
                e.Ignore(i => i.Status);
            });

            base.OnModelCreating(mb);
        }
    }
}