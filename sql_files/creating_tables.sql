CREATE TABLE `Customer` (
    `CustomerID` INT AUTO_INCREMENT,
    `Name` VARCHAR(200) NOT NULL,
    `Email` VARCHAR(254) NOT NULL,
    `Phone` VARCHAR(15),
    `IsDeleted` BOOLEAN NOT NULL DEFAULT FALSE,
    PRIMARY KEY (`CustomerID`),
    UNIQUE KEY `UQ_Customer_Email` (`Email`)
);

CREATE TABLE `Product` (
    `ProductID` INT AUTO_INCREMENT,
    `Name` VARCHAR(255) NOT NULL,
    `Description` TEXT,
    `Price` DECIMAL(12,2) NOT NULL,
    `IsActive` BOOLEAN NOT NULL DEFAULT TRUE,
    PRIMARY KEY (`ProductID`),
    UNIQUE KEY `UQ_Product_Name` (`Name`)
);

CREATE TABLE `Category` (
    `CategoryID` INT AUTO_INCREMENT,
    `Name` VARCHAR(120) NOT NULL,
    PRIMARY KEY (`CategoryID`),
    UNIQUE KEY `UQ_Category_Name` (`Name`)
);

CREATE TABLE `Address` (
    `AddressID` INT AUTO_INCREMENT,
    `CustomerID` INT NOT NULL,
    `Street` VARCHAR(150) NOT NULL,
    `City` VARCHAR(50) NOT NULL,
    `StateProvince` VARCHAR(50) NOT NULL,
    `PostalCode` VARCHAR(12) NOT NULL,
    `Country` VARCHAR(60) NOT NULL,
    PRIMARY KEY (`AddressID`),
    FOREIGN KEY (`CustomerID`) REFERENCES `Customer`(`CustomerID`) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE `Order` (
    `OrderID` INT AUTO_INCREMENT,
    `PlacedAt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `CustomerID` INT NOT NULL,
    `Name` VARCHAR(200) NOT NULL,
    `Email` VARCHAR(254) NOT NULL,
    `Phone` VARCHAR(15),
    `Street` VARCHAR(150) NOT NULL,
    `City` VARCHAR(50) NOT NULL,
    `StateProvince` VARCHAR(50) NOT NULL,
    `PostalCode` VARCHAR(12) NOT NULL,
    `Country` VARCHAR(60) NOT NULL,
    `StoredTotal` DECIMAL(14,2) NOT NULL,
    PRIMARY KEY (`OrderID`),
    FOREIGN KEY (`CustomerID`) REFERENCES `Customer`(`CustomerID`) ON UPDATE CASCADE
);

CREATE TABLE `Order_item` (
    `OrderID` INT NOT NULL,
    `ProductID` INT NOT NULL,
    `QtyOrdered` INT NOT NULL,
    `UnitPriceAtOrder` DECIMAL(12,2) NOT NULL,
    PRIMARY KEY (`OrderID`, `ProductID`),
    FOREIGN KEY (`OrderID`) REFERENCES `Order`(`OrderID`) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (`ProductID`) REFERENCES `Product`(`ProductID`) ON UPDATE CASCADE
);

CREATE TABLE `Inventory` (
    `ProductID` INT NOT NULL,
    `CurrentQty` INT NOT NULL,
    `LastUpdatedAt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`ProductID`),
    FOREIGN KEY (`ProductID`) REFERENCES `Product`(`ProductID`) ON UPDATE CASCADE
);

CREATE TABLE `Product_category_map` (
    `ProductID` INT NOT NULL,
    `CategoryID` INT NOT NULL,
    PRIMARY KEY (`ProductID`, `CategoryID`),
    FOREIGN KEY (`ProductID`) REFERENCES `Product`(`ProductID`) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (`CategoryID`) REFERENCES `Category`(`CategoryID`) ON DELETE CASCADE ON UPDATE CASCADE
);
