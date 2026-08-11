-- Test data for New_Property and New_Purchase.
-- Run after loading schema.sql and both procedures.

DELETE FROM Purchases;
DELETE FROM Property_Listing;
DELETE FROM Property;
DELETE FROM User;

CALL New_Property('CA','San Francisco','1 Main St','USA','House',2,4,2,1,50.00,200.00,25.00);
CALL New_Property('NY','New York','2 Broad St','USA','Condo',1,2,1,1,40.00,150.00,20.00);

-- Property_ID should be 1 and 2
SELECT Property_ID, City, Property_Type, Max_Guest_Num FROM Property;

INSERT INTO User (User_ID, Email, Password_Hash, Address)
VALUES (1, 'test@example.com', 'hashed_password', '1 Main St');

-- Two listings priced differently, so a bad lookup shows up as a wrong rate
INSERT INTO Property_Listing (Property_ID, Listing_ID, Date, Service_Fee, Cost_Per_Night, Cleaning_Fee)
VALUES (1, 101, '2026-01-01', 25.00, 200.00, 50.00),
       (2, 102, '2026-01-01', 20.00, 150.00, 40.00);

CALL New_Purchase(1, 101, 2, '2026-03-01', '2026-03-04');
CALL New_Purchase(1, 102, 1, '2026-04-01', '2026-04-03');

-- Rate should be 675.00 (3 x 200 + 50 + 25) and 360.00 (2 x 150 + 40 + 20)
SELECT Purchase_ID, Listing_ID, Number_Of_People, Rate, Start_Date, End_Date
FROM Purchases;
