DROP TABLE IF EXISTS Persons;
DROP TABLE IF EXISTS Addresses;
DROP TABLE IF EXISTS Customers;
DROP TABLE IF EXISTS Phones;
DROP TABLE IF EXISTS Cards;
DROP TABLE IF EXISTS Users;
DROP TABLE IF EXISTS Locations;
DROP TABLE IF EXISTS Employees;
DROP TABLE IF EXISTS Rentals;
DROP TABLE IF EXISTS Vehicles;
DROP TABLE IF EXISTS Parties;
DROP TABLE IF EXISTS RentalOrders;
DROP TABLE IF EXISTS DriversLicense;
DROP TABLE IF EXISTS DriverInsurance;
DROP TABLE IF EXISTS Discounts;
DROP TABLE IF EXISTS ScheduleBlocks;
DROP TABLE IF EXISTS Emails;
DROP TABLE IF EXISTS Payments;
DROP TABLE IF EXISTS Checks;
DROP TABLE IF EXISTS VehicleTypes;
DROP TABLE IF EXISTS PaymentsToOrders;


CREATE TABLE Persons (
PersonID INT PRIMARY KEY NOT NULL,
FirstName VARCHAR(50) NOT NULL,
MiddleInitial CHAR(1),
LastName VARCHAR(50) NOT NULL,
Suffix VARCHAR(10));

CREATE TABLE Addresses (
AddressID INT AUTO_INCREMENT PRIMARY KEY,
PartyID INT NOT NULL,
AddressType CHAR(1) NOT NULL,
StreetAddress VARCHAR(100) NOT NULL,
City VARCHAR(50) NOT NULL,
StateOrProvince VARCHAR(50) NOT NULL,
ZipCode CHAR(5),
Country VARCHAR(50) NOT NULL);

CREATE TABLE Customers (
CustomerID INT PRIMARY KEY NOT NULL);

CREATE TABLE Phones (
PhoneID INT PRIMARY KEY NOT NULL,
PartyID INT NOT NULL,
PhoneType CHAR(1) NOT NULL,
CountryCode VARCHAR(5),
PhoneNumber CHAR(10) NOT NULL);

CREATE TABLE Cards (
CardID INT AUTO_INCREMENT PRIMARY KEY,
WalletID INT NOT NULL,
CardType VARCHAR(50) NOT NULL,
CardToken VARCHAR(50) NOT NULL,
ExpirationYear CHAR(4) NOT NULL,
ExpirationMonth CHAR(2) NOT NULL,
ModifiedDate DATETIME NOT NULL);

CREATE TABLE Users (
UserID INT PRIMARY KEY NOT NULL,
Username VARCHAR(50) NOT NULL,
PasswordHash VARCHAR(50) NOT NULL,
CreationDate DATETIME NOT NULL,
LastLoginDate DATETIME,
LastModifiedDate DATETIME NOT NULL);

CREATE TABLE Locations (
LocationID INT PRIMARY KEY NOT NULL,
MaxVehicles INT NOT NULL);

CREATE TABLE Employees (
EmployeeID INT PRIMARY KEY NOT NULL,
HireDate DATE NOT NULL,
IsActive BIT NOT NULL,
Gender VARCHAR(10) NOT NULL,
PayRate DECIMAL(5,2) NOT NULL);

CREATE TABLE Rentals (
RentalID INT AUTO_INCREMENT PRIMARY KEY,
VehicleID INT NOT NULL,
AgreementID  INT NOT NULL,
DriversLicenseID INT NOT NULL,
DriverInsuranceID INT NOT NULL,
Status CHAR(1) NOT NULL DEFAULT '0',
IsOnlineReservation BIT NOT NULL DEFAULT 0,
PickupLocation INT NOT NULL,
DropOffLocation INT,
EmployeeID INT,
CreationDate DATETIME NOT NULL,
StartDate DATETIME NOT NULL,
EndDate DATETIME,
ReturnedOnDate DATETIME,
StartMileage INT NOT NULL,
EndMileage INT NOT NULL);

