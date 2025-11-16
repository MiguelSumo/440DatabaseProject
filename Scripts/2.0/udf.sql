--- UDF
--- This query tracks mileage at check out and check in. The business purpose of this is to calculate the mileage-based charges. 
--- This supports our business requirements by tracking vehicle usage.

CREATE FUNCTION fn_GetMilesDriven (@RentalID INT)
RETURNS INT
AS
BEGIN
    DECLARE @MilesDriven INT;

    SELECT @MilesDriven = EndMileage - StartMileage
    FROM Rentals
    WHERE RentalID = @RentalID;

    RETURN @MilesDriven;
END;

