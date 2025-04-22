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
