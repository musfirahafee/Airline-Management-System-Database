-- creating database

CREATE DATABASE Airline_Management_System;
USE Airline_Management_System;

-- independent tables
-- table of passport details

CREATE TABLE Passport_Detail(
Passport_No VARCHAR (20) PRIMARY KEY UNIQUE,
Nationality VARCHAR (50) 
);

DESC Passport_Detail;

-- table of admin role type

CREATE TABLE Admin_Role_Type(
Role_Type VARCHAR(30) PRIMARY KEY,
Dept_Code VARCHAR(10) NOT NULL
);

DESC Admin_Role_Type;

-- table of crew role

CREATE TABLE Crew_Role(
Role VARCHAR(30) PRIMARY KEY,
Qualification VARCHAR(100)
);

DESC Crew_Role;

-- table of flight route

CREATE TABLE Flight_Route(
Flight_No VARCHAR(10) PRIMARY KEY,
Origin CHAR(3) NOT NULL,
Destination CHAR(3) NOT NULL
);

DESC Flight_Route;

-- table of aircraft model 

CREATE TABLE Aircraft_Model(
Model VARCHAR(50) PRIMARY KEY,
Capacity INT NOT NULL
); 

DESC Aircraft_Model;

-- dependent tables
-- table of passenger

CREATE TABLE Passenger(
Passenger_ID INT PRIMARY KEY AUTO_INCREMENT,
Passport_No VARCHAR (20),
CONSTRAINT fk_Passport
FOREIGN KEY (Passport_No)
REFERENCES Passport_Detail (Passport_No),
F_name VARCHAR (50) NOT NULL,
L_name VARCHAR (50) NOT NULL,
DOB DATE,
E_mail VARCHAR (100) UNIQUE,
Phone_No VARCHAR (20), 
Frequent_Flyer_No VARCHAR(30) UNIQUE
);

DESC Passenger;

-- table of Admin/Airline Staff

CREATE TABLE Admin_Airline_Staff(
Staff_ID INT PRIMARY KEY AUTO_INCREMENT,
Role_Type VARCHAR(30),
CONSTRAINT fk_Staff
FOREIGN KEY (Role_Type)
REFERENCES Admin_Role_Type (Role_Type),
F_Name VARCHAR (20) NOT NULL,
L_name VARCHAR (20) NOT NULL,
User_Name VARCHAR(50) UNIQUE NOT NULL,
Password_Hash VARCHAR(255) NOT NULL
);

DESC Admin_Airline_Staff;

-- table of crew 

CREATE TABLE Crew(
Crew_ID INT PRIMARY KEY,
Role VARCHAR(30),
CONSTRAINT fk_Crew_Role
FOREIGN KEY (Role)
REFERENCES Crew_Role (Role),
F_name VARCHAR (50) NOT NULL,
L_name VARCHAR (50) NOT NULL,
Availability_Status VARCHAR(20)
);

DESC Crew;

-- table of aircraft

CREATE TABLE Aircraft(
Aircraft_ID VARCHAR(20) PRIMARY KEY,
Model VARCHAR(50),
CONSTRAINT fk_Aircraft_Model
FOREIGN KEY (Model)
REFERENCES Aircraft_Model (Model),
Status VARCHAR(20) NOT NULL
);

DESC Aircraft;

-- TRANSACTIONAL SCHEDULES
-- table of flight

CREATE TABLE Flight(
Flight_ID VARCHAR(20) PRIMARY KEY,
Aircraft_ID VARCHAR(20),
CONSTRAINT fk_Flight_Aircraft_ID
FOREIGN KEY (Aircraft_ID)
REFERENCES Aircraft(Aircraft_ID),
Staff_ID INT,
CONSTRAINT fk_Flight_Staff_ID
FOREIGN KEY (Staff_ID)
REFERENCES Admin_Airline_Staff(Staff_ID),
Flight_No VARCHAR(10),
CONSTRAINT fk_Flight_No
FOREIGN KEY (Flight_No)
REFERENCES Flight_Route(Flight_No),
Departure_Time DATETIME NOT NULL,
Arrival_Time DATETIME NOT NULL,
Status VARCHAR(15) NOT NULL
);

