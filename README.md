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

| Table Name           | Purpose                                                                 |
|----------------------|-------------------------------------------------------------------------|
| `brand`              | Stores brand information including name, description, and logo URL      |
| `product_category`   | Classifies products with hierarchical parent-child relationships        |
| `product`            | Stores general product details with active/inactive status              |
| `product_variation`  | Represents specific color/size variants of a product                    |
| `color`              | Contains color options with names and color codes                       |
| `size_category`      | Groups sizing types (e.g., shoes, clothes, screen sizes)               |
| `size_option`        | Stores specific sizes with sort order for consistent display            |
| `product_item`       | Purchasable items with SKU, stock quantity, and availability            |
| `product_image`      | Stores image URLs with primary flag and display order                   |
| `product_attribute`  | Stores product specifications and details                               |
| `attribute_category` | Categorizes attributes (e.g., physical, technical, material)            |
| `attribute_type`     | Defines attribute data types (text, number, boolean, date)              |

---

## 🧠 Entity-Relationship Diagram (ERD)

📍 Click below to view the full ERD of the database:
![E-commerce ERD](diagrams/ecommerce-erd.png)

> Or view the live ERD on [dbdiagram.io](https://dbdiagram.io) *(link here if hosted)*

---

## 📂 Repository Contents

- **ecommerce.sql** - Complete SQL schema with table creation statements and sample data
- **dataflow.md** - Detailed explanation of data relationships and access patterns
- **README.md** - This overview document

## Data Flow Summary

Our database design supports a complete product catalog system with:
- Hierarchical product categorization
- Multiple product variations (color/size)
- Detailed product attributes and specifications
- Inventory tracking with SKUs and stock quantities

For detailed information about data relationships and common access patterns, please see the [dataflow.md](dataflow.md) document.

---

## 💾 How to Use

1. Clone this repo:
   ```bash
   git clone https://github.com/LucylleMakachia/PLP-ECommerceDB-Group-Work.git 
   cd PLP-ECommerceDB-Group-Work
   ```

2. Import the database schema:
   ```bash
   mysql -u username -p < ecommerce.sql
   ```

3. Explore the schema and sample data:
   ```sql
   USE ecommerceDB;
   SHOW TABLES;
   SELECT * FROM product;
   ```

## Key Features

- **Product Variations**: Support for different colors and sizes
- **Hierarchical Categories**: Multi-level product categorization
- **Flexible Attributes**: Custom product specifications using various data types
- **Image Management**: Multiple product images with primary designation
- **Inventory Tracking**: Stock quantity and availability status

---

## 👥 Authors

1. Lucylle Makachia
2. Ikechukwu Agoha
3. Charmaine Mashaa
4. Nombuso Simelane