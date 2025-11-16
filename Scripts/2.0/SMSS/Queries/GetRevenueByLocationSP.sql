USE [CIS440CarRentalProject]
GO

/****** Object:  StoredProcedure [dbo].[GetRevenueByLocation]    Script Date: 11/12/2025 1:06:58 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE OR ALTER PROC [dbo].[GetRevenueByLocation]
    @StartDate date = NULL,      
    @EndDate   date = NULL       
AS
BEGIN
    SET NOCOUNT ON;

    IF OBJECT_ID('tempdb..#temp') IS NOT NULL
        DROP TABLE #temp;

    /* Build the base rows, then apply optional date filters on PaymentDate */
    SELECT
        l.LocationID,
        a.City,
        a.StateOrProvince,
        ro.TotalDue
    INTO #temp
    FROM dbo.Locations     AS l
    JOIN dbo.Addresses     AS a  ON l.LocationID = a.PartyID
    JOIN dbo.Rentals       AS r  ON r.PickupLocation = l.LocationID
    JOIN dbo.RentalOrders  AS ro ON ro.RentalID      = r.RentalID
    WHERE
        (@StartDate IS NULL OR ro.PaymentDate >= @StartDate)
        AND (@EndDate IS NULL OR ro.PaymentDate < DATEADD(day, 1, @EndDate));  -- inclusive end

    DECLARE @cols      nvarchar(max);
    DECLARE @colsalias nvarchar(max);
    DECLARE @sql       nvarchar(max);

    SELECT @cols =
        STRING_AGG(QUOTENAME(CAST(LocationID AS varchar(20))), ',')
            WITHIN GROUP (ORDER BY LocationID)
    FROM (SELECT DISTINCT LocationID FROM #temp) d;

    SELECT @colsalias =
        STRING_AGG(
            QUOTENAME(CAST(LocationID AS varchar(20))) + N' AS ' +
            QUOTENAME(City + N', ' + StateOrProvince),
            ','
        ) WITHIN GROUP (ORDER BY LocationID)
    FROM (SELECT DISTINCT LocationID, City, StateOrProvince FROM #temp) d;

    IF @cols IS NULL
    BEGIN
        -- no rows in range
        SELECT N'TotalRevenue' AS [TotalRevenueByLocation];
        RETURN;
    END

    SET @sql = N'
        SELECT ''TotalRevenue'' AS [TotalRevenueByLocation], ' + @colsalias + N'
        FROM (
            SELECT LocationID, TotalDue
            FROM #temp
        ) AS s
        PIVOT (
            SUM(TotalDue) FOR LocationID IN (' + @cols + N')
        ) AS p;
    ';

    EXEC sys.sp_executesql @sql;

    DROP TABLE #temp;
END
GO