DESC Flight;

-- TRANSACTIONAL TRANSACTION ENTITIES
-- table of reservation
CREATE TABLE Reservation(
Reservation_ID CHAR(6) PRIMARY KEY NOT NULL,
Passenger_ID INT,
CONSTRAINT fk_Passenger
FOREIGN KEY (Passenger_ID)
REFERENCES Passenger (Passenger_ID),
Flight_ID VARCHAR(20),
CONSTRAINT fk_Reservation_Flight_ID
FOREIGN KEY (Flight_ID)
REFERENCES Flight(Flight_ID),
Reservation_Date DATE NOT NULL,
Seat_No VARCHAR(5),
Reservation_Status VARCHAR(20) NOT NULL,
Class_Tier VARCHAR(20) NOT NULL
);

DESC Reservation;

-- table of payment

CREATE TABLE Payment(
Payment_ID VARCHAR(20) PRIMARY KEY,
Reservation_ID CHAR(6),
CONSTRAINT fk_Payment
FOREIGN KEY (Reservation_ID)
REFERENCES Reservation(Reservation_ID),
Amount DECIMAL(10,2) NOT NULL,
Payment_Status VARCHAR(20) NOT NULL,
Payment_Date DATETIME NOT NULL,
Payment_Method VARCHAR(30) NOT NULL
);

DESC Payment;

-- table of flight  crew

CREATE TABLE Flight_Crew(
Flight_Crew_ID INT PRIMARY KEY,
Flight_ID VARCHAR(20),
CONSTRAINT fk_Flight_ID
FOREIGN KEY (Flight_ID)
REFERENCES Flight(Flight_ID),
Crew_ID INT,
CONSTRAINT fk_Crew_ID
FOREIGN KEY (Crew_ID)
REFERENCES Crew(Crew_ID),
Assignment_Role VARCHAR(30) 
);

DESC Flight_Crew;

-- table of maintenance task

CREATE TABLE Maintenance_Task(
Maintenance_ID INT PRIMARY KEY,
Aircraft_ID VARCHAR(20),
CONSTRAINT fk_Aircraft_ID
FOREIGN KEY (Aircraft_ID)
REFERENCES Aircraft(Aircraft_ID),
Staff_ID INT,
CONSTRAINT fk_Staff_ID
FOREIGN KEY (Staff_ID)
REFERENCES Admin_Airline_Staff(Staff_ID),
Status VARCHAR(20) NOT NULL
);

DESC Maintenance_Task;


-- INSERTING DATA IN THE table 


-- Passport details
INSERT INTO Passport_Detail (Passport_No, Nationality) VALUES
('AB1234567', 'Pakistani'), ('CD2345678', 'Pakistani'), ('EF3456789', 'Pakistani'),
('GH4567890', 'Pakistani'), ('IJ5678901', 'Pakistani'), ('KL6789012', 'Pakistani'),
('MN7890123', 'Pakistani'), ('OP8901234', 'Pakistani'), ('QR9012345', 'Pakistani'),
('ST0123456', 'Pakistani'), ('UV1234567', 'Pakistani'), ('WX2345678', 'Pakistani'),
('YZ3456789', 'Pakistani'), ('AA4567890', 'Pakistani'), ('BB5678901', 'Pakistani'),
('CC6789012', 'Pakistani'), ('DD7890123', 'Pakistani'), ('EE8901234', 'Pakistani'),
('FF9012345', 'Pakistani'), ('GG0123456', 'Pakistani'), ('HH1234567', 'Pakistani'),
('II2345678', 'Pakistani'), ('JJ3456789', 'Pakistani'), ('KK4567890', 'Pakistani'),
('LL5678901', 'Pakistani'), ('MM6789012', 'Pakistani'), ('NN7890123', 'Pakistani'),
('OO8901234', 'Pakistani'), ('PP9012345', 'Pakistani'), ('QQ0123456', 'Pakistani'),
('RR1234567', 'Pakistani'), ('SS2345678', 'Pakistani'), ('TT3456789', 'Pakistani'),
('UU4567890', 'Pakistani'), ('VV5678901', 'Pakistani'); 