CREATE TABLE Vehicles (
VehicleID INT AUTO_INCREMENT PRIMARY KEY,
CurrentLocation INT NOT NULL,
Make VARCHAR(20) NOT NULL,
Model VARCHAR(30) NOT NULL,
Year CHAR(4) NOT NULL,
VIN CHAR(23) NOT NULL,
Color VARCHAR(20) NOT NULL,
VehicleType INT NOT NULL,
LicensePlate VARCHAR(10) NOT NULL,
FuelType CHAR(1) NOT NULL,
CurrentFuel INT NOT NULL,
Mileage INT NOT NULL,
MileageRate DECIMAL(5,2),
DailyRate DECIMAL(6,2),
BaseFee DECIMAL(7,2),
Status CHAR(1) NOT NULL DEFAULT '0',
ModifiedDate  DATETIME NOT NULL);

CREATE TABLE Parties (
PartyID INT AUTO_INCREMENT PRIMARY KEY);

CREATE TABLE RentalOrders (
OrderID INT AUTO_INCREMENT PRIMARY KEY,
CustomerID INT NOT NULL,
RentalID INT NOT NULL,
SubTotal DECIMAL(7,2),
DiscountID INT,
Tax DECIMAL(4,2),
TotalDue DECIMAL(7,2),
OrderStatus CHAR(1) NOT NULL,
DateModified  DATETIME NOT NULL,
DueDate DATETIME NOT NULL,
PaymentDate DATETIME NOT NULL);

CREATE TABLE DriversLicense (
DriversLicenseID INT PRIMARY KEY NOT NULL,
PersonID INT NOT NULL,
LicenseState CHAR(2) NOT NULL,
LicenseNumber VARCHAR(5) NOT NULL,
DateOfBirth DATE NOT NULL,
ExpirationDate DATE NOT NULL);

CREATE TABLE DriverInsurance (
InsuranceID INT PRIMARY KEY NOT NULL,
PersonID  INT NOT NULL,
PolicyProvider VARCHAR(50) NOT NULL,
PolicyNumber VARCHAR(50) NOT NULL,
ExpirationDate DATE NOT NULL);

CREATE TABLE Discounts (
DiscountID INT AUTO_INCREMENT PRIMARY KEY,
DiscountCode VARCHAR(20) NOT NULL,
StartDate DATETIME NOT NULL,
EndDate DATETIME,
DiscountType CHAR(1) NOT NULL,
DiscountAmount DECIMAL(6,2) NOT NULL);

CREATE TABLE ScheduleBlocks (
BlockID INT PRIMARY KEY NOT NULL,
VehicleID INT NOT NULL,
BlockStartDate DATETIME NOT NULL,
BlockEndDate DATETIME,
BlockReason VARCHAR(250) NOT NULL);

CREATE TABLE Emails (
EmailID INT PRIMARY KEY NOT NULL,
PartyID INT NOT NULL,
EmailType CHAR(1) NOT NULL,
EmailAddress VARCHAR(100) NOT NULL);

CREATE TABLE Payments (
PaymentID INT PRIMARY KEY NOT NULL);

CREATE TABLE Checks (
CheckID INT PRIMARY KEY NOT NULL,
CheckNumber VARCHAR(25) NOT NULL,
AccountNumber INT NOT NULL,
RoutingNumber INT NOT NULL);

CREATE TABLE VehicleTypes (
VehicleTypes INT PRIMARY KEY NOT NULL,
Type VARCHAR(100) NOT NULL);

CREATE TABLE PaymentsToOrders (
PaymentToOrderId INT PRIMARY KEY NOT NULL,
PaymentID INT NOT NULL,
RentalOrderID INT NOT NULL,
PaymentAmount DECIMAL(10,2) NOT NULL);

