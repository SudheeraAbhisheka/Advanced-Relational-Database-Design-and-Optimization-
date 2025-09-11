INSERT INTO `Customer` (`CustomerID`, `Name`, `Email`, `Phone`) VALUES
(1, 'Sandun Perera', 'sandun.p@email.com', '0771234567'),
(2, 'Desman Silva', 'desman.silva@email.com', '0719876543'),
(3, 'Chathura Fernando', 'c.fernando@email.com', '0765551234');

INSERT INTO `Address` (`AddressID`, `CustomerID`, `Street`, `City`, `StateProvince`, `PostalCode`, `Country`) VALUES
(1, 1, '45 Galle Road', 'Colombo', 'Western Province', '00300', 'Sri Lanka'),
(2, 1, '12 Temple Lane', 'Kandy', 'Central Province', '20000', 'Sri Lanka'),
(3, 2, '88 Beach Road', 'Unawatuna', 'Southern Province', '80600', 'Sri Lanka'),
(4, 3, '210 Main Street', 'Jaffna', 'Northern Province', '40000', 'Sri Lanka');

DELIMITER $$
CREATE PROCEDURE `ProductCatelog`()
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL; -- sending the error message after the rollback
    END;

    START TRANSACTION;

    INSERT INTO `Category` (`CategoryID`, `Name`) VALUES
    (1, 'Electronics'),
    (2, 'Books'),
    (3, 'Home & Kitchen'),
    (4, 'Apparel'),
    (5, 'Sports & Outdoors');

    INSERT INTO `Product` (`ProductID`, `Name`, `Description`, `Price`) VALUES
    (1, 'ProBook Laptop', 'High-performance laptop for work and study.', 185000.00),
    (2, 'Galaxy Smartphone', 'Latest smartphone with a great display and camera.', 120000.00),
    (3, 'Noise-Cancelling Headphones', 'Premium noise-cancelling over-ear headphones.', 45000.00),
    (4, 'The Silent Patient', 'A psychological thriller by Alex Michaelides.', 2500.00),
    (5, 'Atomic Habits', 'A book on building good habits by James Clear.', 3200.00),
    (6, 'Espresso Machine', 'Easy-to-use home coffee machine.', 28000.00),
    (7, "'Men\'s Cotton T-Shirt", 'Comfortable and stylish 100% cotton t-shirt.', 1800.00),
    (8, 'Eco-Friendly Yoga Mat', 'Durable, non-slip, and eco-friendly yoga mat.', 7500.00);

    INSERT INTO `Product_category_map` (`ProductID`, `CategoryID`) VALUES
    (1, 1), (2, 1), (3, 1), (4, 2), (5, 2), (6, 3), (7, 4), (8, 5);

    INSERT INTO `Inventory` (`ProductID`, `CurrentQty`) VALUES
    (1, 25), (2, 50), (3, 120), (4, 200), (5, 150), (6, 40), (7, 300), (8, 80);
    
    COMMIT;
END$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE `CustomerOrder1`()
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    START TRANSACTION;

    INSERT INTO `Order` (`OrderID`, `PlacedAt`, `CustomerID`, `Name`, `Email`, `Phone`, `Street`, `City`, `StateProvince`, `PostalCode`, `Country`, `StoredTotal`) VALUES
    (1, '2025-09-08 10:15:00', 1, 'Sandun Perera', 'sandun.p@email.com', '0771234567', '45 Galle Road', 'Colombo', 'Western Province', '00300', 'Sri Lanka', 230000.00);

    INSERT INTO `Order_item` (`OrderID`, `ProductID`, `QtyOrdered`, `UnitPriceAtOrder`) VALUES
    (1, 1, 1, 185000.00),
    (1, 3, 1, 45000.00);
    
    COMMIT;
END$$
DELIMITER ;


DELIMITER $$
CREATE PROCEDURE `CustomerOrder2`()
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    START TRANSACTION;

    INSERT INTO `Order` (`OrderID`, `PlacedAt`, `CustomerID`, `Name`, `Email`, `Phone`, `Street`, `City`, `StateProvince`, `PostalCode`, `Country`, `StoredTotal`) VALUES
    (2, '2025-09-10 11:05:21', 2, 'Desman Silva', 'desman.silva@email.com', '0719876543', '88 Beach Road', 'Unawatuna', 'Southern Province', '80600', 'Sri Lanka', 12500.00);

    INSERT INTO `Order_item` (`OrderID`, `ProductID`, `QtyOrdered`, `UnitPriceAtOrder`) VALUES
    (2, 8, 1, 7500.00),
    (2, 5, 1, 3200.00),
    (2, 7, 1, 1800.00);
    
    COMMIT;
END$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE `CustomerOrder3`()
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    START TRANSACTION;

    INSERT INTO `Order` (`OrderID`, `PlacedAt`, `CustomerID`, `Name`, `Email`, `Phone`, `Street`, `City`, `StateProvince`, `PostalCode`, `Country`, `StoredTotal`) VALUES
    (3, '2025-09-11 10:30:00', 3, 'Nimali Perera', 'nimali.p@email.com', '0771234567', '123 Kandy Road', 'Watareka', 'Western Province', '10500', 'Sri Lanka', 5500.00);
    
    INSERT INTO `Order_item` (`OrderID`, `ProductID`, `QtyOrdered`, `UnitPriceAtOrder`) VALUES
    (3, 1, 2, 1500.00),
    (3, 4, 1, 2500.00);

    COMMIT;
END$$
DELIMITER ;

CALL ProductCatelog();
CALL CustomerOrder1();
CALL CustomerOrder2();
CALL CustomerOrder3();