-- admin role type
INSERT INTO Admin_Role_Type (Role_Type, Dept_Code) VALUES
('Gate_Agent', 'GRND_OPS'),
('Ticketing_Officer', 'SALES'),
('Flight_Dispatcher', 'FLT_OPS'),
('Finance_Analyst', 'FINANCE'),
('IT_Support', 'IT_DEPT');

-- crew role
INSERT INTO Crew_Role (Role, Qualification) VALUES
('Captain', 'ATPL Licence - 5000+ Hours Widebody'),
('First_Officer', 'Commercial Pilot Licence - Multi-Engine'),
('Purser', 'Senior Cabin Crew Management Certificate'),
('Flight_Attendant', 'Aviation Safety & Customer Service Dip.');

-- flight route
INSERT INTO Flight_Route (Flight_No, Origin, Destination) VALUES
('PK300', 'KHI', 'ISB'), ('PK304', 'KHI', 'LHE'), ('PK306', 'KHI', 'LHE'),
('PK781', 'ISB', 'YYZ'), ('PK782', 'YYZ', 'ISB'), ('PK211', 'ISB', 'DXB'),
('PK212', 'DXB', 'ISB'), ('PK757', 'LHE', 'LHR'), ('PK758', 'LHR', 'LHE'),
('PK605', 'ISB', 'GIL'); 

-- aircraft model
INSERT INTO Aircraft_Model (Model, Capacity) VALUES
('Boeing 777-300ER', 393),
('Boeing 777-200LR', 310),
('Airbus A320-200', 180),
('ATR 72-600', 70); 

-- admin airline staff
INSERT INTO Admin_Airline_Staff (Role_Type, F_Name, L_name, User_Name, Password_Hash) VALUES
('Ticketing_Officer', 'Kamran', 'Akmal', 'kamran.pia', 'hash_pass_101'),
('Ticketing_Officer', 'Ayesha', 'Khan', 'ayesha.k', 'hash_pass_102'),
('Gate_Agent', 'Zain', 'Ali', 'zain.ali', 'hash_pass_103'),
('Gate_Agent', 'Sana', 'Javed', 'sana.j', 'hash_pass_104'),
('Flight_Dispatcher', 'Tariq', 'Mehmood', 'tariq.ops', 'hash_pass_105'),
('Flight_Dispatcher', 'Bilal', 'Saeed', 'bilal.ops', 'hash_pass_106'),
('Finance_Analyst', 'Noman', 'Sheikh', 'noman.fin', 'hash_pass_107'),
('Finance_Analyst', 'Mariam', 'Riaz', 'mariam.r', 'hash_pass_108'),
('IT_Support', 'Fahad', 'Mustafa', 'fahad.it', 'hash_pass_109'),
('IT_Support', 'Amna', 'Ilyas', 'amna.it', 'hash_pass_110');

-- crew
INSERT INTO Crew (Crew_ID, Role, F_name, L_name, Availability_Status) VALUES
(8001, 'Captain', 'Asif', 'Raza', 'Available'),
(8002, 'Captain', 'Javed', 'Iqbal', 'Available'),
(8003, 'First_Officer', 'Haris', 'Rauf', 'Available'),
(8004, 'First_Officer', 'Saad', 'Khan', 'Standby'),
(9001, 'Purser', 'Nadia', 'Hussain', 'Available'),
(9002, 'Purser', 'Fatima', 'Ali', 'Available'),
(9003, 'Flight_Attendant', 'Hina', 'Altaf', 'Available'),
(9004, 'Flight_Attendant', 'Zoya', 'Nasir', 'Available'),
(9005, 'Flight_Attendant', 'Hamza', 'Abbasi', 'Standby'),
(9006, 'Flight_Attendant', 'Usman', 'Mukhtar', 'Available');

