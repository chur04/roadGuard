CREATE DATABASE PRJASS1 ; 

USE PRJASS1 ; 

CREATE TABLE Users (
    UserID INT PRIMARY KEY IDENTITY(1,1),
    FullName VARCHAR(100) NOT NULL,
    Email VARCHAR(100) NOT NULL UNIQUE,
    Password VARCHAR(255) NOT NULL,
    Role VARCHAR(20) CHECK (Role IN ('Citizen', 'TrafficPolice')) NOT NULL,
    Phone VARCHAR(15) NOT NULL,
    Address TEXT
);

CREATE TABLE Vehicles (
    VehicleID INT PRIMARY KEY IDENTITY(1,1),
    PlateNumber VARCHAR(15) NOT NULL UNIQUE,
    OwnerID INT NOT NULL,
    Brand VARCHAR(50),
    Model VARCHAR(50),
    ManufactureYear INT,  
    FOREIGN KEY (OwnerID) REFERENCES Users(UserID)
);

CREATE TABLE Reports (
    ReportID INT PRIMARY KEY IDENTITY(1,1),
    ReporterID INT NOT NULL,
    ViolationType VARCHAR(50) NOT NULL,
    Description TEXT NOT NULL,
    PlateNumber VARCHAR(15) NOT NULL,
    ImageURL TEXT,
    VideoURL TEXT,
    Location VARCHAR(255) NOT NULL,
    ReportDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    Status VARCHAR(10) DEFAULT 'Pending',  
    ProcessedBy INT NULL,
    FOREIGN KEY (ReporterID) REFERENCES Users(UserID),
    FOREIGN KEY (ProcessedBy) REFERENCES Users(UserID),
    FOREIGN KEY (PlateNumber) REFERENCES Vehicles(PlateNumber)
);

CREATE TABLE Violations (
    ViolationID INT PRIMARY KEY IDENTITY(1,1),
    ReportID INT NOT NULL,
    PlateNumber VARCHAR(15) NOT NULL,
    ViolatorID INT NULL,
    FineAmount DECIMAL(10,2) NOT NULL,
    FineDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    PaidStatus BIT DEFAULT 0,  
    FOREIGN KEY (ReportID) REFERENCES Reports(ReportID),
    FOREIGN KEY (PlateNumber) REFERENCES Vehicles(PlateNumber),
    FOREIGN KEY (ViolatorID) REFERENCES Users(UserID)
);

CREATE TABLE Notifications (
    NotificationID INT PRIMARY KEY IDENTITY(1,1),
    UserID INT NOT NULL,
    Message TEXT NOT NULL,
    PlateNumber VARCHAR(15) NULL,
    SentDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    IsRead BIT DEFAULT 0,  
    FOREIGN KEY (UserID) REFERENCES Users(UserID),
    FOREIGN KEY (PlateNumber) REFERENCES Vehicles(PlateNumber)
);



CREATE TABLE Appeals (
    AppealID INT PRIMARY KEY IDENTITY(1,1),
    ViolationID INT NOT NULL,
    ViolatorID INT NOT NULL,
    AppealText TEXT NOT NULL,
    AppealDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    Status VARCHAR(20) DEFAULT 'Pending',  -- Pending, Approved, Rejected
    AdminResponse TEXT NULL,
    ResponseDate DATETIME NULL,
    ImageURL TEXT NULL, 
    VideoURL TEXT NULL , 
    FOREIGN KEY (ViolationID) REFERENCES Violations(ViolationID),
    FOREIGN KEY (ViolatorID) REFERENCES Users(UserID)
);



ALTER TABLE Users ALTER COLUMN FullName NVARCHAR(100) NOT NULL;
ALTER TABLE Users ALTER COLUMN Address NVARCHAR(MAX);
ALTER TABLE Reports ALTER COLUMN ViolationType NVARCHAR(50) NOT NULL;
ALTER TABLE Reports ALTER COLUMN Description NVARCHAR(MAX) NOT NULL;
ALTER TABLE Reports ALTER COLUMN Location NVARCHAR(255) NOT NULL;
ALTER TABLE Appeals ALTER COLUMN AdminResponse NVARCHAR(MAX);
ALTER TABLE Appeals ALTER COLUMN AppealText NVARCHAR(MAX) NOT NULL;
ALTER TABLE Notifications ALTER COLUMN Message NVARCHAR(MAX) NOT NULL;



INSERT INTO Users (FullName, Email, Password, Role, Phone, Address) VALUES
(N'Nguyễn Thị An', 'nguyenthian@example.com', 'password123', 'Citizen', '0987654321', N'123 Trần Phú, Hà Nội'), -- ID = 1
(N'Trần Văn Bình', 'tranbinh@example.com', 'password456', 'Citizen', '0912345678', N'456 Nguyễn Huệ, TP. Hồ Chí Minh'), -- ID = 2
(N'Hoàng Thị Mai', 'hoangmai@example.com', 'password101', 'Citizen', '0977889900', N'101 Hai Bà Trưng, Đà Nẵng'), -- ID = 3
(N'Lê Văn C', 'levanc@example.com', 'password789', 'TrafficPolice', '0112233445', N'789 Đường, Đà Nẵng'); -- ID = 4


INSERT INTO Vehicles (PlateNumber, OwnerID, Brand, Model, ManufactureYear) VALUES
('29A-67890', 1, 'Honda', 'Civic', 2018),         -- Chủ sở hữu: Nguyễn Thị An
('43C-11223', 2, 'VinFast', 'Lux A2.0', 2022),    -- Chủ sở hữu: Trần Văn Bình
('51G-44556', 3, 'Yamaha', 'Exciter', 2021);      -- Chủ sở hữu: Hoàng Thị Mai


