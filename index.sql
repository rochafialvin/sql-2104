-- Create Database
CREATE DATABASE mysql_2104;

-- Use Database to work with
USE mysql_2104;


SELECT CURRENT_TIMESTAMP;

-- Create table
-- Primary key, sebuah kolom sebagai acuan untuk membedakan satu data dengan lainnya.
CREATE TABLE user (
	user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(17) UNIQUE NOT NULL,
    password VARCHAR(200) NOT NULL,
    phone VARCHAR(13) UNIQUE,
    age INT,
    isVerified BOOLEAN DEFAULT FALSE,
	createdAt DATETIME DEFAULT CURRENT_TIMESTAMP,
    updatedAt DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

ALTER TABLE user ADD city VARCHAR(20) AFTER age;
ALTER TABLE user DROP city;
ALTER TABLE user RENAME COLUMN phone TO phoneNumber;

ALTER TABLE product ADD updatedAt DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP AFTER createdAt;