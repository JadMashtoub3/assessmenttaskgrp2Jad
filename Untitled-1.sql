/* Jad Mashtoub 103596586 */ 

/* 
Tour(TourName, Description)
PK(TourName)
FK(EventYear, EventMonth, EventDay)

Event(EventYear, EventMonth, EventDay, Fee)
PK(EventYear, EventMonth, EventDay)

Booking(DateBooked, Payment)
FK(EventYear, EventMonth, EventDay, ClientID)

Client(ClientID, Surname, GivenName, Gender)
PK(ClientID)
*/

-- Create a new table called 'Tour' in schema 'SchemaName'
-- Drop the table if it already exists
IF OBJECT_ID('Booking', 'U') IS NOT NULL
DROP TABLE Booking
GO

IF OBJECT_ID('Event', 'U') IS NOT NULL
DROP TABLE Event
GO

IF OBJECT_ID('Client', 'U') IS NOT NULL
DROP TABLE Client
GO

IF OBJECT_ID('Tour', 'U') IS NOT NULL
DROP TABLE Tour
GO

CREATE TABLE Tour
(
    TourName [NVARCHAR] (100) PRIMARY KEY, 
    Description [NVARCHAR](500),
);
GO



CREATE TABLE Client
(
    ClientId INT PRIMARY KEY, 
    Surname [NVARCHAR](100) NOT NULL,
    GivenName [NVARCHAR](100) NOT NULL,
    Gender [NVARCHAR] (1) NULL,
    CONSTRAINT check_Gender CHECK (Gender IN('M','F','I'))
    
);



CREATE TABLE Event
(
    TourName [NVARCHAR](100),
    FOREIGN KEY (Tourname) REFERENCES Tour(Tourname),
    EventMonth [NVARCHAR](3),
    EventDay INT  NOT NULL,
    EventYear INT,
    EventFee MONEY NOT NULL,
    Primary Key(Tourname, EventMonth, EventDay, EventYear),
    CONSTRAINT check_Event
        CHECK (EventMonth IN ('Jan', 'Feb', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December')),
    CONSTRAINT check_EventDay
        CHECK (EventDay >= 1 AND EventDay <= 31),
    CONSTRAINT check_Eventyear
        CHECK (DATALENGTH(EventYear) = 4),
    CONSTRAINT check_EventFee
        CHECK (EventFee >0)
);



CREATE TABLE Booking
(
    ClientId int,
    FOREIGN KEY (ClientId)  REFERENCES Client(ClientID),
    TourName [NVARCHAR](100) NOT NULL,
    EventMonth [NVARCHAR](3),
    EventDay INT,
    EventYear INT,
    Payment MONEY,
    DateBooked Date NOT NULL,
    Primary KEY(ClientId, TourName, EventMonth, EventDay, EventYear),
    CONSTRAINT FK_ClientId FOREIGN KEY (TourName, EventMonth, EventDay, EventYear)
    REFERENCES Event(TourName, EventMonth, EventDay, EventYear),
    CONSTRAINT check_EventMonth
        CHECK (DATALENGTH(EventYear) = 4),
    CONSTRAINT check_payment
        CHECK (payment > 0),
);
GO

INSERT INTO Tour (TourName, Description)
            Values('North' , 'Tour of Wineries and outlets of the Bendigo and Castlemaine region'),
                  ('South' , 'Tour of Wineries and outlets of Mornington peninsula')   ,
                  ('West' , 'Tour of Wineries and outlets of the Geelongand Otways region')       

Insert INTO Client ( ClientId, Surname, GivenName, Gender)
            Values('1', 'Price', 'Taylor', 'M'),
                  ('2', 'Gamble', 'Ellyse', 'F'),
                  ('3', 'Tan', 'Tilly', 'F'),
                  ('4', 'Jad', 'Mashtoub', 'M');

Insert INTO Event (TourName, EventMonth, EventDay, EventYear, EventFee)
            VALUES('North', 'Jan', '9', '2016', '200'),
                  ('North', 'Feb', '13', '2016', '225'),
                  ('South', 'Jan', '9', '2016', '200'),
                  ('South', 'Jan', '16', '2016', '200'),
                  ('West', 'Jan', '29', '2016', '225')

Insert INTO Booking(ClientId, TourName, EventMonth, EventDay, EventYear, Payment, DateBooked)
            VALUES('1', 'North', 'Jan', '9', '2016','200','12/10/2015'),
                  ('2','North', 'Jan', '9', '2016', '200', '12/16/2015'),
                  ('1', 'North', 'Feb', '13', '2016', '225','1/8/2016'),
                  ('2', 'North', 'Feb', '13', '2016','125', '1/14/2016'),
                  ('3', 'North', 'Feb', '13', '2016', '225', '2/3/2016'),
                  ('1', 'South', 'Jan', '9', '2016', '200', '12/10/2015'),
                  ('2', 'South', 'Jan', '16', '2016', '200', '12/18/2015'),
                  ('3', 'South', 'Jan', '16', '2016', '200', '1/9/2016'),
                  ('2', 'West', 'Jan', '29', '2016', '225', '12/17/2015'),
                  ('3', 'West','Jan', '29', '2016', '200', '12/18/2015')

CREATE VIEW [Clients] AS     
Select client.GivenName, client.Surname, booking.TourName, tour.description, booking.EventYear, booking.EventMonth, booking.EventDay, EventFee, DateBooked, Payment
From Tour, Client, Booking, Event
/* shows all data about the client and the fees paid */
Select EventMonth, TourName, count(*) "num bookings"
from Booking
Group by EventMonth, TourName
Order by EventMonth, TourName
/* counts all the bookings successfully and added a number of bookings column */
select Payment
from Booking


--final comment


