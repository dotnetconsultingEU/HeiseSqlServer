// Disclaimer
// Dieser Quellcode ist als Vorlage oder als Ideengeber gedacht. Er kann frei und ohne 
// Auflagen oder Einschränkungen verwendet oder verändert werden.
// Jedoch wird keine Garantie übernommen, dass eine Funktionsfähigkeit mit aktuellen und 
// zukünftigen API-Versionen besteht. Der Autor übernimmt daher keine direkte oder indirekte 
// Verantwortung, wenn dieser Code gar nicht oder nur fehlerhaft ausgeführt wird.
// Für Anregungen und Fragen stehe ich jedoch gerne zur Verfügung.

// Thorsten Kansy, www.dotnetconsulting.eu

using dotnetconsulting.EFCore.DomainsGuid;

using Microsoft.EntityFrameworkCore;

namespace dotnetconsulting.EFCore.CosmosDbSql
{
    public class CosmosDbContextGuid : DbContext
    {
        public CosmosDbContextGuid(DbContextOptions Options) : base(Options)
        {
        }

        public CosmosDbContextGuid()
        {

        }

        internal DbSet<SpeakerGuid> Speakers { get; set; }

        internal DbSet<SessionGuid> Sessions { get; set; }

        internal DbSet<TechEventGuid> TechEvents { get; set; }

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            if (!optionsBuilder.IsConfigured)
            {
                // Konfiguration auf Azure Comos DB Emulator
                // string endPoint = @"https://127.0.0.1:8888/";
                string endPoint = @"https://127.0.0.1:8081/";
                string authKey = @"C2y6yDjf5/R+ob0N8A7Cgv30VRDJIWEHLM+4QDU5DE2nQ9nDuVTqobD4b8mGGyPMbIZnqyMsEcaGQy67XIw/Jw==";
                string databaseName = @"EFDatabaseGuid";
                optionsBuilder
                    .EnableSensitiveDataLogging(true)
                    .ConfigureWarnings(c =>
                    {
                        // c.Throw(...);
                    })
                    .UseCosmos(endPoint, authKey, databaseName)
                    // .UseLoggerFactory(EFLoggerFactory.Instance)
                    ;
            }

            base.OnConfiguring(optionsBuilder);
        }

        protected override void OnModelCreating(ModelBuilder mb)
        {
            mb.Entity<SpeakerGuid>().ToContainer("CosmosDbContextGuid");

            mb.Entity<SessionGuid>(p =>
            {
                p.ToContainer("CosmosDbContextGuid");
            });

            mb.Entity<SpeakerGuid>().OwnsOne(p => p.MainExperience);

            mb.Entity<SpeakerGuid>().OwnsMany(p => p.Experiences);

            mb.Entity<TechEventGuid>().ToContainer("CosmosDbContextGuid");

            mb.Entity<SecredIdentityGuid>().ToContainer("CosmosDbContextGuid");

            mb.Entity<SpeakerSessionGuid>(e =>
            {
                e.ToContainer("CosmosDbContextGuid");

                e.HasKey(k => new { k.SpeakerId, k.SessionId });

                e.HasOne(s => s.Session)
                 .WithMany(s => s.SpeakerSessions)
                 .HasForeignKey(s => s.SessionId)
                 .OnDelete(DeleteBehavior.Cascade);

                e.HasOne(s => s.Speaker)
                 .WithMany(s => s.SpeakerSessions)
                 .HasForeignKey(s => s.SpeakerId)
                 .OnDelete(DeleteBehavior.Cascade);
            });

            base.OnModelCreating(mb);
        }
    }
}