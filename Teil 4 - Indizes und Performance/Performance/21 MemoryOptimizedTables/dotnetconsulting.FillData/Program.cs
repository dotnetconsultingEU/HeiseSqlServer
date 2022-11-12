using Microsoft.Extensions.Configuration;
using System;
using System.Diagnostics;
using System.IO;

namespace dotnetconsulting.FillData
{
    class Program
    {
        static void Main(string[] args)
        {
            // Konfiguration vorbereiten & Einsatz bereit machen
            IConfigurationRoot config = new ConfigurationBuilder()
                .SetBasePath(Directory.GetCurrentDirectory())
                .AddJsonFile("appsettings.json")
                .Build();

            string connectionString = config["ConnectionStrings:Main"];

            for (int i = 0; i < 50; i++)
            {
                Stopwatch sw = new Stopwatch();
                sw.Start();
                DataGenerator dg = new DataGenerator(connectionString);

                // dg.GenerateRows(100_000);
                dg.GenerateRowsTVP(1_000_000);

                Console.WriteLine($"Duration: {sw.ElapsedMilliseconds / 1000:N0}s");
            }
        }
    }
}
