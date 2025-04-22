# E-commerce Database Data Flow

This document explains how data flows through our e-commerce database system.

## Core Entities and Data Flow

### Product Catalog Flow

1. **Brand Registration**
   - Brands are registered in the system with basic information
   - Each brand can have multiple products

2. **Category Structure**
   - Categories are organized in a hierarchical structure
   - Parent categories can have multiple child categories
   - Products are assigned to specific categories

3. **Product Creation Process**
   - Basic product information is stored in the `product` table
   - Products are linked to brands and categories
   - Products can have multiple images, with one marked as primary
   - Product attributes provide detailed specifications

4. **Variation Management**
   - Products can have multiple variations based on color and size
   - Colors are predefined in the system
   - Sizes are organized by categories (clothing, shoes, screens, etc.)
   - Each combination creates a unique product variation

5. **Inventory Management**
   - Each specific product variation becomes a purchasable item
   - Items have unique SKUs, prices, and stock quantities
   - Availability status is tracked for each item

## Data Relationships

- A **brand** has many **products**
- A **product category** contains many **products** and can have **subcategories**
- A **product** has:
  - Multiple **images**
  - Multiple **variations** (color/size combinations)
  - Multiple **attributes** (specifications)
  - Multiple purchasable **items**
- **Product variations** combine **colors** and **sizes**
- **Size options** belong to **size categories**
- **Product attributes** are grouped by **attribute categories** and defined by **attribute types**

## Data Access Patterns

### Common Queries

1. **Product Browsing**
   - List products by category
   - Filter products by brand, color, size, price range
   - Search products by name or description

2. **Product Detail View**
   - Fetch product with all images
   - Load all available variations (colors/sizes)
   - Show specific attributes and specifications
   - Display available items with prices and stock status

3. **Inventory Management**
   - Update stock quantities
   - Check availability
   - Adjust prices for specific variations

## Database Integrity

The database design enforces referential integrity through foreign key constraints:

- When a product is deleted, all its images, variations, items, and attributes are automatically removed
- When a brand or category is deleted, products are not deleted but their references are set to NULL
- When a color or size is deleted, product variations maintain referential integrity

## Future Expansion Possibilities

This database design allows for future expansion:

1. **Customer and Order Management**
   - Add tables for customers, orders, order items
   - Link order items to product items

2. **Review System**
   - Add tables for product reviews and ratings

3. **Discount and Promotion System**
   - Add tables for discounts, coupons, and promotional pricing