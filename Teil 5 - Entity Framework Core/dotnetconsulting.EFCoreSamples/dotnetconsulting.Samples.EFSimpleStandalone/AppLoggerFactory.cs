// Disclaimer
// Dieser Quellcode ist als Vorlage oder als Ideengeber gedacht. Er kann frei und ohne 
// Auflagen oder Einschränkungen verwendet oder verändert werden.
// Jedoch wird keine Garantie übernommen, dass eine Funktionsfähigkeit mit aktuellen und 
// zukünftigen API-Versionen besteht. Der Autor übernimmt daher keine direkte oder indirekte 
// Verantwortung, wenn dieser Code gar nicht oder nur fehlerhaft ausgeführt wird.
// Für Anregungen und Fragen stehe ich jedoch gerne zur Verfügung.

// Thorsten Kansy, www.dotnetconsulting.eu

using Microsoft.Extensions.Logging;

namespace dotnetconsulting.Samples.EFSimpleStandalone;

/// <summary>
/// Singelton-Pattern um nur eine(!) Instanz der LoggerFactory zu erzeugen.
/// </summary>
public static class AppLoggerFactory
{
    private static ILoggerFactory _loggerFactory;

    public static ILoggerFactory Instance
    {
        get
        {
            if (_loggerFactory is null)
                CreateLoggerFactory();
            return _loggerFactory!;
        }
    }

    private static void CreateLoggerFactory()
    {
        _loggerFactory = LoggerFactory.Create(builder =>
        {
            builder.AddConsole();
            builder.AddDebug();
            builder.SetMinimumLevel(LogLevel.Trace);
        });
    }
}