-- aircraft
INSERT INTO Aircraft (Aircraft_ID, Model, Status) VALUES
('AP-BHW', 'Boeing 777-300ER', 'Active'),
('AP-BID', 'Boeing 777-300ER', 'Active'),
('AP-BMH', 'Boeing 777-200LR', 'Active'),
('AP-BGZ', 'Boeing 777-200LR', 'Maintenance'),
('AP-BLB', 'Airbus A320-200', 'Active'),
('AP-BLC', 'Airbus A320-200', 'Active'),
('AP-BLD', 'Airbus A320-200', 'Active'),
('AP-BIE', 'Airbus A320-200', 'Active'),
('AP-BHO', 'ATR 72-600', 'Active'),
('AP-BHP', 'ATR 72-600', 'Active');

-- flight
INSERT INTO Flight (Flight_ID, Aircraft_ID, Staff_ID, Flight_No, Departure_Time, Arrival_Time, Status) VALUES
('PK304-260517', 'AP-BLC', 1, 'PK304', '2026-05-17 15:00:00', '2026-05-17 16:45:00', 'Scheduled'),
('PK781-260601', 'AP-BHW', 5, 'PK781', '2026-06-01 11:15:00', '2026-06-01 16:30:00', 'Scheduled');

-- passenger
INSERT INTO Passenger (Passport_No, F_name, L_name, DOB, E_mail, Phone_No, Frequent_Flyer_No) VALUES
('AB1234567', 'Muhammad', 'Ali', '1985-05-12', 'm.ali@email.pk', '+923001234567', 'PK-AWARDS-101'),
('CD2345678', 'Sayyeda', 'Rehana', '1978-11-23', 'rehana.bibi@email.pk', '+923219876543', NULL),
('EF3456789', 'Ahmed', 'Shah', '1992-02-15', 'ahmed.shah@email.pk', '+923334567890', 'PK-AWARDS-102'),
('GH4567890', 'Fatima', 'Zahra', '2000-08-30', 'fatima.z@email.com', '+923451122334', NULL),
('IJ5678901', 'Zubair', 'Khan', '1965-04-04', 'zubair.khan@email.com', '+923017654321', 'PK-AWARDS-103'),
('KL6789012', 'Ayesha', 'Siddiqua', '1995-12-12', 'ayesha.s@email.pk', '+923123456789', NULL),
('MN7890123', 'Omar', 'Farooq', '1988-07-19', 'omar.f@email.com', '+923229988776', NULL),
('OP8901234', 'Zainab', 'Bibi', '1972-01-01', 'zainab.bibi@email.pk', '+923345566778', NULL),
('QR9012345', 'Hamza', 'Malik', '1994-09-25', 'hamza.m@email.com', '+923028877665', 'PK-AWARDS-104'),
('ST0123456', 'Saniya', 'Mirza', '1991-06-14', 'saniya.m@email.com', '+923154433221', NULL),
('UV1234567', 'Bilal', 'Siddiqui', '1983-03-21', 'bilal.s@email.pk', '+923201122334', 'PK-AWARDS-105'),
('WX2345678', 'Mariam', 'Nawaz', '1979-10-05', 'mariam.n@email.com', '+923315544332', NULL),
('YZ3456789', 'Asad', 'Umar', '1970-08-11', 'asad.umar@email.pk', '+923056677889', NULL),
('AA4567890', 'Nida', 'Dar', '1989-01-29', 'nida.dar@email.com', '+923118899001', 'PK-AWARDS-106'),
('BB5678901', 'Fawad', 'Khan', '1981-11-29', 'fawad.k@email.pk', '+923234455667', NULL),
('CC6789012', 'Mahira', 'Khan', '1984-12-21', 'mahira.k@email.com', '+923367788990', NULL),
('DD7890123', 'Babar', 'Azam', '1994-10-15', 'babar.azam@email.pk', '+923071112223', 'PK-AWARDS-001'),
('EE8901234', 'Shaheen', 'Afridi', '2000-04-06', 'shaheen.a@email.pk', '+923464445556', 'PK-AWARDS-002'),
('FF9012345', 'Rizwan', 'Mohammad', '1992-06-01', 'm.rizwan@email.com', '+923177778889', 'PK-AWARDS-003'),
('GG0123456', 'Naseem', 'Shah', '2003-02-15', 'naseem.s@email.com', '+923259990001', NULL),
('HH1234567', 'Shadab', 'Khan', '1998-10-04', 'shadab.k@email.pk', '+923351113335', NULL),
('II2345678', 'Imran', 'Nazir', '1981-12-16', 'imran.n@email.com', '+923042224442', NULL),
('JJ3456789', 'Misbah', 'Ul-Haq', '1974-05-28', 'misbah.h@email.pk', '+923145556665', 'PK-AWARDS-107'),
('KK4567890', 'Younis', 'Khan', '1977-11-29', 'younis.k@email.com', '+923247778887', NULL),
('LL5678901', 'Inzamam', 'Ul-Haq', '1970-03-03', 'inzamam.h@email.pk', '+923348889998', NULL),
('MM6789012', 'Waqar', 'Younis', '1971-11-16', 'waqar.y@email.com', '+923063332221', NULL),
('NN7890123', 'Wasim', 'Akram', '1966-06-03', 'wasim.a@email.pk', '+923164443332', 'PK-AWARDS-000'),
('OO8901234', 'Shoaib', 'Akhtar', '1975-08-13', 'shoaib.a@email.com', '+923265554443', NULL),
('PP9012345', 'Sana', 'Mir', '1986-01-05', 'sana.mir@email.pk', '+923366665554', 'PK-AWARDS-108'),
('QQ0123456', 'Javeria', 'Khan', '1988-05-14', 'javeria.k@email.com', '+923087776665', NULL),
('RR1234567', 'Kamran', 'Khan', '1990-04-18', 'kamran.k@email.pk', '+923188887776', NULL),
('SS2345678', 'Ali', 'Zafar', '1980-05-18', 'ali.zafar@email.com', '+923289998887', NULL),
('TT3456789', 'Atif', 'Aslam', '1983-03-12', 'atif.aslam@email.pk', '+923381112221', 'PK-AWARDS-109'),
('UU4567890', 'Rahat', 'Ali', '1987-10-10', 'rahat.ali@email.com', '+923483334443', NULL),
('VV5678901', 'Abida', 'Parveen', '1954-02-20', 'abida.p@email.pk', '+923094445554', NULL); 

