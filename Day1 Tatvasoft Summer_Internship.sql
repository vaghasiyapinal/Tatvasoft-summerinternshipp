CREATE DATABASE MissionPortal;

-- Country Table
CREATE TABLE Country(
	Id int PRIMARY KEY,
	CountryName varchar(100)
);
select * from Country;

insert into Country (Id, CountryName) VALUES 
(1, 'INDIA'),(2, 'UNITED STATES');

ALTER TABLE Country
RENAME COLUMN ID TO CountryID;

UPDATE Country
SET CountryName = 'United States'
where CountryID=1;

UPDATE Country
SET CountryName = 'Canada'
where CountryID=2;

-- City Table
CREATE TABLE City (CityID int PRIMARY KEY, 
	CountryID int,
	CityName varchar(100),
	FOREIGN KEY (CountryID) REFERENCES Country(CountryID)
	);

INSERT INTO City(CityID, CountryID,CityName) VALUES
(1,1, 'New York'),
(2,1,'Los Angeles'),
(3,2,'Toronto');

select * from City;

-- MissionApplication
CREATE TABLE MissionApplication(
    MissionApplicationId INT PRIMARY KEY,
    "MissionId" INT,
    "UserId" INT,
    "AppliedDate" TIMESTAMP,
    "Status" BOOLEAN,
    "Sheet" INT
	
);
INSERT INTO MissionApplication (MissionApplicationId, "MissionId", "UserId", "AppliedDate", "Status", "Sheet")
VALUES
    (1, 1, 1, '2023-05-15 10:30:00', true, 1),
    (2, 2, 2, '2023-05-18 14:45:00', false, 2);

SELECT * FROM MissionApplication;

--Missions Table

CREATE TABLE Missions (
     MissionsId INT PRIMARY KEY,
     MissionTitle VARCHAR(255),
     MissionDescription TEXT,
     MissionOrganisationName VARCHAR(255),
     MissionOrganisationDetail  TEXT,
     CountryID INT,
     CityID INT,
     StartDate DATE,
     EndDate DATE,
     MissionType VARCHAR(255),
    TotalSheets INT,
    RegistrationDeadLineDate DATE,
    MissionThemeId VARCHAR(255),
    MissionSkillId VARCHAR(255),
    MissionImages VARCHAR(255),
    MissionDocuments VARCHAR(255),
    MissionAvilability VARCHAR(255),
    MissionVideoUrl VARCHAR(255),
    FOREIGN KEY (CountryID) REFERENCES Country(CountryID),
    FOREIGN KEY (CityID) REFERENCES City(CityID)
);

INSERT INTO Missions (MissionsId, MissionTitle, MissionDescription, MissionOrganisationName, MissionOrganisationDetail, CountryId, CityId, StartDate, EndDate, MissionType, TotalSheets, RegistrationDeadLineDate, MissionThemeId, MissionSkillId, MissionImages, MissionDocuments, MissionAvilability, MissionVideoUrl)
VALUES
    (1, 'Beach Cleanup', 'Help clean up the local beach', 'Ocean Conservancy', 'Non-profit organization focused on ocean conservation', 1, 1, '2023-06-01', '2023-06-15', 'Environmental', 10, '2023-05-25', '1', '1', 'beach_cleanup.jpg', 'cleanup_guidelines.pdf', 'Weekends', 'https://example.com/beach_cleanup');

SELECT * FROM Missions;

--MissionSkill Table
CREATE TABLE MissionSkill (
    MissionSkillId INT PRIMARY KEY,
    SkillName VARCHAR(255),
    Status VARCHAR(255)
);

INSERT INTO MissionSkill (MissionSkillId, SkillName, Status)
VALUES
    (1, 'Physical Labor', 'Active'),
    (2, 'Environmental Awareness', 'Active');

SELECT * FROM MissionSkill;

-- MissionTheme Table
CREATE TABLE MissionTheme (
    MissionThemeId INT PRIMARY KEY,
    ThemeName VARCHAR(255),
    Status VARCHAR(255)
);

INSERT INTO MissionTheme (MissionThemeId, ThemeName, Status)
VALUES
    (1, 'Environmental Protection', 'Active'),
    (2, 'Community Development', 'Active');

