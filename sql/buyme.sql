DROP DATABASE IF EXISTS `buyme`;
CREATE DATABASE IF NOT EXISTS `buyme`;

USE `buyme`;

DROP TABLE IF EXISTS `account`;

CREATE TABLE `account`
(
    `account_number` INT NOT NULL auto_increment,
    `first_name`     VARCHAR(25) DEFAULT NULL,
    `last_name`      VARCHAR(25) DEFAULT NULL,
    `username`       VARCHAR(50) DEFAULT NULL,
    `password`       VARCHAR(50) DEFAULT NULL,
    `email`          VARCHAR(50) DEFAULT NULL,
    `access_level`   INT NOT NULL,
    `is_active`       BOOLEAN NOT NULL,
    PRIMARY KEY (`account_number`)
);

-- Adding data for admin and three customer representatives

LOCK TABLES account WRITE;
INSERT INTO account (first_name, last_name, username, password, email, access_level, is_active) VALUES
('admin','admin','admin','admin','admin@buyme.com',1, true),
('John','Smith','jsmith','1234','jsmith@buyme.com',2, true),
('Jane','Doe','jdoe','4321','jdoe@buyme.com',2, true),
('Joe','Shmoe','jshmoe','password','jshmoe@buyme.com',2, true),
('Zoe', 'Long', 'zlong', '1234', 'zlong@google.com', 3, true),
('Kevin', 'Motts', 'kmotts', '1234', 'kmotts@gmail.com', 3, true);
UNLOCK TABLES;

-- Display account table

SELECT * FROM `account`;

-- Create a question table for q&a

DROP TABLE IF EXISTS `question`;
CREATE TABLE `question`
(
    `question_id`     INT NOT NULL auto_increment,
    `topic`           VARCHAR(50) DEFAULT NULL,
    `question`        VARCHAR(200) DEFAULT NULL,
    `asked_by`        INT DEFAULT NULL,
    `ask_date`        DATETIME DEFAULT NULL,
    `answer`          VARCHAR(200) DEFAULT NULL,
    `answered_by`     INT DEFAULT NULL,
    `answer_date`     DATETIME DEFAULT NULL,
    PRIMARY KEY (`question_id`),
    FOREIGN KEY(`asked_by`) REFERENCES account(`account_number`) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY(`answered_by`) REFERENCES account(`account_number`) ON DELETE CASCADE ON UPDATE CASCADE
);

SELECT * FROM `question`;

-- Creates an the item for auction
DROP TABLE IF EXISTS `auctionItem`;
CREATE TABLE `auctionItem`
(
    `listingID` 		INT NOT NULL auto_increment,
    `productID`    		VARCHAR(50) DEFAULT NULL,
    `type`				VARCHAR(10) DEFAULT NULL,
    `listPrice`			DECIMAL(20,2) DEFAULT NULL,
    `minSellPrice`		DECIMAL(20,2) DEFAULT NULL,
    `soldPrice`			DECIMAL(20,2) DEFAULT NULL,
    `exteriorColor` 	VARCHAR(25) DEFAULT NULL,
    `interiorColor` 	VARCHAR(25) DEFAULT NULL,
    `model`		    	VARCHAR(50) DEFAULT NULL,
    `manufacturer`  	VARCHAR(50) DEFAULT NULL,
    `condition`  		VARCHAR(5) DEFAULT NULL,
    `capacity` 			INT DEFAULT NULL,
    `closingDate`      	DATETIME DEFAULT NULL,
    `year`				INT DEFAULT NULL,
    `listDate`			DATETIME DEFAULT NULL,
    `seller`			INT DEFAULT NULL,
    `purchaser`			INT DEFAULT NULL,
    PRIMARY KEY (`listingID`),
    FOREIGN KEY(`seller`) REFERENCES account(`account_number`) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY(`purchaser`) REFERENCES account(`account_number`) ON DELETE CASCADE ON UPDATE CASCADE
);

DROP TABLE IF EXISTS `car`;
CREATE TABLE `car`
(
    `listingID` 		INT NOT NULL,
    `fuelType`			VARCHAR(50) DEFAULT NULL,
    `mileage`			INT DEFAULT NULL,
    `driveType`			VARCHAR(50) DEFAULT NULL,
    `bodyType`			VARCHAR(50) DEFAULT NULL,
    `transmission`		VARCHAR(50) DEFAULT NULL,
    PRIMARY KEY (`listingID`),
    FOREIGN KEY(`listingID`) REFERENCES auctionItem(`listingID`) ON DELETE CASCADE ON UPDATE CASCADE
);

DROP TABLE IF EXISTS `boat`;
CREATE TABLE `boat`
(
    `listingID` 		INT NOT NULL,
    `engineType`		VARCHAR(50) DEFAULT NULL,
    `boatType`			VARCHAR(50) DEFAULT NULL,
    `hullMaterial`		VARCHAR(50) DEFAULT NULL,
    `primaryFuelType`	VARCHAR(50) DEFAULT NULL,
    PRIMARY KEY (`listingID`),
    FOREIGN KEY(`listingID`) REFERENCES auctionItem(`listingID`) ON DELETE CASCADE ON UPDATE CASCADE
);

