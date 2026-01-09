# API Contracts

This document lists all the API endpoints available in the ShopStack Pro application.

## 🔓 Public / Auth APIs

### Authentication (`/api/auth`)
*   **POST** `/api/auth/signin`
    *   **Body**: `LoginRequest` { username, password }
    *   **Returns**: `JwtResponse`
*   **POST** `/api/auth/signup`
    *   **Body**: `SignupRequest` { username, email, password, role }
    *   **Returns**: `MessageResponse`
*   **POST** `/api/auth/forgot-password`
    *   **Body**: `ForgetPasswordRequest` { email }
    *   **Returns**: Message & Token
*   **POST** `/api/auth/reset-password`
    *   **Body**: `ResestPasswordRequest` { token, newPassword }
    *   **Returns**: Message

### Public Products (`/api/public/products`)
*   **GET** `/api/public/products`
    *   **Params**: `name`, `categoryId`, `minPrice`, `maxPrice`, `inStock`, `page`, `size`
    *   **Returns**: `Page<ProductDTO>`
*   **GET** `/api/public/products/{id}`
    *   **Returns**: `ProductDTO`
*   **GET** `/api/public/products/search`
    *   **Params**: `name`, `page`, `size`
    *   **Returns**: `Page<ProductDTO>`
*   **GET** `/api/public/products/category/{categoryId}`
    *   **Params**: `page`, `size`
    *   **Returns**: `Page<ProductDTO>`

### Public Categories (`/api/public/categories`)
*   **GET** `/api/public/categories`
    *   **Returns**: `List<CategoryDTO>`

### Public Reviews (`/api/public/reviews`)
*   **GET** `/api/public/reviews/product/{productId}`
    *   **Returns**: `List<ReviewDTO>`

### Public Analytics (`/api/public/analytics`)
*   **GET** `/api/public/analytics/stats`
    *   **Returns**: `AnalyticsDTO`

---

## 🛡️ Admin APIs (Role: ADMIN)

### Admin Analytics (`/api/admin/analytics`)
*   **GET** `/api/admin/analytics/dashboard`
    *   **Returns**: `AnalyticsDTO`

### Admin Categories (`/api/admin/categories`)
*   **POST** `/api/admin/categories`
    *   **Body**: `CategoryDTO`
    *   **Returns**: `CategoryDTO`
*   **PUT** `/api/admin/categories/{id}`
    *   **Body**: `CategoryDTO`
    *   **Returns**: `CategoryDTO`
*   **DELETE** `/api/admin/categories/{id}`
    *   **Returns**: Void

### Admin Orders (`/api/admin/orders`)
*   **GET** `/api/admin/orders`
    *   **Returns**: `List<OrderDTO>`
*   **PUT** `/api/admin/orders/{id}/status`
    *   **Params**: `status` (OrderStatus)
    *   **Returns**: `OrderDTO`

### Admin Products (`/api/admin/products`)
*   **GET** `/api/admin/products`
    *   **Params**: `name`, `categoryId`, `minPrice`, `maxPrice`, `inStock`, `sellerId`, `page`, `size`
    *   **Returns**: `Page<ProductDTO>`
*   **POST** `/api/admin/products`
    *   **Body**: `MultipartFile image`, `String product` (JSON)
    *   **Returns**: `ProductDTO`
*   **PUT** `/api/admin/products/{id}`
    *   **Body**: `MultipartFile image` (optional), `String product` (JSON)
    *   **Returns**: `ProductDTO`
*   **DELETE** `/api/admin/products/{id}`
    *   **Returns**: Void

### Admin Users (`/api/admin/users`)
*   **GET** `/api/admin/users`
    *   **Returns**: `List<UserDTO>`
*   **PUT** `/api/admin/users/{id}/ban`
    *   **Returns**: Void
*   **PUT** `/api/admin/users/{id}/unban`
    *   **Returns**: Void

---

## 💼 Seller APIs (Role: SELLER)

### Seller Orders (`/api/seller/orders`)
*   **GET** `/api/seller/orders`
    *   **Returns**: `List<OrderDTO>` (Orders containing seller's products)
*   **GET** `/api/seller/orders/{id}`
    *   **Returns**: `OrderDTO`

### Seller Products (`/api/seller/products`)
*   **GET** `/api/seller/products`
    *   **Returns**: `List<ProductDTO>` (Only seller's products)
*   **POST** `/api/seller/products`
    *   **Body**: `MultipartFile image`, `String product` (JSON)
    *   **Returns**: `ProductDTO`
*   **PUT** `/api/seller/products/{id}`
    *   **Body**: `MultipartFile image` (optional), `String product` (JSON)
    *   **Returns**: `ProductDTO`
*   **DELETE** `/api/seller/products/{id}`
    *   **Returns**: Void

---

## 👤 User APIs (Role: USER)

### User Cart (`/api/user/cart`)
*   **GET** `/api/user/cart`
    *   **Returns**: `CartDTO`
*   **POST** `/api/user/cart/add`
    *   **Params**: `productId`, `quantity`
    *   **Returns**: `CartDTO`
*   **PUT** `/api/user/cart/update`
    *   **Params**: `productId`, `quantity`
    *   **Returns**: `CartDTO`
*   **DELETE** `/api/user/cart/remove/{productId}`
    *   **Returns**: `CartDTO`
*   **DELETE** `/api/user/cart/clear`
    *   **Returns**: Void

### User Orders (`/api/user/orders`)
*   **POST** `/api/user/orders`
    *   **Params**: `shippingAddress`
    *   **Returns**: `OrderDTO`
*   **GET** `/api/user/orders`
    *   **Returns**: `List<OrderDTO>`
*   **GET** `/api/user/orders/{id}`
    *   **Returns**: `OrderDTO`
*   **GET** `/api/user/orders/{id}/invoice`
    *   **Returns**: PDF File
*   **PUT** `/api/user/orders/{id}/confirm-payment`
    *   **Returns**: `OrderDTO`

### User Payments (`/api/user/payments`)
*   **POST** `/api/user/payments/create-intent`
    *   **Body**: `PaymentRequest`
    *   **Returns**: `PaymentResponse`

### User Profile (`/api/user/profile`)
*   **GET** `/api/user/profile`
    *   **Returns**: `UserDTO`
*   **PUT** `/api/user/profile` (Multipart)
    *   **Body**: `MultipartFile image` (optional), `String user` (JSON)
    *   **Returns**: `UserDTO`
*   **PUT** `/api/user/profile` (JSON)
    *   **Body**: `UserUpdateRequest`
    *   **Returns**: `UserDTO`

### User Reviews (`/api/user/reviews`)
*   **POST** `/api/user/reviews/{productId}`
    *   **Body**: `ReviewDTO`
    *   **Returns**: `ReviewDTO`
*   **DELETE** `/api/user/reviews/{reviewId}`
    *   **Returns**: Void

### User Wishlist (`/api/user/wishlist`)
*   **GET** `/api/user/wishlist`
    *   **Returns**: `List<ProductDTO>`
*   **POST** `/api/user/wishlist/add/{productId}`
    *   **Returns**: Void
*   **DELETE** `/api/user/wishlist/remove/{productId}`
    *   **Returns**: Void
*   **GET** `/api/user/wishlist/check/{productId}`
    *   **Returns**: `Boolean`
