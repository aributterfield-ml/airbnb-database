CREATE PROCEDURE New_Property (
    State_or_Area VARCHAR(20),
    City VARCHAR(20),
    Street_Address VARCHAR(50),
    Country VARCHAR(20),
    Property_Type VARCHAR(20),
    Num_Bedrooms INT,
    Max_Guest_Num INT,
    Num_Beds INT,
    Num_Baths INT,
    Cleaning_Fee DECIMAL(10,2),
    Cost_per_Night DECIMAL(10,2),
    Service_Fee DECIMAL(10,2)
  )
BEGIN
    DECLARE Property_ID INT;
    SELECT (COUNT(Property_ID)+1) INTO Property_ID
    FROM Property;
INSERT INTO Property
    (Property_ID,
    State_or_Area,
    City,
    Street_Address,
    Country,
    Poperty_Type,
    Num_Bedrooms,
    Max_Guest,
    Num_Beds,
    Num_Baths,
    Cleaning_Fee,
    Cost_per_Night,
    Service_Fee)
VALUES
    (Property_ID,
    State_or_Area,
    City,
    Street_Address,
    Country,
    Poperty_Type,
    Num_Bedrooms,
    Max_Guest,
    Num_Beds,
    Num_Baths,
    Cleaning_Fee,
    Cost_per_Night,
    Service_Fee);
END