-- reservation
INSERT INTO Reservation (Reservation_ID, Passenger_ID, Flight_ID, Reservation_Date, Seat_No, Reservation_Status, Class_Tier) VALUES
('8PPP3G', 1, 'PK304-260517', '2026-05-01', '14A', 'Confirmed', 'Economy'),
('9XYZ4Q', 2, 'PK304-260517', '2026-05-02', '14B', 'Confirmed', 'Economy'),
('AB123C', 3, 'PK304-260517', '2026-05-02', '02A', 'Confirmed', 'Business'),
('DE456F', 4, 'PK304-260517', '2026-05-03', '15C', 'Confirmed', 'Economy'),
('GH789I', 5, 'PK304-260517', '2026-05-03', '16D', 'Confirmed', 'Economy'),
('JK012L', 6, 'PK304-260517', '2026-05-04', '17E', 'Confirmed', 'Economy'),
('MN345O', 7, 'PK304-260517', '2026-05-04', '18F', 'Confirmed', 'Economy'),
('PQ678R', 8, 'PK304-260517', '2026-05-05', '19A', 'Confirmed', 'Economy'),
('ST901U', 9, 'PK304-260517', '2026-05-05', '20B', 'Confirmed', 'Economy'),
('VW234X', 10, 'PK304-260517', '2026-05-06', '21C', 'Confirmed', 'Economy'),
('YZ567A', 11, 'PK781-260601', '2026-05-06', '10A', 'Confirmed', 'Economy'),
('BC890D', 12, 'PK781-260601', '2026-05-07', '11B', 'Confirmed', 'Economy'),
('EF123G', 13, 'PK781-260601', '2026-05-07', '01A', 'Confirmed', 'Business'),
('HI456J', 14, 'PK781-260601', '2026-05-08', '12C', 'Confirmed', 'Economy'),
('KL789M', 15, 'PK781-260601', '2026-05-08', '14D', 'Confirmed', 'Economy'),
('NO012P', 16, 'PK781-260601', '2026-05-09', '15E', 'Confirmed', 'Economy'),
('QR345S', 17, 'PK781-260601', '2026-05-09', '01B', 'Confirmed', 'Business'),
('TU678V', 18, 'PK781-260601', '2026-05-10', '02B', 'Confirmed', 'Business'),
('WX901Y', 19, 'PK781-260601', '2026-05-10', '03B', 'Confirmed', 'Business'),
('ZA234B', 20, 'PK781-260601', '2026-05-11', '16F', 'Confirmed', 'Economy'),
('CD567E', 21, 'PK781-260601', '2026-05-11', '17A', 'Confirmed', 'Economy'),
('FG890H', 22, 'PK781-260601', '2026-05-12', '18B', 'Confirmed', 'Economy'),
('JK123L', 23, 'PK781-260601', '2026-05-12', '19C', 'Confirmed', 'Economy'),
('MN456O', 24, 'PK781-260601', '2026-05-13', '20D', 'Confirmed', 'Economy'),
('PQ789R', 25, 'PK781-260601', '2026-05-13', '21E', 'Confirmed', 'Economy'),
('ST012U', 26, 'PK781-260601', '2026-05-14', '22F', 'Confirmed', 'Economy'),
('VW345X', 27, 'PK781-260601', '2026-05-14', '04A', 'Confirmed', 'Business'),
('YZ678A', 28, 'PK781-260601', '2026-05-15', '23A', 'Confirmed', 'Economy'),
('BC901D', 29, 'PK781-260601', '2026-05-15', '24B', 'Confirmed', 'Economy'),
('EF234G', 30, 'PK781-260601', '2026-05-16', '25C', 'Confirmed', 'Economy'),
('HI567J', 31, 'PK781-260601', '2026-05-16', '26D', 'Confirmed', 'Economy'),
('KL890M', 32, 'PK781-260601', '2026-05-17', '27E', 'Confirmed', 'Economy'),
('NO123P', 33, 'PK781-260601', '2026-05-17', '05B', 'Confirmed', 'Business'),
('QR456S', 34, 'PK781-260601', '2026-05-18', '28F', 'Confirmed', 'Economy'),
('TU789V', 35, 'PK781-260601', '2026-05-18', '29A', 'Confirmed', 'Economy');

