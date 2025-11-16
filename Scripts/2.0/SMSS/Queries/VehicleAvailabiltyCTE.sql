WITH VehicleAvailability AS (
    SELECT 
        VehicleID,
        Make,
        Model,
        Year,
        Status AS AvailabilityStatus
    FROM Vehicles
)
SELECT * 
FROM VehicleAvailability;
