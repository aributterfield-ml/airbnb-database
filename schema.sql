CREATE TABLE User(
    User_ID INT,
    Email VARCHAR(30) NOT NULL,
    Password VARCHAR(30) NOT NULL,
    Government_ID INT,
    Address VARCHAR(50) NOT NULL,
    Default_Language VARCHAR(15) DEFAULT "English",
    Translation_On BOOL DEFAULT False,
    Timezone VARCHAR(3),
    Gender VARCHAR(10),
    Default_Currency VARCHAR(10),
    Date_Joined DATE,
    Emergency_Contact VARCHAR(30),
    Use_First_Name_Photo BOOL DEFAULT False,
    Include_Profile_Search BOOL DEFAULT False,
    Messages BOOL DEFAULT True,
    Reminders BOOL DEFAULT True,
    Guest_Policies BOOL DEFAULT True,
    Account_Activity BOOL DEFAULT True,
    Travel_Regulations BOOL DEFAULT True,
    Inspiration_Offers BOOL DEFAULT True,
    Trip_Planning BOOL DEFAULT True,
    News_Programs BOOL DEFAULT True,
    Feedback BOOL DEFAULT True,
    PRIMARY KEY (User_ID)
);
CREATE TABLE Property (
    Property_ID INT,
    State_or_Area VARCHAR(20) NOT NULL,
    City VARCHAR(20) NOT NULL,
    Street_Address VARCHAR(50) NOT NULL,
    Country VARCHAR(20) NOT NULL,
    Property_Type VARCHAR(20) NOT NULL,
    Num_Bedrooms INT NOT NULL,
    Max_Guest_Num INT NOT NULL,
    Num_Beds INT NOT NULL,
    Num_Baths INT NOT NULL,
    Cleaning_Fee DECIMAL(10,2) NOT NULL,
    Cost_per_Night DECIMAL(10,2) NOT NULL,
    Service_Fee DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (Property_ID)
);
CREATE TABLE Payout_Method (
    Payout_ID INT,
    Routing_Number INT NOT NULL,
    Account_Number INT NOT NULL,
    Account_Holder_Name VARCHAR(50) NOT NULL,
    Is_Checking BOOL NOT NULL,
    PRIMARY KEY (Payout_ID)
);
CREATE TABLE Experience (
    Experience_ID INT,
    Length VARCHAR(10) NOT NULL,
    Allows_Private_Bookings BOOL DEFAULT True,
    Max_Guest_Num INT NOT NULL,
    Photos VARCHAR(500),
    Description VARCHAR(1000) NOT NULL,
    Language VARCHAR(20) NOT NULL,
    Experience_Type VARCHAR(20) NOT NULL,
    PRIMARY KEY (Experience_ID)
);
CREATE TABLE Owns_Property (
    User_ID INT,
    Property_ID INT,
    PRIMARY KEY (User_ID, Property_ID),
    FOREIGN KEY (User_ID) REFERENCES User(User_ID)
    ON DELETE CASCADE,
    FOREIGN KEY (Property_ID) REFERENCES Property(Property_ID)
    ON DELETE CASCADE
);
CREATE TABLE Owns_Experience (
    User_ID INT,
    Experience_ID INT,
    PRIMARY KEY (User_ID, Experience_ID),
    FOREIGN KEY (User_ID) REFERENCES User(User_ID)  
    ON DELETE CASCADE,
    FOREIGN KEY (Experience_ID) REFERENCES Experience(Experience_ID)
    ON DELETE CASCADE
);
CREATE TABLE Host (
    User_ID INT,
    Is_Superhost BOOL DEFAULT False,
    Identity_Verified BOOL DEFAULT False,
    Is_Simplified_Fee BOOL DEFAULT True,
    Allow_Contributions Bool DEFAULT True,
    Response_Rate DECIMAL(2,2),
    Num_Reviews INT DEFAULT 0,
    PRIMARY KEY (User_ID),
    FOREIGN KEY (User_ID) REFERENCES User(User_ID)
    ON DELETE CASCADE
);
CREATE TABLE Open_Dates (
    Property_ID INT,
    Day DATE NOT NULL,
    PRIMARY KEY (Property_ID, Day),
    FOREIGN KEY (Property_ID) REFERENCES Property(Property_ID)
    ON DELETE CASCADE
);
CREATE TABLE Property_Pictures (
    Property_ID INT,
    Photo VARCHAR(500) NOT NULL,
    PRIMARY KEY (Property_ID, Photo),
    FOREIGN KEY (Property_ID) REFERENCES Property(Property_ID)
    ON DELETE CASCADE
);
CREATE TABLE Amenities (
    Property_ID INT,
    Amenity VARCHAR(50) NOT NULL,
    PRIMARY KEY (Property_ID, Amenity),
    FOREIGN KEY (Property_ID) REFERENCES Property(Property_ID)
    ON DELETE CASCADE
);
CREATE TABLE Health_and_Safety (
    Property_ID INT,
    Information VARCHAR(500) NOT NULL,
    PRIMARY KEY (Property_ID, Information),
    FOREIGN KEY (Property_ID) REFERENCES Property(Property_ID)
    ON DELETE CASCADE
);
CREATE TABLE Cancellation_Policy (
    Property_ID INT,
    Information VARCHAR(500) NOT NULL,
    PRIMARY KEY (Property_ID, Information),
    FOREIGN KEY (Property_ID) REFERENCES Property(Property_ID)
    ON DELETE CASCADE
);
CREATE TABLE Price_and_Availability (
    Property_ID INT,
    Information VARCHAR(500) NOT NULL,
    PRIMARY KEY (Property_ID, Information),
    FOREIGN KEY (Property_ID) REFERENCES Property(Property_ID)
    ON DELETE CASCADE
);
CREATE TABLE House_Rules (
    Property_ID INT,
    Information VARCHAR(500) NOT NULL,
    PRIMARY KEY (Property_ID, Information),
    FOREIGN KEY (Property_ID) REFERENCES Property(Property_ID)
    ON DELETE CASCADE
);
CREATE TABLE Property_Listing (
    Property_ID INT,
    Listing_ID INT,
    Date DATE NOT NULL,
    Service_Fee DECIMAL(10,2) NOT NULL,
    Cost_Per_Night DECIMAL(10,2) NOT NULL,
    Cleaning_Fee DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (Listing_ID),
    FOREIGN KEY (Property_ID) REFERENCES Property(Property_ID)
    ON DELETE CASCADE
);
CREATE TABLE Payment_Method (
    Payment_ID INT,
    User_ID INT,
    Zip_Code VARCHAR(50) NOT NULL,
    Country VARCHAR(100) NOT NULL,
    CVV VARCHAR(10) NOT NULL,
    Card_Number INT(20) NOT NULL,
    PRIMARY KEY (Payment_ID),
    FOREIGN KEY (User_ID) REFERENCES User(User_ID)  
    ON DELETE CASCADE
);
CREATE TABLE Has_Payment (
    Host_ID INT,
    Payout_ID INT,
    PRIMARY KEY (Host_ID, Payout_ID),
    FOREIGN KEY (Host_ID) REFERENCES Host(User_ID)  
    ON DELETE CASCADE,
    FOREIGN KEY (Payout_ID) REFERENCES Payout_Method(Payout_ID)  
    ON DELETE CASCADE
);
CREATE TABLE User_Payment_Method (
    User_ID INT,
    Payment_ID INT,
    PRIMARY KEY (User_ID, Payment_ID),
    FOREIGN KEY (User_ID) REFERENCES User(User_ID)  
    ON DELETE CASCADE,
    FOREIGN KEY (Payment_ID) REFERENCES Payment_Method(Payment_ID)  
    ON DELETE CASCADE
);
CREATE TABLE User_Saves_Property (
    User_ID INT,
    Property_ID INT,
    PRIMARY KEY (User_ID, Property_ID),
    FOREIGN KEY (User_ID) REFERENCES User(User_ID)  
    ON DELETE CASCADE,
    FOREIGN KEY (Property_ID) REFERENCES Property(Property_ID)  
    ON DELETE CASCADE
);
CREATE TABLE Messages (
    User1_ID INT,
    User2_ID INT,
    Contents VARCHAR(1000) NOT NULL,
    Date DATE,
    PRIMARY KEY (User1_ID, User2_ID),
    FOREIGN KEY (User1_ID) REFERENCES User(User_ID)  
    ON DELETE CASCADE,
    FOREIGN KEY (User2_ID) REFERENCES User(User_ID)  
    ON DELETE CASCADE
);
CREATE TABLE User_Saves_Experience (
    User_ID INT,
    Experience_ID INT,
    PRIMARY KEY (User_ID, Experience_ID),
    FOREIGN KEY (User_ID) REFERENCES User(User_ID)  
    ON DELETE CASCADE,
    FOREIGN KEY (Experience_ID) REFERENCES Experience(Experience_ID)  
    ON DELETE CASCADE
);
CREATE TABLE What_To_Bring (
    Experience_ID INT,
    List_Item VARCHAR(255),
    PRIMARY KEY (Experience_ID, List_Item),
    FOREIGN KEY (Experience_ID) REFERENCES Experience(Experience_ID)  
    ON DELETE CASCADE
);
CREATE TABLE In_Person_Experience (
    Experience_ID INT,
    Address VARCHAR(50) NOT NULL,
    Location_Description VARCHAR(1000),
    Equipment_Description VARCHAR(1000),
    Drinks_Description VARCHAR(1000),
    Transportation_Description VARCHAR(1000),
    PRIMARY KEY (Experience_ID),
    FOREIGN KEY (Experience_ID) REFERENCES Experience(Experience_ID)  
    ON DELETE CASCADE
);
CREATE TABLE Online_Experience (
    Experience_ID INT,
    Zoom_Link VARCHAR(100) NOT NULL,
    PRIMARY KEY (Experience_ID),
    FOREIGN KEY (Experience_ID) REFERENCES Experience(Experience_ID)  
    ON DELETE CASCADE
);
CREATE TABLE Experience_Listing (
    Experience_ID INT,
    Listing_ID INT,
    Day DATE,
    Time TIME,
    Cost_Per_Person DECIMAL(10,2),
    PRIMARY KEY (Experience_ID, Listing_ID),
    FOREIGN KEY (Experience_ID) REFERENCES Experience(Experience_ID)  
    ON DELETE CASCADE,
    FOREIGN KEY (Listing_ID) REFERENCES Property_Listing(Listing_ID)  
    ON DELETE CASCADE
);
CREATE TABLE Purchases (
    Purchase_ID INT,
    User_ID INT,
    Listing_ID INT,
    Confirmation_Code INT,
    Number_Of_People INT,
    Rate DECIMAL(10,2),
    Start_Date DATE,
    End_Date DATE,
    PRIMARY KEY(Purchase_ID),
    FOREIGN KEY (User_ID) REFERENCES User(User_ID)  
    ON DELETE SET NULL,
    FOREIGN KEY (Listing_ID) REFERENCES Property_Listing(Listing_ID)  
    ON DELETE SET NULL
);
CREATE TABLE Reviews (
    User_ID INT,
    Listing_ID INT,
    Overall_Rating DECIMAL(3,2),
    Location_Rating DECIMAL(3,2),
    Accuracy_Rating DECIMAL(3,2),
    Value_Rating DECIMAL(3,2),
    Check_In_Rating DECIMAL(3,2),
    Communication_Rating DECIMAL(3,2),
    Cleanliness_Rating DECIMAL(3,2),
    Date DATE,
    Review_Text VARCHAR(1000),
    PRIMARY KEY(User_ID, Listing_ID),
    FOREIGN KEY (User_ID) REFERENCES User(User_ID)  
    ON DELETE CASCADE,
    FOREIGN KEY (Listing_ID) REFERENCES Property_Listing(Listing_ID)  
    ON DELETE CASCADE
);
CREATE TABLE Financial_Receipt (
    Receipt_ID INT,
    Payout_ID INT,
    Purchase_ID INT,
    Payment_ID INT,
    Taxes DECIMAL(10,2) NOT NULL,
    Service_Fee DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (Receipt_ID),
    FOREIGN KEY (Payout_ID) REFERENCES Payout_Method(Payout_ID)  
    ON DELETE SET NULL,
    FOREIGN KEY (Purchase_ID) REFERENCES Purchases(Purchase_ID)  
    ON DELETE SET NULL,
    FOREIGN KEY (Payment_ID) REFERENCES Payment_Method(Payment_ID)  
    ON DELETE SET NULL  
);