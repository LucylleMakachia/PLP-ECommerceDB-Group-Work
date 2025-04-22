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
| `brand`              | Stores brand information                                                |
| `product_category`   | Classifies products (e.g., Electronics, Clothing)                       |
| `product`            | Stores general product details                                          |
| `product_variation`  | Represents specific color/size variants of a product                    |
| `color`              | Contains color options                                                  |
| `size_category`      | Groups sizing types (e.g., shoes, clothes)                              |
| `size_option`        | Stores specific sizes like S, M, L, 42                                  |
| `product_item`       | Purchasable item with SKU, stock, and price                             |
| `product_image`      | Stores image URLs linked to product items                               |
| `product_attribute`  | Stores custom attributes like weight, material                          |
| `attribute_category` | Categorizes attributes (e.g., physical, technical)                      |
| `attribute_type`     | Defines attribute data types (text, number, boolean)                    |

---

## 🧠 Entity-Relationship Diagram (ERD)

📍 Click below to view the full ERD of the database:

![E-commerce ERD](diagrams/ecommerce-erd.png)

> Or view the live ERD on [dbdiagram.io](https://dbdiagram.io) *(link here if hosted)*

---

## 💾 How to Use

1. Clone this repo:
   ```bash
   git clone https://github.com/LucylleMakachia/PLP-ECommerceDB-Group-Work.git 
   cd ecommerce-database
