-- Create ecommerce database
CREATE DATABASE ecommerce_db;
USE ecommerce_db;

-- Core Tables
CREATE TABLE customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    full_name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    phone VARCHAR(50),
    password_hash VARCHAR(255) NOT NULL,
    registration_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE brands (
    brand_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    logo_url VARCHAR(500)
);

CREATE TABLE product_categories (
    category_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    parent_category_id INT,
    FOREIGN KEY (parent_category_id) REFERENCES product_categories(category_id)
);

CREATE TABLE products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    brand_id INT,
    category_id INT,
    base_price DECIMAL(10, 2),
    description TEXT,
    active BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (brand_id) REFERENCES brands(brand_id),
    FOREIGN KEY (category_id) REFERENCES product_categories(category_id)
);

-- Product Variations and Attributes
CREATE TABLE colors (
    color_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL,
    color_code VARCHAR(7)
);

CREATE TABLE size_categories (
    size_category_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    description TEXT
);

CREATE TABLE size_options (
    size_id INT PRIMARY KEY AUTO_INCREMENT,
    size_category_id INT,
    name VARCHAR(50),
    code VARCHAR(50),
    sort_order INT DEFAULT 0,
    FOREIGN KEY (size_category_id) REFERENCES size_categories(size_category_id)
);

CREATE TABLE product_variations (
    variation_id INT PRIMARY KEY AUTO_INCREMENT,
    product_id INT,
    color_id INT,
    size_id INT,
    FOREIGN KEY (product_id) REFERENCES products(product_id),
    FOREIGN KEY (color_id) REFERENCES colors(color_id),
    FOREIGN KEY (size_id) REFERENCES size_options(size_id)
);

CREATE TABLE product_items (
    product_item_id INT PRIMARY KEY AUTO_INCREMENT,
    product_id INT,
    variation_id INT,
    sku VARCHAR(100) UNIQUE,
    price DECIMAL(10, 2),
    quantity_in_stock INT DEFAULT 0,
    is_available BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (product_id) REFERENCES products(product_id),
    FOREIGN KEY (variation_id) REFERENCES product_variations(variation_id)
);

CREATE TABLE product_images (
    image_id INT PRIMARY KEY AUTO_INCREMENT,
    product_id INT,
    image_url VARCHAR(500) NOT NULL,
    is_primary BOOLEAN DEFAULT FALSE,
    display_order INT DEFAULT 0,
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

CREATE TABLE attribute_categories (
    attr_category_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    description TEXT
);

CREATE TABLE attribute_types (
    attr_type_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    data_type VARCHAR(50) NOT NULL
);

CREATE TABLE product_attributes (
    attribute_id INT PRIMARY KEY AUTO_INCREMENT,
    product_id INT,
    attr_category_id INT,
    attr_type_id INT,
    attribute_name VARCHAR(255) NOT NULL,
    attribute_value TEXT,
    FOREIGN KEY (product_id) REFERENCES products(product_id),
    FOREIGN KEY (attr_category_id) REFERENCES attribute_categories(attr_category_id),
    FOREIGN KEY (attr_type_id) REFERENCES attribute_types(attr_type_id)
);

-- Order Management Tables
CREATE TABLE orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    order_status VARCHAR(50) DEFAULT 'pending',
    total_amount DECIMAL(10, 2),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT NOT NULL,
    product_item_id INT NOT NULL,
    quantity INT NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_item_id) REFERENCES product_items(product_item_id)
);

CREATE TABLE shipping (
    shipping_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT NOT NULL,
    shipping_address TEXT NOT NULL,
    shipping_method VARCHAR(50),
    tracking_number VARCHAR(100),
    shipped_date DATE,
    delivery_date DATE,
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
);

