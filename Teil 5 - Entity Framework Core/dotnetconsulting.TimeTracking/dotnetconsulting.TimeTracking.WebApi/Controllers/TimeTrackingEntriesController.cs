// Disclaimer
// Dieser Quellcode ist als Vorlage oder als Ideengeber gedacht. Er kann frei und ohne 
// Auflagen oder Einschränkungen verwendet oder verändert werden.
// Jedoch wird keine Garantie übernommen, dass eine Funktionsfähigkeit mit aktuellen und 
// zukünftigen API-Versionen besteht. Der Autor übernimmt daher keine direkte oder indirekte 
// Verantwortung, wenn dieser Code gar nicht oder nur fehlerhaft ausgeführt wird.
// Für Anregungen und Fragen stehe ich jedoch gerne zur Verfügung.

// Thorsten Kansy, www.dotnetconsulting.eu

using dotnetconsulting.TimeTracking.Interfaces;
using Microsoft.AspNetCore.Mvc;

namespace dotnetconsulting.TimeTracking.WebApi.Controllers;

[Route("api/[controller]")]
[ApiController]
public class TimeTrackingEntriesController : ControllerBase
{
    private readonly IAppLogic _appLogic;

    public TimeTrackingEntriesController(IAppLogic AppLogic)
    {
        _appLogic = AppLogic;
    }

    // GET api/TimeTrackingEntries?s=07-01-2018&e=07-30-2018&order=99
    [HttpGet()]
    public async Task<IActionResult> Get([FromQuery(Name = "s")] DateTime? Start, [FromQuery(Name = "e")] DateTime? End, [FromQuery(Name = "order")] int? OrderId, CancellationToken cancellationToken)
    {
        var result = await _appLogic.GetTimeTrackingEntriesAsync(Start, End, OrderId, cancellationToken);

        return Ok(result);
    }

    // DELETE api/TimeTrackingEntries?Id=99
    [HttpDelete("{id}")]
    public async Task Delete(int Id, CancellationToken cancellationToken)
    {
        await _appLogic.DeleteTimeTrackingAsync(Id, cancellationToken);
    }
}