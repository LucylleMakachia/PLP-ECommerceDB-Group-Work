# 🛍️ E-commerce Database Design – Peer Group Assignment

Welcome to our **E-commerce Database Project**! This repository contains the Entity-Relationship Diagram (ERD) and SQL schema used to design a relational database for an online shopping platform.

## 🎯 Objective
Our goal is to master the art of database design by:
- Creating a robust **ERD** for an e-commerce system
- Defining entities, relationships, keys, and constraints
- Implementing a normalized SQL schema
- Planning data flow and collaboration effectively as a team



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



## 🧠 Entity-Relationship Diagram (ERD)

📍 Click below to view the full ERD of the database:

![E-commerce ERD](diagrams/ecommerce-erd.png)

> Note: Our normalized database design follows industry best practices to minimize redundancy while maintaining data integrity.


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



## 📊 Key Features

- **Product Variation System**: Flexible model for handling products with multiple variations
- **Hierarchical Categories**: Support for parent-child relationships in product categories
- **Customizable Attributes**: Dynamic attribute system for diverse product types
- **Order Management**: Complete tracking from order creation through fulfillment
- **Review System**: Customer feedback and ratings for products


## 👥 Authors
- Lucylle Makachia
- Ikechukwu Agoha
- Charmaine Mashaa
- Nombuso Simelane