SELECT * FROM MissionTheme;

-- User Table
CREATE TABLE "User" (
    UserId INT PRIMARY KEY,
    FirstName VARCHAR(255),
    LastName VARCHAR(255),
    PhoneNumber VARCHAR(20),
    EmailAddress VARCHAR(255),
    UserType VARCHAR(255),
    "Password" VARCHAR(255)
);

INSERT INTO "User" (UserId, FirstName, LastName, PhoneNumber, EmailAddress, UserType, "Password")
VALUES
    (1, 'John', 'Doe', '1234567890', 'john.doe@gmail.com', 'Volunteer', 'password123'),
    (2, 'Jane', 'Smith', '9876543210', 'jane.smith@gmail.com', 'Volunteer', 'securepass');

SELECT * FROM "User";

--UserDetail Table

CREATE TABLE UserDetail (
    UserDetailId INT PRIMARY KEY,
    UserId INT,
    "Name" VARCHAR(255),
    Surname VARCHAR(255),
    EmployeeId VARCHAR(255),
    Manager VARCHAR(255),
    Title VARCHAR(255),
    Department VARCHAR(255),
    MyProfile TEXT,
    WhyIVolunteer TEXT,
    CountryID INT,
    CityID INT,
    Availability VARCHAR(255),
    LinkdInUrl VARCHAR(255),
    MySkills TEXT,
    UserImage VARCHAR(255),
    Status BOOLEAN,
    FOREIGN KEY (UserId) REFERENCES "User"(UserId),
    FOREIGN KEY (CountryID) REFERENCES Country(CountryID),
    FOREIGN KEY (CityID) REFERENCES City(CityId)
);

INSERT INTO UserDetail (UserDetailId, UserId, "Name", Surname, EmployeeId, Manager, Title, Department, MyProfile, WhyIVolunteer, CountryID, CityID, Availability, LinkdInUrl, MySkills, UserImage, Status)
VALUES
    (1, 1, 'John', 'Doe', 'EMP001', 'Jane Smith', 'Software Engineer', 'IT', 'Passionate about technology and helping others.', 'I volunteer to give back to the community.', 1, 1, 'Weekends', 'https://linkedin.com/john.doe', 'Programming, problem-solving', 'john_doe.jpg', true);

SELECT * FROM UserDetail;

--UserSkills Table
CREATE TABLE UserSkills(
    UserSkillsId INT PRIMARY KEY,
    Skills VARCHAR(255),
    UserId INT,
    FOREIGN KEY (UserId) REFERENCES "User"(UserId)
);

INSERT INTO UserSkills (UserSkillsId, Skills, UserId)
VALUES
    (1, 'Python', 1),
    (2, 'Java', 1),
    (3, 'JavaScript', 2);

SELECT * FROM UserSkills;

-- Filtering , Grouping ,Joins And Sub Query on Country Table

-- Select all columns from the Country table
SELECT * FROM Country;

-- Filter countries by name
SELECT * FROM Country WHERE CountryName LIKE '%United%';

-- Group countries by name and count the number of countries
SELECT CountryName, COUNT(*) AS CountryCount
FROM Country
GROUP BY CountryName;

-- Join with the City table to get cities for each country
SELECT c.CountryName, ci.CityName
FROM Country c
JOIN City ci ON c.CountryID = ci.CountryID;

-- Subquery to get countries with cities
SELECT *
FROM Country
WHERE CountryID IN (
    SELECT CountryID
    FROM City WHERE CountryID=2
);


--Filtering , Grouping ,Joins And Sub Query on Country Table

-- Select all columns from the City table
SELECT * FROM City;

-- Filter cities by country ID
SELECT * FROM City WHERE CountryID = 1;

-- Group cities by country ID and count the number of cities
SELECT CountryID ,COUNT(*) AS CityCount
FROM City
GROUP BY CountryID;

-- Join with the Country table to get country names for each city
SELECT ci.CityName, c.CountryName
FROM City ci
JOIN Country c ON ci.CountryID = c.CountryID;

-- Subquery to get cities for a specific country
SELECT *
FROM City
WHERE CountryID = (
    SELECT CountryID
    FROM Country
    WHERE CountryName = 'United States'
);