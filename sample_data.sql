-- Initial Roles
INSERT INTO roles(name) VALUES('ROLE_USER');
INSERT INTO roles(name) VALUES('ROLE_SELLER');
INSERT INTO roles(name) VALUES('ROLE_ADMIN');

-- Initial Categories
INSERT INTO categories(name, description) VALUES('Electronics', 'Gadgets, devices, and more');
INSERT INTO categories(name, description) VALUES('Fashion', 'Clothing, shoes, and accessories');
INSERT INTO categories(name, description) VALUES('Home & Living', 'Furniture, decor, and kitchenware');

-- Initial Products (Assuming category IDs 1, 2, 3)
INSERT INTO products(name, description, price, stock_quantity, image_url, category_id, created_at, updated_at) 
VALUES('iPhone 15 Pro', 'The latest iPhone with titanium design.', 999.99, 50, 'https://images.unsplash.com/photo-1696446701796-da61225697cc?auto=format&fit=crop&q=80&w=800', 1, NOW(), NOW());

INSERT INTO products(name, description, price, stock_quantity, image_url, category_id, created_at, updated_at) 
VALUES('MacBook Air M3', 'Supercharged by M3 chip.', 1099.00, 30, 'https://images.unsplash.com/photo-1517336714731-489689fd1ca8?auto=format&fit=crop&q=80&w=800', 1, NOW(), NOW());

INSERT INTO products(name, description, price, stock_quantity, image_url, category_id, created_at, updated_at) 
VALUES('Leather Jacket', 'Premium quality leather jacket.', 199.50, 100, 'https://images.unsplash.com/photo-1551028719-00167b16eac5?auto=format&fit=crop&q=80&w=800', 2, NOW(), NOW());

INSERT INTO products(name, description, price, stock_quantity, image_url, category_id, created_at, updated_at) 
VALUES('Modern Sofa', 'Comfortable 3-seater sofa.', 599.00, 10, 'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?auto=format&fit=crop&q=80&w=800', 3, NOW(), NOW());