DROP TABLE IF EXISTS `aircraft`;
CREATE TABLE `aircraft`
(
    `listingID` 		INT NOT NULL,
    `airCategory`		VARCHAR(50) DEFAULT NULL,
    `engineHours`		INT DEFAULT NULL,
    `avionics`			VARCHAR(100) DEFAULT NULL,
    PRIMARY KEY (`listingID`),
    FOREIGN KEY(`listingID`) REFERENCES auctionItem(`listingID`) ON DELETE CASCADE ON UPDATE CASCADE
);

-- insert for car
LOCK TABLES auctionItem WRITE;
INSERT INTO auctionItem (productID, type, listPrice, minSellPrice, exteriorColor, interiorColor, model, manufacturer, `condition`, capacity, closingDate, `year`, listDate, seller, purchaser) VALUES
('acc', 'Car', 12000.00, 18000.00, 'white', 'black', 'Gappu', 'Volkswagon', 'used', 5, '2022-05-01 12:30:00', 2015, '2021-04-11 16:30:00', 5, 6);
UNLOCK TABLES;

LOCK TABLES auctionItem WRITE;
INSERT INTO auctionItem (productID, type, listPrice, minSellPrice, exteriorColor, interiorColor, model, manufacturer, `condition`, capacity, closingDate, `year`, listDate, seller) VALUES
('acd', 'Car', 12000.00, 18000.00, 'white', 'black', 'Pasat', 'Volkswagon', 'used', 5, '2022-05-01 12:30:00', 2015, '2021-04-11 16:30:00', 6);
UNLOCK TABLES;

LOCK TABLES car WRITE;
INSERT INTO car (listingID, fuelType, mileage, driveType, bodyType, transmission) VALUES
    -- (1, 'super', 80000, 'FWD', 'Sedan', 'automatic'),
    (LAST_INSERT_ID(), 'super', 50000, 'FWD', 'Sedan', 'automatic');
UNLOCK TABLES;

-- insert for boat
LOCK TABLES auctionItem WRITE;
INSERT INTO auctionItem (productID, type, listPrice, minSellPrice, exteriorColor, interiorColor, model, manufacturer, `condition`, capacity, closingDate, `year`, listDate, seller) VALUES
('adc', 'Boat', 12000.00, 18000.00, 'black', 'red', 'X22', 'Mastercraft', 'new', 5, '2020-05-01 12:30:00', 2019, '2020-04-12 16:30:00', 5);
UNLOCK TABLES;

LOCK TABLES boat WRITE;
INSERT INTO boat (listingID, engineType, boatType, hullMaterial, primaryFuelType) VALUES
(LAST_INSERT_ID(), 'Direct Drive', 'Dragger', 'Fiberglass', 'Other');
UNLOCK TABLES;

LOCK TABLES auctionItem WRITE;
INSERT INTO auctionItem (productID, type, listPrice, minSellPrice, exteriorColor, interiorColor, model, manufacturer, `condition`, capacity, closingDate, `year`, listDate, seller) VALUES
('ccb', 'Aircraft', 5750000.00, 5760000.00, 'white and blue', 'white', 'XLS+', 'Cessna', 'used', 9, '2021-04-18 12:30:00', 2019, '2021-04-12 16:30:00', 5);
UNLOCK TABLES;

LOCK TABLES aircraft WRITE;
INSERT INTO aircraft (listingID, airCategory, engineHours, avionics) VALUES
(LAST_INSERT_ID(), 'Twin Piston', 2231, 'Collins Pro Line 21 Avionics 4 Tube EFIS');
UNLOCK TABLES;

select * from `auctionItem`;
select aI.listingID, ai.productID, aI.type, aI.listPrice, aI.minSellPrice, aI.soldPrice, aI.exteriorColor, aI.interiorColor, aI.model, aI.manufacturer, aI.`condition`, aI.capacity, aI.closingDate, aI.`year`, aI.listDate, aI.seller, aI.purchaser, c.fuelType, c.mileage, c.driveType, c.bodyType, c.transmission
from auctionItem aI inner join car c
                               on aI.listingID = c.listingID;

select aI.listingID, ai.productID, aI.type, aI.listPrice, aI.minSellPrice, aI.soldPrice, aI.exteriorColor, aI.interiorColor, aI.model, aI.manufacturer, aI.`condition`, aI.capacity, aI.closingDate, aI.`year`, aI.listDate, aI.seller, aI.purchaser, b.engineType, b.boatType, b.hullMaterial, b.primaryFuelType
from auctionItem aI inner join boat b
                               on aI.listingID = b.listingID;

select aI.listingID, ai.productID, aI.type, aI.listPrice, aI.minSellPrice, aI.soldPrice, aI.exteriorColor, aI.interiorColor, aI.model, aI.manufacturer, aI.`condition`, aI.capacity, aI.closingDate, aI.`year`, aI.listDate, aI.seller, aI.purchaser, a.airCategory, a.engineHours, a.avionics
from auctionItem aI inner join aircraft a
                               on aI.listingID = a.listingID;
