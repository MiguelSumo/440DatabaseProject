DECLARE LateCursor CURSOR FOR
    SELECT 
        AgreementID,
        VehicleID,
        EndDate,
        Status
    FROM Rentals
    WHERE EndDate < GETDATE()
      AND Status != 'Checked-In';

OPEN LateCursor;

DECLARE 
    @AgreementID INT,
    @VehicleID   INT,
    @EndDate     DATETIME,
    @Status      CHAR(10);

FETCH NEXT FROM LateCursor INTO @AgreementID, @VehicleID, @EndDate, @Status;

WHILE @@FETCH_STATUS = 0
BEGIN
    PRINT 'Rental Agreement ' + CAST(@AgreementID AS VARCHAR(10)) + ' is overdue.';

    FETCH NEXT FROM LateCursor INTO @AgreementID, @VehicleID, @EndDate, @Status;
END


CLOSE LateCursor;
DEALLOCATE LateCursor;
