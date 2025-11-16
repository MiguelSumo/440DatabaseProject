 SELECT
    l.LocationID,
    'Branch - ' + a.City AS BranchName,
    (
        SELECT COUNT(*)
        FROM Rentals r
        WHERE r.PickupLocation = l.LocationID
    ) AS TotalRentals
FROM Locations l
JOIN Addresses a
    ON a.PartyID = l.LocationID
ORDER BY a.City;
