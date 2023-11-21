USE us_west_hotel;

DROP TABLE IF EXISTS staff;
CREATE TABLE staff (
    stfID VARCHAR(45) PRIMARY KEY,
    stfFirst VARCHAR(45) NOT NULL,
    stfLast VARCHAR(45) NOT NULL
);
DROP TABLE IF EXISTS manager;
CREATE TABLE manager (
    managerID VARCHAR(45) PRIMARY KEY,
    managerFirstName VARCHAR(45) NOT NULL,
    managerLastName VARCHAR(45) NOT NULL,
    managerBirthday DATE NOT NULL,
    managerSalary INT NOT NULL CHECK (managerSalary > 0),
    managerBonus INT
);
DROP TABLE IF EXISTS hotel;
CREATE TABLE hotel (
    htlID VARCHAR(45) PRIMARY KEY,
    htlAddress VARCHAR(60) NOT NULL,
    noOfRooms INT NOT NULL CHECK (noOfRooms > 0),
    htlManagerID VARCHAR(45) REFERENCES manager(managerID)
);
DROP TABLE IF EXISTS hotelClient;
CREATE TABLE hotelClient (
    hcID VARCHAR(45) PRIMARY KEY,
    hcAddress VARCHAR(60),
    hcFirst VARCHAR(45) NOT NULL,
    hcLast VARCHAR(45) NOT NULL,
    hcReferenceID VARCHAR(45) REFERENCES hotelClient(hcID)
);
DROP TABLE IF EXISTS suite;
CREATE TABLE suite (
    sutNumber INT,
    htlID VARCHAR(45) REFERENCES hotel(htlID),
    sutNoOfBeds INT NOT NULL CHECK (sutNoOfBeds > 0),
    bkCheckInDate DATE,
    bkCheckOutDate DATE,
    clientID VARCHAR(45) REFERENCES hotelClient(hcID),
    PRIMARY KEY (sutNumber, htlID)
);
DROP TABLE IF EXISTS managerPhoneNumbers;
CREATE TABLE managerPhoneNumbers (
    phoneNumber VARCHAR(45),
    managerID VARCHAR(45) REFERENCES manager(managerID),
    PRIMARY KEY (phoneNumber, managerID)
);
DROP TABLE IF EXISTS cleans;
CREATE TABLE cleans (
    sutNumber INT REFERENCES suite(sutNumber),
    htlID VARCHAR(45) REFERENCES suite(htlID),
    stfID VARCHAR(45) REFERENCES staff(stfID),
    PRIMARY KEY (sutNumber, htlID, stfID)
);

INSERT INTO staff(stfID, stfFirst, stfLast) 
VALUES 
('STF-12345', 'Harry', 'Styles'),
('STF-98765', 'Celine', 'Dion'),
('STF-31415', 'Leonhard', 'Euler'),
('STF-67890', 'Margaret', 'Atwood'),
('STF-12410', 'Christian', 'Bale'),
('STF-12515', 'Shawn', 'Michaels'),
('STF-16767', 'George', 'Washington'),
('STF-54774', 'Mel', 'Gibson'),
('STF-21252', 'Serena', 'Williams'),
('STF-89639', 'Dwight', 'Eisenhower'),
('STF-34698', 'Robert', 'Oppenheimer');

INSERT INTO manager(managerID, managerFirstName, managerLastName, managerBirthday, managerSalary, managerBonus) 
VALUES 
('MNG-12345', 'Satoru', 'Gojo', '1989-12-07', 100000, 20000),
('MNG-31415', 'Gottfried', 'Leibniz', '1946-07-01', 120000, 15000),
('MNG-89898', 'Jennette', 'McCurdy', '1992-06-26', 115000, NULL),
('MNG-19282', 'LeBron', 'James', '1998-05-07', 300000, NULL);