CREATE TABLE product_reviews (
    review_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    product_id INT NOT NULL,
    rating INT CHECK (rating BETWEEN 1 AND 5),
    review_text TEXT,
    review_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- Sample Data
-- Brands
INSERT INTO brands (name, description, logo_url) VALUES
('Nike', 'Athletic and casual footwear, apparel, and accessories', 'https://example.com/logos/nike.png'),
('Apple', 'Consumer electronics, software, and online services', 'https://example.com/logos/apple.png'),
('IKEA', 'Ready-to-assemble furniture, kitchen appliances, and home accessories', 'https://example.com/logos/ikea.png');

-- Product Categories
INSERT INTO product_categories (name, description, parent_category_id) VALUES
('Electronics', 'Electronic devices and accessories', NULL),
('Clothing', 'Apparel and fashion items', NULL),
('Furniture', 'Home and office furniture', NULL);

-- Add subcategories
INSERT INTO product_categories (name, description, parent_category_id) VALUES
('Smartphones', 'Mobile phones and accessories', 1),
('Laptops', 'Portable computers', 1),
('Men\'s Clothing', 'Clothing items for men', 2),
('Women\'s Clothing', 'Clothing items for women', 2),
('Living Room', 'Furniture for living rooms', 3),
('Office', 'Furniture for offices', 3);

-- Colors
INSERT INTO colors (name, color_code) VALUES
('Black', '#000000'),
('White', '#FFFFFF'),
('Red', '#FF0000'),
('Blue', '#0000FF'),
('Green', '#00FF00'),
('Gray', '#808080');

-- Size Categories
INSERT INTO size_categories (name, description) VALUES
('Clothing Sizes', 'Standard clothing sizes'),
('Shoe Sizes', 'Standard shoe sizes'),
('Screen Sizes', 'Device screen sizes in inches');

-- Size Options
INSERT INTO size_options (size_category_id, name, code, sort_order) VALUES
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

-- Attribute Categories
INSERT INTO attribute_categories (name, description) VALUES
('Physical', 'Physical attributes like weight, dimensions'),
('Technical', 'Technical specifications'),
('Material', 'Material composition information');

-- Attribute Types
INSERT INTO attribute_types (name, data_type) VALUES
('Text', 'text'),
('Number', 'number'),
('Boolean', 'boolean'),
('Date', 'date');

-- Sample Customers
INSERT INTO customers (full_name, email, phone, password_hash) VALUES
('John Wekesa', 'john@example.com', '555-123-4567', 'hgRT7#M!'),
('Jane Kamau', 'jane@example.com', '555-987-6543', 'xE9@maL');

-- Products
INSERT INTO products (name, description, base_price, brand_id, category_id, active) VALUES
('iPhone 14 Pro', 'Apple\'s flagship smartphone with advanced camera system', 999.99, 2, 4, TRUE),
('MacBook Pro', 'Powerful laptop for professionals', 1999.99, 2, 5, TRUE),
('Air Force 1', 'Iconic basketball shoes turned streetwear staple', 90.00, 1, 2, TRUE),
('POÄNG Chair', 'Bentwood armchair with cushion', 159.00, 3, 8, TRUE),
('Wireless Mouse', 'Ergonomic wireless mouse', 15.00, 2, 1, TRUE),
('USB Keyboard', 'Standard wired USB keyboard', 25.00, 2, 1, TRUE);

-- Product Variations
INSERT INTO product_variations (product_id, color_id, size_id) VALUES
(1, 1, NULL), -- iPhone 14 Pro in Black
(1, 2, NULL), -- iPhone 14 Pro in White
(2, 1, 11),   -- MacBook Pro in Black, 16-inch
(2, 2, 10),   -- MacBook Pro in White, 14-inch
(3, 1, 6),    -- Air Force 1 in Black, Size US 8
(3, 2, 6),    -- Air Force 1 in White, Size US 8
(3, 2, 7),    -- Air Force 1 in White, Size US 9
(4, 6, NULL), -- POÄNG Chair in Gray
(5, 1, NULL), -- Wireless Mouse in Black
(6, 1, NULL); -- USB Keyboard in Black

-- Product Items
INSERT INTO product_items (product_id, variation_id, sku, price, quantity_in_stock, is_available) VALUES
(1, 1, 'IPH14PRO-BLK-128', 999.99, 50, TRUE),
(1, 2, 'IPH14PRO-WHT-128', 999.99, 30, TRUE),
(2, 3, 'MBP16-BLK-512', 2499.99, 15, TRUE),
(2, 4, 'MBP14-WHT-512', 1999.99, 10, TRUE),
(3, 5, 'AF1-BLK-08', 90.00, 25, TRUE),
(3, 6, 'AF1-WHT-08', 90.00, 40, TRUE),
(3, 7, 'AF1-WHT-09', 90.00, 35, TRUE),
(4, 8, 'POANGCHR-GRY', 159.00, 20, TRUE),
(5, 9, 'WMOUSE-BLK', 15.00, 50, TRUE),
(6, 10, 'KBUSB-BLK', 25.00, 30, TRUE);

-- Product Images
INSERT INTO product_images (product_id, image_url, is_primary, display_order) VALUES
(1, 'https://example.com/images/iphone14pro_1.jpg', TRUE, 1),
(1, 'https://example.com/images/iphone14pro_2.jpg', FALSE, 2),
(2, 'https://example.com/images/macbookpro_1.jpg', TRUE, 1),
(3, 'https://example.com/images/airforce1_1.jpg', TRUE, 1),
(3, 'https://example.com/images/airforce1_2.jpg', FALSE, 2),
(4, 'https://example.com/images/poang_1.jpg', TRUE, 1);

-- Product Attributes
INSERT INTO product_attributes (product_id, attr_category_id, attr_type_id, attribute_name, attribute_value) VALUES
(1, 2, 2, 'Storage', '128 GB'),
(1, 2, 2, 'RAM', '6 GB'),
(1, 1, 2, 'Weight', '240 g'),
(2, 2, 2, 'Processor', 'Apple M2 Pro'),
(2, 2, 2, 'RAM', '16 GB'),
(3, 3, 1, 'Upper Material', 'Leather'),
(3, 3, 1, 'Sole Material', 'Rubber'),
(4, 3, 1, 'Frame Material', 'Birch veneer'),
(4, 3, 1, 'Cushion Material', 'Polyester');

-- Sample Orders
INSERT INTO orders (customer_id, order_date, order_status, total_amount) VALUES
(1, CURRENT_TIMESTAMP, 'pending', 55.00);

-- Order Items - referencing product_item_id instead of product_id
INSERT INTO order_items (order_id, product_item_id, quantity, price) VALUES
(1, 9, 2, 15.00), -- 2 Wireless Mouse
(1, 10, 1, 25.00); -- 1 USB Keyboard

-- Shipping
INSERT INTO shipping (order_id, shipping_address, shipping_method, tracking_number, shipped_date) VALUES
(1, '123 Bookstore Ave, Lagos', 'Standard Delivery', 'TRACK123456', CURRENT_DATE);

-- Product Reviews
INSERT INTO product_reviews (customer_id, product_id, rating, review_text) VALUES
(1, 5, 5, 'This wireless mouse is super smooth and works great!'),
(1, 6, 4, 'Keyboard feels good but the cable is a bit short.');

-- Sample Query - View an Order with Product Information
SELECT 
    o.order_id,
    c.full_name AS customer_name,
    p.name AS product_name,
    oi.quantity,
    oi.price,
    (oi.quantity * oi.price) AS total_price
FROM order_items oi
JOIN orders o ON oi.order_id = o.order_id
JOIN customers c ON o.customer_id = c.customer_id
JOIN product_items pi ON oi.product_item_id = pi.product_item_id
JOIN products p ON pi.product_id = p.product_id
WHERE o.order_id = 1;

-- Get Product Details with Variations

SELECT 
    p.name AS product_name,
    b.name AS brand_name,
    c.name AS color_name,
    s.name AS size_name,
    pi.sku,
    pi.price,
    pi.quantity_in_stock
FROM products p
JOIN brands b ON p.brand_id = b.brand_id
JOIN product_variations pv ON p.product_id = pv.product_id
JOIN product_items pi ON pv.variation_id = pi.variation_id
LEFT JOIN colors c ON pv.color_id = c.color_id
LEFT JOIN size_options s ON pv.size_id = s.size_id
WHERE p.product_id = 3;


--- Get Complete Order Information

SELECT 
    o.order_id,
    c.full_name AS customer_name,
    p.name AS product_name,
    pi.sku,
    oi.quantity,
    oi.price,
    (oi.quantity * oi.price) AS total_price,
    s.shipping_address,
    s.tracking_number
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
JOIN product_items pi ON oi.product_item_id = pi.product_item_id
JOIN products p ON pi.product_id = p.product_id
LEFT JOIN shipping s ON o.order_id = s.order_id
WHERE o.order_id = 1;

