create database if not exists dbproject;
use dbproject;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS categories;
CREATE TABLE categories (
  categoryId int(11) NOT NULL PRIMARY KEY,
  cname text);

	INSERT INTO `categories` 
    VALUES (1,'Men'),(2,'Books'),(3,'Computers'),
    (4,'Movies'),(5,'jewellery'),
    (6,'Women');


DROP TABLE IF EXISTS products;
CREATE TABLE products (
  productId int(11) NOT NULL PRIMARY KEY,
  pname varchar(255),
  price decimal(10,2) DEFAULT NULL,
  description text,
  image text,
  stock int(11) DEFAULT NULL,
  categoryId int(11) DEFAULT NULL,
  FOREIGN KEY (categoryId) REFERENCES categories(categoryId)
);

	INSERT INTO `products`
    VALUES (2,'Men Watch',29.99,'Elegant Men Wrist watch','wristwatch1.jpg',4,5),
    (3,'Leather Watches',15.00,'Water proof leather wrist watch','wristwatch2.jpg',3,5),
    (4,'Bracelet Watches',10.00,'Beautiful ladies hand braclet wrist watch','wristwatch3.jpg',3,5),
    (5,'Sliver Watches',20.50,'Sliver coated wrist watch for all gender','wristwatch4.jpg',2,5),
    (6,'Unique watch',9.50,'Suitable for everyone','wristwatch5.jpg',5,5),
    (7,'Kada bracelet',35.00,'Shop hand kada bracelet with ring','bracelet1.jpg',4,5),
    (8,'Sliver Bracelet',20.00,'Hand sterling Sliver bracelet','bracelet2.jpg',3,5),
    (9,'Gold Bracelet',20.59,'Gold plated hand bracelet','bracelet3.jpg',7,5),
    (10,'Gold hand chain',29.50,'Fashion bracelet gold hand chain','bracelet4.jpg',5,5),
    (11,'Necklace',73.38,'Interlocking sliver necklace and bracelet','bracelet5.jpg',4,5),
    (12,'Necklace',12.99,'Multi strand necklace','bracelet6.jpg',14,5),
    (13,'Mini necklace',73.38,'Beautiful, attractive mini necklace','bracelet7.jpg',2,5),
    (14,'Men shirt',50.00,'Slim fit men long sleeve shirt','men1.jpg',15,1),
    (15,'Men suit',100.85 ,'fitted men suit', 'men2.jpg',10,1),
    (16,'Men T-shirt',20,'Men fitted shirt','men3.jpg',20,1),
    (17,'Men blazer',30,'Men fitted blazer','men4.jpg',30,1),
    (18,'Men Jacket',24.56,'Men Brown Jacket','men5.jpg',14,1),
    (19,'Men Knittle',35.00,'Cute Men Knittle Jacket','men6.jpg',5,1),
    (20,'Hugh loafers',50,'Hugh perforated penny loafers','men7.jpg',11,1),
    (21,'Men dress shoe',60,'Black men dress shoe','men8.jpg',8,1),
    (22,'New Laptop',550.80,'Hp 3-1 function','laptop1.jpg',4,3),
    (23,'Hp Essential',1000,'Hp Essential personal laptop','laptop2.jpg',4,3),
	(24,'New Mac',2550.80,'Mac for hackering','laptop3.jpg',2,3),
    (25,'Iphone 7',1000,'Apple iPhone 7','laptop6.jpg',14,3),
	(26,'Samsung Phone',550.80,'Samsung galaxy S5 Black','laptop5.jpg',12,3),
    (27,'New Dell',1500,'Dell inspiron personal laptop (i3542-)','laptop4.jpg',4,3),
    (28,'Ladies dress',150.40,'Summer women midi dress','women1.jpg',14,6),
    (29,'Short dress',100,'Ladies midi dress','women2.jpg',24,6),
	(30,'Long sleeve dress',50.80,'Women button down long sleeve','women3.jpg',12,6),
    (31,'Leather Bag',50,'Women Pu leather dollar bag','women4.jpg',14,6),
	(32,'Shoulder bag',40.80,'Women comfort Shoulder bag','women5.jpg',12,6),
    (33,'Laptop handbag',30,'Comfortable to use','women6.jpg',4,6),
    (34,'Ladies loafers',50,'Flat durable loafers','women7.jpg',14,6),
	(35,'Ladies high heels',150.80,'Available in various colors','women8.jpg',12,6),
    (36,'Ladies office shoe',25,'cute with different colors','women9.jpg',4,6),
    (37,'Venom',20,'Venom by tom hardy','movie1.jpg',14,4),
	(38,'Scooby-Doo',20.80,'Kids halloween movie','movie2.jpg',12,4),
    (39,'Avengers',30,'Avengers : infinity war','movie3.jpg',4,4),
    (40,'Super Heros',50,'Lego Super heroes 2','movie4.jpg',14,4),
	(41,'Switch game',53.80,'Nintendo switch game','movie5.jpg',12,4),
    (42,'Video games',25,'video games','movie6.jpg',4,4);


