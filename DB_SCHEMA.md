# Database Schema Visualization

This document visualizes the database schema for the ShopStack Pro application using Mermaid.js.

```mermaid
erDiagram
    USERS ||--o{ ROLES : "has"
    USERS ||--o{ PRODUCTS : "sells (as seller)"
    USERS ||--o{ ORDERS : "places"
    USERS ||--o{ REVIEWS : "writes"
    USERS ||--|| CARTS : "has"
    USERS ||--|| WISHLISTS : "has"

    CATEGORIES ||--o{ PRODUCTS : "contains"

    PRODUCTS ||--o{ PRODUCT_VARIANTS : "has"
    PRODUCTS ||--o{ ORDER_ITEMS : "included in"
    PRODUCTS ||--o{ CART_ITEMS : "included in"
    PRODUCTS ||--o{ REVIEWS : "has"
    PRODUCTS ||--o{ WISHLIST_PRODUCTS : "in"

    ORDERS ||--o{ ORDER_ITEMS : "contains"
    ORDERS ||--|| PAYMENTS : "has"

    CARTS ||--o{ CART_ITEMS : "contains"

    WISHLISTS ||--o{ WISHLIST_PRODUCTS : "contains"

    USERS {
        UUID id PK
        String username
        String email UK
        String password
        Boolean isActive
        String profileImageUrl
        LocalDateTime createdAt
        LocalDateTime updatedAt
    }

    ROLES {
        UUID id PK
        String name
    }

    CATEGORIES {
        UUID id PK
        String name UK
        String description
    }

    PRODUCTS {
        UUID id PK
        String name
        String description
        Double price
        Integer stockQuantity
        String imageUrl
        UUID category_id FK
        UUID seller_id FK
        LocalDateTime createdAt
        LocalDateTime updatedAt
    }

    PRODUCT_VARIANTS {
        UUID id PK
        UUID product_id FK
        String name
        String value
        Double price
        Integer stockQuantity
        String sku UK
    }

    ORDERS {
        UUID id PK
        UUID user_id FK
        Double totalAmount
        String status
        String shippingAddress
        LocalDateTime orderDate
    }

    ORDER_ITEMS {
        UUID id PK
        UUID order_id FK
        UUID product_id FK
        Integer quantity
        Double price
    }

    CARTS {
        UUID id PK
        UUID user_id FK
        Double totalPrice
    }

    CART_ITEMS {
        UUID id PK
        UUID cart_id FK
        UUID product_id FK
        Integer quantity
        Double price
    }

    REVIEWS {
        UUID id PK
        String comment
        Integer rating
        UUID user_id FK
        UUID product_id FK
        LocalDateTime createdAt
    }

    PAYMENTS {
        UUID id PK
        UUID order_id FK
        String paymentMethod
        String transactionId
        Double amount
        String status
        LocalDateTime paymentDate
    }

    WISHLISTS {
        UUID id PK
        UUID user_id FK
    }
```

## Entity Details

### User
*   **id**: UUID (Primary Key)
*   **username**: String (Max 20)
*   **email**: String (Max 50, Unique)
*   **password**: String (Max 120)
*   **isActive**: Boolean
*   **profileImageUrl**: String
*   **roles**: Many-to-Many relationship with Role

### Role
*   **id**: UUID (Primary Key)
*   **name**: Enum (ROLE_USER, ROLE_SELLER, ROLE_ADMIN)

### Product
*   **id**: UUID (Primary Key)
*   **name**: String
*   **description**: String (Max 1000)
*   **price**: Double
*   **stockQuantity**: Integer
*   **imageUrl**: String (Max 500)
*   **category**: Many-to-One relationship with Category
*   **seller**: Many-to-One relationship with User
*   **variants**: One-to-Many relationship with ProductVariant

### Category
*   **id**: UUID (Primary Key)
*   **name**: String (Unique)
*   **description**: String

### Order
*   **id**: UUID (Primary Key)
*   **user**: Many-to-One relationship with User
*   **items**: One-to-Many relationship with OrderItem
*   **totalAmount**: Double
*   **status**: Enum (PENDING, PAID, SHIPPED, DELIVERED, CANCELLED)
*   **shippingAddress**: String
*   **orderDate**: LocalDateTime

### Cart
*   **id**: UUID (Primary Key)
*   **user**: One-to-One relationship with User
*   **items**: One-to-Many relationship with CartItem
*   **totalPrice**: Double

### Review
*   **id**: UUID (Primary Key)
*   **comment**: String
*   **rating**: Integer (1-5)
*   **user**: Many-to-One relationship with User
*   **product**: Many-to-One relationship with Product

### Payment
*   **id**: UUID (Primary Key)
*   **order**: One-to-One relationship with Order
*   **paymentMethod**: String
*   **transactionId**: String
*   **amount**: Double
*   **status**: String

### Wishlist
*   **id**: UUID (Primary Key)
*   **user**: One-to-One relationship with User
*   **products**: Many-to-Many relationship with Product

## 🔗 Relationships

### User Relationships
*   **User ↔ Role (Many-to-Many)**: A user can have multiple roles (e.g., User and Seller), and a role can be assigned to multiple users. Managed via `user_roles` join table.
*   **User ↔ Cart (One-to-One)**: Each user has exactly one active shopping cart.
*   **User ↔ Wishlist (One-to-One)**: Each user has exactly one wishlist.
*   **User ↔ Order (One-to-Many)**: A user can place multiple orders over time.
*   **User ↔ Product (One-to-Many)**: A user (specifically a Seller) can list multiple products.
*   **User ↔ Review (One-to-Many)**: A user can write reviews for multiple products.

### Product Relationships
*   **Product ↔ Category (Many-to-One)**: A product belongs to a single category.
*   **Product ↔ User (Many-to-One)**: A product is sold by a specific seller (User).
*   **Product ↔ ProductVariant (One-to-Many)**: A product can have multiple variants (e.g., different sizes or colors).
*   **Product ↔ Review (One-to-Many)**: A product can have multiple customer reviews.
*   **Product ↔ OrderItem (One-to-Many)**: A product can be included in many different orders.
*   **Product ↔ CartItem (One-to-Many)**: A product can be in many users' carts.
*   **Product ↔ Wishlist (Many-to-Many)**: A product can be in multiple users' wishlists.

### Order Relationships
*   **Order ↔ User (Many-to-One)**: An order belongs to the user who placed it.
*   **Order ↔ OrderItem (One-to-Many)**: An order consists of multiple line items (specific products and quantities).
*   **Order ↔ Payment (One-to-One)**: An order has one associated payment transaction.

### Cart Relationships
*   **Cart ↔ User (One-to-One)**: A cart belongs to a specific user.
*   **Cart ↔ CartItem (One-to-Many)**: A cart contains multiple items.

### Review Relationships
*   **Review ↔ User (Many-to-One)**: A review is written by a specific user.
*   **Review ↔ Product (Many-to-One)**: A review is for a specific product.
