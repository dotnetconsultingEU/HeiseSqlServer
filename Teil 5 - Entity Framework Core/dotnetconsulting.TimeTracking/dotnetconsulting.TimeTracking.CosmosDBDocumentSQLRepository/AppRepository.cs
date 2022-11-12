// Disclaimer
// Dieser Quellcode ist als Vorlage oder als Ideengeber gedacht. Er kann frei und ohne 
// Auflagen oder Einschränkungen verwendet oder verändert werden.
// Jedoch wird keine Garantie übernommen, dass eine Funktionsfähigkeit mit aktuellen und 
// zukünftigen API-Versionen besteht. Der Autor übernimmt daher keine direkte oder indirekte 
// Verantwortung, wenn dieser Code gar nicht oder nur fehlerhaft ausgeführt wird.
// Für Anregungen und Fragen stehe ich jedoch gerne zur Verfügung.

// Thorsten Kansy, www.dotnetconsulting.eu

// Achtung! Wegen der Id/id- und Integer/GUID-Problematik nicht voll funktionsfähig!

using dotnetconsulting.TimeTracking.CosmosDBDocumentSQLRepository.ComosDB;
using dotnetconsulting.TimeTracking.Interfaces;
using dotnetconsulting.TimeTracking.Interfaces.Dtos;
using AutoMapper;
using dotnetconsulting.TimeTracking.CosmosDBDocumentSQLRepository.Automapper;
using Microsoft.Azure.Documents.Client;
using Microsoft.Azure.Documents.Linq;

namespace dotnetconsulting.TimeTracking.CosmosDBDocumentSQLRepository;

public class AppRepository : IAppRepository
{
    private readonly AppRepositoryCosmosSqlConfig _config;
    private readonly IMapper _mapper;

    public AppRepository(AppRepositoryCosmosSqlConfig Config)
    {
        _config = Config;
        _mapper = new MapperConfiguration(cfg =>
        {
            cfg.AddProfile(new MapperProfile());
        }).CreateMapper();
    }

    private DocumentClient createDocumentClient()
    {
        return new DocumentClient(new Uri(_config.Endpoint), _config.Key, new ConnectionPolicy
        {
            EnableEndpointDiscovery = false
        });
    }

    public async Task DeleteTrackingEntryAsync(int EntryId, CancellationToken cancellationToken)
    {
        // Daten löschen
        using DocumentClient documentClient = createDocumentClient();

        await documentClient.DeleteDocumentAsync(UriFactory.CreateDocumentUri(_config.DatabaseId, _config.CollectionId, EntryId.ToString()), cancellationToken: cancellationToken).ConfigureAwait(false);
        cancellationToken.ThrowIfCancellationRequested();
    }

    public async Task<bool> AnyEntryOnDate(int Id, DateTime Date, CancellationToken cancellationToken)
    {
        // Daten abfragen
        using DocumentClient documentClient = createDocumentClient();

        IDocumentQuery<Entry> query = documentClient.CreateDocumentQuery<Entry>(
        UriFactory.CreateDocumentCollectionUri(_config.DatabaseId, _config.CollectionId),
        new FeedOptions { MaxItemCount = -1 })
            .Where(w => (w.Id != Id.ToString() && w.Day == new DateTime(Date.Year, Date.Month, Date.Day)))
            .AsDocumentQuery();

        var rawResult = await query.ExecuteNextAsync<Entry>(cancellationToken).ConfigureAwait(false);
        cancellationToken.ThrowIfCancellationRequested();

        return rawResult.Any();
    }

    public async Task<IList<CustomerDto>> GetCustomersAsync(CancellationToken cancellationToken)
    {
        IList<Customer> rawResult;

        // Daten abfragen
        using (DocumentClient documentClient = createDocumentClient())
        {
            IDocumentQuery<Customer> query = documentClient.CreateDocumentQuery<Customer>(
                UriFactory.CreateDocumentCollectionUri(_config.DatabaseId, _config.CollectionId),
                new FeedOptions { MaxItemCount = -1 })
                .Where(w => w.Discriminator == nameof(Customer))
                .AsDocumentQuery();

            rawResult = (await query.ExecuteNextAsync<Customer>(cancellationToken).ConfigureAwait(false)).ToList();
            cancellationToken.ThrowIfCancellationRequested();
        }

        // Mappen
        IList<CustomerDto> result = _mapper.Map<IList<CustomerDto>>(rawResult);

        // Rückgabe
        return result;
    }

