// Disclaimer
// Dieser Quellcode ist als Vorlage oder als Ideengeber gedacht. Er kann frei und ohne 
// Auflagen oder Einschränkungen verwendet oder verändert werden.
// Jedoch wird keine Garantie übernommen, dass eine Funktionsfähigkeit mit aktuellen und 
// zukünftigen API-Versionen besteht. Der Autor übernimmt daher keine direkte oder indirekte 
// Verantwortung, wenn dieser Code gar nicht oder nur fehlerhaft ausgeführt wird.
// Für Anregungen und Fragen stehe ich jedoch gerne zur Verfügung.

// Thorsten Kansy, www.dotnetconsulting.eu

using Microsoft.AspNetCore.Components.Forms;

namespace dotnetconsulting.TimeTracking.BlazorWASM.Client.Shared.Controls;

public class InputSelectInt32<T> : InputSelect<T>
{
    protected override bool TryParseValueFromString(string? value, out T result, out string validationErrorMessage)
    {
        if (typeof(T) == typeof(int))
        {
            if (int.TryParse(value, out var resultInt))
            {
                result = (T)(object)resultInt;
                validationErrorMessage = null!;
                return true;
            }
            else
            {
                result = default!;
                validationErrorMessage = "The chosen value is not a valid number.";
                return false;
            }
        }
        else
        {
            return base.TryParseValueFromString(value, out result!, out validationErrorMessage!);
        }
    }
}