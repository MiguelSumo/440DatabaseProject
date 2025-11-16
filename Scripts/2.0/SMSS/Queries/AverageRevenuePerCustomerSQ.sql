SELECT 
    AVG(CustomerRevenue.TotalRevenue) AS AvgRevenuePerCustomer
FROM (
        SELECT 
            c.CustomerID,
            SUM(pto.PaymentAmount) AS TotalRevenue
        FROM Customers c
        JOIN RentalOrders ro 
            ON ro.CustomerID = c.CustomerID
        JOIN PaymentsToOrders pto 
            ON pto.RentalOrderID = ro.OrderID
        GROUP BY c.CustomerID
     ) AS CustomerRevenue;
