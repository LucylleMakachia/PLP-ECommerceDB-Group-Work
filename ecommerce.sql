CREATE DATABASE ecommerceDB;
USE ecommerceDB;

CREATE TABLE brand (
    brand_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    description TEXT
);

CREATE TABLE product_category (
    category_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    description TEXT
);

CREATE TABLE product (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    brand_id INT,
    category_id INT,
    base_price DECIMAL(10, 2),
    description TEXT,
    FOREIGN KEY (brand_id) REFERENCES brand(brand_id),
    FOREIGN KEY (category_id) REFERENCES product_category(category_id)
);

CREATE TABLE color (
    color_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50),
    hex_value VARCHAR(7)
);

CREATE TABLE size_category (
    size_category_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL
);

CREATE TABLE size_option (
    size_option_id INT PRIMARY KEY AUTO_INCREMENT,
    size_category_id INT,
    label VARCHAR(50),
    value VARCHAR(50),
    FOREIGN KEY (size_category_id) REFERENCES size_category(size_category_id)
);

CREATE TABLE product_variation (
    variation_id INT PRIMARY KEY AUTO_INCREMENT,
    product_id INT,
    color_id INT,
    size_option_id INT,
    FOREIGN KEY (product_id) REFERENCES product(product_id),
    FOREIGN KEY (color_id) REFERENCES color(color_id),
    FOREIGN KEY (size_option_id) REFERENCES size_option(size_option_id)
);

CREATE TABLE product_item (
    product_item_id INT PRIMARY KEY AUTO_INCREMENT,
    product_id INT,
    variation_id INT,
    sku VARCHAR(100),
    stock_quantity INT,
    price_override DECIMAL(10, 2),
    FOREIGN KEY (product_id) REFERENCES product(product_id),
    FOREIGN KEY (variation_id) REFERENCES product_variation(variation_id)
);

CREATE TABLE product_image (
    image_id INT PRIMARY KEY AUTO_INCREMENT,
    product_item_id INT,
    image_url VARCHAR(500),
    FOREIGN KEY (product_item_id) REFERENCES product_item(product_item_id)
);

CREATE TABLE attribute_type (
    attribute_type_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100)
);

CREATE TABLE attribute_category (
    attribute_category_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100)
);

CREATE TABLE product_attribute (
    attribute_id INT PRIMARY KEY AUTO_INCREMENT,
    product_id INT,
    attribute_category_id INT,
    attribute_type_id INT,
    name VARCHAR(255),
    value TEXT,
    FOREIGN KEY (product_id) REFERENCES product(product_id),
    FOREIGN KEY (attribute_category_id) REFERENCES attribute_category(attribute_category_id),
    FOREIGN KEY (attribute_type_id) REFERENCES attribute_type(attribute_type_id)
);

--Introducing Customer and Order Management Tables into the e-commerce database

-- 1. Products Table
CREATE TABLE IF NOT EXISTS Products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    price DECIMAL(10, 2) NOT NULL,
    stock_quantity INT DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 2. Orders Table
CREATE TABLE IF NOT EXISTS Orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    CustomerID INT NOT NULL, -- matches your existing Customers table
    order_date DATE NOT NULL,
    order_status VARCHAR(50) DEFAULT 'pending',
    total_amount DECIMAL(10, 2),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- 3. OrderItems Table
