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
    VALUES (1,'Men'),(2,'Books'),(3,'Computers and Accessories'),
    (4,'Movies, Music and Video Games'),(5,'Jwelery, Watches and Eyewear'),
    (6,'Women');


DROP TABLE IF EXISTS products;
CREATE TABLE products (
  productId int(11) NOT NULL PRIMARY KEY,
  pname varchar(255),
  price decimal(10,0) DEFAULT NULL,
  description text,
  image text,
  stock int(11) DEFAULT NULL,
  categoryId int(11) DEFAULT NULL,
  FOREIGN KEY (categoryId) REFERENCES categories(categoryId)
); 

	INSERT INTO `products` 
    VALUES (2,'Second',2,'Second Item','Kinkaku_Ji_by_Elizabeth_K_Joseph.jpg',2,1),
    (3,'First',1,'First book.','Untitled_by_Troy_Jarrell.jpg',1,2),
    (4,'T Shirt 1',1,'First T shirt','Kinkaku_Ji_by_Elizabeth_K_Joseph.jpg',1,1),
    (5,'T Shirt 2',2,'Second T shirt','The_Sky_Is_The_Limit_by_Kaushik_Panchal.jpg',2,1),
    (6,'T Shirt 3',3,'Third tshirt','Untitled_by_Troy_Jarrell.jpg',3,1),
    (7,'T Shirt 4',4,'Fourth T shirt','Untitled_by_Aaron_Burden.jpg',4,1),
    (8,'T Shirt 5',5,'FIfth Tshirt','The_Sky_Is_The_Limit_by_Kaushik_Panchal.jpg',5,1),
    (9,'Book 1',1,'FIrst Book','Mountainous_View_by_Sven_Scheuermeier.jpg',1,2),
    (10,'Book 2',2,'Second Book','The_Sky_Is_The_Limit_by_Kaushik_Panchal.jpg',2,2),
    (11,'Book 3',3,'Third book.','Untitled_0026_by_Mike_Sinko.jpg',3,2),
    (12,'Book 4',4,'Fourth book.','Untitled_7019_by_Mike_Sinko.jpg',4,2),
    (13,'Book 5',5,'Fifth book.','Untitled_by_Troy_Jarrell.jpg',5,2),
    (14,'Computer 1',1,'First computer','Untitled_by_Aaron_Burden.jpg',1,3),
    (15,'Movie 1',1,'First mvoie','Yellow_Jacket_by_Manuel_Frei.png',1,4),
    (16,'Jwelery 1',1,'First jwelery','Kinkaku_Ji_by_Elizabeth_K_Joseph.jpg',1,5),
    (17,'Saree 1',1,'First saree','Mountainous_View_by_Sven_Scheuermeier.jpg',1,6);


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
  phone text
);
alter table users
add column date date;

alter table users
modify column date text;


INSERT INTO `users` 
VALUES (1,'0cc175b9c0f1b6a831c399e269772661','abcd@example.com','Tobe','Ihegborow','scaa','asa','as','asc','dasd','dfas','dsa');


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

SELECT productId, pname, price, description, image, stock FROM products WHERE productId = "5";