--
-- Table structure for table `users`
--
DROP TABLE IF EXISTS users;
CREATE TABLE users (
  userId int(11) NOT NULL auto_increment primary KEY,
  password text,
  email text,
  firstName text,
  lastName text,
  address1 text,
  address2 text,
  zipcode text,
  city text,
  state text,
  country text,
  phone text,
  date text
);

--
-- Table structure for table `kart`
--

DROP TABLE IF EXISTS cart;
CREATE TABLE cart (
	cartId int(11) PRIMARY KEY,
	userId int(11),
	productId int(11),
	FOREIGN KEY (userId) REFERENCES users(userId),
	FOREIGN KEY (productId) REFERENCES products(productId)
);




CREATE TABLE admin (
  adminId int(11) NOT NULL auto_increment primary KEY,
  password text,
  email text
);

CREATE TABLE ORDERS (
	orderId int(11) auto_increment PRIMARY KEY,
    productId int(11),
    stock int(11),
    FOREIGN KEY (productId) REFERENCES products(productId)
);



DELETE FROM `dbproject`.`users` WHERE `userId`='1';
UPDATE `dbproject`.`users` SET `userId`='1' WHERE `userId`='2';
INSERT INTO `dbproject`.`users` (`userId`, `password`, `email`, `firstName`, `lastName`, `address1`, `address2`, `zipcode`, `city`, `state`, `country`, `phone`, `date`) VALUES ('2', '1234', 'sg@mathew.com', 'mathew', 'mathew', 'lasf', 'lasf', 'lasf', 'lasf', 'lasf', 'lasf', '0901309', '20-01-2019');
INSERT INTO `dbproject`.`users` (`userId`, `password`, `email`, `firstName`, `lastName`, `address1`, `address2`, `zipcode`, `city`, `state`, `country`, `phone`, `date`) VALUES ('3', '1234', 'qwt@mathew.com', 'mathew', 'mathew', 'lasf', 'lasf', 'lasf', 'lasf', 'lasf', 'lasf', '0901309', '20-02-2019');
INSERT INTO `dbproject`.`users` (`userId`, `password`, `email`, `firstName`, `lastName`, `address1`, `address2`, `zipcode`, `city`, `state`, `country`, `phone`, `date`) VALUES ('4', '1234', 'hafs@mathew.com', 'mathew', 'mathew', 'lasf', 'lasf', 'lasf', 'lasf', 'lasf', 'lasf', '0901309', '12-04-2018');
INSERT INTO `dbproject`.`users` (`userId`, `password`, `email`, `firstName`, `lastName`, `address1`, `address2`, `zipcode`, `city`, `state`, `country`, `phone`, `date`) VALUES ('5', '1234', 'hwer@mathew.com', 'mathew', 'mathew', 'lasf', 'lasf', 'lasf', 'lasf', 'lasf', 'lasf', '0901309', '12-05-2018');
INSERT INTO `dbproject`.`users` (`userId`, `password`, `email`, `firstName`, `lastName`, `address1`, `address2`, `zipcode`, `city`, `state`, `country`, `phone`, `date`) VALUES ('6', '1234', 'qerd@mathew.com', 'mathew', 'mathew', 'lasf', 'lasf', 'lasf', 'lasf', 'lasf', 'lasf', '0901309', '12-05-2018');
INSERT INTO `dbproject`.`users` (`userId`, `password`, `email`, `firstName`, `lastName`, `address1`, `address2`, `zipcode`, `city`, `state`, `country`, `phone`, `date`) VALUES ('7', '1234', 'hewt@mathew.com', 'mathew', 'mathew', 'lasf', 'lasf', 'lasf', 'lasf', 'lasf', 'lasf', '0901309', '11-08-2018');
INSERT INTO `dbproject`.`users` (`userId`, `password`, `email`, `firstName`, `lastName`, `address1`, `address2`, `zipcode`, `city`, `state`, `country`, `phone`, `date`) VALUES ('8', '1234', 'asd@mathew.com', 'mathew', 'mathew', 'lasf', 'lasf', 'lasf', 'lasf', 'lasf', 'lasf', '0901309', '14-12-2018');
INSERT INTO `dbproject`.`users` (`userId`, `password`, `email`, `firstName`, `lastName`, `address1`, `address2`, `zipcode`, `city`, `state`, `country`, `phone`, `date`) VALUES ('9', '1234', 'lll@mathew.com', 'mathew', 'mathew', 'lasf', 'lasf', 'lasf', 'lasf', 'lasf', 'lasf', '0901309', '11-12-2018');
INSERT INTO `dbproject`.`users` (`userId`, `password`, `email`, `firstName`, `lastName`, `address1`, `address2`, `zipcode`, `city`, `state`, `country`, `phone`, `date`) VALUES ('10', '1234', 'mmm@mathew.com', 'mathew', 'mathew', 'lasf', 'lasf', 'lasf', 'lasf', 'lasf', 'lasf', '0901309', '5-05-2018');
INSERT INTO `dbproject`.`users` (`userId`, `password`, `email`, `firstName`, `lastName`, `address1`, `address2`, `zipcode`, `city`, `state`, `country`, `phone`, `date`) VALUES ('11', '1234', 'nnn@mathew.com', 'mathew', 'mathew', 'lasf', 'lasf', 'lasf', 'lasf', 'lasf', 'lasf', '0901309', '30-01-2018');
INSERT INTO `dbproject`.`users` (`userId`, `password`, `email`, `firstName`, `lastName`, `address1`, `address2`, `zipcode`, `city`, `state`, `country`, `phone`, `date`) VALUES ('12', '1234', 'bbb@mathew.com', 'mathew', 'mathew', 'lasf', 'lasf', 'lasf', 'lasf', 'lasf', 'lasf', '0901309', '28-02-2018');
INSERT INTO `dbproject`.`users` (`userId`, `password`, `email`, `firstName`, `lastName`, `address1`, `address2`, `zipcode`, `city`, `state`, `country`, `phone`, `date`) VALUES ('13', '1234', 'vvv@mathew.com', 'mathew', 'mathew', 'lasf', 'lasf', 'lasf', 'lasf', 'lasf', 'lasf', '0901309', '01-01-2019');
INSERT INTO `dbproject`.`users` (`userId`, `password`, `email`, `firstName`, `lastName`, `address1`, `address2`, `zipcode`, `city`, `state`, `country`, `phone`, `date`) VALUES ('14', '1234', 'ccc@mathew.com', 'mathew', 'mathew', 'lasf', 'lasf', 'lasf', 'lasf', 'lasf', 'lasf', '0901309', '01-02-2019');
INSERT INTO `dbproject`.`users` (`userId`, `password`, `email`, `firstName`, `lastName`, `address1`, `address2`, `zipcode`, `city`, `state`, `country`, `phone`, `date`) VALUES ('15', '1234', 'jjj@mathew.com', 'mathew', 'mathew', 'lasf', 'lasf', 'lasf', 'lasf', 'lasf', 'lasf', '0901309', '03-03-2019');
INSERT INTO `dbproject`.`users` (`userId`, `password`, `email`, `firstName`, `lastName`, `address1`, `address2`, `zipcode`, `city`, `state`, `country`, `phone`, `date`) VALUES ('16', '1234', 'hhh@mathew.com', 'mathew', 'mathew', 'lasf', 'lasf', 'lasf', 'lasf', 'lasf', 'lasf', '0901309', '01-02-2019');
INSERT INTO `dbproject`.`users` (`userId`, `password`, `email`, `firstName`, `lastName`, `address1`, `address2`, `zipcode`, `city`, `state`, `country`, `phone`, `date`) VALUES ('17', '1234', 'fff@mathew.com', 'mathew', 'mathew', 'lasf', 'lasf', 'lasf', 'lasf', 'lasf', 'lasf', '0901309', '12-02-2019');
INSERT INTO `dbproject`.`users` (`userId`, `password`, `email`, `firstName`, `lastName`, `address1`, `address2`, `zipcode`, `city`, `state`, `country`, `phone`, `date`) VALUES ('18', '1234', 'eee@mathew.com', 'mathew', 'mathew', 'lasf', 'lasf', 'lasf', 'lasf', 'lasf', 'lasf', '0901309', '29-12-2018');
INSERT INTO `dbproject`.`users` (`userId`, `password`, `email`, `firstName`, `lastName`, `address1`, `address2`, `zipcode`, `city`, `state`, `country`, `phone`, `date`) VALUES ('19', '1234', 'qqq@mathew.com', 'mathew', 'mathew', 'lasf', 'lasf', 'lasf', 'lasf', 'lasf', 'lasf', '0901309', '25-12-2018');
INSERT INTO `dbproject`.`users` (`userId`, `password`, `email`, `firstName`, `lastName`, `address1`, `address2`, `zipcode`, `city`, `state`, `country`, `phone`, `date`) VALUES ('20', '1234', 'aaa@mathew.com', 'mathew', 'mathew', 'lasf', 'lasf', 'lasf', 'lasf', 'lasf', 'lasf', '0901309', '11-01-2018');



