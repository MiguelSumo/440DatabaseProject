----- CTE
---- The business purpose of this is to show how many vehicles are available for use by customers. 
-----This supports our business requirement of showcasing availability.


WITH VehicleAvailability AS (
    SELECT 
        VehicleID,
        Make,
        Model,
        Year,
        Status AS AvailabilityStatus
    FROM Vehicles
)
SELECT * FROM VehicleAvailability;
