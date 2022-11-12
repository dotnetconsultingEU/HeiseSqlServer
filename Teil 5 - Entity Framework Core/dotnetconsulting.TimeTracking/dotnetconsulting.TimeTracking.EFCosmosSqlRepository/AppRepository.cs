// Disclaimer
// Dieser Quellcode ist als Vorlage oder als Ideengeber gedacht. Er kann frei und ohne 
// Auflagen oder Einschränkungen verwendet oder verändert werden.
// Jedoch wird keine Garantie übernommen, dass eine Funktionsfähigkeit mit aktuellen und 
// zukünftigen API-Versionen besteht. Der Autor übernimmt daher keine direkte oder indirekte 
// Verantwortung, wenn dieser Code gar nicht oder nur fehlerhaft ausgeführt wird.
// Für Anregungen und Fragen stehe ich jedoch gerne zur Verfügung.

// Thorsten Kansy, www.dotnetconsulting.eu

using AutoMapper;
using dotnetconsulting.TimeTracking.EFCosmosSqlRepository.Automapper;
using dotnetconsulting.TimeTracking.EFCosmosSqlRepository.EntityFramework;
using dotnetconsulting.TimeTracking.Interfaces;
using dotnetconsulting.TimeTracking.Interfaces.Dtos;
using Microsoft.EntityFrameworkCore;

namespace dotnetconsulting.TimeTracking.EFCosmosSqlRepository;

public class AppRepository : IAppRepository
{
    private readonly TimeTrackingComosDBContext _context;
    private readonly IMapper _mapper;

    public AppRepository(TimeTrackingComosDBContext Context)
    {
        _context = Context;
        _mapper = new MapperConfiguration(cfg =>
        {
            cfg.AddProfile(new MapperProfile());
        }).CreateMapper();
    }

    public async Task DeleteTrackingEntryAsync(int EntryId, CancellationToken cancellationToken)
    {
        // Daten abfragen
        var rawResult = await _context.Entries.FindAsync(new object[] { EntryId }, cancellationToken).ConfigureAwait(false);
        cancellationToken.ThrowIfCancellationRequested();

        // Wenn es die Entität gibt, dann löschen
        _context.Entries.Remove(rawResult!);

        // Speichern
        await _context.SaveChangesAsync(cancellationToken).ConfigureAwait(false);
        cancellationToken.ThrowIfCancellationRequested();
    }

    public async Task<bool> AnyEntryOnDate(int Id, DateTime Date, CancellationToken cancellationToken)
    {
        // Abfrage
        bool result = await _context.Entries.AnyAsync(w => w.Id != Id && w.Day == new DateTime(Date.Year, Date.Month, Date.Day), cancellationToken).ConfigureAwait(false);
        cancellationToken.ThrowIfCancellationRequested();

        // Rückgabe
        return result;
    }

    public async Task<IList<CustomerDto>> GetCustomersAsync(CancellationToken cancellationToken)
    {
        // Daten abfragen
        var query = _context.Customers;

        // Ergebnis abrufen
        IList<Customer> rawResult = await query.ToListAsync(cancellationToken).ConfigureAwait(false);
        cancellationToken.ThrowIfCancellationRequested();

        // Mappen
        IList<CustomerDto> result = _mapper.Map<IList<CustomerDto>>(rawResult);

        // Rückgabe
        return result;
    }

    public async Task<IList<OrderDto>> GetOrdersAsync(CancellationToken cancellationToken)
    {
        // Daten abfragen
        var query = _context.Orders;

        // Ergebnis abrufen
        IList<Order> rawResult = await query.ToListAsync(cancellationToken).ConfigureAwait(false);
        cancellationToken.ThrowIfCancellationRequested();

        // Mappen
        IList<OrderDto> result = _mapper.Map<IList<OrderDto>>(rawResult);

        // Rückgabe
        return result;
    }

    public async Task<IList<EntryDto>> GetTimeTrackingEntriesAsync(DateTime? Start, DateTime? End, int? OrderId, CancellationToken cancellationToken)
    {
        // Daten abfragen
        var query = _context.Entries
            .Where(w => (Start == null || w.Day >= Start.Value) &&
                        (End == null || w.Day <= End.Value) &&
                        (OrderId == null || w.Order.Id == OrderId.Value));

        // Ergebnis abrufen
        var rawResult = await query.ToListAsync(cancellationToken).ConfigureAwait(false);
        cancellationToken.ThrowIfCancellationRequested();

        // Mappen
        IList<EntryDto> result = _mapper.Map<IList<EntryDto>>(rawResult);

        // Rückgabe
        return result;
    }

    public async Task<EntryDto> GetTimeTrackingEntryAsync(int Id, CancellationToken cancellationToken)
    {
        // Daten abfragen
        var rawResult = await _context.Entries.FindAsync(new object[] { Id }, cancellationToken).ConfigureAwait(false);
        cancellationToken.ThrowIfCancellationRequested();

        // Mappen
        EntryDto result = _mapper.Map<EntryDto>(rawResult);

        // Rückgabe
        return result;
    }

    public async Task StoreTrackingEntryAsync(EntryDto Entry, CancellationToken cancellationToken)
    {
        // Auf EF Entity mappen
        Entry entry = _mapper.Map<Entry>(Entry);

        // Daten abfragen
        var rawResult = await _context.Entries.FindAsync(new object[] { entry.Id }, cancellationToken).ConfigureAwait(false);
        cancellationToken.ThrowIfCancellationRequested();

        // Neu anlegen?
        if (rawResult == null)
        {
            // Neu anlegen, wenn noch nicht vorhanden
            entry.Id = createUniqueId();

            rawResult = _context.Entries.Add(entry).Entity;
        }

        // Aktualisieren
        _mapper.Map(entry, rawResult);

        rawResult.CreatedOrModified = DateTime.Now;

        // Speichern
        await _context.SaveChangesAsync(cancellationToken).ConfigureAwait(false);
        cancellationToken.ThrowIfCancellationRequested();
    }

    private static readonly Random rnd = new();
    private static int createUniqueId()
    {
        return rnd.Next(int.MinValue, int.MaxValue);
    }
}