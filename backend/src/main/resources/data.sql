INSERT INTO roles (id, name)
SELECT '00000000-0000-0000-0000-000000000001', 'ROLE_USER'
WHERE NOT EXISTS (SELECT 1 FROM roles WHERE name = 'ROLE_USER');

INSERT INTO roles (id, name)
SELECT '00000000-0000-0000-0000-000000000002', 'ROLE_SELLER'
WHERE NOT EXISTS (SELECT 1 FROM roles WHERE name = 'ROLE_SELLER');

INSERT INTO roles (id, name)
SELECT '00000000-0000-0000-0000-000000000003', 'ROLE_ADMIN'
WHERE NOT EXISTS (SELECT 1 FROM roles WHERE name = 'ROLE_ADMIN');

INSERT INTO categories (id, name, description)
SELECT '10000000-0000-0000-0000-000000000001', 'Electronics', 'Gadgets, devices, and more'
WHERE NOT EXISTS (SELECT 1 FROM categories WHERE name = 'Electronics');

INSERT INTO categories (id, name, description)
SELECT '10000000-0000-0000-0000-000000000002', 'Fashion', 'Clothing, shoes, and accessories'
WHERE NOT EXISTS (SELECT 1 FROM categories WHERE name = 'Fashion');

INSERT INTO categories (id, name, description)
SELECT '10000000-0000-0000-0000-000000000003', 'Home & Living', 'Furniture, decor, and kitchenware'
WHERE NOT EXISTS (SELECT 1 FROM categories WHERE name = 'Home & Living');

INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, created_at, updated_at)
SELECT
    '20000000-0000-0000-0000-000000000001',
    'iPhone 15 Pro',
    'The latest iPhone with titanium design.',
    999.99,
    50,
    'https://images.unsplash.com/photo-1696446701796-da61225697cc?auto=format&fit=crop&q=80&w=800',
    '10000000-0000-0000-0000-000000000001',
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE name = 'iPhone 15 Pro');

INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, created_at, updated_at)
SELECT
    '20000000-0000-0000-0000-000000000002',
    'MacBook Air M3',
    'Supercharged by M3 chip.',
    1099.00,
    30,
    'https://images.unsplash.com/photo-1517336714731-489689fd1ca8?auto=format&fit=crop&q=80&w=800',
    '10000000-0000-0000-0000-000000000001',
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE name = 'MacBook Air M3');

INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, created_at, updated_at)
SELECT
    '20000000-0000-0000-0000-000000000003',
    'Leather Jacket',
    'Premium quality leather jacket.',
    199.50,
    100,
    'https://images.unsplash.com/photo-1551028719-00167b16eac5?auto=format&fit=crop&q=80&w=800',
    '10000000-0000-0000-0000-000000000002',
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE name = 'Leather Jacket');

INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, created_at, updated_at)
SELECT
    '20000000-0000-0000-0000-000000000004',
    'Modern Sofa',
    'Comfortable 3-seater sofa.',
    599.00,
    10,
    'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?auto=format&fit=crop&q=80&w=800',
    '10000000-0000-0000-0000-000000000003',
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE name = 'Modern Sofa');