-- payment
INSERT INTO Payment (Payment_ID, Reservation_ID, Amount, Payment_Status, Payment_Date, Payment_Method) VALUES
('PAY-2001', '8PPP3G', 35000.00, 'Paid', '2026-05-01 10:15:30', 'Credit Card'),    -- Economy
('PAY-2002', '9XYZ4Q', 35000.00, 'Paid', '2026-05-02 11:20:12', 'EasyPaisa'),      -- Economy
('PAY-2003', 'AB123C', 95000.00, 'Paid', '2026-05-02 14:05:44', 'Bank Transfer'),  -- Business
('PAY-2004', 'DE456F', 35000.00, 'Paid', '2026-05-03 09:12:01', 'Credit Card'),    -- Economy
('PAY-2005', 'GH789I', 35000.00, 'Paid', '2026-05-03 16:44:22', 'JazzCash'),       -- Economy
('PAY-2006', 'JK012L', 35000.00, 'Paid', '2026-05-04 18:22:19', 'Credit Card'),    -- Economy
('PAY-2007', 'MN345O', 35000.00, 'Paid', '2026-05-04 12:30:00', 'EasyPaisa'),      -- Economy
('PAY-2008', 'PQ678R', 35000.00, 'Paid', '2026-05-05 21:01:05', 'Cash'),           -- Economy
('PAY-2009', 'ST901U', 35000.00, 'Paid', '2026-05-05 13:55:40', 'Credit Card'),    -- Economy
('PAY-2010', 'VW234X', 35000.00, 'Paid', '2026-05-06 08:40:11', 'EasyPaisa'),      -- Economy
('PAY-2011', 'YZ567A', 35000.00, 'Paid', '2026-05-06 19:15:33', 'Bank Transfer'),  -- EconomySS
('PAY-2012', 'BC890D', 35000.00, 'Paid', '2026-05-07 11:11:12', 'Credit Card'),    -- Economy
('PAY-2013', 'EF123G', 95000.00, 'Paid', '2026-05-07 15:23:45', 'Credit Card'),    -- Business
('PAY-2014', 'HI567J', 35000.00, 'Paid', '2026-05-08 17:02:59', 'JazzCash'),       -- Economy
('PAY-2015', 'KL789M', 35000.00, 'Paid', '2026-05-08 10:44:12', 'EasyPaisa'),      -- Economy
('PAY-2016', 'NO012P', 35000.00, 'Paid', '2026-05-09 14:12:40', 'Credit Card'),    -- Economy
('PAY-2017', 'QR345S', 95000.00, 'Paid', '2026-05-09 16:33:21', 'Bank Transfer'),  -- Business
('PAY-2018', 'TU678V', 95000.00, 'Paid', '2026-05-10 22:18:02', 'Credit Card'),    -- Business
('PAY-2019', 'WX901Y', 95000.00, 'Paid', '2026-05-10 11:05:50', 'EasyPaisa'),      -- Business
('PAY-2020', 'ZA234B', 35000.00, 'Paid', '2026-05-11 12:59:14', 'Credit Card'),    -- Economy
('PAY-2021', 'CD567E', 35000.00, 'Paid', '2026-05-11 09:24:36', 'JazzCash'),       -- Economy
('PAY-2022', 'FG890H', 35000.00, 'Paid', '2026-05-12 18:41:00', 'Credit Card'),    -- Economy
('PAY-2023', 'JK123L', 35000.00, 'Paid', '2026-05-12 14:15:19', 'Bank Transfer'),  -- Economy
('PAY-2024', 'MN456O', 35000.00, 'Paid', '2026-05-13 15:30:25', 'EasyPaisa'),      -- Economy
('PAY-2025', 'PQ789R', 35000.00, 'Paid', '2026-05-13 11:22:44', 'Credit Card'),    -- Economy
('PAY-2026', 'ST012U', 35000.00, 'Paid', '2026-05-14 07:12:03', 'Cash'),           -- Economy
('PAY-2027', 'VW345X', 95000.00, 'Paid', '2026-05-14 13:45:55', 'Credit Card'),    -- Business
('PAY-2028', 'YZ678A', 35000.00, 'Paid', '2026-05-15 16:19:12', 'EasyPaisa'),      -- Economy
('PAY-2029', 'BC901D', 35000.00, 'Paid', '2026-05-15 10:02:44', 'JazzCash'),       -- Economy
('PAY-2030', 'EF234G', 35000.00, 'Paid', '2026-05-16 14:50:21', 'Credit Card'),    -- Economy
('PAY-2031', 'HI567J', 35000.00, 'Paid', '2026-05-16 12:12:11', 'EasyPaisa'),      -- Economy
('PAY-2032', 'KL890M', 35000.00, 'Paid', '2026-05-17 17:05:44', 'Credit Card'),    -- Economy
('PAY-2033', 'NO123P', 95000.00, 'Paid', '2026-05-17 19:30:00', 'Bank Transfer'),  -- Business
('PAY-2034', 'QR456S', 35000.00, 'Paid', '2026-05-18 11:15:29', 'JazzCash'),       -- Economy
('PAY-2035', 'TU789V', 35000.00, 'Paid', '2026-05-18 15:40:12', 'Credit Card');    -- Economy


