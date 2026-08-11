DELIMITER $$

CREATE PROCEDURE New_Purchase (
    p_User_ID INT,
    p_Listing_ID INT,
    p_Number_Of_People INT,
    p_Start_Date DATE,
    p_End_Date DATE
)
BEGIN
    DECLARE New_ID INT;
    DECLARE v_Cleaning_Fee DECIMAL(10,2);
    DECLARE v_Service_Fee DECIMAL(10,2);
    DECLARE v_Cost_Per_Night DECIMAL(10,2);
    DECLARE v_Rate DECIMAL(10,2);
    DECLARE v_Nights INT;
    DECLARE v_Confirmation_Code INT;

    -- Assign Purchase_ID
    SET New_ID = (SELECT COALESCE(MAX(Purchase_ID),0) + 1 FROM Purchases);

    -- Calculate number of nights
    SET v_Nights = DATEDIFF(p_End_Date, p_Start_Date);

    -- Retrieve nightly cost, cleaning fee and service fee
    SELECT Cleaning_Fee, Service_Fee, Cost_Per_Night
    INTO v_Cleaning_Fee, v_Service_Fee, v_Cost_Per_Night
    FROM Property_Listing
    WHERE Listing_ID = p_Listing_ID;

    -- Calculate Rate
    SET v_Rate = (v_Nights * v_Cost_Per_Night) + v_Cleaning_Fee + v_Service_Fee;

    -- Generate Confirmation Code
    SET v_Confirmation_Code = ROUND(RAND() * 1000000000);

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
        New_ID,
        p_User_ID,
        p_Listing_ID,
        v_Confirmation_Code,
        p_Number_Of_People,
        v_Rate,
        p_Start_Date,
        p_End_Date
    );
END$$

DELIMITER ;
