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
CREATE PROCEDURE `CreateCustomerOrder`(
    IN p_CustomerID INT,
    IN p_Name VARCHAR(255),
    IN p_Email VARCHAR(255),
    IN p_Phone VARCHAR(20),
    IN p_Street VARCHAR(255),
    IN p_City VARCHAR(100),
    IN p_StateProvince VARCHAR(100),
    IN p_PostalCode VARCHAR(20),
    IN p_Country VARCHAR(100),
    IN p_StoredTotal DECIMAL(14, 2),
    IN p_OrderItemsJSON JSON
)
BEGIN
    DECLARE newOrderID INT;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;
    START TRANSACTION;
    INSERT INTO `Order` (
        `CustomerID`, `Name`, `Email`, `Phone`, 
        `Street`, `City`, `StateProvince`, `PostalCode`, `Country`, `StoredTotal`
    ) VALUES (
        p_CustomerID, p_Name, p_Email, p_Phone, 
        p_Street, p_City, p_StateProvince, p_PostalCode, p_Country, p_StoredTotal
    );
    SET newOrderID = LAST_INSERT_ID();
    INSERT INTO `Order_item` (`OrderID`, `ProductID`, `QtyOrdered`, `UnitPriceAtOrder`)
    SELECT
        newOrderID,
        jt.productID,
        jt.qtyOrdered,
        jt.unitPrice
    FROM
        JSON_TABLE(
            p_OrderItemsJSON,
            '$[*]' COLUMNS (
                productID INT PATH '$.productID',
                qtyOrdered INT PATH '$.quantity',
                unitPrice DECIMAL(12, 2) PATH '$.unitPrice'
            )
        ) AS jt;
    COMMIT;
END$$
DELIMITER ;

CALL ProductCatelog();
CALL `CreateCustomerOrder`(
    1,
    'Sandun Perera',
    'sandun.p@email.com',
    '0771234567',
    '45 Galle Road',
    'Colombo',
    'Western Province',
    '00300',
    'Sri Lanka',
    230000.00,
    '[
        {"productID": 1, "quantity": 1, "unitPrice": 185000.00},
        {"productID": 3, "quantity": 1, "unitPrice": 45000.00}
    ]'
);
CALL `CreateCustomerOrder`(
    2,
    'Desman Silva',
    'desman.silva@email.com',
    '0719876543',
    '88 Beach Road',
    'Unawatuna',
    'Southern Province',
    '80600',
    'Sri Lanka',
    12500.00,
    '[
        {"productID": 8, "quantity": 1, "unitPrice": 7500.00},
        {"productID": 5, "quantity": 1, "unitPrice": 3200.00},
        {"productID": 7, "quantity": 1, "unitPrice": 1800.00}
    ]'
);
CALL `CreateCustomerOrder`(
    3,
    'Nimali Perera',
    'nimali.p@email.com',
    '0771234567',
    '123 Kandy Road',
    'Watareka',
    'Western Province',
    '10500',
    'Sri Lanka',
    5500.00,
    '[
        {"productID": 1, "quantity": 2, "unitPrice": 1500.00},
        {"productID": 4, "quantity": 1, "unitPrice": 2500.00}
    ]'
);

