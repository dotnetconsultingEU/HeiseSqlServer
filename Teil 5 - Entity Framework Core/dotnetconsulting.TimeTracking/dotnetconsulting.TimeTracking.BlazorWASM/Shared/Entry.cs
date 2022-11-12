// Disclaimer
// Dieser Quellcode ist als Vorlage oder als Ideengeber gedacht. Er kann frei und ohne 
// Auflagen oder Einschränkungen verwendet oder verändert werden.
// Jedoch wird keine Garantie übernommen, dass eine Funktionsfähigkeit mit aktuellen und 
// zukünftigen API-Versionen besteht. Der Autor übernimmt daher keine direkte oder indirekte 
// Verantwortung, wenn dieser Code gar nicht oder nur fehlerhaft ausgeführt wird.
// Für Anregungen und Fragen stehe ich jedoch gerne zur Verfügung.

// Thorsten Kansy, www.dotnetconsulting.eu
#nullable disable

using System.ComponentModel.DataAnnotations;

namespace dotnetconsulting.TimeTracking.BlazorWASM.Shared;

public class Entry : IValidatableObject
{
    public int Id { get; set; }

#pragma warning disable CS8632 // The annotation for nullable reference types should only be used in code within a '#nullable' annotations context.
    public Order? Order { get; set; }
#pragma warning restore CS8632 // The annotation for nullable reference types should only be used in code within a '#nullable' annotations context.

    [Range(1, int.MaxValue, ErrorMessage = "Bitte Auftrag auswählen.")]
    public int OrderId { get; set; }

    [Required]
    public DateTime Start { get; set; }

    [Required]
    public DateTime End { get; set; }

    [Required]
    public DateTime Break { get; set; }

    public DateTime Duration
    {
        get
        {
            int start = Start.Hour * 60 + Start.Minute;
            int end = End.Hour * 60 + End.Minute;
            int @break = Break.Hour * 60 + Break.Minute;
            int duration = end - start - @break;

            //// Werte in die Konsole des Browsers ausgeben
            //Console.WriteLine($"Start: {Start}");
            //Console.WriteLine($"End: {End}");
            //Console.WriteLine($"@break: {@break}");
            //Console.WriteLine($"duration: {duration}");

            //// Werte in das Output-Fenster 
            //Debug.Print($"Start: {Start}");
            //Debug.Print($"End: {End}");
            //Debug.Print($"@break: {@break}");
            //Debug.Print($"duration: {duration}");

            if (duration < 0)
                duration = 0;
            return new DateTime(TimeSpan.FromMinutes(duration).Ticks);
        }
    }

    public DateTime Day { get; set; }

    [Required(AllowEmptyStrings = false, ErrorMessage = "Bitte Ort angeben."), MinLength(5, ErrorMessage = "Bitte mindestens 5 Zeichen.")]
    public string Place { get; set; } = null!;

    [Required(AllowEmptyStrings = false, ErrorMessage = "Bitte Beschreibung angeben."), MinLength(10, ErrorMessage = "Bitte mindestens 10 Zeichen.")]
    public string Description { get; set; } = null!;

    public override string ToString()
    {
        return $"{nameof(Entry)}: {nameof(Id)}={Id}";
    }

    public IEnumerable<ValidationResult> Validate(ValidationContext validationContext)
    {
        // Der Reihe nach die Model-Validation durchführen
        if (Start >= End)
            yield return new ValidationResult("Start liegt vor Ende");
        if (Duration.Hour == 0 && Duration.Minute == 0 && Duration.Second == 0)
            yield return new ValidationResult("Es ergibt sich eine Dauer von 0 (oder weniger).");
    }
}