CREATE TABLE IF NOT EXISTS OrderItems (
    order_item_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

-- 4. Shipping Table
CREATE TABLE IF NOT EXISTS Shipping (
    shipping_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT NOT NULL,
    shipping_address TEXT NOT NULL,
    shipping_method VARCHAR(50),
    tracking_number VARCHAR(100),
    shipped_date DATE,
    delivery_date DATE,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id)

-- View an Order with Product Information
SELECT 
    o.order_id,
    c.FullName AS customer_name,
    p.name AS product_name,
    oi.quantity,
    oi.price,
    (oi.quantity * oi.price) AS total_price
FROM OrderItems oi
JOIN Orders o ON oi.order_id = o.order_id
JOIN Customers c ON o.CustomerID = c.CustomerID
JOIN Products p ON oi.product_id = p.product_id
WHERE o.order_id = 10;

-- Create ProductReviews Table

CREATE TABLE IF NOT EXISTS ProductReviews (
    review_id INT PRIMARY KEY AUTO_INCREMENT,
    CustomerID INT NOT NULL,
    product_id INT NOT NULL,
    rating INT CHECK (rating BETWEEN 1 AND 5),
    review_text TEXT,
    review_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);


-- Inserting sample data into the e-commerce database

-- Sample Brands
INSERT INTO brand (name, description, logo_url) VALUES
('Nike', 'Athletic and casual footwear, apparel, and accessories', 'https://example.com/logos/nike.png'),
('Apple', 'Consumer electronics, software, and online services', 'https://example.com/logos/apple.png'),
('IKEA', 'Ready-to-assemble furniture, kitchen appliances, and home accessories', 'https://example.com/logos/ikea.png');

-- Sample Product Categories (with hierarchy)
INSERT INTO product_category (name, description, parent_category_id) VALUES
('Electronics', 'Electronic devices and accessories', NULL),
('Clothing', 'Apparel and fashion items', NULL),
('Furniture', 'Home and office furniture', NULL);

-- Add subcategories
INSERT INTO product_category (name, description, parent_category_id) VALUES
('Smartphones', 'Mobile phones and accessories', 1),
('Laptops', 'Portable computers', 1),
('Men\'s Clothing', 'Clothing items for men', 2),
('Women\'s Clothing', 'Clothing items for women', 2),
('Living Room', 'Furniture for living rooms', 3),
('Office', 'Furniture for offices', 3);

-- Sample Colors
INSERT INTO color (name, color_code) VALUES
('Black', '#000000'),
('White', '#FFFFFF'),
('Red', '#FF0000'),
('Blue', '#0000FF'),
('Green', '#00FF00'),
('Gray', '#808080');

-- Sample Size Categories
INSERT INTO size_category (name, description) VALUES
('Clothing Sizes', 'Standard clothing sizes'),
('Shoe Sizes', 'Standard shoe sizes'),
('Screen Sizes', 'Device screen sizes in inches');

-- Sample Size Options
INSERT INTO size_option (size_category_id, name, code, sort_order) VALUES
(1, 'Small', 'S', 1),
(1, 'Medium', 'M', 2),
(1, 'Large', 'L', 3),
(1, 'X-Large', 'XL', 4),
(2, 'US 7', '7', 1),
(2, 'US 8', '8', 2),
(2, 'US 9', '9', 3),
(2, 'US 10', '10', 4),
(3, '13-inch', '13', 1),
(3, '14-inch', '14', 2),
(3, '16-inch', '16', 3);

-- Sample Attribute Categories
INSERT INTO attribute_category (name, description) VALUES
('Physical', 'Physical attributes like weight, dimensions'),
('Technical', 'Technical specifications'),
('Material', 'Material composition information');

-- Sample Attribute Types
INSERT INTO attribute_type (name, data_type) VALUES
('Text', 'text'),
('Number', 'number'),
('Boolean', 'boolean'),
('Date', 'date');

-- Sample Products
INSERT INTO product (name, description, base_price, brand_id, category_id, active) VALUES
('iPhone 14 Pro', 'Apple\'s flagship smartphone with advanced camera system', 999.99, 2, 4, TRUE),
('MacBook Pro', 'Powerful laptop for professionals', 1999.99, 2, 5, TRUE),
('Air Force 1', 'Iconic basketball shoes turned streetwear staple', 90.00, 1, 2, TRUE),
('POÄNG Chair', 'Bentwood armchair with cushion', 159.00, 3, 8, TRUE);

-- Sample Product Images
INSERT INTO product_image (product_id, image_url, is_primary, display_order) VALUES
(1, 'https://example.com/images/iphone14pro_1.jpg', TRUE, 1),
(1, 'https://example.com/images/iphone14pro_2.jpg', FALSE, 2),
(2, 'https://example.com/images/macbookpro_1.jpg', TRUE, 1),
(3, 'https://example.com/images/airforce1_1.jpg', TRUE, 1),
(3, 'https://example.com/images/airforce1_2.jpg', FALSE, 2),
(4, 'https://example.com/images/poang_1.jpg', TRUE, 1);

-- Sample Product Variations
INSERT INTO product_variation (product_id, color_id, size_id) VALUES
(1, 1, NULL), -- iPhone 14 Pro in Black
(1, 2, NULL), -- iPhone 14 Pro in White
(2, 1, 11),   -- MacBook Pro in Black, 16-inch
(2, 2, 10),   -- MacBook Pro in White, 14-inch
(3, 1, 6),    -- Air Force 1 in Black, Size US 8
(3, 2, 6),    -- Air Force 1 in White, Size US 8
(3, 2, 7),    -- Air Force 1 in White, Size US 9
(4, 6, NULL); -- POÄNG Chair in Gray

-- Sample Product Items (SKUs)
INSERT INTO product_item (product_id, variation_id, sku, price, quantity_in_stock, is_available) VALUES
(1, 1, 'IPH14PRO-BLK-128', 999.99, 50, TRUE),
(1, 2, 'IPH14PRO-WHT-128', 999.99, 30, TRUE),
(2, 3, 'MBP16-BLK-512', 2499.99, 15, TRUE),
(2, 4, 'MBP14-WHT-512', 1999.99, 10, TRUE),
(3, 5, 'AF1-BLK-08', 90.00, 25, TRUE),
(3, 6, 'AF1-WHT-08', 90.00, 40, TRUE),
(3, 7, 'AF1-WHT-09', 90.00, 35, TRUE),
(4, 8, 'POANGCHR-GRY', 159.00, 20, TRUE);

-- Sample Product Attributes
INSERT INTO product_attribute (product_id, attr_category_id, attr_type_id, attribute_name, attribute_value) VALUES
(1, 2, 2, 'Storage', '128 GB'),
(1, 2, 2, 'RAM', '6 GB'),
(1, 1, 2, 'Weight', '240 g'),
(2, 2, 2, 'Processor', 'Apple M2 Pro'),
(2, 2, 2, 'RAM', '16 GB'),
(3, 3, 1, 'Upper Material', 'Leather'),
(3, 3, 1, 'Sole Material', 'Rubber'),
(4, 3, 1, 'Frame Material', 'Birch veneer'),
(4, 3, 1, 'Cushion Material', 'Polyester');

-- Sample data for Customer and Order Management

 -- Insert Products
INSERT INTO Products (name, description, price, stock_quantity) VALUES
('Wireless Mouse', 'Ergonomic wireless mouse', 15.00, 50),
('USB Keyboard', 'Standard wired USB keyboard', 25.00, 30),
('HD Monitor', '24-inch full HD monitor', 120.00, 20);

-- Insert a Sample Order. giving that there is a customerID = 1 in the customer table
INSERT INTO Orders (CustomerID, order_date, order_status, total_amount) VALUES
(1, CURDATE(), 'pending', 55.00); -- total = (2 * 15) + (1 * 25)


-- Insert OrderItems if the order_id = 1 from the above
INSERT INTO OrderItems (order_id, product_id, quantity, price) VALUES
(1, 1, 2, 15.00), -- 2 Wireless Mouse
(1, 2, 1, 25.00); -- 1 USB Keyboard

-- Insert Shipping Information
INSERT INTO Shipping (order_id, shipping_address, shipping_method, tracking_number, shipped_date)
VALUES
(1, '123 Bookstore Ave, Lagos', 'Standard Delivery', 'TRACK123456', CURDATE());

-- Sample data for product reviews between 1 to 5 star rating

INSERT INTO ProductReviews (CustomerID, product_id, rating, review_text) VALUES
(1, 1, 5, 'This wireless mouse is super smooth and works great!'),
(1, 2, 4, 'Keyboard feels good but the cable is a bit short.');