    public async Task<IList<OrderDto>> GetOrdersAsync(CancellationToken cancellationToken)
    {
        IList<Order> rawOrderResult;

        // Daten abfragen
        using (DocumentClient documentClient = createDocumentClient())
        {
            IDocumentQuery<Order> query = documentClient.CreateDocumentQuery<Order>(
                UriFactory.CreateDocumentCollectionUri(_config.DatabaseId, _config.CollectionId),
                new FeedOptions { MaxItemCount = -1 })
                .Where(w => w.Discriminator == nameof(Order))
                .AsDocumentQuery();

            rawOrderResult = (await query.ExecuteNextAsync<Order>(cancellationToken).ConfigureAwait(false)).ToList();
            cancellationToken.ThrowIfCancellationRequested();
        }

        // Wir brauchen auch die Kunden. Die SQL-Grammatik von CosmosDB 
        // erlaubt keine Joins zwischen Entitäten.
        // Workaround mit kleiner Datenmenge

        // Kunden abfragen
        IList<Customer> rawCustomerResult;
        using (DocumentClient documentClient = createDocumentClient())
        {
            IDocumentQuery<Customer> query = documentClient.CreateDocumentQuery<Customer>(
                UriFactory.CreateDocumentCollectionUri(_config.DatabaseId, _config.CollectionId),
                new FeedOptions { MaxItemCount = -1 })
                .Where(w => w.Discriminator == nameof(Customer))
                .AsDocumentQuery();

            rawCustomerResult = (await query.ExecuteNextAsync<Customer>(cancellationToken).ConfigureAwait(false)).ToList();
            cancellationToken.ThrowIfCancellationRequested();
        }

        foreach (var item in rawOrderResult)
            item.Customer = rawCustomerResult.FirstOrDefault(w => w.Id == item.CustomerId);

        // Mappen
        IList<OrderDto> result = _mapper.Map<IList<OrderDto>>(rawOrderResult);

        // Rückgabe
        return result;
    }

    public async Task<IList<EntryDto>> GetTimeTrackingEntriesAsync(DateTime? Start, DateTime? End, int? OrderId, CancellationToken cancellationToken)
    {
        // Nullables werden nicht unterstützt.
        Start ??= new DateTime(2000, 1, 1);
        End ??= new DateTime(2099, 12, 31);
        OrderId ??= -1;

        IList<Entry> rawResult;
        using (DocumentClient documentClient = createDocumentClient())
        {
            // Daten abfragen
            IDocumentQuery<Entry> query = documentClient.CreateDocumentQuery<Entry>(
                UriFactory.CreateDocumentCollectionUri(_config.DatabaseId, _config.CollectionId),
                new FeedOptions { MaxItemCount = -1 })
                .Where(w => (w.Day >= Start.Value) &&
                            (w.Day <= End.Value) &&
                            (OrderId == -1 || w.Order.Id == OrderId.Value) &&
                            (w.Discriminator == nameof(Entry)))
                .AsDocumentQuery();

            rawResult = (await query.ExecuteNextAsync<Entry>(cancellationToken).ConfigureAwait(false)).ToList();
            cancellationToken.ThrowIfCancellationRequested();
        }

        // Mappen
        IList<EntryDto> result = _mapper.Map<IList<EntryDto>>(rawResult);

        // Rückgabe
        return result;
    }

    public async Task<EntryDto> GetTimeTrackingEntryAsync(int Id, CancellationToken cancellationToken)
    {
        Entry rawResult;

        // Daten abfragen
        using (DocumentClient documentClient = createDocumentClient())
        {
            IDocumentQuery<Entry> query = documentClient.CreateDocumentQuery<Entry>(
                UriFactory.CreateDocumentCollectionUri(_config.DatabaseId, _config.CollectionId),
                new FeedOptions { MaxItemCount = 1 })
                .Where(w => w.Discriminator == nameof(Entry))
                .AsDocumentQuery();

            rawResult = (await query.ExecuteNextAsync<Entry>(cancellationToken).ConfigureAwait(false)).FirstOrDefault()!;
            cancellationToken.ThrowIfCancellationRequested();
        }

        // Mappen
        EntryDto result = _mapper.Map<EntryDto>(rawResult);

        // Rückgabe
        return result;
    }

    public async Task StoreTrackingEntryAsync(EntryDto Entry, CancellationToken cancellationToken)
    {
        // Auf Entity mappen
        Entry entry = _mapper.Map<Entry>(Entry);

        using DocumentClient documentClient = createDocumentClient();
        // Anlegen oder aktualisieren?
        entry.Id = entry.Id != "0" ? entry.Id : createUniqueId().ToString();

        await documentClient.UpsertDocumentAsync(
            UriFactory.CreateDocumentCollectionUri(_config.DatabaseId, _config.CollectionId),
            entry, cancellationToken: cancellationToken).ConfigureAwait(false);
        cancellationToken.ThrowIfCancellationRequested();
    }

    /// <summary>
    /// 'Eindeutige' ID auf einfache Art und Weise
    /// </summary>
    /// <param name="discriminator">Um welche Art und welches Element handelt es sich?</param>
    /// <returns></returns>
    /// <remarks><c>discriminator</c> wird nicht verwendet.</remarks>
    private static int createUniqueId()
    {
        return rnd.Next(int.MinValue, int.MaxValue);
    }

    private static readonly Random rnd = new();
}