INSERT INTO hotel(htlID, htlAddress, noOfRooms, htlManagerID) 
VALUES 
('HTL-12345', '6728 W Roosevelt St, Phoenix, Arizona', 256, 'MNG-12345'),
('HTL-98765', '901 Palm Walk, Tempe, Arizona', 211, 'MNG-31415'),
('HTL-77777', '22800 N 67th Ave, Glendale, Arizona', 158, 'MNG-12345'),
('HTL-14715', '10541 Bolsa Ave, Garden Grove, California', 274, 'MNG-89898'),
('HTL-99898', '13752 Francisquito Ave, Baldwin Park, California', 364, 'MNG-89898'),
('HTL-33112', '334 1st Ave N, Seattle, Washington', 667, 'MNG-19282'),
('HTL-76412', '1 N Center Ct St, Portland, Oregon', 423, 'MNG-19282');

INSERT INTO hotelClient(hcID, hcAddress, hcFirst, hcLast, hcReferenceID) 
VALUES 
('HC-12345', '4701 W Thunderbird Rd, Glendale, Arizona', 'Steve', 'Harvey', 'HC-31415'),
('HC-31415', '681 E Apache Blvd, Tempe, Arizona', 'Tony', 'Stark', NULL),
('HC-12589', '1320 E Broadway Rd, Tempe, Arizona', 'Toji', 'Fushiguro', 'HC-31415'),
('HC-33998', '3584 S Figueroa St, Los Angeles, California', 'John', 'Lennon', 'HC-12345'),
('HC-22859', '797 3rd Ave, New York, New York', 'Bilbo', 'Baggins', NULL);

INSERT INTO suite(sutNumber, htlID, sutNoOfBeds, bkCheckInDate, bkCheckOutDate, clientID)
VALUES 
(113, 'HTL-12345', 2, '2023-08-05', '2023-08-08', 'HC-31415'),
(221, 'HTL-12345', 2, '2023-10-15', '2023-10-22', 'HC-12345'),
(316, 'HTL-31415', 3, NULL, NULL, NULL),
(415, 'HTL-31415', 3, NULL, NULL, NULL),
(818, 'HTL-77777', 3, NULL, NULL, NULL),
(153, 'HTL-98765', 2, '2022-09-28', '2022-10-02', 'HC-22859'),
(415, 'HTL-14715', 4, NULL, NULL, NULL),
(501, 'HTL-14715', 3, NULL, NULL, NULL),
(136, 'HTL-33112', 1, '2023-05-05', '2023-05-10', 'HC-12589'),
(331, 'HTL-76412', 3, NULL, NULL, NULL),
(112, 'HTL-76412', 2, NULL, NULL, NULL),
(551, 'HTL-99898', 2, '2023-01-01', '2023-01-10', 'HC-33998'),
(215, 'HTL-33112', 3, NULL, NULL, NULL);

INSERT INTO managerPhoneNumbers(phoneNumber, managerID) 
VALUES 
('480-123-3141', 'MNG-12345'),
('480-331-1521', 'MNG-12345'),
('602-215-1586', 'MNG-31415'),
('623-515-8857', 'MNG-31415'),
('315-125-1125', 'MNG-89898'),
('125-289-9498', 'MNG-19282');

INSERT INTO cleans(sutNumber, htlID, stfID) 
VALUES 
(113, 'HTL-12345', 'STF-12345'),
(221, 'HTL-12345', 'STF-12345'),
(316, 'HTL-31415', 'STF-98765'),
(316, 'HTL-31415', 'STF-31415'),
(415, 'HTL-31415', 'STF-98765'),
(818, 'HTL-77777', 'STF-67890'),
(818, 'HTL-77777', 'STF-12410'),
(153, 'HTL-98765', 'STF-12410'),
(415, 'HTL-14715', 'STF-12515'),
(501, 'HTL-14715', 'STF-16767'),
(136, 'HTL-33112', 'STF-54774'),
(331, 'HTL-76412', 'STF-21252'),
(112, 'HTL-76412', 'STF-21252'),
(551, 'HTL-99898', 'STF-89639'),
(215, 'HTL-33112', 'STF-34698');
