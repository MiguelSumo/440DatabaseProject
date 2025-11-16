;WITH CustomerVehicleCounts AS (
    SELECT 
        c.CustomerID,
        p.FirstName,
        p.LastName,
        v.Make,
        v.Model,
        COUNT(*) AS TimesRented,
        ROW_NUMBER() OVER (
            PARTITION BY c.CustomerID
            ORDER BY COUNT(*) DESC, v.Make, v.Model
        ) AS rn
    FROM RentalOrders ro
    JOIN Rentals r
        ON ro.RentalID = r.RentalID
    JOIN Customers c
        ON ro.CustomerID = c.CustomerID
    JOIN Persons p
        ON c.CustomerID = p.PersonID
    JOIN Vehicles v
        ON r.VehicleID = v.VehicleID
    GROUP BY 
        c.CustomerID,
        p.FirstName,
        p.LastName,
        v.Make,
        v.Model
)
SELECT 
    CustomerID,
    FirstName,
    LastName,
    Make,
    Model,
    TimesRented
FROM CustomerVehicleCounts
WHERE rn = 1
ORDER BY CustomerID;
