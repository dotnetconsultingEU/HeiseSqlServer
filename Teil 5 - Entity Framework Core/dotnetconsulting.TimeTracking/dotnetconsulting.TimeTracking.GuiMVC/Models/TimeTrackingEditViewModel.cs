// Disclaimer
// Dieser Quellcode ist als Vorlage oder als Ideengeber gedacht. Er kann frei und ohne 
// Auflagen oder Einschränkungen verwendet oder verändert werden.
// Jedoch wird keine Garantie übernommen, dass eine Funktionsfähigkeit mit aktuellen und 
// zukünftigen API-Versionen besteht. Der Autor übernimmt daher keine direkte oder indirekte 
// Verantwortung, wenn dieser Code gar nicht oder nur fehlerhaft ausgeführt wird.
// Für Anregungen und Fragen stehe ich jedoch gerne zur Verfügung.

// Thorsten Kansy, www.dotnetconsulting.eu

using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using System.ComponentModel.DataAnnotations;

namespace dotnetconsulting.TimeTracking.GuiMVC.Models;

public class TimeTrackingEditViewModel : IValidatableObject
{
    [HiddenInput]
    public int Id { get; set; }

    public bool IsNewEntry => OrderId == null;

    public IEnumerable<SelectListItem>? Orders { get; set; }

    [Display(Name = "Auftrag")]
    [Required]
    public int? OrderId { get; set; }

    [Display(Name = "Start")]
    [DataType(DataType.Time)]
    [Required]
    [DisplayFormat(DataFormatString = @"{0:hh\:mm}", ApplyFormatInEditMode = true)]
    public TimeSpan? Start { get; set; }

    [Display(Name = "Ende")]
    [DataType(DataType.Time)]
    [Required]
    [DisplayFormat(DataFormatString = @"{0:hh\:mm}", ApplyFormatInEditMode = true)]
    public TimeSpan? End { get; set; }

    [Display(Name = "Pause")]
    [DataType(DataType.Duration)]
    [Required]
    [DisplayFormat(DataFormatString = @"{0:hh\:mm}")]
    public TimeSpan? Break { get; set; }

    [Display(Name = "Buchung am")]
    [DataType(DataType.Date)]
    [Required]
    public DateTime Day { get; set; }

    [Display(Name = "Ort")]
    [Required, MaxLength(50)]
    public string Place { get; set; } = null!;

    [Display(Name = "Beschreibung!")]
    [Required]
    [MaxLength(250)]
    public string Description { get; set; } = null!;

    public IEnumerable<ValidationResult> Validate(ValidationContext validationContext)
    {
        if (Start > End)
            yield return new ValidationResult("Start muss vor Ende liegen.", new string[] { nameof(Start), nameof(End) });

        if ((End - Start - Break)!.Value.TotalMinutes < 5)
            yield return new ValidationResult("Dauer muss mindestens 5 Minuten betragen.", Array.Empty<string>());
    }
}