DELIMITER

CREATE PROCEDURE New_Purchase (
    User_ID INT,
    Listing_ID INT,
    Number_Of_People INT,
    Start_Date DATE,
    End_Date DATE
)
BEGIN
    DECLARE Purchase_ID INT;
    DECLARE Cleaning_Fee DECIMAL(10,2);
    DECLARE Service_Fee DECIMAL(10,2);
    DECLARE Rate DECIMAL(10,2);
    DECLARE DateDiff INT;
    DECLARE Confirmation_Code BIGINT;

    -- Assign Purchase_ID
    SET Purchase_ID = (SELECT COUNT(Purchases_ID) + 1 FROM Purchases);

    -- Calculate DateDiff
    SET DateDiff = DATEDIFF(End_Date, Start_Date);

    -- Retrieve Service Fee and Cleaning Fee
    SELECT Service_Fee, Cleaning_Fee
    INTO Cleaning_Fee, Service_Fee
    FROM Property_Listing
    WHERE Listing_ID = Listing_ID;

    -- Calculate Rate
    SET Rate = (DateDiff * Cost_Per_Night) + Cleaning_Fee + Service_Fee;

    -- Generate Confirmation Code
    SET Confirmation_Code = ROUND(RAND() * 1000000000000);

    -- Insert into Purchases table
    INSERT INTO Purchases (
        Purchase_ID,
        User_ID,
        Listing_ID,
        Confirmation_Code,
        Number_Of_People,
        Rate,
        Start_Date,
        End_Date
    ) VALUES (
        Purchase_ID,
        User_ID,
        Listing_ID,
        Confirmation_Code,
        Number_Of_People,
        Rate,
        Start_Date,
        End_Date
    );
END