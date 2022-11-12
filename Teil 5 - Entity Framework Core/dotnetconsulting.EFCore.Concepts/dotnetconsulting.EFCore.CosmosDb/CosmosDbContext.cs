// Disclaimer
// Dieser Quellcode ist als Vorlage oder als Ideengeber gedacht. Er kann frei und ohne 
// Auflagen oder Einschränkungen verwendet oder verändert werden.
// Jedoch wird keine Garantie übernommen, dass eine Funktionsfähigkeit mit aktuellen und 
// zukünftigen API-Versionen besteht. Der Autor übernimmt daher keine direkte oder indirekte 
// Verantwortung, wenn dieser Code gar nicht oder nur fehlerhaft ausgeführt wird.
// Für Anregungen und Fragen stehe ich jedoch gerne zur Verfügung.

// Thorsten Kansy, www.dotnetconsulting.eu

using dotnetconsulting.EFCore.CosmosDb;
using dotnetconsulting.EFCore.Domains;
using Microsoft.EntityFrameworkCore;

namespace dotnetconsulting.EFCore.CosmosDbSql
{
    public class CosmosDbContext : DbContext
    {
        public CosmosDbContext(DbContextOptions Options) : base(Options)
        {
        }

        public CosmosDbContext()
        {
        }

        internal DbSet<Speaker> Speakers { get; set; }

        internal DbSet<Session> Sessions { get; set; }

        internal DbSet<TechEvent> TechEvents { get; set; }

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            if (!optionsBuilder.IsConfigured)
            {
                // Konfiguration auf Azure Comos DB Emulator
                string endPoint = @"https://localhost:8081";
                string authKey = @"C2y6yDjf5/R+ob0N8A7Cgv30VRDJIWEHLM+4QDU5DE2nQ9nDuVTqobD4b8mGGyPMbIZnqyMsEcaGQy67XIw/Jw==";
                string databaseName = @"EFDatabase";
                optionsBuilder
                    .EnableSensitiveDataLogging(true)
                    .UseCosmos(endPoint, authKey, databaseName)
                    // .UseLoggerFactory(EFLoggerFactory.Instance)
                    ;
            }

            base.OnConfiguring(optionsBuilder);
        }

        protected override void OnModelCreating(ModelBuilder mb)
        {
            mb.Entity<Speaker>().ToContainer("Elements");
            
            mb.Entity<Session>(p =>
            {
                p.ToContainer("Elements");

                // Bei 2.2 Preview 2 aktuell ein Problem mit Enums?
                p.Ignore(i => i.Difficulty);
            });

            mb.Entity<TechEvent>().ToContainer("Elements");

            mb.Entity<SecredIdentity>().ToContainer("Elements");

            mb.Entity<SpeakerSession>(e =>
            {
                e.ToContainer("Elements");

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