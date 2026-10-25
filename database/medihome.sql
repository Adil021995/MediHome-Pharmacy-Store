CREATE DATABASE IF NOT EXISTS medihome CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE medihome;
DROP TABLE IF EXISTS order_items;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS medicines;
DROP TABLE IF EXISTS categories;
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS admins;
CREATE TABLE admins(id INT AUTO_INCREMENT PRIMARY KEY,name VARCHAR(100) NOT NULL,email VARCHAR(190) UNIQUE NOT NULL,password_hash VARCHAR(255) NOT NULL);
CREATE TABLE users(id INT AUTO_INCREMENT PRIMARY KEY,name VARCHAR(100) NOT NULL,email VARCHAR(190) UNIQUE NOT NULL,phone VARCHAR(30),password_hash VARCHAR(255) NOT NULL,created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP);
CREATE TABLE categories(id INT AUTO_INCREMENT PRIMARY KEY,name VARCHAR(100) UNIQUE NOT NULL,icon VARCHAR(20) NOT NULL DEFAULT '💊');
CREATE TABLE medicines(id INT AUTO_INCREMENT PRIMARY KEY,category_id INT NOT NULL,name VARCHAR(180) NOT NULL,description TEXT,price DECIMAL(10,2) NOT NULL,old_price DECIMAL(10,2),stock INT NOT NULL DEFAULT 0,image_url VARCHAR(500),prescription_required TINYINT(1) NOT NULL DEFAULT 0,is_featured TINYINT(1) NOT NULL DEFAULT 0,expiry_date DATE,created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,FOREIGN KEY(category_id) REFERENCES categories(id));
CREATE TABLE orders(id INT AUTO_INCREMENT PRIMARY KEY,user_id INT NOT NULL,customer_name VARCHAR(100) NOT NULL,phone VARCHAR(30) NOT NULL,address TEXT NOT NULL,payment_method VARCHAR(40) NOT NULL DEFAULT 'Demo Payment',payment_status VARCHAR(40) NOT NULL DEFAULT 'Demo only',status ENUM('Pending','Confirmed','Packed','Shipped','Delivered','Cancelled') NOT NULL DEFAULT 'Pending',total DECIMAL(10,2) NOT NULL,created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,FOREIGN KEY(user_id) REFERENCES users(id));
CREATE TABLE order_items(id INT AUTO_INCREMENT PRIMARY KEY,order_id INT NOT NULL,medicine_id INT NOT NULL,medicine_name VARCHAR(180) NOT NULL,quantity INT NOT NULL,unit_price DECIMAL(10,2) NOT NULL,FOREIGN KEY(order_id) REFERENCES orders(id) ON DELETE CASCADE,FOREIGN KEY(medicine_id) REFERENCES medicines(id));
-- Demo admin login is handled in admin/login.php; change it before any public deployment.
INSERT INTO admins(name,email,password_hash) VALUES('MediHome Admin','admin@medihome.local','demo-login-only');
INSERT INTO categories(name,icon) VALUES('Everyday Care','💊'),('Vitamins & Wellness','🍊'),('First Aid','🩹'),('Personal Care','🧴'),('Baby Care','🍼');
INSERT INTO medicines(category_id,name,description,price,old_price,stock,image_url,prescription_required,is_featured,expiry_date) VALUES
(1,'Dolo-650 Paracetamol Tablets','Paracetamol 650 mg tablet product listing. Read the package label and consult a qualified healthcare professional before use. Use only as directed by a healthcare professional.',30,35,60,'https://texinkart.com/cdn/shop/products/Dolo-650-Tablets---15-Tablets-Micro-Labs-1667089226.jpg?v=1747710967',1,1,'2027-12-31'),
(2,'Himalayan Organics Vitamin C 1000 mg','Vitamin C supplement listing. Check the package for ingredients, serving instructions, warnings and suitability before use.',399,449,42,'https://cdn.netmeds.tech/v2/plain-cake-860195/netmed/wrkr/products/assets/item/free/resize-w%3A400/x5lJxOk3Jc-himalayan_organics_vitamin_c_1000_mg_tablet_120s_0_0.jpg',0,1,'2027-11-30'),
(3,'First Aid Essentials Kit','First-aid kit listing. Check kit contents and product instructions before use.',349,399,25,'/MediHome/assets/images/first-aid.svg',0,1,'2028-03-31'),
(4,'Dettol Original Hand Sanitizer 200 ml','Hand sanitizer product listing. Follow the product label and keep away from children and sources of flame.',89,99,75,'https://bf1af2.akinoncloudcdn.com/products/2025/06/04/56913/b8fae8d6-1bd0-4e02-ab75-6c9aeb4de15b_size3840_cropCenter.jpg',0,1,'2027-09-30'),
(5,'Baby Care Starter Pack','Baby-care product bundle listing. Check individual package labels and age suitability before use.',499,549,18,'/MediHome/assets/images/baby-care.svg',0,1,'2027-10-31'),
(3,'Digital Thermometer','Digital thermometer product listing. Follow the manufacturer instructions for use and cleaning.',199,NULL,30,'/MediHome/assets/images/thermometer.svg',0,1,NULL);
