
    /**
    INSERT INTO PrimaryCustomer(Last_Name,First_Name,Middle_Initial,Suffix,Gender)
    VALUES
        ('Sumo','Miguel','Y',null,'M')
    **/
    /**
    INSERT INTO EmailAddress(Email,Type,CreatedAt)  
    VALUES
        ('miguelsumo@mnsu.edu', 'School', GetDATE());
    **/
    /**
    INSERT INTO CustomerEmail(CustomerID,EmailAddressID,isPrimary,Notes,Start_Date)
    VALUES
        (1,1,1,'N/A', GETDATE());
    **/
    /**
    INSERT INTO PhoneNumber(PhoneNumber,Type, CreatedAt, Extension)
    VALUES
        ('612-849-7771','Mobile',GETDATE(),null);
    **/
    /**
    INSERT INTO CustomerPhone(Phone_NumberID,CustomerID,Notes,Start_Date,End_Date, IsPrimary)
    VALUES
        (1,1,'Prefers To Be Contacted In Afternoon', GETDATE(), NULL, 1);
    **/
    /**
    INSERT INTO Insurance(PolicyNumber,EffectiveOn,ExpirationOn,Provider,VerifiedAt,CreatedAt)
    VALUES 
        ('869954687','2025-03-03','2026-06-01','Progressive',GETDATE(), GETDATE());
    **/
    /**
    INSERT INTO CustomerInsurance(CustomerID,InsuranceID,IsActive,Notes)
    VALUES
        (1,1,1,NULL);
    **/
    /**
    INSERT INTO Location(Address1, Address2,Addendum,City,State,Zip_Code,Country,CreatedAt,Location_Name,Email,Phone_Number,isActive)
    VALUES
        ('1356 Elm St','APT 1',NULL,'Chaska','MN','55318','USA',GETDATE(),'Chaska Branch','chaskaBranch@email.com','952-457-9864',1);
    **/
    /**
    INSERT INTO  VehicleType(Vehicle_Name,Rate_Per_Hour,Seating,Base_Rate_Per_Day,Description)
    VALUES 
        ('Sedan','11.50',5,'225.00', 'A compact, fuel-efficient car ideal for city driving and small families.');
    **/
    


    