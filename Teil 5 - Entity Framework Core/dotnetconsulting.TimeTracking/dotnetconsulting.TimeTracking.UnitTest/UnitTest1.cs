// Disclaimer
// Dieser Quellcode ist als Vorlage oder als Ideengeber gedacht. Er kann frei und ohne 
// Auflagen oder Einschränkungen verwendet oder verändert werden.
// Jedoch wird keine Garantie übernommen, dass eine Funktionsfähigkeit mit aktuellen und 
// zukünftigen API-Versionen besteht. Der Autor übernimmt daher keine direkte oder indirekte 
// Verantwortung, wenn dieser Code gar nicht oder nur fehlerhaft ausgeführt wird.
// Für Anregungen und Fragen stehe ich jedoch gerne zur Verfügung.

// Thorsten Kansy, www.dotnetconsulting.eu

using dotnetconsulting.TimeTracking.Interfaces;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Microsoft.Extensions.DependencyInjection;
using dotnetconsulting.TimeTracking.EFRepository.EntityFramework;
using System.Diagnostics;
using dotnetconsulting.TimeTracking.Interfaces.Dtos;

namespace dotnetconsulting.TimeTracking.UnitTests;

[TestClass]
public class UnitTest1
{
    #region Initialize & Deinitialize
    IServiceScope scope = null!;
    private IAppLogic logic = null!;
    private CancellationToken cancellationToken;

    [TestInitialize]
    public void TestInitialize()
    {
        Debug.Assert(scope == null);
        scope = Setup.serviceProvider.CreateScope();

        IServiceProvider sericeProvider = scope.ServiceProvider;
        logic = sericeProvider.GetService<IAppLogic>()!;

        // Testdaten erzeugen
        TimeTrackingContext context = sericeProvider.GetService<TimeTrackingContext>()!;
        context.Database.EnsureCreated();

        // Cancellation Token Erzeugen
        CancellationTokenSource source = new();
        cancellationToken = source.Token;
    }

    [TestCleanup]
    public void TestDeinitialize()
    {
        logic = null!;
        scope?.Dispose();
        scope = null!;
    }
    #endregion

    [TestMethod]
    public void TestOrdersCount()
    {
        // Arange
        // ...

        // Act
        var orders = logic.GetOrdersAsync(cancellationToken).GetAwaiter().GetResult();

        // Assert
        Assert.IsTrue(orders.Count == 4);
    }

    [TestMethod]
    public void TestCustomersCount()
    {
        // Arange
        // ...

        // Act
        var orders = logic.GetCustomersAsync(cancellationToken).GetAwaiter().GetResult();

        // Assert
        Assert.IsTrue(orders.Count == 2);
    }

    [TestMethod]
    public void TestAddTimeTrackingEntry1()
    {
        // Arange
        OrderDto order = logic.GetOrdersAsync(cancellationToken).GetAwaiter().GetResult().First();

        // Act
        // Speichern...
        EntryDto timeTracking = new()
        {
            Day = DateTime.Today,
            Description = "Unit test",
            Start = new TimeSpan(9, 0, 0),
            End = new TimeSpan(11, 30, 0),
            Break = new TimeSpan(0, 30, 0),
            OrderId = order.Id
        };
        logic.StoreTimeTrackingAsync(timeTracking, cancellationToken).Wait();
        // ... und wieder laden
        EntryDto newTimeTracking = logic.GetTimeTrackingEntryAsync(0, cancellationToken).GetAwaiter().GetResult();

        // Assert
        Assert.IsTrue(newTimeTracking.Id == 0);
        Assert.IsTrue(newTimeTracking.Description == timeTracking.Description);
        Assert.IsTrue(newTimeTracking.Start == timeTracking.Start);
        Assert.IsTrue(newTimeTracking.End == timeTracking.End);
        Assert.IsTrue(newTimeTracking.Break == timeTracking.Break);
    }

    [TestMethod]
    public void TestAddTimeTrackingEntry2()
    {
        // Arange
        int oldTimeTrackingeCount = logic.GetTimeTrackingEntriesAsync(null, null, null, cancellationToken).GetAwaiter().GetResult().Count;
        OrderDto order = logic.GetOrdersAsync(cancellationToken).GetAwaiter().GetResult().First();

        // Act
        EntryDto newTimeTracking = new()
        {
            Day = DateTime.Today,
            Description = "Unit test",
            Start = new TimeSpan(9, 0, 0),
            End = new TimeSpan(11, 30, 0),
            Break = new TimeSpan(0, 30, 0),
            OrderId = order.Id,
            Id = 100
        };
        logic.StoreTimeTrackingAsync(newTimeTracking, cancellationToken).Wait();

        int newTimeTrackingeCount = logic.GetTimeTrackingEntriesAsync(null, null, null, cancellationToken).GetAwaiter().GetResult().Count;

        // Assert
        Assert.IsTrue(oldTimeTrackingeCount == newTimeTrackingeCount - 1);
    }

    [TestMethod]
    public void TestAddTimeTrackingEntry3()
    {
        // ToDo: Weitere Tests schreiben (Übung)

        // Arange

        // Act

        // Assert
    }
}