// Disclaimer
// Dieser Quellcode ist als Vorlage oder als Ideengeber gedacht. Er kann frei und ohne 
// Auflagen oder Einschränkungen verwendet oder verändert werden.
// Jedoch wird keine Garantie übernommen, dass eine Funktionsfähigkeit mit aktuellen und 
// zukünftigen API-Versionen besteht. Der Autor übernimmt daher keine direkte oder indirekte 
// Verantwortung, wenn dieser Code gar nicht oder nur fehlerhaft ausgeführt wird.
// Für Anregungen und Fragen stehe ich jedoch gerne zur Verfügung.

// Thorsten Kansy, www.dotnetconsulting.eu

using Microsoft.EntityFrameworkCore;

namespace dotnetconsulting.TimeTracking.EFRepository.EntityFramework;

public class TimeTrackingContext : DbContext
{
    public TimeTrackingContext(DbContextOptions Options) : base(Options)
    {
    }

    public TimeTrackingContext()
    {
    }

    internal DbSet<Entry>? Entries { get; set; }

    internal DbSet<Order>? Orders { get; set; }

    internal DbSet<Customer>? Customers { get; set; }

    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
    {
        if (!optionsBuilder.IsConfigured)
        {
            optionsBuilder.UseSqlServer(@"Server=(localdb)\mssqllocaldb;Database=TimeTracking;Integrated Security=true;Application name=TimeTracker;");
        }
        base.OnConfiguring(optionsBuilder);
    }

    protected override void OnModelCreating(ModelBuilder mb)
    {
        mb.HasDefaultSchema("TimeTracking");

        mb.Entity<Customer>(e =>
        {
            e.ToTable("Customers");
            e.HasKey(k => k.Id);
            e.HasQueryFilter(f => f.IsActive == true);

            e.Property(p => p.Displayname)
            .IsRequired()
            .IsUnicode(false)
            .HasMaxLength(50);

            e.Property(p => p.Comment)
            .IsRequired(false)
            .IsUnicode(false)
            .HasMaxLength(200);

            e.Property(p => p.IsActive)
            .HasDefaultValue(true);
        });

        mb.Entity<Order>(e =>
        {
            e.ToTable("Orders");
            e.HasKey(k => k.Id);

            e.Property(p => p.OrderNr)
            .IsRequired()
            .IsUnicode(false)
            .HasMaxLength(50);

            e.Property(p => p.Description)
            .IsRequired(false)
            .IsUnicode(false)
            .HasMaxLength(50);

            e.Property(p => p.Created)
            .IsRequired()
            .HasColumnType("date")
            .HasDefaultValueSql("getdate()");

            e.HasOne(p => p.Customer)
            .WithMany(p => p.Orders)
            .OnDelete(DeleteBehavior.Cascade);
        });

        mb.Entity<Entry>(e =>
        {
            e.ToTable("Entries");
            e.HasKey(k => k.Id);

            e.Property(p => p.Day)
            .IsRequired()
            .HasColumnType("date")
            .HasDefaultValueSql("getdate()");

            e.Property(p => p.Start)
            .IsRequired()
            .HasColumnType("time");

            e.Property(p => p.End)
            .IsRequired()
            .HasColumnType("time");

            e.Property(p => p.Break)
            .IsRequired(false)
            .HasColumnType("time")
            .HasDefaultValue(new TimeSpan(0));

            e.Property(p => p.Place)
            .IsRequired()
            .IsUnicode(false)
            .HasMaxLength(50);

            e.Property(p => p.Description)
            .IsRequired()
            .IsUnicode(false)
            .HasMaxLength(250);

            e.Property(p => p.CreatedOrModified)
            .IsRequired()
            .HasColumnType("datetime")
            .HasDefaultValueSql("getdate()");

            e.HasOne(p => p.Order)
            .WithMany(o => o.Entires)
            .HasForeignKey(p => p.OrderId)
            .OnDelete(DeleteBehavior.Cascade);
        });

        // (Demo-)Daten
        // setupData(mb);

        base.OnModelCreating(mb);
    }

#pragma warning disable IDE0051 // Remove unused private members
    private static void setupData(ModelBuilder mb)
    {
        // Vollständer Inhalt unter \Content\TimeTracking.sql\
        // Kunden
        Customer customer1 = new() { Id = 1, Displayname = "Customer 1", IsActive = true };
        Customer customer2 = new() { Id = 2, Displayname = "Customer 2", IsActive = true };

        mb.Entity<Customer>().HasData(customer1, customer2);

        mb.Entity<Order>().HasData(
            new Order() { Id = 1, CustomerId = 1, OrderNr = "123", Description = "Order 1" },
            new Order() { Id = 2, CustomerId = 1, OrderNr = "234", Description = "Order 2" },
            new Order() { Id = 3, CustomerId = 2, OrderNr = "345", Description = "Order 3" },
            new Order() { Id = 4, CustomerId = 2, OrderNr = "456", Description = "Order 4" }
            );
    }
#pragma warning restore IDE0051 // Remove unused private members
}