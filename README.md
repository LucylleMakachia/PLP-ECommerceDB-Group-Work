# 🛍️ E-commerce Database Design – Peer Group Assignment

Welcome to our **E-commerce Database Project**! This repository contains the Entity-Relationship Diagram (ERD) and SQL schema used to design a relational database for an online shopping platform.

## 🎯 Objective
Our goal is to master the art of database design by:
- Creating a robust **ERD** for an e-commerce system
- Defining entities, relationships, keys, and constraints
- Implementing a normalized SQL schema
- Planning data flow and collaboration effectively as a team

---

## 🗃️ Database Overview

Our database consists of the following major components:

| Table Name             | Purpose                                                          |
|------------------------|------------------------------------------------------------------|
| `customers`            | Stores customer account information                              |
| `brands`               | Stores brand information                                         |
| `product_categories`   | Classifies products with hierarchical relationships              |
| `products`             | Stores general product details                                   |
| `colors`               | Contains color options with hex codes                            |
| `size_categories`      | Groups sizing types (e.g., clothing, shoes, screens)             |
| `size_options`         | Stores specific sizes with standardized codes                    |
| `product_variations`   | Connects products with specific color/size combinations          |
| `product_items`        | Purchasable items with SKU, stock, and price                     |
| `product_images`       | Stores image URLs linked to products                             |
| `attribute_categories` | Categorizes attributes (e.g., physical, technical)               |
| `attribute_types`      | Defines attribute data types (text, number, boolean, date)       |
| `product_attributes`   | Stores custom product specifications                             |
| `orders`               | Tracks customer orders and status                                |
| `order_items`          | Links orders to specific product items                           |
| `shipping`             | Manages shipping details for orders                              |
| `product_reviews`      | Stores customer reviews and ratings                              |

---

## 🧠 Entity-Relationship Diagram (ERD)

📍 Click below to view the full ERD of the database:

![E-commerce ERD](diagrams/ecommerce.drawio)

> Note: Our normalized database design follows industry best practices to minimize redundancy while maintaining data integrity.

---

## 💾 How to Use

1. Clone this repository:
   ```bash
   git clone https://github.com/LucylleMakachia/PLP-ECommerceDB-Group-Work.git 
   cd PLP-ECommerceDB-Group-Work
   ```

2. Import the SQL schema into your database management system:
   ```bash
   mysql -u username -p < schema.sql
   ```

3. Load sample data (optional):
   ```bash
   mysql -u username -p < sample_data.sql
   ```

4. Start exploring the database structure and relationships!

---

## 📊 Key Features

- **Product Variation System**: Flexible model for handling products with multiple variations
- **Hierarchical Categories**: Support for parent-child relationships in product categories
- **Customizable Attributes**: Dynamic attribute system for diverse product types
- **Order Management**: Complete tracking from order creation through fulfillment
- **Review System**: Customer feedback and ratings for products

---

## 🔍 Sample Queries

### Get Product Details with Variations
```sql
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
```

### Get Complete Order Information
```sql
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
```

---

## 👥 Authors
- Lucylle Makachia
- Ikechukwu Agoha
- Charmaine Mashaa
- Nombuso Simelane

---

