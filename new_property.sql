DELIMITER $$

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
    DECLARE New_ID INT;
    SELECT (COALESCE(MAX(Property_ID),0)+1) INTO New_ID
    FROM Property;
INSERT INTO Property
    (Property_ID,
    State_or_Area,
    City,
    Street_Address,
    Country,
    Property_Type,
    Num_Bedrooms,
    Max_Guest_Num,
    Num_Beds,
    Num_Baths,
    Cleaning_Fee,
    Cost_per_Night,
    Service_Fee)
VALUES
    (New_ID,
    State_or_Area,
    City,
    Street_Address,
    Country,
    Property_Type,
    Num_Bedrooms,
    Max_Guest_Num,
    Num_Beds,
    Num_Baths,
    Cleaning_Fee,
    Cost_per_Night,
    Service_Fee);
END$$

DELIMITER ;
