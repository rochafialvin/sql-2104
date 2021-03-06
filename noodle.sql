CREATE DATABASE noodles;

USE noodles;

CREATE TABLE product (
	product_id INT AUTO_INCREMENT PRIMARY KEY,
	variant VARCHAR(30) NOT NULL,
	price DECIMAL(3, 2), 
	-- Jumlah digit total yang dimiliki maksimal adalah tiga digit, dengan dua digit di belakang koma
	-- 3.50, 1.00
    -- DECIMAL (5, 2) -- Maksimal terdapat 5 digit, dengan 2 digit di belakang koma
    -- benar : 3.50 , 23.34, 234.99
    -- salah : 7689.99
	origin VARCHAR(20),
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP, -- 2022-01-18 09:24:00
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP -- 2022-01-19 19:24:00
);

CREATE TABLE customer(
	customer_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(20),
    last_name VARCHAR(20),
    age INT NOT NULL, -- NOT NULL : kolom ini tidak boleh kosong
    gender ENUM('M', 'F'), -- ENUM memungkinkan kita untuk menentukan value apa saja yang dapat disimpan pada suatu kolom
	phone VARCHAR(13),
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP, -- Mencatat waktu saat data baru ditambahkan
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP -- Mencatat waktu terakhir kali data mengalami perubahan
);

CREATE TABLE orders(
	order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT, -- FOREIGN KEY untuk customers
    product_id INT, -- FOREIGN KEY untuk products
    order_time DATETIME,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP, -- 2022-01-18 09:24:00
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, -- 2022-01-19 19:24:00
    -- kolom customer_id merupakan foreign key yang akan menyimpan data dari kolom customer_id milik tabel customer
	-- saat customer_id milik table customer berubah, maka customer_id pada order juga akan berubah
	-- saat data pada customer dihapus, maka customer id pada order akan menjadi null
    CONSTRAINT FK_customer_id FOREIGN KEY (customer_id) REFERENCES customer(customer_id) ON UPDATE CASCADE ON DELETE SET NULL,
    -- kolom product_id merupakan foreign key yang akan menyimpan data dari kolom product_id milik tabel product
    -- saat product_id milik table product berubah, maka product_id pada order juga akan berubah
	-- saat data pada product dihapus, maka akan dihalangi (tidak bisa di hapus)
    CONSTRAINT FK_product_id FOREIGN KEY (product_id) REFERENCES product(product_id) ON UPDATE CASCADE ON DELETE RESTRICT
);

