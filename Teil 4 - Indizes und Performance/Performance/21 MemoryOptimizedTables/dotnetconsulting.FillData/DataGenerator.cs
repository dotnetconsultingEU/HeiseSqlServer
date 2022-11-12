using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Data.SqlClient;
using System.Text;

namespace dotnetconsulting.FillData
{
    public class DataGenerator
    {
        private readonly string constring;

        public DataGenerator(string ConnectionString)
        {
            constring = ConnectionString;
        }

        public void GenerateRows(int RowCount)
        {
            Random rnd = new Random();

            // Alles vorbereiten
            using (SqlConnection con = new SqlConnection(constring))
            {
                con.Open();

                using (SqlCommand cmd = con.CreateCommand())
                {
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.CommandText = "dbo.uspInsertIntoSearchCatalog";

                    cmd.Parameters.AddWithValue("Start", null);
                    cmd.Parameters.AddWithValue("End", null);
                    cmd.Parameters.AddWithValue("Criterium01", null);
                    cmd.Parameters.AddWithValue("Criterium02", null);
                    cmd.Parameters.AddWithValue("Criterium03", null);
                    cmd.Parameters.AddWithValue("Criterium04", null);
                    cmd.Parameters.AddWithValue("Criterium05", null);
                    cmd.Parameters.AddWithValue("Criterium06", null);
                    cmd.Parameters.AddWithValue("Criterium07", null);
                    cmd.Parameters.AddWithValue("Criterium08", null);
                    cmd.Parameters.AddWithValue("Criterium09", null);
                    cmd.Parameters.AddWithValue("Criterium10", null);
                    cmd.Parameters.AddWithValue("Criterium11", null);
                    cmd.Parameters.AddWithValue("Criterium12", null);
                    cmd.Parameters.AddWithValue("Criterium13", null);
                    cmd.Parameters.AddWithValue("Criterium14", null);
                    cmd.Parameters.AddWithValue("Criterium15", null);
                    cmd.Parameters.AddWithValue("Criterium16", null);
                    cmd.Parameters.AddWithValue("Criterium17", null);
                    cmd.Parameters.AddWithValue("Criterium18", null);
                    cmd.Parameters.AddWithValue("Criterium19", null);
                    cmd.Parameters.AddWithValue("Criterium20", null);
                    cmd.Parameters.AddWithValue("Active", null);

                    // Zeilen einfügen
                    for (int i = 0; i < RowCount; i++)
                    {
                        // Alle Parameter mit Werten befüllen
                        foreach (DbParameter parameter in cmd.Parameters)
                        {
                            object value = null;
                            switch (parameter.ParameterName)
                            {
                                case "Start":
                                case "End":
                                    value = DateTime.Today.AddDays(rnd.Next(1, 200));
                                    break;
                                case "Active":
                                    value = true;
                                    break;
                                case string s when s.StartsWith("Criterium"):
                                    value = rnd.Next(1, 200);
                                    break;
                                default:
                                    throw new ArgumentOutOfRangeException(nameof(parameter.ParameterName));
                            }
                            parameter.Value = value;
                        }

                        // SP ausführen
                        cmd.ExecuteNonQuery();
                        if (i % 1000 == 0)
                        {
                            Console.WriteLine($"{DateTime.Now:T} - {i:N0} rows inserted.");
                        }
                    }
                }
            }
        }

        public void GenerateRowsTVP(int RowCount)
        {
            Random rnd = new Random();

            // DataTable für TVP vorbereiten
            DataTable table = new DataTable();

            table.Columns.Add("ID", typeof(Int32));
            table.Columns.Add("Start", typeof(DateTime));
            table.Columns.Add("End", typeof(DateTime));
            table.Columns.Add("Criterium01", typeof(Int32));
            table.Columns.Add("Criterium02", typeof(Int32));
            table.Columns.Add("Criterium03", typeof(Int32));
            table.Columns.Add("Criterium04", typeof(Int32));
            table.Columns.Add("Criterium05", typeof(Int32));
            table.Columns.Add("Criterium06", typeof(Int32));
            table.Columns.Add("Criterium07", typeof(Int32));
            table.Columns.Add("Criterium08", typeof(Int32));
            table.Columns.Add("Criterium09", typeof(Int32));
            table.Columns.Add("Criterium10", typeof(Int32));
            table.Columns.Add("Criterium11", typeof(Int32));
            table.Columns.Add("Criterium12", typeof(Int32));
            table.Columns.Add("Criterium13", typeof(Int32));
            table.Columns.Add("Criterium14", typeof(Int32));
            table.Columns.Add("Criterium15", typeof(Int32));
            table.Columns.Add("Criterium16", typeof(Int32));
            table.Columns.Add("Criterium17", typeof(Int32));
            table.Columns.Add("Criterium18", typeof(Int32));
            table.Columns.Add("Criterium19", typeof(Int32));
            table.Columns.Add("Criterium20", typeof(Int32));
            table.Columns.Add("Active", typeof(bool));

            for (int i = 0; i < RowCount; i++)
            {
                DataRow row = table.NewRow();

                foreach (DataColumn column in table.Columns)
                {
                    object value = null;
                    switch (column.ColumnName)
                    {
                        case "ID":
                            value = i;
                            break;
                        case "Start":
                        case "End":
                            value = DateTime.Today.AddDays(rnd.Next(1, 200));
                            break;
                        case "Active":
                            value = true;
                            break;
                        case string s when s.StartsWith("Criterium"):
                            value = rnd.Next(1, 200);
                            break;
                        default:
                            throw new ArgumentOutOfRangeException(nameof(column.ColumnName));
                    }
                    row[column.ColumnName] = value;
                }
                table.Rows.Add(row);
            }
            table.AcceptChanges();

            // Alles vorbereiten
            using (SqlConnection con = new SqlConnection(constring))
            {
                con.Open();

                using (SqlCommand cmd = con.CreateCommand())
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.CommandText = "dbo.uspInsertIntoSearchCatalogTVP2";

                    DbParameter p1 = new SqlParameter()
                    {
                        ParameterName = "Items",
                        SqlDbType = SqlDbType.Structured,
                        Value = table
                    };

                    cmd.Parameters.Add(p1);

                    // Ausführen
                    Console.WriteLine("Execute Cmd");
                    cmd.ExecuteScalar();
                }
            }
        }
    }
}