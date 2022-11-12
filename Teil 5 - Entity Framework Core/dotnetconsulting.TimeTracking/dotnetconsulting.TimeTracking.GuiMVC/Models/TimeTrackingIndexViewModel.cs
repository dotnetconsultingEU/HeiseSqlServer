// Disclaimer
// Dieser Quellcode ist als Vorlage oder als Ideengeber gedacht. Er kann frei und ohne 
// Auflagen oder Einschränkungen verwendet oder verändert werden.
// Jedoch wird keine Garantie übernommen, dass eine Funktionsfähigkeit mit aktuellen und 
// zukünftigen API-Versionen besteht. Der Autor übernimmt daher keine direkte oder indirekte 
// Verantwortung, wenn dieser Code gar nicht oder nur fehlerhaft ausgeführt wird.
// Für Anregungen und Fragen stehe ich jedoch gerne zur Verfügung.

// Thorsten Kansy, www.dotnetconsulting.eu

using Microsoft.AspNetCore.Mvc.Rendering;
using System.ComponentModel.DataAnnotations;

namespace dotnetconsulting.TimeTracking.GuiMVC.Models;

public class TimeTrackingIndexViewModel
{
    public IEnumerable<TimeTrackingEntryViewModel> List { get; set; } = null!;

    public IEnumerable<SelectListItem> Orders { get; set; } = null!;

    [Display(Name = "Auftrag")]
    public int? OrderId { get; set; }

    [Display(Name = "Von")]
    [DataType(DataType.Date)]
    [DisplayFormat(ConvertEmptyStringToNull = true)]
    public DateTime? FilterStart { get; set; }

    [Display(Name = "Bis")]
    [DataType(DataType.Date)]
    [DisplayFormat(ConvertEmptyStringToNull = true)]
    public DateTime? FilterEnd { get; set; }
}

public class TimeTrackingEntryViewModel
{
    public int Id { get; set; }

    [Display(Name = "Auftrag")]
    public string CustomerAndOrder { get; set; } = null!;

    [Display(Name = "Start")]
    [DisplayFormat(DataFormatString = @"{0:hh\:mm}", ApplyFormatInEditMode = true)]
    public TimeSpan Start { get; set; }

    [Display(Name = "Ende")]
    [DisplayFormat(DataFormatString = @"{0:hh\:mm}", ApplyFormatInEditMode = true)]
    public TimeSpan End { get; set; }

    [Display(Name = "Pause")]
    [DisplayFormat(DataFormatString = @"{0:hh\:mm}")]
    public TimeSpan Break { get; set; }

    [Display(Name = "Dauer")]
    [DisplayFormat(DataFormatString = @"{0:hh\:mm}")]
    public TimeSpan Duration => (End - Start - Break);

    [Display(Name = "Buchung am")]
    [DataType(DataType.Date)]
    public DateTime Day { get; set; }

    [Display(Name = "Ort")]
    public string Place { get; set; } = null!;

    [Display(Name = "Beschreibung")]
    public string Description { get; set; } = null!;
}