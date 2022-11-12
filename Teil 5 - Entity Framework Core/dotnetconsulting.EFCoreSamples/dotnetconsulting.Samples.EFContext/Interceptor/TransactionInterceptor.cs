// Disclaimer
// Dieser Quellcode ist als Vorlage oder als Ideengeber gedacht. Er kann frei und ohne 
// Auflagen oder Einschränkungen verwendet oder verändert werden.
// Jedoch wird keine Garantie übernommen, dass eine Funktionsfähigkeit mit aktuellen und 
// zukünftigen API-Versionen besteht. Der Autor übernimmt daher keine direkte oder indirekte 
// Verantwortung, wenn dieser Code gar nicht oder nur fehlerhaft ausgeführt wird.
// Für Anregungen und Fragen stehe ich jedoch gerne zur Verfügung.

// Thorsten Kansy, www.dotnetconsulting.eu

using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore.Diagnostics;
using System.Data;
using System.Data.Common;
using System.Reflection;

#pragma warning disable IDE0051 // Remove unread private members

namespace dotnetconsulting.Samples.EFContext.Interceptor;

public class TransactionInterceptor : DbTransactionInterceptor
{
    public override InterceptionResult<DbTransaction> TransactionStarting(DbConnection connection, TransactionStartingEventData eventData, InterceptionResult<DbTransaction> result)
    {
        if (connection is SqlConnection sqlCon)
        {
            // Nutzlos, das IsolationLevel read-only ist
            // SqlTransaction tran = GetTransaction(sqlCon);

            sqlCon.BeginTransaction(IsolationLevel.RepeatableRead);
        }

        return base.TransactionStarting(connection, eventData, result);
    }

    private static readonly PropertyInfo ConnectionInfo = typeof(SqlConnection).GetProperty("InnerConnection", BindingFlags.NonPublic | BindingFlags.Instance)!;
    
    private static SqlTransaction GetTransaction(IDbConnection conn)
    {
        var internalConn = ConnectionInfo.GetValue(conn, null);
        var currentTransactionProperty = internalConn!.GetType().GetProperty("CurrentTransaction", BindingFlags.NonPublic | BindingFlags.Instance);
        var currentTransaction = currentTransactionProperty!.GetValue(internalConn, null);
        var realTransactionProperty = currentTransaction!.GetType().GetProperty("Parent", BindingFlags.NonPublic | BindingFlags.Instance);
        var realTransaction = realTransactionProperty!.GetValue(currentTransaction, null);
        return (SqlTransaction)realTransaction!;
    }
}