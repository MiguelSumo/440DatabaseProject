/**
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
**/

SELECT dbo.fn_GetMilesDriven(12) as MilesDriven;
