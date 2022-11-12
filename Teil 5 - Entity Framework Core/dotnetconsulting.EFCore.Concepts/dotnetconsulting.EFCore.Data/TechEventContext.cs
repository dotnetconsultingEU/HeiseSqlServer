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
using Microsoft.EntityFrameworkCore.Diagnostics;
using Microsoft.EntityFrameworkCore.Infrastructure;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Logging;

namespace dotnetconsulting.EFCore.Data
{
    public class TechEventContext : DbContext
    {
        //private readonly IConfigurationRoot configuration;

        //public TechEventContext(IConfigurationRoot configuration)
        //{
        //    this.configuration = configuration;
        //}

        public DbSet<TechEvent> TechEvents { get; set; }
        public DbSet<Session> Sessions { get; set; }
        public DbSet<Speaker> Speakers { get; set; }
        public DbSet<SpeakerSession> SpeakerSession { get; set; }

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            string conString = @"Server=.;Database=dotnetconsulting.TechEvents;Trusted_Connection=True;MultipleActiveResultSets=true;";
            optionsBuilder.UseSqlServer(conString);
            optionsBuilder.ConfigureWarnings(w =>
            {
                w.Throw(RelationalEventId.QueryPossibleUnintendedUseOfEqualsWarning);
            });
            optionsBuilder.LogToConsole();
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<SpeakerSession>()
                .HasKey(w => new { w.SessionId, w.SpeakerId });

            modelBuilder.Entity<SpeakerSession>()
                .Property(p => p.Tag)
                .IsUnicode(false)
                .IsRequired(true)
                .HasMaxLength(20);

            modelBuilder.Entity<SpeakerSession>()
                .HasAlternateKey(a => a.Tag);

            modelBuilder.Entity<SpeakerSession>()
                .HasIndex(a => a.Tag)
                .IsUnique();

            modelBuilder.Entity<Speaker>()
                .Property(p => p.Name)
                .IsUnicode(false)
                .HasDefaultValue("???")
                .HasMaxLength(50);

            //modelBuilder.Entity<Speaker>()
            //    .HasOne(o => o.SecredIdentity);

            base.OnModelCreating(modelBuilder);
        }
    }


    public static class DbContextExtensions
    {
        public static void LogToConsole(this DbContextOptionsBuilder contextOptionsBuilder)
        {
            var loggerFactory = LoggerFactory.Create(builder => {
                builder.AddFilter("Microsoft", LogLevel.Warning)
                       .AddFilter("System", LogLevel.Warning)
                       .AddFilter("SampleApp.Program", LogLevel.Debug)
                       .AddConsole();
            });

            contextOptionsBuilder.UseLoggerFactory(loggerFactory);
        }
    }
}