select * from `car`;
select * from `boat`;
select * from `aircraft`;

-- Bid
DROP TABLE IF EXISTS `bid`;
CREATE TABLE `bid`
(
    `listingID` INT,
    `bidder` INT,
    `bidValue`  DECIMAL(20, 2),
    `bidDate`   DATETIME DEFAULT NULL,
    PRIMARY KEY (listingID, bidValue),
    FOREIGN KEY (listingID) REFERENCES auctionitem(listingID) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (bidder) REFERENCES account(account_number) ON DELETE CASCADE ON UPDATE CASCADE
);

LOCK TABLES bid WRITE;
INSERT INTO bid (listingID, bidder, bidValue, bidDate) VALUES
(1, 3, 210.00, '2021-04-18 12:30:00'),
(1, 4, 220.00, '2021-04-18 13:30:00'),
(2, 2, 210.00, '2021-04-18 12:30:00'),
(2, 2, 220.00, '2021-04-18 13:30:00'),
(2, 3, 230.00, '2021-04-18 14:30:00'),
(3, 2, 210.00, '2021-04-18 12:30:00'),
(3, 3, 220.00, '2021-04-18 13:30:00'),
(3, 4, 230.00, '2021-04-18 14:30:00');
UNLOCK TABLES;
SELECT * FROM bid;

SELECT * FROM bid WHERE listingID = 2 ORDER BY bidDate DESC;
-- Alerts
DROP TABLE IF EXISTS `alert`;
CREATE TABLE `alert`
(
    `alertID`      INT NOT NULL auto_increment,
    `user`         INT,
    `alertTopic`   VARCHAR(50),
    `alertMessage` VARCHAR(300),
    `isRead`       BOOLEAN DEFAULT false,
    PRIMARY KEY (alertID),
    FOREIGN KEY(`user`) REFERENCES account(`account_number`) ON DELETE CASCADE
        ON UPDATE CASCADE
);

LOCK TABLES alert WRITE;
INSERT INTO alert (`user`, alertTopic, alertMessage, isRead) VALUES
(5, 'Item Listed', 'The car you wanted is up for auction', TRUE),
(5, 'Auction Won', 'Congrats you won the auction', FALSE),
(6, 'Item Listed', 'The car you wanted is up for auction', TRUE),
(6, 'Auction Won', 'Congrats you won the auction', FALSE);
UNLOCK TABLES;
SELECT * FROM alert;

DROP TABLE IF EXISTS `wishlist`;
CREATE TABLE `wishlist`
(
    `user`         INT,
    `model`        VARCHAR(50),
    `manufacturer` VARCHAR(50),
    `condition`    VARCHAR(5),
    `maxPrice`     DECIMAL(20, 2),
    PRIMARY KEY (`user`, `model`, `manufacturer`, `condition`, `maxPrice`),
    FOREIGN KEY(`user`) REFERENCES account(`account_number`) ON DELETE CASCADE
        ON UPDATE CASCADE
);
-- Transaction History
-- SELECT * FROM auctionItem WHERE seller = 7; -- All auctions created by a user; Use a if condition to check if the auction ended without a winner
-- SELECT * FROM auctionItem WHERE purchaser = 7; -- All auctions won by user
-- SELECT * FROM bid WHERE bidder = 2 GROUP BY listingID, bidder; -- All auctions the user participated in

-- Total Earnings - Change minSellPrice to soldPrice
SELECT SUM(minSellPrice) AS `Total Earnings` FROM auctionItem;
-- Earnings Per Item
SELECT manufacturer AS Manufacturer, model AS Model, COUNT(model) AS Quantity, SUM(minSellPrice) AS Earnings FROM auctionItem GROUP BY manufacturer, model;
-- Earnings Per Item Type
SELECT type AS `Item Type`, SUM(minSellPrice) AS `Earnings` FROM auctionItem GROUP BY type;
-- Earnings Per End-User
SELECT a.first_name AS `First Name`, a.last_name AS `Last Name`, a.username, SUM(aI.minSellPrice) AS Earnings
FROM account a INNER JOIN auctionItem aI
                          ON a.account_number = aI.seller
GROUP BY aI.seller;

-- SELECT seller AS `End User`, SUM(soldPrice) AS Earnings FROM auctionItem GROUP BY seller;
-- Best-Selling Items - Change instances of minSellPrice to soldPrice
SELECT manufacturer AS Manufacturer, model AS Model, COUNT(model) AS Quantity, SUM(minSellPrice) AS Earnings FROM auctionItem
WHERE minSellPrice IS NOT NULL
GROUP BY manufacturer, model
ORDER BY Quantity DESC
    LIMIT 5;

-- Biggest Spenders -- Need Bidding History Table
SELECT a.first_name AS `First Name`, a.last_name AS `Last Name`, a.username, SUM(aI.minSellPrice) AS `Total Money Spent`
FROM account a INNER JOIN auctionItem aI
                          ON a.account_number = aI.purchaser
GROUP BY aI.purchaser
ORDER BY `Total Money Spent` DESC
    LIMIT 5;