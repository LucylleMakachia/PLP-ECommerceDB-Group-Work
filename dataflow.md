# E-commerce Database Data Flow

This document explains how data flows through our e-commerce database system.

## Core Entities and Data Flow

### Product Catalog Flow

1. **Brand Registration**
   - Brands are registered in the system with name, description, and logo URL
   - Each brand can have multiple products

2. **Category Structure**
   - Categories are organized in a hierarchical structure
   - Parent categories can have multiple child categories
   - Products are assigned to specific categories

3. **Product Creation Process**
   - Basic product information is stored in the `products` table
   - Products are linked to brands and categories
   - Products can have multiple images, with one marked as primary
   - Product attributes provide detailed specifications

4. **Variation Management**
   - Products can have multiple variations based on color and size
   - Colors are predefined in the system with name and hex code
   - Sizes are organized by categories (clothing, shoes, screens, etc.)
   - Each combination creates a unique product variation

5. **Inventory Management**
   - Each specific product variation becomes a purchasable item
   - Items have unique SKUs, prices, and stock quantities
   - Availability status is tracked for each item

### Order Processing Flow

1. **Customer Registration**
   - Customers create accounts with personal information
   - Authentication credentials are securely stored

2. **Order Creation**
   - Orders are created when customers complete checkout
   - Multiple items can be added to a single order
   - Order status tracks progress (pending, processing, shipped, delivered)

3. **Inventory Update**
   - Stock quantities are decreased when orders are placed
   - Stock can be replenished through inventory management

4. **Shipping Process**
   - Shipping information is recorded for each order
   - Tracking numbers allow order status monitoring
   - Delivery dates are recorded upon completion

5. **Review Collection**
   - After purchase, customers can leave product reviews
   - Ratings and text feedback are stored for each reviewed product

## Data Relationships

- A **customer** places many **orders**
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
- An **order** contains multiple **order items**
- **Order items** reference specific **product items**
- An **order** has one **shipping** record
- A **customer** can leave multiple **product reviews**

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

4. **Order Management**
   - Track orders by customer
   - View order history with statuses
   - Generate order details with product information

5. **Reporting**
   - Calculate sales by product category
   - Determine popular products by order volume
   - Analyze average review ratings

## Database Integrity

The database design enforces referential integrity through foreign key constraints:

- When a product is deleted, all its images, variations, items, and attributes are automatically removed
- When a brand or category is deleted, products are not deleted but their references are set to NULL
- When a color or size is deleted, product variations maintain referential integrity
- Orders maintain permanent records of purchased items, even if products change

## Future Expansion Possibilities

This database design allows for future expansion:

1. **Discount and Promotion System**
   - Add tables for discounts, coupons, and promotional pricing
   - Implement time-based sales events

2. **Wishlist and Favorites**
   - Add tables for tracking customer product interests
   - Implement product recommendation system

3. **Invoices / Payment Records**
   - Add tables for tracking customer payment details
   - Support multiple payment methods

4. **Return Management**
   - Implement product return tracking
   - Process refunds and exchanges

5. **Vendor Management**
   - Support multiple vendors/sellers
   - Track commission and revenue sharing

## Database Performance Considerations

- Indexes have been created on frequently queried columns
- Foreign keys ensure data integrity while maintaining performance
- Normalized structure prevents data redundancy
- Selective denormalization applied where query performance benefits outweigh storage costs