-- DESKRIPSI TABLE / INFORMASI TABLE (jumlah kolum, nama beserta tipe data setiap kolum , dst
DESC customer;


-- ADD NEW COLUMN (Paling belakang)
ALTER TABLE customer ADD COLUMN address VARCHAR(20);

-- ADD NEW COLUMN (Tentukan Posisi)
ALTER TABLE customer ADD COLUMN age INT AFTER last_name;

-- CHANGE COLUMN
ALTER TABLE customer CHANGE address alamat VARCHAR(20);
ALTER TABLE customer CHANGE gender gender ENUM('M', 'F');

-- DELETE COLUMN
ALTER TABLE customer DROP COLUMN age;

-- ###########
-- # C R U D #
-- ###########


INSERT INTO product (variant, price, origin)
VALUES	('Soto Banjar', 3.50, 'Banjar'),
		('Soto Banjar Limau Kulit', 3.60, 'Banjar'),
		('Mi Cakalang', 3.50, 'Manado'),
        ('Mi Goreng Cakalang',3.00,'Manado'),
		('Empal Gentong',3.50,'Betawi'),
		('Soto Betawi',3.00,'Betawi'),
		('Mi Kocok Bandung',3.00,'Bandung'),
		('Soto Medan', 2.30,'Medan'),
		('Kari Ayam Medan', 2.50,'Medan'),
		('Bulgogi', 4.20, 'Korea'),
		('Laksa', 4.00, 'Singapore'),
		('Tomyum', 3.80, 'Thailand');
	

INSERT INTO customer (first_name, last_name, age, gender, phone)
VALUES ('Hinata','Shoyo', 15,'M','01123147789'),
('Elon','Musk', 20,'F','01123439899'),('Mark','Zuckerberg', 28,'M','01174592013'),
('Leonardo','Davinci', 35,'M',NULL),('Sarah','Teressa', 20, 'F','01176348290'),
('Neil','Armstrong', 40,'F','01145787353'),('Michael','Jordan', 55,'M','01980289282'),
('Daily','Nash',35,'F','01176987789'),('Max','Jordan',35,'M','01173456782'),
('Senku',NULL, 19, 'F','01139287883'),('Linda','Jordan', 19,'F','01176923804'),
('Kevin','Hard', 40, 'M',NULL),('John','Smith', 56,'M','01174987221'),
('John','Teressa', 36,'M',NULL),('Elon','Smith', 38, 'F','01176984116'),('Gob','Jordan', 36,'M','01176985498'),
('George','Jordan', 41,'M','01176984303'),('Lucian','Jordan', 28, 'F','01198773214'),
('George','Evans', 33, 'M','01174502933'),('Emily','Sinek',37, 'F','01899284352'),
('Steph','Smith', 53,  'M','01144473330'),('Jennifer',NULL, 20, 'F',NULL),
('Toby','Wan', 34, 'M','01176009822'),('Paul','London', 33,'M','01966947113');

INSERT INTO orders (product_id,customer_id,order_time) VALUES (1,1,'2017-01-01 08-02-11'),(1,2,'2017-01-01 08-05-16'),
(5,12,'2017-01-01 08-44-34'),(3,4,'2017-01-01 09-20-02'),
(1,9,'2017-01-01 11-51-56'),(6,22,'2017-01-01 13-07-10'),
(1,1,'2017-01-02 08-03-41'),(3,10,'2017-01-02 09-15-22'),
(2,2,'2017-01-02 10-10-10'),(3,13,'2017-01-02 12-07-23'),
(1,1,'2017-01-03 08-13-50'),(7,16,'2017-01-03 08-47-09'),
(6,21,'2017-01-03 09-12-11'),(5,22,'2017-01-03 11-05-33'),
(4,3,'2017-01-03 11-08-55'),(3,11,'2017-01-03 12-02-14'),
(2,23,'2017-01-03 13-41-22'),(1,1,'2017-01-04 08-08-56'),
(3,10,'2017-01-04 11-23-43'),(4,12,'2017-01-05 08-30-09'),
(7,1,'2017-01-06 09-02-47'),(3,18,'2017-01-06 13-23-34'),
(2,16,'2017-01-07 09-12-39'),(2,14,'2017-01-07 11-24-15'),
(4,5,'2017-01-08 08-54-11'),(1,1,'2017-01-09 08-03-11'),
(6,20,'2017-01-10 10-34-12'),(3,3,'2017-01-10 11-02-11'),
(4,24,'2017-01-11 08-39-11'),(4,8,'2017-01-12 13-20-13'),
(1,1,'2017-01-14 08-27-10'),(4,15,'2017-01-15 08-30-56'),
(1,7,'2017-01-16 10-02-11'),(2,10,'2017-01-17 09-50-05'),
(1,1,'2017-01-18 08-22-55'),(3,9,'2017-01-19 09-00-19'),
(7,11,'2017-01-19 11-33-00'),(6,12,'2017-01-20 08-02-21'),
(3,14,'2017-01-21 09-45-50'),(5,2,'2017-01-22 10-10-34'),
(6,24,'2017-01-23 08-32-19'),(6,22,'2017-01-23 08-45-12'),
(6,17,'2017-01-23 12-45-30'),(2,11,'2017-01-24 08-01-27'),
(1,1,'2017-01-25 08-05-13'),(6,11,'2017-01-26 10-49-10'),
(7,3,'2017-01-27 09-23-57'),(7,1,'2017-01-27 10-08-16'),
(3,18,'2017-01-27 10-13-09'),(4,19,'2017-01-27 11-02-40'),
(3,10,'2017-01-28 08-03-21'),(1,2,'2017-01-28 08-33-28'),
(1,12,'2017-01-28 11-55-33'),(1,13,'2017-01-29 09-10-17'),
(6,6,'2017-01-30 10-07-13'),(1,1,'2017-02-01 08-10-14'),
(2,14,'2017-02-02 10-02-11'),(7,10,'2017-02-02 09-43-17'),
(7,20,'2017-02-03 08-33-49'),(4,21,'2017-02-04 09-31-01'),
(5,22,'2017-02-05 09-07-10'),(3,23,'2017-02-06 08-15-10'),
(2,24,'2017-02-07 08-27-26'),(1,1,'2017-02-07 08-45-10'),
(6,11,'2017-02-08 10-37-10'),(3,13,'2017-02-09 08-58-18'),
(3,14,'2017-02-10 09-12-40'),(5,4,'2017-02-10 11-05-34'),
(1,2,'2017-02-11 08-00-38'),(3,8,'2017-02-12 08-08-08'),
(7,20,'2017-02-12 09-22-10'),(1,1,'2017-02-13 08-37-45'),
(5,2,'2017-02-13 12-34-56'),(4,3,'2017-02-14 08-22-43'),(5,4,'2017-02-14 09-12-56'),(3,5,'2017-02-15 08-09-10'),(6,7,'2017-02-15 09-05-12'),(1,8,'2017-02-15 09-27-50'),(2,9,'2017-02-16 08-51-12'),(3,10,'2017-02-16 13-07-46'),(4,11,'2017-02-17 08-03-55'),(4,12,'2017-02-17 09-12-11'),(5,10,'2017-02-17 11-41-17'),(6,18,'2017-02-17 13-05-56'),(7,19,'2017-02-18 08-33-27'),(1,17,'2017-02-19 08-12-31'),(1,1,'2017-02-20 09-50-17'),(3,5,'2017-02-20 09-51-29'),(4,6,'2017-02-20 10-43-39'),(3,1,'2017-02-21 08-32-17'),(1,1,'2017-02-21 10-30-11'),(3,2,'2017-02-21 11-08-45'),(4,3,'2017-02-22 11-46-32'),(2,15,'2017-02-22 13-35-16'),(6,13,'2017-02-23 08-34-48'),(4,24,'2017-02-24 08-32-03'),(2,13,'2017-02-25 08-03-12'),(7,17,'2017-02-25 09-34-23'),(7,23,'2017-02-25 11-32-54'),(5,12,'2017-02-26 11-47-34'),
(6,4,'2017-02-27 12-12-34'),(1,1,'2017-02-28 08-59-22');


-- READ

-- Tampilkan semua kolom dari table product
SELECT * FROM product;

-- Tampilkan kolom variant dan origin dari table product
SELECT variant, origin FROM product;

SELECT product_id, variant, price, origin FROM product
WHERE price = 3.50 AND origin = "Banjar";

SELECT product_id, variant, price, origin FROM product
WHERE price = 3.00 OR origin = "Manado";

-- INEQUALITY (>, <, >=, <=, !=)

-- Harganya bukan 3.50
SELECT product_id, variant, price FROM product WHERE price != 3.50;

-- Product yang tidak memiliki asal. originnya null
SELECT product_id, variant, origin FROM product WHERE origin IS NULL;

-- Yang memiliki asal (origin) dan harganya 3.00
SELECT * FROM product WHERE origin IS NOT NULL AND price = 3.00;


SELECT first_name, last_name FROM customer
WHERE last_name IN ('smith', 'jordan' ,'armstrong');

SELECT first_name, last_name FROM customer
WHERE last_name NOT IN ('smith', 'jordan' ,'armstrong');

-- BETWEEN
-- Tampilkan pesanan yang terjadi pada tanggal 5 hingga 20 januari 2017;
SELECT * FROM orders
WHERE order_time BETWEEN '2017-01-05 00:00:00' AND '2017-01-20 23:59:59';

SELECT * FROM product
WHERE price BETWEEN 3.00 AND 3.80;

-- LIKE (case in-sensitive : tidak membedakan huruf kapital dan huruf kecil)
-- % , karakter apapun , dengan jumlah berapapun
-- _ , krakter apapun, satu karakter

-- Customer yang memiliki huruf o, sebelum dan sesudah huruf o boleh ada karakter apapun dan berapapun
-- Elon, Leonardo, John, Gob, George, Toby
SELECT first_name FROM customer
WHERE first_name LIKE '%o%';

-- Customer yang memiliki akhiran l , tidak boleh ada karakter setelah huruf l, tapi boleh ada karakter sebelum l
-- Neil, Michael, Paul
SELECT first_name FROM customer
WHERE first_name LIKE '%l';

SELECT first_name FROM customer
WHERE first_name LIKE 'l%';


-- Customer yang memiliki huruf o, hanya boleh ada satu karakter pada awal dan akhir nama.
-- Gob
SELECT first_name FROM customer
WHERE first_name LIKE '_o_';

-- Customer yang memiliki huruf o
-- sebelum huruf o boleh memiliki karakter berapapun, setelah huruf o hanya boleh ada satu karakter.
SELECT first_name FROM customer
WHERE first_name LIKE '%o_';


-- EXERCISE
-- ########

-- Tampilkan nama depan dan nomor handphone untuk perempuan yang memiliki nama belakang = Jordan
SELECT first_name, phone FROM customer WHERE gender = 'F' AND last_name = "Jordan";
-- Tampilkan nama product yang memiliki harga lebih besar dari 3.50 atau berasal dari Medan
SELECT variant FROM product WHERE price > 3.50 OR origin = 'medan';
-- Tampilkan semua kolom untuk laki - laki yang tidak memiliki nomor handphone
SELECT * FROM customer WHERE gender = 'M' AND phone IS NULL;
-- Tampilkan semua kolom untuk customer yang memiliki nama belakang antara 'Smith', 'Jordan', 'Armstrong';
SELECT * FROM customer WHERE last_name IN('Smith', 'Jordan', 'Armstrong');


-- ORDER BY
-- Mengurutkan data berdasarkan kolom tertentu.
-- ASC / ASCENDING  : kecil --> besar (default)
-- DESC / DESCENDING : besar --> kecil

-- Mengurutkan produk berdasarkan harga (dari yang termurah).
SELECT product_id, variant, price FROM product ORDER BY price;
-- termahal
SELECT product_id, variant, price FROM product ORDER BY price DESC ;

-- Pesanan yang dilakukan oleh user dengan id 4 dan diurutkan berdasarkan tanggal (dari yang terbaru)
SELECT * FROM orders ORDER BY order_time DESC;

-- DISTINCT
-- Menampilkan data secara unique

-- Menampilkan daftar origin products
SELECT DISTINCT (origin) FROM product;

-- Product apa saja yang pernah dipesan
SELECT DISTINCT(product_id) FROM orders;

-- LIMIT & OFFSET
-- ##############
-- LIMIT  : Membatasi jumlah data
-- OFFSET : Skip data


SELECT product_id, variant FROM product LIMIT 5;
SELECT product_id, variant FROM product LIMIT 5 OFFSET 2 ;

-- 1 halaman 5 product

-- halaman 1
SELECT product_id, variant FROM product LIMIT 5 OFFSET 0;

-- halaman 2
SELECT product_id, variant FROM product LIMIT 5 OFFSET 5;

-- halaman 3
SELECT product_id, variant FROM product LIMIT 5 OFFSET 10;

-- ALIAS
-- #####
-- Mengubah nama kolom saat ditampilkan

SELECT product_id AS No, variant AS Nama FROM product;

SELECT product_id No, variant Nama FROM product;

-- MONTH(), YEAR(), DATE()

SELECT variant, YEAR(created_at) FROM product;
SELECT variant, MONTH(created_at) FROM product;
SELECT variant, DATE(created_at) FROM product;

-- EXERCISE
-- Tampilkan nama produk dan harga untuk semua product yang berasal dari DKI atau Manado
SELECT variant, price  FROM product WHERE origin IN ("Betawi", "Manado");
-- Tampilkan semua kolom untuk order yang terjadi pada bulan februari untuk costumer dengan id 2 , 4, 6, 8
SELECT * FROM orders WHERE MONTH(order_time) = 2 AND customer_id IN (2, 4, 6, 8);
-- Tampilkan nama depan, nama belakang, nomor tlp untuk customer yang nama belakang mengandung huruf 'ar'
SELECT first_name, last_name, phone FROM customer WHERE last_name LIKE '%ar%';
-- Tampilkan semua kolom untuk 3 order pertama yang dilakukan oleh customer dengan id 4
SELECT * FROM orders WHERE customer_id = 4 LIMIT 3;
-- Tampilkan product id berapa saja yang berhasil terjual pada bulan februari
SELECT product_id FROM orders WHERE MONTH(order_time) = 2;
-- Tampilkan semua kolom untuk orderan terakhir yang dilakukan oleh customer dengan id 4
SELECT * FROM orders WHERE customer_id = 4 ORDER BY order_time DESC LIMIT 1;



-- JOIN
-- 2 tables
SELECT 
	c.customer_id, first_name, phone, order_time 
FROM customer c
JOIN orders o ON c.customer_id = o.customer_id;

-- customer : customer_id, first_name, last_name, phone
-- order : order_id, customer_id, product_id, order_time

-- c.customer_id, first_name, order_time
SELECT 
	 first_name, order_time
FROM customer c
JOIN orders o USING(customer_id) ;

-- tables
SELECT 
	c.customer_id, first_name, variant, price, order_time 
FROM customer c
JOIN orders o USING(customer_id)
JOIN product p USING(product_id)
WHERE price <= 3.5 LIMIT 3;

-- JOIN : INNER JOIN | LEFT JOIN | RIGHT JOIN
-- ##########################################

SELECT
	first_name, order_time
FROM customer c
LEFT JOIN orders o USING(customer_id);

SELECT
	first_name, order_time
FROM orders o
RIGHT JOIN customer c USING(customer_id);

-- Sub Query

-- List produk yang pernah dipesan
SELECT DISTINCT product_id FROM orders; -- 1 2 3 4 5 6 7

-- List produk yang belum pernah dipesan / tidak ada di tabel orders
SELECT product_id FROM product WHERE product_id NOT IN (SELECT DISTINCT product_id FROM orders);

-- AGGREGATE FUNCTION ????

-- AVG
-- Rata - rata harga mi
SELECT AVG(price) FROM product; -- 1 baris

SELECT origin FROM product; -- 12 baris

SELECT 
	origin, AVG(price) 
FROM product 
GROUP BY origin; 


-- COUNT

SELECT variant, origin FROM product; -- variant : 12, origin : 11

SELECT COUNT(variant) FROM product; -- Menghitung jumlah data pada kolom variant

SELECT COUNT(origin) FROM product; -- Menghitung jumlah data pada kolom origin

SELECT COUNT(DISTINCT origin) FROM product; -- Menghitung jumlah origin secara unique.

-- Jumlah mie untuk setiap daerah
SELECT origin, COUNT(variant) Total FROM product GROUP BY origin;


-- SUM

-- total pendapatan seluruhnya

SELECT
	SUM(price)
FROM orders o 
JOIN product p USING(product_id);

-- total pendapatan untuk masing - masing variant

SELECT
	variant, SUM(price)
FROM orders o 
JOIN product p USING(product_id)
GROUP BY variant;


-- MIN & MAX

SELECT MAX(price) FROM product;
SELECT MIN(price) FROM product;

-- profit terendah yang di dapatkan oleh sebuah variant

SELECT variant, SUM(price)
FROM orders o
JOIN product p USING(product_id) GROUP BY variant ORDER BY SUM(price) LIMIT 1;


SELECT MIN(total_price) FROM (SELECT variant, SUM(price) as total_price
FROM orders o
JOIN product p USING(product_id)
GROUP BY variant) as x;



-- EXERCISE

-- Rata2 umur pelanggan (average_age)
-- Rata2 umur wanita dan pria. (gender, average_age)
-- Jumlah customer dikelompokkan berdasarkan umur. (age, total_customer)
-- Jumlah order masing - masing user (first_name, last_name, total_order)
-- Tampilkan top 3 customer pada bulan januari (first_name, last_name, total_order)

-- Menambahkan field password, image, username, email di user
ALTER TABLE user
ADD password VARCHAR(200) NOT NULL AFTER phone,
ADD image VARCHAR(100) AFTER age,
ADD username VARCHAR(20) UNIQUE AFTER user_id,
ADD email VARCHAR(50) NOT NULL AFTER username;