-- flight crew
INSERT INTO Flight_Crew (Flight_Crew_ID, Flight_ID, Crew_ID, Assignment_Role) VALUES
(5001, 'PK304-260517', 8001, 'Pilot In Command'),
(5002, 'PK304-260517', 8003, 'First Officer'),
(5003, 'PK304-260517', 9001, 'In-Flight Purser'),
(5004, 'PK304-260517', 9003, 'Cabin Crew Attendant'),
(5005, 'PK304-260517', 9004, 'Cabin Crew Attendant'),
(5006, 'PK781-260601', 8002, 'Pilot In Command'),
(5007, 'PK781-260601', 8001, 'Relief Co-Captain'),  -- Two Captains flying together scenario
(5008, 'PK781-260601', 9002, 'In-Flight Purser'),
(5009, 'PK781-260601', 9006, 'Cabin Crew Attendant');

-- maintenance task
INSERT INTO Maintenance_Task (Maintenance_ID, Aircraft_ID, Staff_ID, Status) VALUES
(7001, 'AP-BHW', 5, 'Completed'), -- Pre-flight systems diagnostics check
(7002, 'AP-BID', 6, 'Completed'), -- Engine oil pressure valve flush
(7003, 'AP-BMH', 5, 'Completed'), -- Cabin pressure seal verification
(7004, 'AP-BGZ', 6, 'In Progress'),-- Main landing gear brake assembly overhaul
(7005, 'AP-BLB', 5, 'Completed'), -- Avionics software cluster update
(7006, 'AP-BLC', 6, 'Completed'), -- Oxygen mask deployment testing
(7007, 'AP-BLD', 5, 'Completed'), -- Weather radar telemetry recalibration
(7008, 'AP-BIE', 6, 'Pending'),   -- Fuel line linkage cleaning cycle
(7009, 'AP-BHO', 5, 'Completed'), -- Propeller synchronization alignment
(7010, 'AP-BHP', 6, 'Completed'); -- Tail fin stabilizer structural review



