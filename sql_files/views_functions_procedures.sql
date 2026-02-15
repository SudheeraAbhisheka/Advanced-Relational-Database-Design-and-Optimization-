-- top-selling products based on the total number of units sold
CREATE VIEW V_TopSellingProducts AS
SELECT
    p.ProductID,
    p.Name,
    p.Description,
    SUM(oi.QtyOrdered) AS TotalUnitsSold
FROM
    Product p
JOIN
    Order_item oi ON p.ProductID = oi.ProductID
GROUP BY
    p.ProductID,
    p.Name,
    p.Description
ORDER BY
    TotalUnitsSold DESC;

-- the average price of products within a specific category
DELIMITER $$
CREATE FUNCTION F_GetAverageCategoryPrice(
    p_CategoryID INT
)
RETURNS DECIMAL(12,2)

READS SQL DATA -- declares that this function may read data but does not modify it
BEGIN
    DECLARE avg_price DECIMAL(12,2);

    SELECT AVG(p.Price) INTO avg_price
    FROM Product p
    JOIN Product_category_map pcm ON p.ProductID = pcm.ProductID
    WHERE pcm.CategoryID = p_CategoryID;

    RETURN avg_price;
END$$
DELIMITER ;

-- a monthly sales report
DELIMITER $$
CREATE PROCEDURE P_GenerateMonthlySalesReport()
BEGIN
    SELECT
        YEAR(PlacedAt) AS SalesYear,
        MONTHNAME(PlacedAt) AS SalesMonth,
        SUM(StoredTotal) AS TotalSales
    FROM
        `Order`
    GROUP BY
        YEAR(PlacedAt),
        MONTH(PlacedAt),
        MONTHNAME(PlacedAt)
    ORDER BY
        YEAR(PlacedAt),
        MONTH(PlacedAt);
END$$
DELIMITER ;


SELECT * FROM V_TopSellingProducts;
SELECT F_GetAverageCategoryPrice(1);
CALL P_GenerateMonthlySalesReport();