DELIMITER $$ 
CREATE TRIGGER updatestock
 BEFORE UPDATE ON products
 FOR EACH ROW
BEGIN
IF new.stock = 0 THEN
	INSERT INTO ORDERS(productId,stock) values (old.productId,50);
END IF;
END $$
DELIMITER ;



drop table if exists purchase_history;
CREATE TABLE purchase_history (
p_historyID int(11) NOT NULL auto_increment primary KEY,
userId int,
p_name text,
quantity int,
productId int(11) NOT NULL,
FOREIGN KEY (userId) REFERENCES users(userId),
FOREIGN KEY (productId) REFERENCES products(productId));

INSERT INTO purchase_history
VALUES (null, 3, 'Gold Bracelet', 3, 9), (null, 9, 'New Laptop', 1, 22);


DROP TABLES IF EXISTS bestselling_products;
CREATE TABLE bestselling_products(
bestsellingID int(11) NOT NULL auto_increment primary key,
productId int(11) NOT NULL,
p_name text,
quantity int,
FOREIGN KEY (productId) REFERENCES products(productId));


INSERT INTO bestselling_products
VALUES (null, 17, 'Men blazer', 20);


-- Manager Privileges ------------------------------------------
CREATE USER 'manager'@'localhost' IDENTIFIED BY 'password';
GRANT SELECT, INSERT, DELETE, UPDATE ON dbproject.products TO 'manager'@'localhost';
GRANT EXECUTE ON PROCEDURE dbproject.last4months_users TO 'manager'@'localhost';
GRANT EXECUTE ON PROCEDURE dbproject.low_stock TO 'manager'@'localhost';
GRANT EXECUTE ON PROCEDURE dbproject.Top3_BestSellingProducts TO 'user'@'localhost';
GRANT EXECUTE ON PROCEDURE dbproject.Bestselling TO 'user'@'localhost';