-- Assecc to Passenger detail by Flight 

SELECT 
    f.Flight_ID,
    f.Flight_No,
    p.Passenger_ID,
    p.F_name AS First_Name,
    p.L_name AS Last_Name,
    p.Passport_No,
    r.Seat_No,
    r.Class_Tier,
    r.Reservation_Status
FROM Passenger AS p
INNER JOIN Reservation AS r ON p.Passenger_ID = r.Passenger_ID
INNER JOIN Flight AS f ON r.Flight_ID = f.Flight_ID
WHERE f.Flight_ID = 'PK304-260517';



-- Access to details of assigened Flight Crew

SELECT 
    fc.Flight_ID,
    f.Flight_No,
    c.Crew_ID,
    CONCAT(c.F_name, ' ', c.L_name) AS Crew_Member_Name,
    c.Role AS Corporate_Rank,
    fc.Assignment_Role AS Flight_Duty
FROM Crew AS c
INNER JOIN Flight_Crew AS fc ON c.Crew_ID = fc.Crew_ID
INNER JOIN Flight AS f ON fc.Flight_ID = f.Flight_ID
WHERE fc.Flight_ID = 'PK304-260517';


-- Detail of flight 

SELECT Flight_No, Aircraft_ID, Departure_Time, Status 
FROM Flight 
WHERE Flight_ID = 'PK304-260517';




SELECT 
concat(F_NAME, " ", L_Name) AS FullName,Frequent_Flyer_NO,DOB
FROM Passenger
WHERE DOB>='2000-01-01';




