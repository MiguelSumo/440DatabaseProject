CREATE TRIGGER trg_AfterVehicleDelete_Audit
ON Vehicles
AFTER DELETE
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO VehicleDeleteAudit (
        VehicleID,
        Make,
        Model,
        Year,
        VIN,
        LicensePlate,
        DeletedBy,
        DeletedAt
    )
    SELECT
        d.VehicleID,
        d.Make,
        d.Model,
        d.Year,
        d.VIN,
        d.LicensePlate,
        SUSER_SNAME(),
        GETDATE()
    FROM deleted d;
END;
GO