ALTER TABLE Persons ADD CONSTRAINT Persons_PersonID_Parties_PartyID FOREIGN KEY (PersonID) REFERENCES Parties(PartyID);
ALTER TABLE Addresses ADD CONSTRAINT Addresses_PartyID_Parties_PartyID FOREIGN KEY (PartyID) REFERENCES Parties(PartyID);
ALTER TABLE Customers ADD CONSTRAINT Customers_CustomerID_Persons_PersonID FOREIGN KEY (CustomerID) REFERENCES Persons(PersonID);
ALTER TABLE Phones ADD CONSTRAINT Phones_PartyID_Parties_PartyID FOREIGN KEY (PartyID) REFERENCES Parties(PartyID);
ALTER TABLE Cards ADD CONSTRAINT Cards_CardID_Payments_PaymentID FOREIGN KEY (CardID) REFERENCES Payments(PaymentID);
ALTER TABLE Cards ADD CONSTRAINT Cards_WalletID_Customers_CustomerID FOREIGN KEY (WalletID) REFERENCES Customers(CustomerID);
ALTER TABLE Users ADD CONSTRAINT Users_UserID_Persons_PersonID FOREIGN KEY (UserID) REFERENCES Persons(PersonID);
ALTER TABLE Locations ADD CONSTRAINT Locations_LocationID_Parties_PartyID FOREIGN KEY (LocationID) REFERENCES Parties(PartyID);
ALTER TABLE Employees ADD CONSTRAINT Employees_EmployeeID_Persons_PersonID FOREIGN KEY (EmployeeID) REFERENCES Persons(PersonID);
ALTER TABLE Rentals ADD CONSTRAINT Rentals_VehicleID_Vehicles_VehicleID FOREIGN KEY (VehicleID) REFERENCES Vehicles(VehicleID);
ALTER TABLE Rentals ADD CONSTRAINT Rentals_DriversLicenseID_DriversLicense_DriversLicenseID FOREIGN KEY (DriversLicenseID) REFERENCES DriversLicense(DriversLicenseID);
ALTER TABLE Rentals ADD CONSTRAINT Rentals_DriverInsuranceID_DriverInsurance_InsuranceID FOREIGN KEY (DriverInsuranceID) REFERENCES DriverInsurance(InsuranceID);
ALTER TABLE Rentals ADD CONSTRAINT Rentals_PickupLocation_Locations_LocationID FOREIGN KEY (PickupLocation) REFERENCES Locations(LocationID);
ALTER TABLE Rentals ADD CONSTRAINT Rentals_DropOffLocation_Locations_LocationID FOREIGN KEY (DropOffLocation) REFERENCES Locations(LocationID);
ALTER TABLE Rentals ADD CONSTRAINT Rentals_EmployeeID_Employees_EmployeeID FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID);
ALTER TABLE Vehicles ADD CONSTRAINT Vehicles_CurrentLocation_Locations_LocationID FOREIGN KEY (CurrentLocation) REFERENCES Locations(LocationID);
ALTER TABLE Vehicles ADD CONSTRAINT Vehicles_VehicleType_VehicleTypes_VehicleTypes FOREIGN KEY (VehicleType) REFERENCES VehicleTypes(VehicleTypes);
ALTER TABLE RentalOrders ADD CONSTRAINT RentalOrders_CustomerID_Customers_CustomerID FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID);
ALTER TABLE RentalOrders ADD CONSTRAINT RentalOrders_RentalID_Rentals_RentalID FOREIGN KEY (RentalID) REFERENCES Rentals(RentalID);
ALTER TABLE RentalOrders ADD CONSTRAINT RentalOrders_DiscountID_Discounts_DiscountID FOREIGN KEY (DiscountID) REFERENCES Discounts(DiscountID);
ALTER TABLE DriversLicense ADD CONSTRAINT DriversLicense_PersonID_Persons_PersonID FOREIGN KEY (PersonID) REFERENCES Persons(PersonID);
ALTER TABLE DriverInsurance ADD CONSTRAINT DriverInsurance_PersonID_Persons_PersonID FOREIGN KEY (PersonID ) REFERENCES Persons(PersonID);
ALTER TABLE ScheduleBlocks ADD CONSTRAINT ScheduleBlocks_VehicleID_Vehicles_VehicleID FOREIGN KEY (VehicleID) REFERENCES Vehicles(VehicleID);
ALTER TABLE Emails ADD CONSTRAINT Emails_PartyID_Parties_PartyID FOREIGN KEY (PartyID) REFERENCES Parties(PartyID);
ALTER TABLE Checks ADD CONSTRAINT Checks_CheckID_Payments_PaymentID FOREIGN KEY (CheckID) REFERENCES Payments(PaymentID);
ALTER TABLE PaymentsToOrders ADD CONSTRAINT PaymentsToOrders_PaymentID_Payments_PaymentID FOREIGN KEY (PaymentID) REFERENCES Payments(PaymentID);
ALTER TABLE PaymentsToOrders ADD CONSTRAINT PaymentsToOrders_RentalOrderID_RentalOrders_OrderID FOREIGN KEY (RentalOrderID) REFERENCES RentalOrders(OrderID);