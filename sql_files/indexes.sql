CREATE INDEX `IDX_Customer_Name` ON `Customer`(`Name`);
CREATE INDEX `IDX_Product_Price` ON `Product`(`Price`);
CREATE INDEX `IDX_Product_IsActive_Price` ON `Product`(`IsActive`, `Price`);
CREATE INDEX `IDX_Order_CustomerID` ON `Order`(`CustomerID`);
CREATE INDEX `IDX_Order_PlacedAt` ON `Order`(`PlacedAt`);
CREATE INDEX `IDX_Order_item_ProductID` ON `Order_item`(`ProductID`);
CREATE INDEX `IDX_Product_category_map_CategoryID` ON `Product_category_map`(`CategoryID`);