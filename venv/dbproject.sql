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
    VALUES (2,'Sliver Watches',20.50,'Sliver coated wrist watch for all gender','wristwatch4.jpg',2,5),
    (3,'Sliver Bracelet',20.00,'Hand sterling Sliver bracelet','bracelet2.jpg',3,5),
    (4,'Necklace',12.99,'Multi strand necklace','bracelet6.jpg',14,5),
    (5,'New Laptop',550.80,'Hp 3-1 function','laptop1.jpg',4,3),
    (6,'Iphone 7',1000,'Apple iPhone 7','laptop6.jpg',14,3),
    (7,'Super Heros',50,'Lego Super heroes 2','movie4.jpg',14,4),
    (8,'Scooby-Doo',20.80,'Kids halloween movie','movie2.jpg',12,4),
    (9,'Men dress shoe',60,'Black men dress shoe','men8.jpg',8,1),
     (10,'Men Knittle',35.00,'Cute Men Knittle Jacket','men6.jpg',5,1),
     (11,'Shoulder bag',40.80,'Women comfort Shoulder bag','women5.jpg',12,6),
     (12,'Short dress',100,'Ladies midi dress','women2.jpg',24,6),
	(13,'Ladies high heels',150.80,'Available in various colors','women8.jpg',12,6),

    (14,'Men Watch',29.99,'Elegant Men Wrist watch','wristwatch1.jpg',4,5),
    (15,'Leather Watches',15.00,'Water proof leather wrist watch','wristwatch2.jpg',3,5),
    (16,'Bracelet Watches',10.00,'Beautiful ladies hand braclet wrist watch','wristwatch3.jpg',3,5),
    (17,'Unique watch',9.50,'Suitable for everyone','wristwatch5.jpg',5,5),
    (18,'Kada bracelet',35.00,'Shop hand kada bracelet with ring','bracelet1.jpg',4,5),
    (19,'Gold Bracelet',20.59,'Gold plated hand bracelet','bracelet3.jpg',7,5),
    (20,'Gold hand chain',29.50,'Fashion bracelet gold hand chain','bracelet4.jpg',5,5),
    (21,'Necklace',73.38,'Interlocking sliver necklace and bracelet','bracelet5.jpg',4,5),
    (22,'Mini necklace',73.38,'Beautiful, attractive mini necklace','bracelet7.jpg',2,5),
    (23,'Men shirt',50.00,'Slim fit men long sleeve shirt','men1.jpg',15,1),
    (24,'Men suit',100.85 ,'fitted men suit', 'men2.jpg',10,1),
    (25,'Men T-shirt',20,'Men fitted shirt','men3.jpg',20,1),
    (26,'Men blazer',30,'Men fitted blazer','men4.jpg',30,1),
    (27,'Men Jacket',24.56,'Men Brown Jacket','men5.jpg',14,1),
    (28,'Hugh loafers',50,'Hugh perforated penny loafers','men7.jpg',11,1),
    (29,'Hp Essential',1000,'Hp Essential personal laptop','laptop2.jpg',4,3),
	(30,'New Mac',2550.80,'Mac for hackering','laptop3.jpg',2,3),
	(31,'Samsung Phone',550.80,'Samsung galaxy S5 Black','laptop5.jpg',12,3),
    (32,'New Dell',1500,'Dell inspiron personal laptop (i3542-)','laptop4.jpg',4,3),
    (33,'Ladies dress',150.40,'Summer women midi dress','women1.jpg',14,6),
	(34,'Long sleeve dress',50.80,'Women button down long sleeve','women3.jpg',12,6),
    (35,'Leather Bag',50,'Women Pu leather dollar bag','women4.jpg',14,6),
    (36,'Laptop handbag',30,'Comfortable to use','women6.jpg',4,6),
    (37,'Ladies loafers',50,'Flat durable loafers','women7.jpg',14,6),
    (38,'Ladies office shoe',25,'cute with different colors','women9.jpg',4,6),
    (39,'Venom',20,'Venom by tom hardy','movie1.jpg',14,4),
    (40,'Avengers',30,'Avengers : infinity war','movie3.jpg',4,4),
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

INSERT INTO `users`
VALUES (1,'0cc175b9c0f1b6a831c399e269772661','abcd@example.com','Tobe','Ihegborow','scaa','asa','as','asc','dasd','dfas','dsa','23-02-2010');


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