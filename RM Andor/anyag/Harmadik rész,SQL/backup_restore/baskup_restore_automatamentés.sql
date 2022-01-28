-- Hol lehet az adatbázisban beállítani a küldésre használt emailt

https://www.sqlshack.com/configure-database-mail-sql-server/

management -> database mail -> configure database mail

-- Van-e sql parancs a backupset tartalmának listázására

https://docs.microsoft.com/en-us/sql/relational-databases/backup-restore/view-the-contents-of-a-backup-tape-or-file-sql-server?view=sql-server-ver15

--példa:


RESTORE HEADERONLY   
FROM DISK = N'C:\Program Files\Microsoft SQL Server\MSSQL15.ANDORSQL\MSSQL\Backup\DemoDB' ;  


-- Diff és Log mentés sql parancsai

BACKUP DATABASE DemoDB
TO DISK = 'C:\Program Files\Microsoft SQL Server\MSSQL15.ANDORSQL\MSSQL\Backup\DemoDB'
WITH DIFFERENTIAL; 

BACKUP LOG DemoDB TO DISK = 'C:\Program Files\Microsoft SQL Server\MSSQL15.ANDORSQL\MSSQL\Backup\DemoDB'
GO

-- Transaction log

SELECT [Current LSN],
       [Operation],
       [Transaction Name],
       [Transaction ID],
       [Transaction SID],
       [SPID],
       [Begin Time]
FROM   fn_dblog(null,null)
ORDER BY [Begin Time] DESC