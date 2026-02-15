CREATE USER 'product_manager'@'localhost' IDENTIFIED BY 'k3&)jLy83jdf';
GRANT SELECT, INSERT, UPDATE ON `e_commerce_db`.`Product` TO 'product_manager'@'localhost';
GRANT SELECT, INSERT, UPDATE ON `e_commerce_db`.`Category` TO 'product_manager'@'localhost';
GRANT SELECT, INSERT, UPDATE ON `e_commerce_db`.`Inventory` TO 'product_manager'@'localhost';
GRANT SELECT, INSERT, DELETE ON `e_commerce_db`.`Product_category_map` TO 'product_manager'@'localhost';

CREATE USER 'order_processor'@'localhost' IDENTIFIED BY 'k58*&Ynjkjljl';
GRANT SELECT ON `e_commerce_db`.`Customer` TO 'order_processor'@'localhost';
GRANT SELECT ON `e_commerce_db`.`Address` TO 'order_processor'@'localhost';
GRANT SELECT ON `e_commerce_db`.`Order` TO 'order_processor'@'localhost';
GRANT SELECT ON `e_commerce_db`.`Order_item` TO 'order_processor'@'localhost';
GRANT SELECT ON `e_commerce_db`.`Product` TO 'order_processor'@'localhost';
GRANT SELECT, UPDATE ON `e_commerce_db`.`Inventory` TO 'order_processor'@'localhost';

CREATE USER 'reporting_analyst'@'localhost' IDENTIFIED BY 'fd**)*M886df';
GRANT SELECT ON `e_commerce_db`.`Order` TO 'reporting_analyst'@'localhost';
GRANT SELECT ON `e_commerce_db`.`Product` TO 'reporting_analyst'@'localhost';
GRANT SELECT ON `e_commerce_db`.`Category` TO 'reporting_analyst'@'localhost';
GRANT SELECT ON `e_commerce_db`.`Inventory` TO 'reporting_analyst'@'localhost';
GRANT SELECT ON `e_commerce_db`.`Product_category_map` TO 'reporting_analyst'@'localhost';