-- User Privileges ------------------------------------------
CREATE USER 'user'@'localhost' IDENTIFIED BY 'password';
GRANT SELECT ON dbproject.products TO 'user'@'localhost';
GRANT EXECUTE ON PROCEDURE dbproject.Top3_BestSellingProducts TO 'user'@'localhost';
GRANT EXECUTE ON PROCEDURE dbproject.Top10_ExpensiveProducts TO 'user'@'localhost';

FLUSH PRIVILEGES;




-- Bestselling Stored Procedures ----------
DROP procedure IF EXISTS `Bestselling`;
DELIMITER $$
USE `dbproject`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `Bestselling`()
BEGIN
SELECT * from bestselling_products;
END$$
DELIMITER ;


-- Low Stock Stored Procedures ----------
USE `dbproject`;
DROP procedure IF EXISTS `low_stock`;
DELIMITER $$
USE `dbproject`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `low_stock`()
BEGIN
SELECT productId, pname, price, stock
FROM dbproject.products
where stock < 5;
END$$
DELIMITER ;


-- Top10_ExpensiveProducts Stored Procedures ----------
DROP procedure IF EXISTS `Top10_ExpensiveProducts`;
DELIMITER $$
USE `dbproject`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `Top10_ExpensiveProducts`()
BEGIN
	SELECT productId, pname, price
	FROM dbproject.products
	where price > 50.00
	order by price desc
	limit 10 ;
END$$
DELIMITER ;


-- Top3_BestSellingProducts Stored Procedures ----------
USE `dbproject`;
DROP procedure IF EXISTS `Top3_BestSellingProducts`;
DELIMITER $$
USE `dbproject`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `Top3_BestSellingProducts`()
BEGIN
	SELECT *
	from bestselling_products
	where quantity > 10
	limit 3;
END$$
DELIMITER ;


-- last4months_users Stored Procedures ----------
USE `dbproject`;
DROP procedure IF EXISTS `last4months_users`;
DELIMITER $$
USE `dbproject`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `last4months_users`()
BEGIN
	SELECT userId, email, firstname, lastName
	FROM dbproject.users
	where date between '01-01-2019' and '01-04-2019';
END$$
DELIMITER ;