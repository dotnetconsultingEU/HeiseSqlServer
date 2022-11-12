// Disclaimer
// Dieser Quellcode ist als Vorlage oder als Ideengeber gedacht. Er kann frei und ohne 
// Auflagen oder Einschränkungen verwendet oder verändert werden.
// Jedoch wird keine Garantie übernommen, dass eine Funktionsfähigkeit mit aktuellen und 
// zukünftigen API-Versionen besteht. Der Autor übernimmt daher keine direkte oder indirekte 
// Verantwortung, wenn dieser Code gar nicht oder nur fehlerhaft ausgeführt wird.
// Für Anregungen und Fragen stehe ich jedoch gerne zur Verfügung.

// Thorsten Kansy, www.dotnetconsulting.eu

using AutoMapper;
using dotnetconsulting.TimeTracking.BlazorWASM.Shared;
using dotnetconsulting.TimeTracking.Interfaces;
using dotnetconsulting.TimeTracking.Interfaces.Dtos;
using Microsoft.AspNetCore.Mvc;

namespace dotnetconsulting.TimeTracking.BlazorWASM.Server.Controllers;

[ApiController]
[Route("[controller]")]
public class TimeTrackingController : Controller
{
    private readonly IAppLogic _appLogic;
    private readonly IMapper _mapper;
    private readonly ILogger<TimeTrackingController> _logger;

    public TimeTrackingController(IAppLogic AppLogic,
                                  IMapper Mapper,
                                  ILogger<TimeTrackingController> Logger)
    {
        _appLogic = AppLogic;
        _mapper = Mapper;
        _logger = Logger;
    }

    [HttpGet("Orders")]
    public async Task<ActionResult<IEnumerable<Order>>> Orders(CancellationToken cancellationToken)
    {
        // Daten abfragen
        IList<OrderDto> listOrder = await _appLogic.GetOrdersAsync(cancellationToken).ConfigureAwait(false);
        cancellationToken.ThrowIfCancellationRequested();

        // Mappen
        IEnumerable<Order> result = _mapper.Map<IEnumerable<Order>>(listOrder);

        // Rückgabe
        return Ok(result);
    }

    [HttpGet("Entries")]
    public async Task<ActionResult<IEnumerable<Entry>>> Entries(CancellationToken cancellationToken, DateTime? Start = null, DateTime? End = null, int? OrderId = null)
    {
        // Daten abfragen
        IList<EntryDto> listEntries = await _appLogic.GetTimeTrackingEntriesAsync(Start, End, OrderId, cancellationToken).ConfigureAwait(false);
        cancellationToken.ThrowIfCancellationRequested();

        // Mappen
        IEnumerable<Entry> result = _mapper.Map<IEnumerable<Entry>>(listEntries);

        // Rückgabe
        return Ok(result);
    }

    [HttpGet("Entry")]
    public async Task<ActionResult<Entry>> GetEntry(int Id, CancellationToken cancellationToken)
    {
        _logger.LogInformation("GetEntry({Id})", Id);

        // Daten abfragen
        EntryDto entry = await _appLogic.GetTimeTrackingEntryAsync(Id, cancellationToken).ConfigureAwait(false);
        cancellationToken.ThrowIfCancellationRequested();

        // Mappen
        Entry result = _mapper.Map<Entry>(entry);

        // Fertig
        return Ok(result);
    }

    [HttpPost("Entry")]
    public async Task<ActionResult> StoreEntry(Entry Entry, CancellationToken cancellationToken)
    {
        _logger.LogInformation("StoreEntry({Entry})", Entry);

        // Mappen
        EntryDto entry = _mapper.Map<EntryDto>(Entry);

        // Zugriff auf die Business Logic
        await _appLogic.StoreTimeTrackingAsync(entry, cancellationToken).ConfigureAwait(false);
        cancellationToken.ThrowIfCancellationRequested();

        // Fertig
        return Ok();
    }

    [HttpDelete("Entry")]
    public async Task<IActionResult> DeleteEntry(int Id, CancellationToken cancellationToken)
    {
        _logger.LogInformation("DeleteEntry({Id})", Id);

        // Zugriff auf die Business Logic
        await _appLogic.DeleteTimeTrackingAsync(Id, cancellationToken).ConfigureAwait(false);
        cancellationToken.ThrowIfCancellationRequested();

        // Fertig
        return Ok();
    }

    [HttpGet("AnyEntryOnDate")]
    public async Task<ActionResult<SimpleResult<bool>>> AnyEntryOnDate(int Id, long Date, CancellationToken cancellationToken)
    {
        _logger.LogInformation("AnyEntryOnDate({Id}, {Date})", Id, Date);

        // Zugriff auf die Business Logic
        SimpleResult<bool> result = new()
        {
            Value = await _appLogic.AnyEntryOnDateAsync(Id, new DateTime(Date), cancellationToken).ConfigureAwait(false)
        };
        cancellationToken.ThrowIfCancellationRequested();

        // Fertig
        return Ok(result);
    }
}