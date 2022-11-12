// Disclaimer
// Dieser Quellcode ist als Vorlage oder als Ideengeber gedacht. Er kann frei und ohne 
// Auflagen oder Einschränkungen verwendet oder verändert werden.
// Jedoch wird keine Garantie übernommen, dass eine Funktionsfähigkeit mit aktuellen und 
// zukünftigen API-Versionen besteht. Der Autor übernimmt daher keine direkte oder indirekte 
// Verantwortung, wenn dieser Code gar nicht oder nur fehlerhaft ausgeführt wird.
// Für Anregungen und Fragen stehe ich jedoch gerne zur Verfügung.

// Thorsten Kansy, www.dotnetconsulting.eu

using dotnetconsulting.EFCore.SpatialExtention.Domains;
using Microsoft.EntityFrameworkCore;

namespace dotnetconsulting.EFCore.SpatialExtention;

public class Context : DbContext
{
    public Context(DbContextOptions Options) : base(Options)
    {

    }

    public Context()
    {

    }

    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
    {
        if (!optionsBuilder.IsConfigured)
        {
            optionsBuilder
                 .UseSqlServer(
                   @"Server=(localdb)\mssqllocaldb;Database=MessdatenDb;Trusted_Connection=True",
                   sqlOptions => sqlOptions.UseNetTopologySuite());

        }
        base.OnConfiguring(optionsBuilder);
    }

    protected override void OnModelCreating(ModelBuilder mb)
    {
        mb.Entity<Messpunkt>().ToTable("Messpunkte");

        base.OnModelCreating(mb);
    }

    public DbSet<Messpunkt> Messpunkte { get; set; }
}