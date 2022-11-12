// Disclaimer
// Dieser Quellcode ist als Vorlage oder als Ideengeber gedacht. Er kann frei und ohne 
// Auflagen oder Einschränkungen verwendet oder verändert werden.
// Jedoch wird keine Garantie übernommen, dass eine Funktionsfähigkeit mit aktuellen und 
// zukünftigen API-Versionen besteht. Der Autor übernimmt daher keine direkte oder indirekte 
// Verantwortung, wenn dieser Code gar nicht oder nur fehlerhaft ausgeführt wird.
// Für Anregungen und Fragen stehe ich jedoch gerne zur Verfügung.

// Thorsten Kansy, www.dotnetconsulting.eu

using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;
using static System.Console;

namespace dotnetconsulting.Samples.Gui;

public static class DbContextExt
{
    public static void DumpMetadataRelational(this DbContext Context, ILogger Logger = null)
    {
        // Benötigt "Microsoft.EntityFrameworkCore.Relational"

        writeLine($"=== {Context.GetType()} Metadata ===");
        writeLine($"Provider {Context.Database.ProviderName}");

        foreach (var entityType in Context.Model.GetEntityTypes())
        {
            writeLine("");
            var name = entityType.Name;
            var tableName = entityType.GetTableName();
            writeLine($"{name} ({tableName})");

            foreach (var propertyType in entityType.GetProperties())
            {
                var columnName = propertyType.GetColumnName();
                var columnType = propertyType.ClrType;
                writeLine($"\t{columnName} ({columnType})");
            }
        }

        writeLine("===");

        void writeLine(string line)
        {
            if (Logger != null)
                Logger.LogInformation(line);
            else
                WriteLine(line);
        }
    }

    public static void DumpMetadataNoSql(this DbContext Context, ILogger Logger = null)
    {
        // Benötigt "Microsoft.EntityFrameworkCore.Cosmos"

        writeLine($"=== {Context.GetType()} Metadata ===");
        writeLine($"Provider {Context.Database.ProviderName}");

        foreach (var entityType in Context.Model.GetEntityTypes())
        {
            writeLine("");
            var name = entityType.Name;
            var containerName = entityType.GetContainer();
            writeLine($"{name} ({containerName})");

            foreach (var propertyType in entityType.GetProperties())
            {
                var columnName = propertyType.GetJsonPropertyName();
                var columnType = propertyType.ClrType;
                writeLine($"\t{columnName} ({columnType})");
            }
        }

        writeLine("===");

        void writeLine(string line)
        {
            if (Logger != null)
                Logger.LogInformation(line);
            else
                WriteLine(line);
        }
    }
}