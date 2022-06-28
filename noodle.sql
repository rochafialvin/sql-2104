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
    gender ENUM('Male', 'Female'), -- ENUM memungkinkan kita untuk menentukan value apa saja yang dapat disimpan pada suatu kolom
	phone VARCHAR(13),
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP, -- Mencatat waktu saat data baru ditambahkan
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP -- Mencatat waktu terakhir kali data mengalami perubahan
);


CREATE TABLE order(
	order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT, -- FOREIGN KEY untuk customers
    product_id INT, -- FOREIGN KEY untuk products
    order_time DATETIME,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP, -- 2022-01-18 09:24:00
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, -- 2022-01-19 19:24:00
    -- kolom customer_id merupakan foreign key yang akan menyimpan data dari kolom customer_id milik tabel customer
    CONSTRAINT FK_customer_id FOREIGN KEY (customer_id) REFERENCES customer(customer_id) ON UPDATE CASCADE ON DELETE SET NULL,
    -- kolom product_id merupakan foreign key yang akan menyimpan data dari kolom product_id milik tabel product
    CONSTRAINT FK_product_id FOREIGN KEY (product_id) REFERENCES product(product_id) ON UPDATE CASCADE ON DELETE RESTRICT
);



