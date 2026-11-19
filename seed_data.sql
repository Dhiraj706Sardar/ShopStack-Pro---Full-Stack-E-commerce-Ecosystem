-- ===========================================================================
-- SHOPSTACK PRO: ENTERPRISE DATA SEED SCRIPT (1,000+ PRODUCTS + ROLES & USERS)
-- Generated with realistic accounts for Admin, Merchant, Customer
-- ===========================================================================

-- 1. ROLES
INSERT INTO roles (id, name) SELECT '00000000-0000-0000-0000-000000000001', 'ROLE_USER' WHERE NOT EXISTS (SELECT 1 FROM roles WHERE name = 'ROLE_USER');
INSERT INTO roles (id, name) SELECT '00000000-0000-0000-0000-000000000002', 'ROLE_SELLER' WHERE NOT EXISTS (SELECT 1 FROM roles WHERE name = 'ROLE_SELLER');
INSERT INTO roles (id, name) SELECT '00000000-0000-0000-0000-000000000003', 'ROLE_ADMIN' WHERE NOT EXISTS (SELECT 1 FROM roles WHERE name = 'ROLE_ADMIN');

-- 2. USERS (admin@gmail.com, merchant@gmail.com, user@gmail.com)
INSERT INTO users (id, username, email, password, is_active, profile_image_url, created_at, updated_at)
SELECT '00000000-0000-0000-0000-000000000010', 'admin', 'admin@gmail.com', '$2a$10$7Qa7vw7iOeelmMUDBWeRQ./r2TcV6W3Y/e0Cc1BTGKstWztW.UYkq', true, 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&q=80&w=200', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM users WHERE email = 'admin@gmail.com');
INSERT INTO users (id, username, email, password, is_active, profile_image_url, created_at, updated_at)
SELECT '00000000-0000-0000-0000-000000000020', 'merchant', 'merchant@gmail.com', '$2a$10$unXhzQheuAChbfGttvzQve9/E3AbeMMJCm4ZTgLzjqsQ9mFZF/DgK', true, 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&q=80&w=200', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM users WHERE email = 'merchant@gmail.com');
INSERT INTO users (id, username, email, password, is_active, profile_image_url, created_at, updated_at)
SELECT '00000000-0000-0000-0000-000000000030', 'user', 'user@gmail.com', '$2a$10$VBRLLpwug8c8twSEKpdHfe4aQFVVgeeQjIIYofjaoz2gd9Cjj5Rw6', true, 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?auto=format&fit=crop&q=80&w=200', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM users WHERE email = 'user@gmail.com');
UPDATE users SET password = '$2a$10$7Qa7vw7iOeelmMUDBWeRQ./r2TcV6W3Y/e0Cc1BTGKstWztW.UYkq', is_active = true WHERE email = 'admin@gmail.com';
UPDATE users SET password = '$2a$10$unXhzQheuAChbfGttvzQve9/E3AbeMMJCm4ZTgLzjqsQ9mFZF/DgK', is_active = true WHERE email = 'merchant@gmail.com';
UPDATE users SET password = '$2a$10$VBRLLpwug8c8twSEKpdHfe4aQFVVgeeQjIIYofjaoz2gd9Cjj5Rw6', is_active = true WHERE email = 'user@gmail.com';

-- 3. USER_ROLES (Dynamically linked to prevent foreign key issues)
INSERT INTO user_roles (user_id, role_id)
SELECT u.id, r.id FROM users u CROSS JOIN roles r
WHERE u.email = 'admin@gmail.com' AND r.name IN ('ROLE_ADMIN', 'ROLE_USER')
AND NOT EXISTS (SELECT 1 FROM user_roles ur WHERE ur.user_id = u.id AND ur.role_id = r.id);

INSERT INTO user_roles (user_id, role_id)
SELECT u.id, r.id FROM users u CROSS JOIN roles r
WHERE u.email = 'merchant@gmail.com' AND r.name IN ('ROLE_SELLER', 'ROLE_USER')
AND NOT EXISTS (SELECT 1 FROM user_roles ur WHERE ur.user_id = u.id AND ur.role_id = r.id);

INSERT INTO user_roles (user_id, role_id)
SELECT u.id, r.id FROM users u CROSS JOIN roles r
WHERE u.email = 'user@gmail.com' AND r.name = 'ROLE_USER'
AND NOT EXISTS (SELECT 1 FROM user_roles ur WHERE ur.user_id = u.id AND ur.role_id = r.id);

-- 4. CATEGORIES
INSERT INTO categories (id, name, description)
SELECT '10000000-0000-0000-0000-000000000001', 'Electronics', 'Smartphones, laptops, audio, wearables, and cutting-edge tech gadgets'
WHERE NOT EXISTS (SELECT 1 FROM categories WHERE name = 'Electronics');
INSERT INTO categories (id, name, description)
SELECT '10000000-0000-0000-0000-000000000002', 'Fashion', 'Premium apparel, designer shoes, luxury bags, and fashion accessories'
WHERE NOT EXISTS (SELECT 1 FROM categories WHERE name = 'Fashion');
INSERT INTO categories (id, name, description)
SELECT '10000000-0000-0000-0000-000000000003', 'Home & Living', 'Contemporary furniture, kitchen appliances, cookware, and modern home decor'
WHERE NOT EXISTS (SELECT 1 FROM categories WHERE name = 'Home & Living');
INSERT INTO categories (id, name, description)
SELECT '10000000-0000-0000-0000-000000000004', 'Beauty & Personal Care', 'Skincare essentials, luxury fragrances, haircare, and wellness products'
WHERE NOT EXISTS (SELECT 1 FROM categories WHERE name = 'Beauty & Personal Care');
INSERT INTO categories (id, name, description)
SELECT '10000000-0000-0000-0000-000000000005', 'Sports & Outdoors', 'Fitness equipment, athletic gear, outdoor recreation, and sports accessories'
WHERE NOT EXISTS (SELECT 1 FROM categories WHERE name = 'Sports & Outdoors');
INSERT INTO categories (id, name, description)
SELECT '10000000-0000-0000-0000-000000000006', 'Books & Stationery', 'Bestsellers, technical manuals, productivity journals, and executive stationery'
WHERE NOT EXISTS (SELECT 1 FROM categories WHERE name = 'Books & Stationery');
INSERT INTO categories (id, name, description)
SELECT '10000000-0000-0000-0000-000000000007', 'Toys & Gaming', 'Gaming accessories, consoles, collectibles, and interactive toys'
WHERE NOT EXISTS (SELECT 1 FROM categories WHERE name = 'Toys & Gaming');
INSERT INTO categories (id, name, description)
SELECT '10000000-0000-0000-0000-000000000008', 'Health & Wellness', 'Organic supplements, posture correctors, massage equipment, and monitoring tools'
WHERE NOT EXISTS (SELECT 1 FROM categories WHERE name = 'Health & Wellness');

-- 5. PRODUCTS (1,040 Realistically Categorized Items)
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000001', 'Apple Wireless Headphones - Edition 01', 'Engineered by Apple. The Wireless Headphones comes equipped with Active Noise Cancellation. Designed for superior performance, premium durability, and daily reliability.', 29.99, 15, 'https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Electronics' LIMIT 1), '10000000-0000-0000-0000-000000000001'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000001');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000002', 'Sony Pro Smartphone - Edition 02', 'Engineered by Sony. The Pro Smartphone comes equipped M3 Max 32GB RAM Edition. Designed for superior performance, premium durability, and daily reliability.', 44.4, 28, 'https://images.unsplash.com/photo-1546868871-7041f2a55e12?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Electronics' LIMIT 1), '10000000-0000-0000-0000-000000000001'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000002');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000003', 'Samsung Ultra Laptop - Edition 03', 'Engineered by Samsung. The Ultra Laptop comes equipped 120Hz Fluid AMOLED Display. Designed for superior performance, premium durability, and daily reliability.', 58.81, 41, 'https://images.unsplash.com/photo-1600080972464-8e5f35f63d08?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Electronics' LIMIT 1), '10000000-0000-0000-0000-000000000001'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000003');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000004', 'Dell OLED Gaming Monitor - Edition 04', 'Engineered by Dell. The OLED Gaming Monitor comes equipped Spatial Audio & 40hr Battery. Designed for superior performance, premium durability, and daily reliability.', 73.21, 54, 'https://images.unsplash.com/photo-1593642632823-8f785ba67e45?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Electronics' LIMIT 1), '10000000-0000-0000-0000-000000000001'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000004');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000005', 'Logitech Smartwatch Series - Edition 05', 'Engineered by Logitech. The Smartwatch Series comes equipped MagSafe Compatible. Designed for superior performance, premium durability, and daily reliability.', 87.62, 67, 'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Electronics' LIMIT 1), '10000000-0000-0000-0000-000000000001'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000005');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000006', 'Bose Bluetooth Speaker - Edition 06', 'Engineered by Bose. The Bluetooth Speaker comes equipped RGB Backlit Wireless. Designed for superior performance, premium durability, and daily reliability.', 102.03, 80, 'https://images.unsplash.com/photo-1583394838336-acd977736f90?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Electronics' LIMIT 1), '10000000-0000-0000-0000-000000000001'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000006');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000007', 'Asus Mechanical Keyboard - Edition 07', 'Engineered by Asus. The Mechanical Keyboard comes equipped Titanium Frame Edition. Designed for superior performance, premium durability, and daily reliability.', 116.44, 93, 'https://images.unsplash.com/photo-1608156639585-b3a032ef9689?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Electronics' LIMIT 1), '10000000-0000-0000-0000-000000000001'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000007');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000008', 'Anker 4K Webcam - Edition 08', 'Engineered by Anker. The 4K Webcam comes equipped Ultra-low Latency. Designed for superior performance, premium durability, and daily reliability.', 109.14, 21, 'https://images.unsplash.com/photo-1517336714731-489689fd1ca8?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Electronics' LIMIT 1), '10000000-0000-0000-0000-000000000001'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000008');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000009', 'Lenovo ANC Earbuds - Edition 09', 'Engineered by Lenovo. The ANC Earbuds comes equipped Thunderbolt 4 Enabled. Designed for superior performance, premium durability, and daily reliability.', 123.55, 34, 'https://images.unsplash.com/photo-1523275335684-37898b6baf30?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Electronics' LIMIT 1), '10000000-0000-0000-0000-000000000001'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000009');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000010', 'LG Fast Charger Dock - Edition 10', 'Engineered by LG. The Fast Charger Dock comes equipped Waterproof IPX8 Rating. Designed for superior performance, premium durability, and daily reliability.', 137.96, 47, 'https://images.unsplash.com/photo-1579586337278-3befd40fd17a?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Electronics' LIMIT 1), '10000000-0000-0000-0000-000000000001'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000010');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000011', 'Sennheiser Mirrorless Camera - Edition 11', 'Engineered by Sennheiser. The Mirrorless Camera comes equipped Custom EQ Acoustic Tuning. Designed for superior performance, premium durability, and daily reliability.', 152.37, 60, 'https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Electronics' LIMIT 1), '10000000-0000-0000-0000-000000000001'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000011');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000012', 'Google Drone Flycam - Edition 12', 'Engineered by Google. The Drone Flycam comes equipped High-Res Audio Certified. Designed for superior performance, premium durability, and daily reliability.', 166.77, 73, 'https://images.unsplash.com/photo-1546868871-7041f2a55e12?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Electronics' LIMIT 1), '10000000-0000-0000-0000-000000000001'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000012');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000013', 'Razer External SSD 2TB - Edition 13', 'Engineered by Razer. The External SSD 2TB comes equipped with Active Noise Cancellation. Designed for superior performance, premium durability, and daily reliability.', 181.18, 86, 'https://images.unsplash.com/photo-1600080972464-8e5f35f63d08?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Electronics' LIMIT 1), '10000000-0000-0000-0000-000000000001'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000013');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000014', 'DJI Gaming Mouse - Edition 14', 'Engineered by DJI. The Gaming Mouse comes equipped M3 Max 32GB RAM Edition. Designed for superior performance, premium durability, and daily reliability.', 195.59, 99, 'https://images.unsplash.com/photo-1593642632823-8f785ba67e45?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Electronics' LIMIT 1), '10000000-0000-0000-0000-000000000001'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000014');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000015', 'Xiaomi Tablet Pro - Edition 15', 'Engineered by Xiaomi. The Tablet Pro comes equipped 120Hz Fluid AMOLED Display. Designed for superior performance, premium durability, and daily reliability.', 188.3, 27, 'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Electronics' LIMIT 1), '10000000-0000-0000-0000-000000000001'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000015');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000016', 'Apple Wireless Headphones - Edition 16', 'Engineered by Apple. The Wireless Headphones comes equipped Spatial Audio & 40hr Battery. Designed for superior performance, premium durability, and daily reliability.', 202.71, 40, 'https://images.unsplash.com/photo-1583394838336-acd977736f90?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Electronics' LIMIT 1), '10000000-0000-0000-0000-000000000001'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000016');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000017', 'Sony Pro Smartphone - Edition 17', 'Engineered by Sony. The Pro Smartphone comes equipped MagSafe Compatible. Designed for superior performance, premium durability, and daily reliability.', 217.11, 53, 'https://images.unsplash.com/photo-1608156639585-b3a032ef9689?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Electronics' LIMIT 1), '10000000-0000-0000-0000-000000000001'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000017');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000018', 'Samsung Ultra Laptop - Edition 18', 'Engineered by Samsung. The Ultra Laptop comes equipped RGB Backlit Wireless. Designed for superior performance, premium durability, and daily reliability.', 231.52, 66, 'https://images.unsplash.com/photo-1517336714731-489689fd1ca8?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Electronics' LIMIT 1), '10000000-0000-0000-0000-000000000001'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000018');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000019', 'Dell OLED Gaming Monitor - Edition 19', 'Engineered by Dell. The OLED Gaming Monitor comes equipped Titanium Frame Edition. Designed for superior performance, premium durability, and daily reliability.', 245.93, 79, 'https://images.unsplash.com/photo-1523275335684-37898b6baf30?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Electronics' LIMIT 1), '10000000-0000-0000-0000-000000000001'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000019');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000020', 'Logitech Smartwatch Series - Edition 20', 'Engineered by Logitech. The Smartwatch Series comes equipped Ultra-low Latency. Designed for superior performance, premium durability, and daily reliability.', 260.34, 92, 'https://images.unsplash.com/photo-1579586337278-3befd40fd17a?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Electronics' LIMIT 1), '10000000-0000-0000-0000-000000000001'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000020');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000021', 'Bose Bluetooth Speaker - Edition 01', 'Engineered by Bose. The Bluetooth Speaker comes equipped Thunderbolt 4 Enabled. Designed for superior performance, premium durability, and daily reliability.', 274.74, 20, 'https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Electronics' LIMIT 1), '10000000-0000-0000-0000-000000000001'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000021');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000022', 'Asus Mechanical Keyboard - Edition 02', 'Engineered by Asus. The Mechanical Keyboard comes equipped Waterproof IPX8 Rating. Designed for superior performance, premium durability, and daily reliability.', 267.45, 33, 'https://images.unsplash.com/photo-1546868871-7041f2a55e12?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Electronics' LIMIT 1), '10000000-0000-0000-0000-000000000001'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000022');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000023', 'Anker 4K Webcam - Edition 03', 'Engineered by Anker. The 4K Webcam comes equipped Custom EQ Acoustic Tuning. Designed for superior performance, premium durability, and daily reliability.', 281.86, 46, 'https://images.unsplash.com/photo-1600080972464-8e5f35f63d08?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Electronics' LIMIT 1), '10000000-0000-0000-0000-000000000001'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000023');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000024', 'Lenovo ANC Earbuds - Edition 04', 'Engineered by Lenovo. The ANC Earbuds comes equipped High-Res Audio Certified. Designed for superior performance, premium durability, and daily reliability.', 296.27, 59, 'https://images.unsplash.com/photo-1593642632823-8f785ba67e45?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Electronics' LIMIT 1), '10000000-0000-0000-0000-000000000001'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000024');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000025', 'LG Fast Charger Dock - Edition 05', 'Engineered by LG. The Fast Charger Dock comes equipped with Active Noise Cancellation. Designed for superior performance, premium durability, and daily reliability.', 310.67, 72, 'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Electronics' LIMIT 1), '10000000-0000-0000-0000-000000000001'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000025');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000026', 'Sennheiser Mirrorless Camera - Edition 06', 'Engineered by Sennheiser. The Mirrorless Camera comes equipped M3 Max 32GB RAM Edition. Designed for superior performance, premium durability, and daily reliability.', 325.08, 85, 'https://images.unsplash.com/photo-1583394838336-acd977736f90?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Electronics' LIMIT 1), '10000000-0000-0000-0000-000000000001'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000026');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000027', 'Google Drone Flycam - Edition 07', 'Engineered by Google. The Drone Flycam comes equipped 120Hz Fluid AMOLED Display. Designed for superior performance, premium durability, and daily reliability.', 339.49, 98, 'https://images.unsplash.com/photo-1608156639585-b3a032ef9689?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Electronics' LIMIT 1), '10000000-0000-0000-0000-000000000001'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000027');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000028', 'Razer External SSD 2TB - Edition 08', 'Engineered by Razer. The External SSD 2TB comes equipped Spatial Audio & 40hr Battery. Designed for superior performance, premium durability, and daily reliability.', 353.9, 26, 'https://images.unsplash.com/photo-1517336714731-489689fd1ca8?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Electronics' LIMIT 1), '10000000-0000-0000-0000-000000000001'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000028');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000029', 'DJI Gaming Mouse - Edition 09', 'Engineered by DJI. The Gaming Mouse comes equipped MagSafe Compatible. Designed for superior performance, premium durability, and daily reliability.', 346.61, 39, 'https://images.unsplash.com/photo-1523275335684-37898b6baf30?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Electronics' LIMIT 1), '10000000-0000-0000-0000-000000000001'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000029');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000030', 'Xiaomi Tablet Pro - Edition 10', 'Engineered by Xiaomi. The Tablet Pro comes equipped RGB Backlit Wireless. Designed for superior performance, premium durability, and daily reliability.', 361.01, 52, 'https://images.unsplash.com/photo-1579586337278-3befd40fd17a?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Electronics' LIMIT 1), '10000000-0000-0000-0000-000000000001'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000030');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000031', 'Apple Wireless Headphones - Edition 11', 'Engineered by Apple. The Wireless Headphones comes equipped Titanium Frame Edition. Designed for superior performance, premium durability, and daily reliability.', 375.42, 65, 'https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Electronics' LIMIT 1), '10000000-0000-0000-0000-000000000001'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000031');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000032', 'Sony Pro Smartphone - Edition 12', 'Engineered by Sony. The Pro Smartphone comes equipped Ultra-low Latency. Designed for superior performance, premium durability, and daily reliability.', 389.83, 78, 'https://images.unsplash.com/photo-1546868871-7041f2a55e12?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Electronics' LIMIT 1), '10000000-0000-0000-0000-000000000001'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000032');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000033', 'Samsung Ultra Laptop - Edition 13', 'Engineered by Samsung. The Ultra Laptop comes equipped Thunderbolt 4 Enabled. Designed for superior performance, premium durability, and daily reliability.', 404.24, 91, 'https://images.unsplash.com/photo-1600080972464-8e5f35f63d08?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Electronics' LIMIT 1), '10000000-0000-0000-0000-000000000001'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000033');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000034', 'Dell OLED Gaming Monitor - Edition 14', 'Engineered by Dell. The OLED Gaming Monitor comes equipped Waterproof IPX8 Rating. Designed for superior performance, premium durability, and daily reliability.', 418.64, 19, 'https://images.unsplash.com/photo-1593642632823-8f785ba67e45?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Electronics' LIMIT 1), '10000000-0000-0000-0000-000000000001'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000034');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000035', 'Logitech Smartwatch Series - Edition 15', 'Engineered by Logitech. The Smartwatch Series comes equipped Custom EQ Acoustic Tuning. Designed for superior performance, premium durability, and daily reliability.', 433.05, 32, 'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Electronics' LIMIT 1), '10000000-0000-0000-0000-000000000001'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000035');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000036', 'Bose Bluetooth Speaker - Edition 16', 'Engineered by Bose. The Bluetooth Speaker comes equipped High-Res Audio Certified. Designed for superior performance, premium durability, and daily reliability.', 425.76, 45, 'https://images.unsplash.com/photo-1583394838336-acd977736f90?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Electronics' LIMIT 1), '10000000-0000-0000-0000-000000000001'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000036');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000037', 'Asus Mechanical Keyboard - Edition 17', 'Engineered by Asus. The Mechanical Keyboard comes equipped with Active Noise Cancellation. Designed for superior performance, premium durability, and daily reliability.', 440.17, 58, 'https://images.unsplash.com/photo-1608156639585-b3a032ef9689?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Electronics' LIMIT 1), '10000000-0000-0000-0000-000000000001'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000037');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000038', 'Anker 4K Webcam - Edition 18', 'Engineered by Anker. The 4K Webcam comes equipped M3 Max 32GB RAM Edition. Designed for superior performance, premium durability, and daily reliability.', 454.57, 71, 'https://images.unsplash.com/photo-1517336714731-489689fd1ca8?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Electronics' LIMIT 1), '10000000-0000-0000-0000-000000000001'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000038');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000039', 'Lenovo ANC Earbuds - Edition 19', 'Engineered by Lenovo. The ANC Earbuds comes equipped 120Hz Fluid AMOLED Display. Designed for superior performance, premium durability, and daily reliability.', 468.98, 84, 'https://images.unsplash.com/photo-1523275335684-37898b6baf30?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Electronics' LIMIT 1), '10000000-0000-0000-0000-000000000001'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000039');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000040', 'LG Fast Charger Dock - Edition 20', 'Engineered by LG. The Fast Charger Dock comes equipped Spatial Audio & 40hr Battery. Designed for superior performance, premium durability, and daily reliability.', 483.39, 97, 'https://images.unsplash.com/photo-1579586337278-3befd40fd17a?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Electronics' LIMIT 1), '10000000-0000-0000-0000-000000000001'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000040');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000041', 'Sennheiser Mirrorless Camera - Edition 01', 'Engineered by Sennheiser. The Mirrorless Camera comes equipped MagSafe Compatible. Designed for superior performance, premium durability, and daily reliability.', 497.8, 25, 'https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Electronics' LIMIT 1), '10000000-0000-0000-0000-000000000001'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000041');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000042', 'Google Drone Flycam - Edition 02', 'Engineered by Google. The Drone Flycam comes equipped RGB Backlit Wireless. Designed for superior performance, premium durability, and daily reliability.', 512.21, 38, 'https://images.unsplash.com/photo-1546868871-7041f2a55e12?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Electronics' LIMIT 1), '10000000-0000-0000-0000-000000000001'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000042');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000043', 'Razer External SSD 2TB - Edition 03', 'Engineered by Razer. The External SSD 2TB comes equipped Titanium Frame Edition. Designed for superior performance, premium durability, and daily reliability.', 504.91, 51, 'https://images.unsplash.com/photo-1600080972464-8e5f35f63d08?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Electronics' LIMIT 1), '10000000-0000-0000-0000-000000000001'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000043');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000044', 'DJI Gaming Mouse - Edition 04', 'Engineered by DJI. The Gaming Mouse comes equipped Ultra-low Latency. Designed for superior performance, premium durability, and daily reliability.', 519.32, 64, 'https://images.unsplash.com/photo-1593642632823-8f785ba67e45?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Electronics' LIMIT 1), '10000000-0000-0000-0000-000000000001'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000044');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000045', 'Xiaomi Tablet Pro - Edition 05', 'Engineered by Xiaomi. The Tablet Pro comes equipped Thunderbolt 4 Enabled. Designed for superior performance, premium durability, and daily reliability.', 533.73, 77, 'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Electronics' LIMIT 1), '10000000-0000-0000-0000-000000000001'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000045');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000046', 'Apple Wireless Headphones - Edition 06', 'Engineered by Apple. The Wireless Headphones comes equipped Waterproof IPX8 Rating. Designed for superior performance, premium durability, and daily reliability.', 548.14, 90, 'https://images.unsplash.com/photo-1583394838336-acd977736f90?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Electronics' LIMIT 1), '10000000-0000-0000-0000-000000000001'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000046');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000047', 'Sony Pro Smartphone - Edition 07', 'Engineered by Sony. The Pro Smartphone comes equipped Custom EQ Acoustic Tuning. Designed for superior performance, premium durability, and daily reliability.', 562.54, 18, 'https://images.unsplash.com/photo-1608156639585-b3a032ef9689?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Electronics' LIMIT 1), '10000000-0000-0000-0000-000000000001'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000047');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000048', 'Samsung Ultra Laptop - Edition 08', 'Engineered by Samsung. The Ultra Laptop comes equipped High-Res Audio Certified. Designed for superior performance, premium durability, and daily reliability.', 576.95, 31, 'https://images.unsplash.com/photo-1517336714731-489689fd1ca8?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Electronics' LIMIT 1), '10000000-0000-0000-0000-000000000001'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000048');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000049', 'Dell OLED Gaming Monitor - Edition 09', 'Engineered by Dell. The OLED Gaming Monitor comes equipped with Active Noise Cancellation. Designed for superior performance, premium durability, and daily reliability.', 591.36, 44, 'https://images.unsplash.com/photo-1523275335684-37898b6baf30?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Electronics' LIMIT 1), '10000000-0000-0000-0000-000000000001'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000049');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000050', 'Logitech Smartwatch Series - Edition 10', 'Engineered by Logitech. The Smartwatch Series comes equipped M3 Max 32GB RAM Edition. Designed for superior performance, premium durability, and daily reliability.', 584.07, 57, 'https://images.unsplash.com/photo-1579586337278-3befd40fd17a?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Electronics' LIMIT 1), '10000000-0000-0000-0000-000000000001'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000050');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000051', 'Bose Bluetooth Speaker - Edition 11', 'Engineered by Bose. The Bluetooth Speaker comes equipped 120Hz Fluid AMOLED Display. Designed for superior performance, premium durability, and daily reliability.', 598.47, 70, 'https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Electronics' LIMIT 1), '10000000-0000-0000-0000-000000000001'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000051');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000052', 'Asus Mechanical Keyboard - Edition 12', 'Engineered by Asus. The Mechanical Keyboard comes equipped Spatial Audio & 40hr Battery. Designed for superior performance, premium durability, and daily reliability.', 612.88, 83, 'https://images.unsplash.com/photo-1546868871-7041f2a55e12?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Electronics' LIMIT 1), '10000000-0000-0000-0000-000000000001'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000052');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000053', 'Anker 4K Webcam - Edition 13', 'Engineered by Anker. The 4K Webcam comes equipped MagSafe Compatible. Designed for superior performance, premium durability, and daily reliability.', 627.29, 96, 'https://images.unsplash.com/photo-1600080972464-8e5f35f63d08?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Electronics' LIMIT 1), '10000000-0000-0000-0000-000000000001'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000053');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000054', 'Lenovo ANC Earbuds - Edition 14', 'Engineered by Lenovo. The ANC Earbuds comes equipped RGB Backlit Wireless. Designed for superior performance, premium durability, and daily reliability.', 641.7, 24, 'https://images.unsplash.com/photo-1593642632823-8f785ba67e45?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Electronics' LIMIT 1), '10000000-0000-0000-0000-000000000001'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000054');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000055', 'LG Fast Charger Dock - Edition 15', 'Engineered by LG. The Fast Charger Dock comes equipped Titanium Frame Edition. Designed for superior performance, premium durability, and daily reliability.', 656.11, 37, 'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Electronics' LIMIT 1), '10000000-0000-0000-0000-000000000001'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000055');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000056', 'Sennheiser Mirrorless Camera - Edition 16', 'Engineered by Sennheiser. The Mirrorless Camera comes equipped Ultra-low Latency. Designed for superior performance, premium durability, and daily reliability.', 670.51, 50, 'https://images.unsplash.com/photo-1583394838336-acd977736f90?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Electronics' LIMIT 1), '10000000-0000-0000-0000-000000000001'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000056');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000057', 'Google Drone Flycam - Edition 17', 'Engineered by Google. The Drone Flycam comes equipped Thunderbolt 4 Enabled. Designed for superior performance, premium durability, and daily reliability.', 663.22, 63, 'https://images.unsplash.com/photo-1608156639585-b3a032ef9689?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Electronics' LIMIT 1), '10000000-0000-0000-0000-000000000001'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000057');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000058', 'Razer External SSD 2TB - Edition 18', 'Engineered by Razer. The External SSD 2TB comes equipped Waterproof IPX8 Rating. Designed for superior performance, premium durability, and daily reliability.', 677.63, 76, 'https://images.unsplash.com/photo-1517336714731-489689fd1ca8?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Electronics' LIMIT 1), '10000000-0000-0000-0000-000000000001'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000058');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000059', 'DJI Gaming Mouse - Edition 19', 'Engineered by DJI. The Gaming Mouse comes equipped Custom EQ Acoustic Tuning. Designed for superior performance, premium durability, and daily reliability.', 692.04, 89, 'https://images.unsplash.com/photo-1523275335684-37898b6baf30?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Electronics' LIMIT 1), '10000000-0000-0000-0000-000000000001'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000059');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000060', 'Xiaomi Tablet Pro - Edition 20', 'Engineered by Xiaomi. The Tablet Pro comes equipped High-Res Audio Certified. Designed for superior performance, premium durability, and daily reliability.', 706.44, 17, 'https://images.unsplash.com/photo-1579586337278-3befd40fd17a?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Electronics' LIMIT 1), '10000000-0000-0000-0000-000000000001'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000060');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000061', 'Apple Wireless Headphones - Edition 01', 'Engineered by Apple. The Wireless Headphones comes equipped with Active Noise Cancellation. Designed for superior performance, premium durability, and daily reliability.', 720.85, 30, 'https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Electronics' LIMIT 1), '10000000-0000-0000-0000-000000000001'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000061');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000062', 'Sony Pro Smartphone - Edition 02', 'Engineered by Sony. The Pro Smartphone comes equipped M3 Max 32GB RAM Edition. Designed for superior performance, premium durability, and daily reliability.', 735.26, 43, 'https://images.unsplash.com/photo-1546868871-7041f2a55e12?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Electronics' LIMIT 1), '10000000-0000-0000-0000-000000000001'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000062');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000063', 'Samsung Ultra Laptop - Edition 03', 'Engineered by Samsung. The Ultra Laptop comes equipped 120Hz Fluid AMOLED Display. Designed for superior performance, premium durability, and daily reliability.', 749.67, 56, 'https://images.unsplash.com/photo-1600080972464-8e5f35f63d08?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Electronics' LIMIT 1), '10000000-0000-0000-0000-000000000001'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000063');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000064', 'Dell OLED Gaming Monitor - Edition 04', 'Engineered by Dell. The OLED Gaming Monitor comes equipped Spatial Audio & 40hr Battery. Designed for superior performance, premium durability, and daily reliability.', 742.37, 69, 'https://images.unsplash.com/photo-1593642632823-8f785ba67e45?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Electronics' LIMIT 1), '10000000-0000-0000-0000-000000000001'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000064');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000065', 'Logitech Smartwatch Series - Edition 05', 'Engineered by Logitech. The Smartwatch Series comes equipped MagSafe Compatible. Designed for superior performance, premium durability, and daily reliability.', 756.78, 82, 'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Electronics' LIMIT 1), '10000000-0000-0000-0000-000000000001'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000065');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000066', 'Bose Bluetooth Speaker - Edition 06', 'Engineered by Bose. The Bluetooth Speaker comes equipped RGB Backlit Wireless. Designed for superior performance, premium durability, and daily reliability.', 771.19, 95, 'https://images.unsplash.com/photo-1583394838336-acd977736f90?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Electronics' LIMIT 1), '10000000-0000-0000-0000-000000000001'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000066');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000067', 'Asus Mechanical Keyboard - Edition 07', 'Engineered by Asus. The Mechanical Keyboard comes equipped Titanium Frame Edition. Designed for superior performance, premium durability, and daily reliability.', 785.6, 23, 'https://images.unsplash.com/photo-1608156639585-b3a032ef9689?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Electronics' LIMIT 1), '10000000-0000-0000-0000-000000000001'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000067');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000068', 'Anker 4K Webcam - Edition 08', 'Engineered by Anker. The 4K Webcam comes equipped Ultra-low Latency. Designed for superior performance, premium durability, and daily reliability.', 800.01, 36, 'https://images.unsplash.com/photo-1517336714731-489689fd1ca8?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Electronics' LIMIT 1), '10000000-0000-0000-0000-000000000001'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000068');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000069', 'Lenovo ANC Earbuds - Edition 09', 'Engineered by Lenovo. The ANC Earbuds comes equipped Thunderbolt 4 Enabled. Designed for superior performance, premium durability, and daily reliability.', 814.41, 49, 'https://images.unsplash.com/photo-1523275335684-37898b6baf30?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Electronics' LIMIT 1), '10000000-0000-0000-0000-000000000001'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000069');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000070', 'LG Fast Charger Dock - Edition 10', 'Engineered by LG. The Fast Charger Dock comes equipped Waterproof IPX8 Rating. Designed for superior performance, premium durability, and daily reliability.', 828.82, 62, 'https://images.unsplash.com/photo-1579586337278-3befd40fd17a?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Electronics' LIMIT 1), '10000000-0000-0000-0000-000000000001'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000070');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000071', 'Sennheiser Mirrorless Camera - Edition 11', 'Engineered by Sennheiser. The Mirrorless Camera comes equipped Custom EQ Acoustic Tuning. Designed for superior performance, premium durability, and daily reliability.', 821.53, 75, 'https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Electronics' LIMIT 1), '10000000-0000-0000-0000-000000000001'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000071');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000072', 'Google Drone Flycam - Edition 12', 'Engineered by Google. The Drone Flycam comes equipped High-Res Audio Certified. Designed for superior performance, premium durability, and daily reliability.', 835.94, 88, 'https://images.unsplash.com/photo-1546868871-7041f2a55e12?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Electronics' LIMIT 1), '10000000-0000-0000-0000-000000000001'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000072');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000073', 'Razer External SSD 2TB - Edition 13', 'Engineered by Razer. The External SSD 2TB comes equipped with Active Noise Cancellation. Designed for superior performance, premium durability, and daily reliability.', 850.34, 16, 'https://images.unsplash.com/photo-1600080972464-8e5f35f63d08?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Electronics' LIMIT 1), '10000000-0000-0000-0000-000000000001'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000073');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000074', 'DJI Gaming Mouse - Edition 14', 'Engineered by DJI. The Gaming Mouse comes equipped M3 Max 32GB RAM Edition. Designed for superior performance, premium durability, and daily reliability.', 864.75, 29, 'https://images.unsplash.com/photo-1593642632823-8f785ba67e45?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Electronics' LIMIT 1), '10000000-0000-0000-0000-000000000001'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000074');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000075', 'Xiaomi Tablet Pro - Edition 15', 'Engineered by Xiaomi. The Tablet Pro comes equipped 120Hz Fluid AMOLED Display. Designed for superior performance, premium durability, and daily reliability.', 879.16, 42, 'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Electronics' LIMIT 1), '10000000-0000-0000-0000-000000000001'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000075');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000076', 'Apple Wireless Headphones - Edition 16', 'Engineered by Apple. The Wireless Headphones comes equipped Spatial Audio & 40hr Battery. Designed for superior performance, premium durability, and daily reliability.', 893.57, 55, 'https://images.unsplash.com/photo-1583394838336-acd977736f90?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Electronics' LIMIT 1), '10000000-0000-0000-0000-000000000001'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000076');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000077', 'Sony Pro Smartphone - Edition 17', 'Engineered by Sony. The Pro Smartphone comes equipped MagSafe Compatible. Designed for superior performance, premium durability, and daily reliability.', 907.97, 68, 'https://images.unsplash.com/photo-1608156639585-b3a032ef9689?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Electronics' LIMIT 1), '10000000-0000-0000-0000-000000000001'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000077');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000078', 'Samsung Ultra Laptop - Edition 18', 'Engineered by Samsung. The Ultra Laptop comes equipped RGB Backlit Wireless. Designed for superior performance, premium durability, and daily reliability.', 900.68, 81, 'https://images.unsplash.com/photo-1517336714731-489689fd1ca8?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Electronics' LIMIT 1), '10000000-0000-0000-0000-000000000001'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000078');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000079', 'Dell OLED Gaming Monitor - Edition 19', 'Engineered by Dell. The OLED Gaming Monitor comes equipped Titanium Frame Edition. Designed for superior performance, premium durability, and daily reliability.', 915.09, 94, 'https://images.unsplash.com/photo-1523275335684-37898b6baf30?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Electronics' LIMIT 1), '10000000-0000-0000-0000-000000000001'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000079');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000080', 'Logitech Smartwatch Series - Edition 20', 'Engineered by Logitech. The Smartwatch Series comes equipped Ultra-low Latency. Designed for superior performance, premium durability, and daily reliability.', 929.5, 22, 'https://images.unsplash.com/photo-1579586337278-3befd40fd17a?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Electronics' LIMIT 1), '10000000-0000-0000-0000-000000000001'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000080');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000081', 'Bose Bluetooth Speaker - Edition 01', 'Engineered by Bose. The Bluetooth Speaker comes equipped Thunderbolt 4 Enabled. Designed for superior performance, premium durability, and daily reliability.', 943.91, 35, 'https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Electronics' LIMIT 1), '10000000-0000-0000-0000-000000000001'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000081');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000082', 'Asus Mechanical Keyboard - Edition 02', 'Engineered by Asus. The Mechanical Keyboard comes equipped Waterproof IPX8 Rating. Designed for superior performance, premium durability, and daily reliability.', 958.31, 48, 'https://images.unsplash.com/photo-1546868871-7041f2a55e12?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Electronics' LIMIT 1), '10000000-0000-0000-0000-000000000001'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000082');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000083', 'Anker 4K Webcam - Edition 03', 'Engineered by Anker. The 4K Webcam comes equipped Custom EQ Acoustic Tuning. Designed for superior performance, premium durability, and daily reliability.', 972.72, 61, 'https://images.unsplash.com/photo-1600080972464-8e5f35f63d08?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Electronics' LIMIT 1), '10000000-0000-0000-0000-000000000001'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000083');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000084', 'Lenovo ANC Earbuds - Edition 04', 'Engineered by Lenovo. The ANC Earbuds comes equipped High-Res Audio Certified. Designed for superior performance, premium durability, and daily reliability.', 987.13, 74, 'https://images.unsplash.com/photo-1593642632823-8f785ba67e45?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Electronics' LIMIT 1), '10000000-0000-0000-0000-000000000001'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000084');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000085', 'LG Fast Charger Dock - Edition 05', 'Engineered by LG. The Fast Charger Dock comes equipped with Active Noise Cancellation. Designed for superior performance, premium durability, and daily reliability.', 979.84, 87, 'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Electronics' LIMIT 1), '10000000-0000-0000-0000-000000000001'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000085');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000086', 'Sennheiser Mirrorless Camera - Edition 06', 'Engineered by Sennheiser. The Mirrorless Camera comes equipped M3 Max 32GB RAM Edition. Designed for superior performance, premium durability, and daily reliability.', 994.24, 15, 'https://images.unsplash.com/photo-1583394838336-acd977736f90?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Electronics' LIMIT 1), '10000000-0000-0000-0000-000000000001'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000086');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000087', 'Google Drone Flycam - Edition 07', 'Engineered by Google. The Drone Flycam comes equipped 120Hz Fluid AMOLED Display. Designed for superior performance, premium durability, and daily reliability.', 1008.65, 28, 'https://images.unsplash.com/photo-1608156639585-b3a032ef9689?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Electronics' LIMIT 1), '10000000-0000-0000-0000-000000000001'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000087');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000088', 'Razer External SSD 2TB - Edition 08', 'Engineered by Razer. The External SSD 2TB comes equipped Spatial Audio & 40hr Battery. Designed for superior performance, premium durability, and daily reliability.', 1023.06, 41, 'https://images.unsplash.com/photo-1517336714731-489689fd1ca8?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Electronics' LIMIT 1), '10000000-0000-0000-0000-000000000001'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000088');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000089', 'DJI Gaming Mouse - Edition 09', 'Engineered by DJI. The Gaming Mouse comes equipped MagSafe Compatible. Designed for superior performance, premium durability, and daily reliability.', 1037.47, 54, 'https://images.unsplash.com/photo-1523275335684-37898b6baf30?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Electronics' LIMIT 1), '10000000-0000-0000-0000-000000000001'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000089');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000090', 'Xiaomi Tablet Pro - Edition 10', 'Engineered by Xiaomi. The Tablet Pro comes equipped RGB Backlit Wireless. Designed for superior performance, premium durability, and daily reliability.', 1051.87, 67, 'https://images.unsplash.com/photo-1579586337278-3befd40fd17a?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Electronics' LIMIT 1), '10000000-0000-0000-0000-000000000001'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000090');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000091', 'Apple Wireless Headphones - Edition 11', 'Engineered by Apple. The Wireless Headphones comes equipped Titanium Frame Edition. Designed for superior performance, premium durability, and daily reliability.', 1066.28, 80, 'https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Electronics' LIMIT 1), '10000000-0000-0000-0000-000000000001'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000091');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000092', 'Sony Pro Smartphone - Edition 12', 'Engineered by Sony. The Pro Smartphone comes equipped Ultra-low Latency. Designed for superior performance, premium durability, and daily reliability.', 1058.99, 93, 'https://images.unsplash.com/photo-1546868871-7041f2a55e12?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Electronics' LIMIT 1), '10000000-0000-0000-0000-000000000001'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000092');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000093', 'Samsung Ultra Laptop - Edition 13', 'Engineered by Samsung. The Ultra Laptop comes equipped Thunderbolt 4 Enabled. Designed for superior performance, premium durability, and daily reliability.', 1073.4, 21, 'https://images.unsplash.com/photo-1600080972464-8e5f35f63d08?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Electronics' LIMIT 1), '10000000-0000-0000-0000-000000000001'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000093');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000094', 'Dell OLED Gaming Monitor - Edition 14', 'Engineered by Dell. The OLED Gaming Monitor comes equipped Waterproof IPX8 Rating. Designed for superior performance, premium durability, and daily reliability.', 1087.81, 34, 'https://images.unsplash.com/photo-1593642632823-8f785ba67e45?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Electronics' LIMIT 1), '10000000-0000-0000-0000-000000000001'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000094');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000095', 'Logitech Smartwatch Series - Edition 15', 'Engineered by Logitech. The Smartwatch Series comes equipped Custom EQ Acoustic Tuning. Designed for superior performance, premium durability, and daily reliability.', 1102.21, 47, 'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Electronics' LIMIT 1), '10000000-0000-0000-0000-000000000001'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000095');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000096', 'Bose Bluetooth Speaker - Edition 16', 'Engineered by Bose. The Bluetooth Speaker comes equipped High-Res Audio Certified. Designed for superior performance, premium durability, and daily reliability.', 1116.62, 60, 'https://images.unsplash.com/photo-1583394838336-acd977736f90?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Electronics' LIMIT 1), '10000000-0000-0000-0000-000000000001'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000096');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000097', 'Asus Mechanical Keyboard - Edition 17', 'Engineered by Asus. The Mechanical Keyboard comes equipped with Active Noise Cancellation. Designed for superior performance, premium durability, and daily reliability.', 1131.03, 73, 'https://images.unsplash.com/photo-1608156639585-b3a032ef9689?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Electronics' LIMIT 1), '10000000-0000-0000-0000-000000000001'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000097');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000098', 'Anker 4K Webcam - Edition 18', 'Engineered by Anker. The 4K Webcam comes equipped M3 Max 32GB RAM Edition. Designed for superior performance, premium durability, and daily reliability.', 1145.44, 86, 'https://images.unsplash.com/photo-1517336714731-489689fd1ca8?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Electronics' LIMIT 1), '10000000-0000-0000-0000-000000000001'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000098');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000099', 'Lenovo ANC Earbuds - Edition 19', 'Engineered by Lenovo. The ANC Earbuds comes equipped 120Hz Fluid AMOLED Display. Designed for superior performance, premium durability, and daily reliability.', 1138.14, 99, 'https://images.unsplash.com/photo-1523275335684-37898b6baf30?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Electronics' LIMIT 1), '10000000-0000-0000-0000-000000000001'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000099');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000100', 'LG Fast Charger Dock - Edition 20', 'Engineered by LG. The Fast Charger Dock comes equipped Spatial Audio & 40hr Battery. Designed for superior performance, premium durability, and daily reliability.', 1152.55, 27, 'https://images.unsplash.com/photo-1579586337278-3befd40fd17a?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Electronics' LIMIT 1), '10000000-0000-0000-0000-000000000001'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000100');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000101', 'Sennheiser Mirrorless Camera - Edition 01', 'Engineered by Sennheiser. The Mirrorless Camera comes equipped MagSafe Compatible. Designed for superior performance, premium durability, and daily reliability.', 1166.96, 40, 'https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Electronics' LIMIT 1), '10000000-0000-0000-0000-000000000001'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000101');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000102', 'Google Drone Flycam - Edition 02', 'Engineered by Google. The Drone Flycam comes equipped RGB Backlit Wireless. Designed for superior performance, premium durability, and daily reliability.', 1181.37, 53, 'https://images.unsplash.com/photo-1546868871-7041f2a55e12?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Electronics' LIMIT 1), '10000000-0000-0000-0000-000000000001'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000102');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000103', 'Razer External SSD 2TB - Edition 03', 'Engineered by Razer. The External SSD 2TB comes equipped Titanium Frame Edition. Designed for superior performance, premium durability, and daily reliability.', 1195.77, 66, 'https://images.unsplash.com/photo-1600080972464-8e5f35f63d08?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Electronics' LIMIT 1), '10000000-0000-0000-0000-000000000001'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000103');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000104', 'DJI Gaming Mouse - Edition 04', 'Engineered by DJI. The Gaming Mouse comes equipped Ultra-low Latency. Designed for superior performance, premium durability, and daily reliability.', 1210.18, 79, 'https://images.unsplash.com/photo-1593642632823-8f785ba67e45?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Electronics' LIMIT 1), '10000000-0000-0000-0000-000000000001'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000104');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000105', 'Xiaomi Tablet Pro - Edition 05', 'Engineered by Xiaomi. The Tablet Pro comes equipped Thunderbolt 4 Enabled. Designed for superior performance, premium durability, and daily reliability.', 1224.59, 92, 'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Electronics' LIMIT 1), '10000000-0000-0000-0000-000000000001'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000105');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000106', 'Apple Wireless Headphones - Edition 06', 'Engineered by Apple. The Wireless Headphones comes equipped Waterproof IPX8 Rating. Designed for superior performance, premium durability, and daily reliability.', 1217.3, 20, 'https://images.unsplash.com/photo-1583394838336-acd977736f90?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Electronics' LIMIT 1), '10000000-0000-0000-0000-000000000001'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000106');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000107', 'Sony Pro Smartphone - Edition 07', 'Engineered by Sony. The Pro Smartphone comes equipped Custom EQ Acoustic Tuning. Designed for superior performance, premium durability, and daily reliability.', 1231.71, 33, 'https://images.unsplash.com/photo-1608156639585-b3a032ef9689?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Electronics' LIMIT 1), '10000000-0000-0000-0000-000000000001'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000107');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000108', 'Samsung Ultra Laptop - Edition 08', 'Engineered by Samsung. The Ultra Laptop comes equipped High-Res Audio Certified. Designed for superior performance, premium durability, and daily reliability.', 1246.11, 46, 'https://images.unsplash.com/photo-1517336714731-489689fd1ca8?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Electronics' LIMIT 1), '10000000-0000-0000-0000-000000000001'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000108');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000109', 'Dell OLED Gaming Monitor - Edition 09', 'Engineered by Dell. The OLED Gaming Monitor comes equipped with Active Noise Cancellation. Designed for superior performance, premium durability, and daily reliability.', 1260.52, 59, 'https://images.unsplash.com/photo-1523275335684-37898b6baf30?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Electronics' LIMIT 1), '10000000-0000-0000-0000-000000000001'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000109');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000110', 'Logitech Smartwatch Series - Edition 10', 'Engineered by Logitech. The Smartwatch Series comes equipped M3 Max 32GB RAM Edition. Designed for superior performance, premium durability, and daily reliability.', 1274.93, 72, 'https://images.unsplash.com/photo-1579586337278-3befd40fd17a?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Electronics' LIMIT 1), '10000000-0000-0000-0000-000000000001'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000110');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000111', 'Bose Bluetooth Speaker - Edition 11', 'Engineered by Bose. The Bluetooth Speaker comes equipped 120Hz Fluid AMOLED Display. Designed for superior performance, premium durability, and daily reliability.', 1289.34, 85, 'https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Electronics' LIMIT 1), '10000000-0000-0000-0000-000000000001'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000111');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000112', 'Asus Mechanical Keyboard - Edition 12', 'Engineered by Asus. The Mechanical Keyboard comes equipped Spatial Audio & 40hr Battery. Designed for superior performance, premium durability, and daily reliability.', 1303.74, 98, 'https://images.unsplash.com/photo-1546868871-7041f2a55e12?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Electronics' LIMIT 1), '10000000-0000-0000-0000-000000000001'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000112');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000113', 'Anker 4K Webcam - Edition 13', 'Engineered by Anker. The 4K Webcam comes equipped MagSafe Compatible. Designed for superior performance, premium durability, and daily reliability.', 1296.45, 26, 'https://images.unsplash.com/photo-1600080972464-8e5f35f63d08?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Electronics' LIMIT 1), '10000000-0000-0000-0000-000000000001'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000113');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000114', 'Lenovo ANC Earbuds - Edition 14', 'Engineered by Lenovo. The ANC Earbuds comes equipped RGB Backlit Wireless. Designed for superior performance, premium durability, and daily reliability.', 1310.86, 39, 'https://images.unsplash.com/photo-1593642632823-8f785ba67e45?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Electronics' LIMIT 1), '10000000-0000-0000-0000-000000000001'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000114');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000115', 'LG Fast Charger Dock - Edition 15', 'Engineered by LG. The Fast Charger Dock comes equipped Titanium Frame Edition. Designed for superior performance, premium durability, and daily reliability.', 1325.27, 52, 'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Electronics' LIMIT 1), '10000000-0000-0000-0000-000000000001'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000115');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000116', 'Sennheiser Mirrorless Camera - Edition 16', 'Engineered by Sennheiser. The Mirrorless Camera comes equipped Ultra-low Latency. Designed for superior performance, premium durability, and daily reliability.', 1339.67, 65, 'https://images.unsplash.com/photo-1583394838336-acd977736f90?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Electronics' LIMIT 1), '10000000-0000-0000-0000-000000000001'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000116');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000117', 'Google Drone Flycam - Edition 17', 'Engineered by Google. The Drone Flycam comes equipped Thunderbolt 4 Enabled. Designed for superior performance, premium durability, and daily reliability.', 1354.08, 78, 'https://images.unsplash.com/photo-1608156639585-b3a032ef9689?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Electronics' LIMIT 1), '10000000-0000-0000-0000-000000000001'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000117');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000118', 'Razer External SSD 2TB - Edition 18', 'Engineered by Razer. The External SSD 2TB comes equipped Waterproof IPX8 Rating. Designed for superior performance, premium durability, and daily reliability.', 1368.49, 91, 'https://images.unsplash.com/photo-1517336714731-489689fd1ca8?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Electronics' LIMIT 1), '10000000-0000-0000-0000-000000000001'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000118');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000119', 'DJI Gaming Mouse - Edition 19', 'Engineered by DJI. The Gaming Mouse comes equipped Custom EQ Acoustic Tuning. Designed for superior performance, premium durability, and daily reliability.', 1382.9, 19, 'https://images.unsplash.com/photo-1523275335684-37898b6baf30?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Electronics' LIMIT 1), '10000000-0000-0000-0000-000000000001'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000119');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000120', 'Xiaomi Tablet Pro - Edition 20', 'Engineered by Xiaomi. The Tablet Pro comes equipped High-Res Audio Certified. Designed for superior performance, premium durability, and daily reliability.', 1375.61, 32, 'https://images.unsplash.com/photo-1579586337278-3befd40fd17a?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Electronics' LIMIT 1), '10000000-0000-0000-0000-000000000001'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000120');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000121', 'Apple Wireless Headphones - Edition 01', 'Engineered by Apple. The Wireless Headphones comes equipped with Active Noise Cancellation. Designed for superior performance, premium durability, and daily reliability.', 1390.01, 45, 'https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Electronics' LIMIT 1), '10000000-0000-0000-0000-000000000001'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000121');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000122', 'Sony Pro Smartphone - Edition 02', 'Engineered by Sony. The Pro Smartphone comes equipped M3 Max 32GB RAM Edition. Designed for superior performance, premium durability, and daily reliability.', 1404.42, 58, 'https://images.unsplash.com/photo-1546868871-7041f2a55e12?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Electronics' LIMIT 1), '10000000-0000-0000-0000-000000000001'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000122');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000123', 'Samsung Ultra Laptop - Edition 03', 'Engineered by Samsung. The Ultra Laptop comes equipped 120Hz Fluid AMOLED Display. Designed for superior performance, premium durability, and daily reliability.', 1418.83, 71, 'https://images.unsplash.com/photo-1600080972464-8e5f35f63d08?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Electronics' LIMIT 1), '10000000-0000-0000-0000-000000000001'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000123');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000124', 'Dell OLED Gaming Monitor - Edition 04', 'Engineered by Dell. The OLED Gaming Monitor comes equipped Spatial Audio & 40hr Battery. Designed for superior performance, premium durability, and daily reliability.', 1433.24, 84, 'https://images.unsplash.com/photo-1593642632823-8f785ba67e45?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Electronics' LIMIT 1), '10000000-0000-0000-0000-000000000001'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000124');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000125', 'Logitech Smartwatch Series - Edition 05', 'Engineered by Logitech. The Smartwatch Series comes equipped MagSafe Compatible. Designed for superior performance, premium durability, and daily reliability.', 1447.64, 97, 'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Electronics' LIMIT 1), '10000000-0000-0000-0000-000000000001'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000125');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000126', 'Bose Bluetooth Speaker - Edition 06', 'Engineered by Bose. The Bluetooth Speaker comes equipped RGB Backlit Wireless. Designed for superior performance, premium durability, and daily reliability.', 1462.05, 25, 'https://images.unsplash.com/photo-1583394838336-acd977736f90?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Electronics' LIMIT 1), '10000000-0000-0000-0000-000000000001'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000126');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000127', 'Asus Mechanical Keyboard - Edition 07', 'Engineered by Asus. The Mechanical Keyboard comes equipped Titanium Frame Edition. Designed for superior performance, premium durability, and daily reliability.', 1454.76, 38, 'https://images.unsplash.com/photo-1608156639585-b3a032ef9689?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Electronics' LIMIT 1), '10000000-0000-0000-0000-000000000001'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000127');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000128', 'Anker 4K Webcam - Edition 08', 'Engineered by Anker. The 4K Webcam comes equipped Ultra-low Latency. Designed for superior performance, premium durability, and daily reliability.', 1469.17, 51, 'https://images.unsplash.com/photo-1517336714731-489689fd1ca8?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Electronics' LIMIT 1), '10000000-0000-0000-0000-000000000001'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000128');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000129', 'Lenovo ANC Earbuds - Edition 09', 'Engineered by Lenovo. The ANC Earbuds comes equipped Thunderbolt 4 Enabled. Designed for superior performance, premium durability, and daily reliability.', 1483.57, 64, 'https://images.unsplash.com/photo-1523275335684-37898b6baf30?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Electronics' LIMIT 1), '10000000-0000-0000-0000-000000000001'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000129');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000130', 'LG Fast Charger Dock - Edition 10', 'Engineered by LG. The Fast Charger Dock comes equipped Waterproof IPX8 Rating. Designed for superior performance, premium durability, and daily reliability.', 1497.98, 77, 'https://images.unsplash.com/photo-1579586337278-3befd40fd17a?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Electronics' LIMIT 1), '10000000-0000-0000-0000-000000000001'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000130');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000131', 'Nike Classic Denim Jacket - Edition 01', 'Engineered by Nike. The Classic Denim Jacket comes equipped 100% Breathable Combed Cotton. Designed for superior performance, premium durability, and daily reliability.', 19.99, 15, 'https://images.unsplash.com/photo-1542291026-7eec264c27ff?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Fashion' LIMIT 1), '10000000-0000-0000-0000-000000000002'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000131');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000132', 'Levi''s Running Sneakers - Edition 02', 'Engineered by Levi''s. The Running Sneakers comes equipped Genuine Full-Grain Leather. Designed for superior performance, premium durability, and daily reliability.', 26.4, 28, 'https://images.unsplash.com/photo-1584917865442-de89df76afd3?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Fashion' LIMIT 1), '10000000-0000-0000-0000-000000000002'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000132');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000133', 'Adidas Leather Crossbody Bag - Edition 03', 'Engineered by Adidas. The Leather Crossbody Bag comes equipped Reflective Night Running Accents. Designed for superior performance, premium durability, and daily reliability.', 32.81, 41, 'https://images.unsplash.com/photo-1591047139829-d91aecb6caea?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Fashion' LIMIT 1), '10000000-0000-0000-0000-000000000002'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000133');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000134', 'Zara Organic Cotton T-Shirt - Edition 04', 'Engineered by Zara. The Organic Cotton T-Shirt comes equipped All-Weather Thermal Lining. Designed for superior performance, premium durability, and daily reliability.', 39.21, 54, 'https://images.unsplash.com/photo-1521572267360-ee0c2909d518?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Fashion' LIMIT 1), '10000000-0000-0000-0000-000000000002'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000134');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000135', 'Ralph Lauren Merino Wool Sweater - Edition 05', 'Engineered by Ralph Lauren. The Merino Wool Sweater comes equipped Hand-Crafted Italian Stitching. Designed for superior performance, premium durability, and daily reliability.', 45.62, 67, 'https://images.unsplash.com/photo-1576995853123-5a10305d93c0?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Fashion' LIMIT 1), '10000000-0000-0000-0000-000000000002'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000135');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000136', 'Tommy Hilfiger Tailored Chino Pants - Edition 06', 'Engineered by Tommy Hilfiger. The Tailored Chino Pants comes equipped Anti-Crease Performance Fabric. Designed for superior performance, premium durability, and daily reliability.', 52.03, 80, 'https://images.unsplash.com/photo-1608231387042-66d1773070a5?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Fashion' LIMIT 1), '10000000-0000-0000-0000-000000000002'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000136');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000137', 'Calvin Klein Polarized Sunglasses - Edition 07', 'Engineered by Calvin Klein. The Polarized Sunglasses comes equipped UV400 Protection Lenses. Designed for superior performance, premium durability, and daily reliability.', 58.44, 93, 'https://images.unsplash.com/photo-1509695503495-ac9986b51052?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Fashion' LIMIT 1), '10000000-0000-0000-0000-000000000002'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000137');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000138', 'Gucci Silk Evening Scarf - Edition 08', 'Engineered by Gucci. The Silk Evening Scarf comes equipped Water-Repellent DWR Finish. Designed for superior performance, premium durability, and daily reliability.', 43.14, 21, 'https://images.unsplash.com/photo-1551028719-00167b16eac5?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Fashion' LIMIT 1), '10000000-0000-0000-0000-000000000002'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000138');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000139', 'Uniqlo Waterproof Parka - Edition 09', 'Engineered by Uniqlo. The Waterproof Parka comes equipped Tailored Modern Silhouette. Designed for superior performance, premium durability, and daily reliability.', 49.55, 34, 'https://images.unsplash.com/photo-1543163521-1bf539c55dd2?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Fashion' LIMIT 1), '10000000-0000-0000-0000-000000000002'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000139');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000140', 'Puma Canvas High-Top Shoes - Edition 10', 'Engineered by Puma. The Canvas High-Top Shoes comes equipped Vintage Indigo Wash. Designed for superior performance, premium durability, and daily reliability.', 55.96, 47, 'https://images.unsplash.com/photo-1594938298603-c8148c4dae35?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Fashion' LIMIT 1), '10000000-0000-0000-0000-000000000002'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000140');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000141', 'Patagonia Slim Fit Dress Shirt - Edition 11', 'Engineered by Patagonia. The Slim Fit Dress Shirt comes equipped 100% Breathable Combed Cotton. Designed for superior performance, premium durability, and daily reliability.', 62.37, 60, 'https://images.unsplash.com/photo-1542291026-7eec264c27ff?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Fashion' LIMIT 1), '10000000-0000-0000-0000-000000000002'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000141');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000142', 'Ray-Ban Minimalist Chronograph Watch - Edition 12', 'Engineered by Ray-Ban. The Minimalist Chronograph Watch comes equipped Genuine Full-Grain Leather. Designed for superior performance, premium durability, and daily reliability.', 68.78, 73, 'https://images.unsplash.com/photo-1584917865442-de89df76afd3?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Fashion' LIMIT 1), '10000000-0000-0000-0000-000000000002'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000142');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000143', 'Coach Casual Chelsea Boots - Edition 13', 'Engineered by Coach. The Casual Chelsea Boots comes equipped Reflective Night Running Accents. Designed for superior performance, premium durability, and daily reliability.', 75.18, 86, 'https://images.unsplash.com/photo-1591047139829-d91aecb6caea?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Fashion' LIMIT 1), '10000000-0000-0000-0000-000000000002'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000143');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000144', 'Under Armour Fleece Zip Hoodie - Edition 14', 'Engineered by Under Armour. The Fleece Zip Hoodie comes equipped All-Weather Thermal Lining. Designed for superior performance, premium durability, and daily reliability.', 81.59, 99, 'https://images.unsplash.com/photo-1521572267360-ee0c2909d518?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Fashion' LIMIT 1), '10000000-0000-0000-0000-000000000002'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000144');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000145', 'The North Face Puffer Winter Vest - Edition 15', 'Engineered by The North Face. The Puffer Winter Vest comes equipped Hand-Crafted Italian Stitching. Designed for superior performance, premium durability, and daily reliability.', 66.3, 27, 'https://images.unsplash.com/photo-1576995853123-5a10305d93c0?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Fashion' LIMIT 1), '10000000-0000-0000-0000-000000000002'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000145');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000146', 'Nike Classic Denim Jacket - Edition 16', 'Engineered by Nike. The Classic Denim Jacket comes equipped Anti-Crease Performance Fabric. Designed for superior performance, premium durability, and daily reliability.', 72.71, 40, 'https://images.unsplash.com/photo-1608231387042-66d1773070a5?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Fashion' LIMIT 1), '10000000-0000-0000-0000-000000000002'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000146');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000147', 'Levi''s Running Sneakers - Edition 17', 'Engineered by Levi''s. The Running Sneakers comes equipped UV400 Protection Lenses. Designed for superior performance, premium durability, and daily reliability.', 79.11, 53, 'https://images.unsplash.com/photo-1509695503495-ac9986b51052?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Fashion' LIMIT 1), '10000000-0000-0000-0000-000000000002'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000147');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000148', 'Adidas Leather Crossbody Bag - Edition 18', 'Engineered by Adidas. The Leather Crossbody Bag comes equipped Water-Repellent DWR Finish. Designed for superior performance, premium durability, and daily reliability.', 85.52, 66, 'https://images.unsplash.com/photo-1551028719-00167b16eac5?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Fashion' LIMIT 1), '10000000-0000-0000-0000-000000000002'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000148');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000149', 'Zara Organic Cotton T-Shirt - Edition 19', 'Engineered by Zara. The Organic Cotton T-Shirt comes equipped Tailored Modern Silhouette. Designed for superior performance, premium durability, and daily reliability.', 91.93, 79, 'https://images.unsplash.com/photo-1543163521-1bf539c55dd2?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Fashion' LIMIT 1), '10000000-0000-0000-0000-000000000002'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000149');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000150', 'Ralph Lauren Merino Wool Sweater - Edition 20', 'Engineered by Ralph Lauren. The Merino Wool Sweater comes equipped Vintage Indigo Wash. Designed for superior performance, premium durability, and daily reliability.', 98.34, 92, 'https://images.unsplash.com/photo-1594938298603-c8148c4dae35?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Fashion' LIMIT 1), '10000000-0000-0000-0000-000000000002'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000150');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000151', 'Tommy Hilfiger Tailored Chino Pants - Edition 01', 'Engineered by Tommy Hilfiger. The Tailored Chino Pants comes equipped 100% Breathable Combed Cotton. Designed for superior performance, premium durability, and daily reliability.', 104.75, 20, 'https://images.unsplash.com/photo-1542291026-7eec264c27ff?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Fashion' LIMIT 1), '10000000-0000-0000-0000-000000000002'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000151');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000152', 'Calvin Klein Polarized Sunglasses - Edition 02', 'Engineered by Calvin Klein. The Polarized Sunglasses comes equipped Genuine Full-Grain Leather. Designed for superior performance, premium durability, and daily reliability.', 89.45, 33, 'https://images.unsplash.com/photo-1584917865442-de89df76afd3?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Fashion' LIMIT 1), '10000000-0000-0000-0000-000000000002'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000152');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000153', 'Gucci Silk Evening Scarf - Edition 03', 'Engineered by Gucci. The Silk Evening Scarf comes equipped Reflective Night Running Accents. Designed for superior performance, premium durability, and daily reliability.', 95.86, 46, 'https://images.unsplash.com/photo-1591047139829-d91aecb6caea?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Fashion' LIMIT 1), '10000000-0000-0000-0000-000000000002'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000153');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000154', 'Uniqlo Waterproof Parka - Edition 04', 'Engineered by Uniqlo. The Waterproof Parka comes equipped All-Weather Thermal Lining. Designed for superior performance, premium durability, and daily reliability.', 102.27, 59, 'https://images.unsplash.com/photo-1521572267360-ee0c2909d518?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Fashion' LIMIT 1), '10000000-0000-0000-0000-000000000002'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000154');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000155', 'Puma Canvas High-Top Shoes - Edition 05', 'Engineered by Puma. The Canvas High-Top Shoes comes equipped Hand-Crafted Italian Stitching. Designed for superior performance, premium durability, and daily reliability.', 108.68, 72, 'https://images.unsplash.com/photo-1576995853123-5a10305d93c0?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Fashion' LIMIT 1), '10000000-0000-0000-0000-000000000002'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000155');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000156', 'Patagonia Slim Fit Dress Shirt - Edition 06', 'Engineered by Patagonia. The Slim Fit Dress Shirt comes equipped Anti-Crease Performance Fabric. Designed for superior performance, premium durability, and daily reliability.', 115.08, 85, 'https://images.unsplash.com/photo-1608231387042-66d1773070a5?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Fashion' LIMIT 1), '10000000-0000-0000-0000-000000000002'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000156');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000157', 'Ray-Ban Minimalist Chronograph Watch - Edition 07', 'Engineered by Ray-Ban. The Minimalist Chronograph Watch comes equipped UV400 Protection Lenses. Designed for superior performance, premium durability, and daily reliability.', 121.49, 98, 'https://images.unsplash.com/photo-1509695503495-ac9986b51052?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Fashion' LIMIT 1), '10000000-0000-0000-0000-000000000002'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000157');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000158', 'Coach Casual Chelsea Boots - Edition 08', 'Engineered by Coach. The Casual Chelsea Boots comes equipped Water-Repellent DWR Finish. Designed for superior performance, premium durability, and daily reliability.', 127.9, 26, 'https://images.unsplash.com/photo-1551028719-00167b16eac5?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Fashion' LIMIT 1), '10000000-0000-0000-0000-000000000002'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000158');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000159', 'Under Armour Fleece Zip Hoodie - Edition 09', 'Engineered by Under Armour. The Fleece Zip Hoodie comes equipped Tailored Modern Silhouette. Designed for superior performance, premium durability, and daily reliability.', 112.61, 39, 'https://images.unsplash.com/photo-1543163521-1bf539c55dd2?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Fashion' LIMIT 1), '10000000-0000-0000-0000-000000000002'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000159');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000160', 'The North Face Puffer Winter Vest - Edition 10', 'Engineered by The North Face. The Puffer Winter Vest comes equipped Vintage Indigo Wash. Designed for superior performance, premium durability, and daily reliability.', 119.02, 52, 'https://images.unsplash.com/photo-1594938298603-c8148c4dae35?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Fashion' LIMIT 1), '10000000-0000-0000-0000-000000000002'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000160');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000161', 'Nike Classic Denim Jacket - Edition 11', 'Engineered by Nike. The Classic Denim Jacket comes equipped 100% Breathable Combed Cotton. Designed for superior performance, premium durability, and daily reliability.', 125.42, 65, 'https://images.unsplash.com/photo-1542291026-7eec264c27ff?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Fashion' LIMIT 1), '10000000-0000-0000-0000-000000000002'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000161');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000162', 'Levi''s Running Sneakers - Edition 12', 'Engineered by Levi''s. The Running Sneakers comes equipped Genuine Full-Grain Leather. Designed for superior performance, premium durability, and daily reliability.', 131.83, 78, 'https://images.unsplash.com/photo-1584917865442-de89df76afd3?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Fashion' LIMIT 1), '10000000-0000-0000-0000-000000000002'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000162');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000163', 'Adidas Leather Crossbody Bag - Edition 13', 'Engineered by Adidas. The Leather Crossbody Bag comes equipped Reflective Night Running Accents. Designed for superior performance, premium durability, and daily reliability.', 138.24, 91, 'https://images.unsplash.com/photo-1591047139829-d91aecb6caea?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Fashion' LIMIT 1), '10000000-0000-0000-0000-000000000002'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000163');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000164', 'Zara Organic Cotton T-Shirt - Edition 14', 'Engineered by Zara. The Organic Cotton T-Shirt comes equipped All-Weather Thermal Lining. Designed for superior performance, premium durability, and daily reliability.', 144.65, 19, 'https://images.unsplash.com/photo-1521572267360-ee0c2909d518?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Fashion' LIMIT 1), '10000000-0000-0000-0000-000000000002'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000164');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000165', 'Ralph Lauren Merino Wool Sweater - Edition 15', 'Engineered by Ralph Lauren. The Merino Wool Sweater comes equipped Hand-Crafted Italian Stitching. Designed for superior performance, premium durability, and daily reliability.', 151.05, 32, 'https://images.unsplash.com/photo-1576995853123-5a10305d93c0?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Fashion' LIMIT 1), '10000000-0000-0000-0000-000000000002'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000165');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000166', 'Tommy Hilfiger Tailored Chino Pants - Edition 16', 'Engineered by Tommy Hilfiger. The Tailored Chino Pants comes equipped Anti-Crease Performance Fabric. Designed for superior performance, premium durability, and daily reliability.', 135.76, 45, 'https://images.unsplash.com/photo-1608231387042-66d1773070a5?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Fashion' LIMIT 1), '10000000-0000-0000-0000-000000000002'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000166');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000167', 'Calvin Klein Polarized Sunglasses - Edition 17', 'Engineered by Calvin Klein. The Polarized Sunglasses comes equipped UV400 Protection Lenses. Designed for superior performance, premium durability, and daily reliability.', 142.17, 58, 'https://images.unsplash.com/photo-1509695503495-ac9986b51052?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Fashion' LIMIT 1), '10000000-0000-0000-0000-000000000002'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000167');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000168', 'Gucci Silk Evening Scarf - Edition 18', 'Engineered by Gucci. The Silk Evening Scarf comes equipped Water-Repellent DWR Finish. Designed for superior performance, premium durability, and daily reliability.', 148.58, 71, 'https://images.unsplash.com/photo-1551028719-00167b16eac5?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Fashion' LIMIT 1), '10000000-0000-0000-0000-000000000002'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000168');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000169', 'Uniqlo Waterproof Parka - Edition 19', 'Engineered by Uniqlo. The Waterproof Parka comes equipped Tailored Modern Silhouette. Designed for superior performance, premium durability, and daily reliability.', 154.99, 84, 'https://images.unsplash.com/photo-1543163521-1bf539c55dd2?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Fashion' LIMIT 1), '10000000-0000-0000-0000-000000000002'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000169');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000170', 'Puma Canvas High-Top Shoes - Edition 20', 'Engineered by Puma. The Canvas High-Top Shoes comes equipped Vintage Indigo Wash. Designed for superior performance, premium durability, and daily reliability.', 161.39, 97, 'https://images.unsplash.com/photo-1594938298603-c8148c4dae35?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Fashion' LIMIT 1), '10000000-0000-0000-0000-000000000002'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000170');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000171', 'Patagonia Slim Fit Dress Shirt - Edition 01', 'Engineered by Patagonia. The Slim Fit Dress Shirt comes equipped 100% Breathable Combed Cotton. Designed for superior performance, premium durability, and daily reliability.', 167.8, 25, 'https://images.unsplash.com/photo-1542291026-7eec264c27ff?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Fashion' LIMIT 1), '10000000-0000-0000-0000-000000000002'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000171');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000172', 'Ray-Ban Minimalist Chronograph Watch - Edition 02', 'Engineered by Ray-Ban. The Minimalist Chronograph Watch comes equipped Genuine Full-Grain Leather. Designed for superior performance, premium durability, and daily reliability.', 174.21, 38, 'https://images.unsplash.com/photo-1584917865442-de89df76afd3?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Fashion' LIMIT 1), '10000000-0000-0000-0000-000000000002'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000172');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000173', 'Coach Casual Chelsea Boots - Edition 03', 'Engineered by Coach. The Casual Chelsea Boots comes equipped Reflective Night Running Accents. Designed for superior performance, premium durability, and daily reliability.', 158.92, 51, 'https://images.unsplash.com/photo-1591047139829-d91aecb6caea?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Fashion' LIMIT 1), '10000000-0000-0000-0000-000000000002'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000173');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000174', 'Under Armour Fleece Zip Hoodie - Edition 04', 'Engineered by Under Armour. The Fleece Zip Hoodie comes equipped All-Weather Thermal Lining. Designed for superior performance, premium durability, and daily reliability.', 165.32, 64, 'https://images.unsplash.com/photo-1521572267360-ee0c2909d518?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Fashion' LIMIT 1), '10000000-0000-0000-0000-000000000002'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000174');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000175', 'The North Face Puffer Winter Vest - Edition 05', 'Engineered by The North Face. The Puffer Winter Vest comes equipped Hand-Crafted Italian Stitching. Designed for superior performance, premium durability, and daily reliability.', 171.73, 77, 'https://images.unsplash.com/photo-1576995853123-5a10305d93c0?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Fashion' LIMIT 1), '10000000-0000-0000-0000-000000000002'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000175');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000176', 'Nike Classic Denim Jacket - Edition 06', 'Engineered by Nike. The Classic Denim Jacket comes equipped Anti-Crease Performance Fabric. Designed for superior performance, premium durability, and daily reliability.', 178.14, 90, 'https://images.unsplash.com/photo-1608231387042-66d1773070a5?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Fashion' LIMIT 1), '10000000-0000-0000-0000-000000000002'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000176');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000177', 'Levi''s Running Sneakers - Edition 07', 'Engineered by Levi''s. The Running Sneakers comes equipped UV400 Protection Lenses. Designed for superior performance, premium durability, and daily reliability.', 184.55, 18, 'https://images.unsplash.com/photo-1509695503495-ac9986b51052?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Fashion' LIMIT 1), '10000000-0000-0000-0000-000000000002'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000177');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000178', 'Adidas Leather Crossbody Bag - Edition 08', 'Engineered by Adidas. The Leather Crossbody Bag comes equipped Water-Repellent DWR Finish. Designed for superior performance, premium durability, and daily reliability.', 190.96, 31, 'https://images.unsplash.com/photo-1551028719-00167b16eac5?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Fashion' LIMIT 1), '10000000-0000-0000-0000-000000000002'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000178');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000179', 'Zara Organic Cotton T-Shirt - Edition 09', 'Engineered by Zara. The Organic Cotton T-Shirt comes equipped Tailored Modern Silhouette. Designed for superior performance, premium durability, and daily reliability.', 197.36, 44, 'https://images.unsplash.com/photo-1543163521-1bf539c55dd2?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Fashion' LIMIT 1), '10000000-0000-0000-0000-000000000002'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000179');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000180', 'Ralph Lauren Merino Wool Sweater - Edition 10', 'Engineered by Ralph Lauren. The Merino Wool Sweater comes equipped Vintage Indigo Wash. Designed for superior performance, premium durability, and daily reliability.', 182.07, 57, 'https://images.unsplash.com/photo-1594938298603-c8148c4dae35?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Fashion' LIMIT 1), '10000000-0000-0000-0000-000000000002'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000180');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000181', 'Tommy Hilfiger Tailored Chino Pants - Edition 11', 'Engineered by Tommy Hilfiger. The Tailored Chino Pants comes equipped 100% Breathable Combed Cotton. Designed for superior performance, premium durability, and daily reliability.', 188.48, 70, 'https://images.unsplash.com/photo-1542291026-7eec264c27ff?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Fashion' LIMIT 1), '10000000-0000-0000-0000-000000000002'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000181');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000182', 'Calvin Klein Polarized Sunglasses - Edition 12', 'Engineered by Calvin Klein. The Polarized Sunglasses comes equipped Genuine Full-Grain Leather. Designed for superior performance, premium durability, and daily reliability.', 194.89, 83, 'https://images.unsplash.com/photo-1584917865442-de89df76afd3?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Fashion' LIMIT 1), '10000000-0000-0000-0000-000000000002'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000182');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000183', 'Gucci Silk Evening Scarf - Edition 13', 'Engineered by Gucci. The Silk Evening Scarf comes equipped Reflective Night Running Accents. Designed for superior performance, premium durability, and daily reliability.', 201.29, 96, 'https://images.unsplash.com/photo-1591047139829-d91aecb6caea?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Fashion' LIMIT 1), '10000000-0000-0000-0000-000000000002'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000183');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000184', 'Uniqlo Waterproof Parka - Edition 14', 'Engineered by Uniqlo. The Waterproof Parka comes equipped All-Weather Thermal Lining. Designed for superior performance, premium durability, and daily reliability.', 207.7, 24, 'https://images.unsplash.com/photo-1521572267360-ee0c2909d518?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Fashion' LIMIT 1), '10000000-0000-0000-0000-000000000002'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000184');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000185', 'Puma Canvas High-Top Shoes - Edition 15', 'Engineered by Puma. The Canvas High-Top Shoes comes equipped Hand-Crafted Italian Stitching. Designed for superior performance, premium durability, and daily reliability.', 214.11, 37, 'https://images.unsplash.com/photo-1576995853123-5a10305d93c0?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Fashion' LIMIT 1), '10000000-0000-0000-0000-000000000002'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000185');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000186', 'Patagonia Slim Fit Dress Shirt - Edition 16', 'Engineered by Patagonia. The Slim Fit Dress Shirt comes equipped Anti-Crease Performance Fabric. Designed for superior performance, premium durability, and daily reliability.', 220.52, 50, 'https://images.unsplash.com/photo-1608231387042-66d1773070a5?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Fashion' LIMIT 1), '10000000-0000-0000-0000-000000000002'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000186');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000187', 'Ray-Ban Minimalist Chronograph Watch - Edition 17', 'Engineered by Ray-Ban. The Minimalist Chronograph Watch comes equipped UV400 Protection Lenses. Designed for superior performance, premium durability, and daily reliability.', 205.23, 63, 'https://images.unsplash.com/photo-1509695503495-ac9986b51052?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Fashion' LIMIT 1), '10000000-0000-0000-0000-000000000002'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000187');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000188', 'Coach Casual Chelsea Boots - Edition 18', 'Engineered by Coach. The Casual Chelsea Boots comes equipped Water-Repellent DWR Finish. Designed for superior performance, premium durability, and daily reliability.', 211.63, 76, 'https://images.unsplash.com/photo-1551028719-00167b16eac5?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Fashion' LIMIT 1), '10000000-0000-0000-0000-000000000002'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000188');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000189', 'Under Armour Fleece Zip Hoodie - Edition 19', 'Engineered by Under Armour. The Fleece Zip Hoodie comes equipped Tailored Modern Silhouette. Designed for superior performance, premium durability, and daily reliability.', 218.04, 89, 'https://images.unsplash.com/photo-1543163521-1bf539c55dd2?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Fashion' LIMIT 1), '10000000-0000-0000-0000-000000000002'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000189');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000190', 'The North Face Puffer Winter Vest - Edition 20', 'Engineered by The North Face. The Puffer Winter Vest comes equipped Vintage Indigo Wash. Designed for superior performance, premium durability, and daily reliability.', 224.45, 17, 'https://images.unsplash.com/photo-1594938298603-c8148c4dae35?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Fashion' LIMIT 1), '10000000-0000-0000-0000-000000000002'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000190');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000191', 'Nike Classic Denim Jacket - Edition 01', 'Engineered by Nike. The Classic Denim Jacket comes equipped 100% Breathable Combed Cotton. Designed for superior performance, premium durability, and daily reliability.', 230.86, 30, 'https://images.unsplash.com/photo-1542291026-7eec264c27ff?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Fashion' LIMIT 1), '10000000-0000-0000-0000-000000000002'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000191');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000192', 'Levi''s Running Sneakers - Edition 02', 'Engineered by Levi''s. The Running Sneakers comes equipped Genuine Full-Grain Leather. Designed for superior performance, premium durability, and daily reliability.', 237.26, 43, 'https://images.unsplash.com/photo-1584917865442-de89df76afd3?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Fashion' LIMIT 1), '10000000-0000-0000-0000-000000000002'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000192');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000193', 'Adidas Leather Crossbody Bag - Edition 03', 'Engineered by Adidas. The Leather Crossbody Bag comes equipped Reflective Night Running Accents. Designed for superior performance, premium durability, and daily reliability.', 243.67, 56, 'https://images.unsplash.com/photo-1591047139829-d91aecb6caea?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Fashion' LIMIT 1), '10000000-0000-0000-0000-000000000002'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000193');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000194', 'Zara Organic Cotton T-Shirt - Edition 04', 'Engineered by Zara. The Organic Cotton T-Shirt comes equipped All-Weather Thermal Lining. Designed for superior performance, premium durability, and daily reliability.', 228.38, 69, 'https://images.unsplash.com/photo-1521572267360-ee0c2909d518?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Fashion' LIMIT 1), '10000000-0000-0000-0000-000000000002'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000194');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000195', 'Ralph Lauren Merino Wool Sweater - Edition 05', 'Engineered by Ralph Lauren. The Merino Wool Sweater comes equipped Hand-Crafted Italian Stitching. Designed for superior performance, premium durability, and daily reliability.', 234.79, 82, 'https://images.unsplash.com/photo-1576995853123-5a10305d93c0?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Fashion' LIMIT 1), '10000000-0000-0000-0000-000000000002'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000195');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000196', 'Tommy Hilfiger Tailored Chino Pants - Edition 06', 'Engineered by Tommy Hilfiger. The Tailored Chino Pants comes equipped Anti-Crease Performance Fabric. Designed for superior performance, premium durability, and daily reliability.', 241.19, 95, 'https://images.unsplash.com/photo-1608231387042-66d1773070a5?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Fashion' LIMIT 1), '10000000-0000-0000-0000-000000000002'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000196');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000197', 'Calvin Klein Polarized Sunglasses - Edition 07', 'Engineered by Calvin Klein. The Polarized Sunglasses comes equipped UV400 Protection Lenses. Designed for superior performance, premium durability, and daily reliability.', 247.6, 23, 'https://images.unsplash.com/photo-1509695503495-ac9986b51052?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Fashion' LIMIT 1), '10000000-0000-0000-0000-000000000002'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000197');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000198', 'Gucci Silk Evening Scarf - Edition 08', 'Engineered by Gucci. The Silk Evening Scarf comes equipped Water-Repellent DWR Finish. Designed for superior performance, premium durability, and daily reliability.', 254.01, 36, 'https://images.unsplash.com/photo-1551028719-00167b16eac5?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Fashion' LIMIT 1), '10000000-0000-0000-0000-000000000002'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000198');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000199', 'Uniqlo Waterproof Parka - Edition 09', 'Engineered by Uniqlo. The Waterproof Parka comes equipped Tailored Modern Silhouette. Designed for superior performance, premium durability, and daily reliability.', 260.42, 49, 'https://images.unsplash.com/photo-1543163521-1bf539c55dd2?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Fashion' LIMIT 1), '10000000-0000-0000-0000-000000000002'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000199');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000200', 'Puma Canvas High-Top Shoes - Edition 10', 'Engineered by Puma. The Canvas High-Top Shoes comes equipped Vintage Indigo Wash. Designed for superior performance, premium durability, and daily reliability.', 266.83, 62, 'https://images.unsplash.com/photo-1594938298603-c8148c4dae35?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Fashion' LIMIT 1), '10000000-0000-0000-0000-000000000002'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000200');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000201', 'Patagonia Slim Fit Dress Shirt - Edition 11', 'Engineered by Patagonia. The Slim Fit Dress Shirt comes equipped 100% Breathable Combed Cotton. Designed for superior performance, premium durability, and daily reliability.', 251.53, 75, 'https://images.unsplash.com/photo-1542291026-7eec264c27ff?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Fashion' LIMIT 1), '10000000-0000-0000-0000-000000000002'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000201');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000202', 'Ray-Ban Minimalist Chronograph Watch - Edition 12', 'Engineered by Ray-Ban. The Minimalist Chronograph Watch comes equipped Genuine Full-Grain Leather. Designed for superior performance, premium durability, and daily reliability.', 257.94, 88, 'https://images.unsplash.com/photo-1584917865442-de89df76afd3?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Fashion' LIMIT 1), '10000000-0000-0000-0000-000000000002'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000202');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000203', 'Coach Casual Chelsea Boots - Edition 13', 'Engineered by Coach. The Casual Chelsea Boots comes equipped Reflective Night Running Accents. Designed for superior performance, premium durability, and daily reliability.', 264.35, 16, 'https://images.unsplash.com/photo-1591047139829-d91aecb6caea?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Fashion' LIMIT 1), '10000000-0000-0000-0000-000000000002'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000203');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000204', 'Under Armour Fleece Zip Hoodie - Edition 14', 'Engineered by Under Armour. The Fleece Zip Hoodie comes equipped All-Weather Thermal Lining. Designed for superior performance, premium durability, and daily reliability.', 270.76, 29, 'https://images.unsplash.com/photo-1521572267360-ee0c2909d518?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Fashion' LIMIT 1), '10000000-0000-0000-0000-000000000002'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000204');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000205', 'The North Face Puffer Winter Vest - Edition 15', 'Engineered by The North Face. The Puffer Winter Vest comes equipped Hand-Crafted Italian Stitching. Designed for superior performance, premium durability, and daily reliability.', 277.16, 42, 'https://images.unsplash.com/photo-1576995853123-5a10305d93c0?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Fashion' LIMIT 1), '10000000-0000-0000-0000-000000000002'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000205');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000206', 'Nike Classic Denim Jacket - Edition 16', 'Engineered by Nike. The Classic Denim Jacket comes equipped Anti-Crease Performance Fabric. Designed for superior performance, premium durability, and daily reliability.', 283.57, 55, 'https://images.unsplash.com/photo-1608231387042-66d1773070a5?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Fashion' LIMIT 1), '10000000-0000-0000-0000-000000000002'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000206');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000207', 'Levi''s Running Sneakers - Edition 17', 'Engineered by Levi''s. The Running Sneakers comes equipped UV400 Protection Lenses. Designed for superior performance, premium durability, and daily reliability.', 289.98, 68, 'https://images.unsplash.com/photo-1509695503495-ac9986b51052?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Fashion' LIMIT 1), '10000000-0000-0000-0000-000000000002'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000207');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000208', 'Adidas Leather Crossbody Bag - Edition 18', 'Engineered by Adidas. The Leather Crossbody Bag comes equipped Water-Repellent DWR Finish. Designed for superior performance, premium durability, and daily reliability.', 274.69, 81, 'https://images.unsplash.com/photo-1551028719-00167b16eac5?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Fashion' LIMIT 1), '10000000-0000-0000-0000-000000000002'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000208');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000209', 'Zara Organic Cotton T-Shirt - Edition 19', 'Engineered by Zara. The Organic Cotton T-Shirt comes equipped Tailored Modern Silhouette. Designed for superior performance, premium durability, and daily reliability.', 281.1, 94, 'https://images.unsplash.com/photo-1543163521-1bf539c55dd2?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Fashion' LIMIT 1), '10000000-0000-0000-0000-000000000002'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000209');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000210', 'Ralph Lauren Merino Wool Sweater - Edition 20', 'Engineered by Ralph Lauren. The Merino Wool Sweater comes equipped Vintage Indigo Wash. Designed for superior performance, premium durability, and daily reliability.', 287.5, 22, 'https://images.unsplash.com/photo-1594938298603-c8148c4dae35?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Fashion' LIMIT 1), '10000000-0000-0000-0000-000000000002'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000210');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000211', 'Tommy Hilfiger Tailored Chino Pants - Edition 01', 'Engineered by Tommy Hilfiger. The Tailored Chino Pants comes equipped 100% Breathable Combed Cotton. Designed for superior performance, premium durability, and daily reliability.', 293.91, 35, 'https://images.unsplash.com/photo-1542291026-7eec264c27ff?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Fashion' LIMIT 1), '10000000-0000-0000-0000-000000000002'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000211');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000212', 'Calvin Klein Polarized Sunglasses - Edition 02', 'Engineered by Calvin Klein. The Polarized Sunglasses comes equipped Genuine Full-Grain Leather. Designed for superior performance, premium durability, and daily reliability.', 300.32, 48, 'https://images.unsplash.com/photo-1584917865442-de89df76afd3?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Fashion' LIMIT 1), '10000000-0000-0000-0000-000000000002'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000212');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000213', 'Gucci Silk Evening Scarf - Edition 03', 'Engineered by Gucci. The Silk Evening Scarf comes equipped Reflective Night Running Accents. Designed for superior performance, premium durability, and daily reliability.', 306.73, 61, 'https://images.unsplash.com/photo-1591047139829-d91aecb6caea?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Fashion' LIMIT 1), '10000000-0000-0000-0000-000000000002'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000213');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000214', 'Uniqlo Waterproof Parka - Edition 04', 'Engineered by Uniqlo. The Waterproof Parka comes equipped All-Weather Thermal Lining. Designed for superior performance, premium durability, and daily reliability.', 313.13, 74, 'https://images.unsplash.com/photo-1521572267360-ee0c2909d518?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Fashion' LIMIT 1), '10000000-0000-0000-0000-000000000002'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000214');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000215', 'Puma Canvas High-Top Shoes - Edition 05', 'Engineered by Puma. The Canvas High-Top Shoes comes equipped Hand-Crafted Italian Stitching. Designed for superior performance, premium durability, and daily reliability.', 297.84, 87, 'https://images.unsplash.com/photo-1576995853123-5a10305d93c0?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Fashion' LIMIT 1), '10000000-0000-0000-0000-000000000002'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000215');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000216', 'Patagonia Slim Fit Dress Shirt - Edition 06', 'Engineered by Patagonia. The Slim Fit Dress Shirt comes equipped Anti-Crease Performance Fabric. Designed for superior performance, premium durability, and daily reliability.', 304.25, 15, 'https://images.unsplash.com/photo-1608231387042-66d1773070a5?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Fashion' LIMIT 1), '10000000-0000-0000-0000-000000000002'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000216');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000217', 'Ray-Ban Minimalist Chronograph Watch - Edition 07', 'Engineered by Ray-Ban. The Minimalist Chronograph Watch comes equipped UV400 Protection Lenses. Designed for superior performance, premium durability, and daily reliability.', 310.66, 28, 'https://images.unsplash.com/photo-1509695503495-ac9986b51052?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Fashion' LIMIT 1), '10000000-0000-0000-0000-000000000002'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000217');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000218', 'Coach Casual Chelsea Boots - Edition 08', 'Engineered by Coach. The Casual Chelsea Boots comes equipped Water-Repellent DWR Finish. Designed for superior performance, premium durability, and daily reliability.', 317.07, 41, 'https://images.unsplash.com/photo-1551028719-00167b16eac5?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Fashion' LIMIT 1), '10000000-0000-0000-0000-000000000002'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000218');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000219', 'Under Armour Fleece Zip Hoodie - Edition 09', 'Engineered by Under Armour. The Fleece Zip Hoodie comes equipped Tailored Modern Silhouette. Designed for superior performance, premium durability, and daily reliability.', 323.47, 54, 'https://images.unsplash.com/photo-1543163521-1bf539c55dd2?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Fashion' LIMIT 1), '10000000-0000-0000-0000-000000000002'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000219');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000220', 'The North Face Puffer Winter Vest - Edition 10', 'Engineered by The North Face. The Puffer Winter Vest comes equipped Vintage Indigo Wash. Designed for superior performance, premium durability, and daily reliability.', 329.88, 67, 'https://images.unsplash.com/photo-1594938298603-c8148c4dae35?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Fashion' LIMIT 1), '10000000-0000-0000-0000-000000000002'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000220');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000221', 'Nike Classic Denim Jacket - Edition 11', 'Engineered by Nike. The Classic Denim Jacket comes equipped 100% Breathable Combed Cotton. Designed for superior performance, premium durability, and daily reliability.', 336.29, 80, 'https://images.unsplash.com/photo-1542291026-7eec264c27ff?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Fashion' LIMIT 1), '10000000-0000-0000-0000-000000000002'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000221');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000222', 'Levi''s Running Sneakers - Edition 12', 'Engineered by Levi''s. The Running Sneakers comes equipped Genuine Full-Grain Leather. Designed for superior performance, premium durability, and daily reliability.', 321.0, 93, 'https://images.unsplash.com/photo-1584917865442-de89df76afd3?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Fashion' LIMIT 1), '10000000-0000-0000-0000-000000000002'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000222');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000223', 'Adidas Leather Crossbody Bag - Edition 13', 'Engineered by Adidas. The Leather Crossbody Bag comes equipped Reflective Night Running Accents. Designed for superior performance, premium durability, and daily reliability.', 327.4, 21, 'https://images.unsplash.com/photo-1591047139829-d91aecb6caea?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Fashion' LIMIT 1), '10000000-0000-0000-0000-000000000002'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000223');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000224', 'Zara Organic Cotton T-Shirt - Edition 14', 'Engineered by Zara. The Organic Cotton T-Shirt comes equipped All-Weather Thermal Lining. Designed for superior performance, premium durability, and daily reliability.', 333.81, 34, 'https://images.unsplash.com/photo-1521572267360-ee0c2909d518?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Fashion' LIMIT 1), '10000000-0000-0000-0000-000000000002'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000224');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000225', 'Ralph Lauren Merino Wool Sweater - Edition 15', 'Engineered by Ralph Lauren. The Merino Wool Sweater comes equipped Hand-Crafted Italian Stitching. Designed for superior performance, premium durability, and daily reliability.', 340.22, 47, 'https://images.unsplash.com/photo-1576995853123-5a10305d93c0?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Fashion' LIMIT 1), '10000000-0000-0000-0000-000000000002'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000225');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000226', 'Tommy Hilfiger Tailored Chino Pants - Edition 16', 'Engineered by Tommy Hilfiger. The Tailored Chino Pants comes equipped Anti-Crease Performance Fabric. Designed for superior performance, premium durability, and daily reliability.', 346.63, 60, 'https://images.unsplash.com/photo-1608231387042-66d1773070a5?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Fashion' LIMIT 1), '10000000-0000-0000-0000-000000000002'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000226');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000227', 'Calvin Klein Polarized Sunglasses - Edition 17', 'Engineered by Calvin Klein. The Polarized Sunglasses comes equipped UV400 Protection Lenses. Designed for superior performance, premium durability, and daily reliability.', 353.04, 73, 'https://images.unsplash.com/photo-1509695503495-ac9986b51052?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Fashion' LIMIT 1), '10000000-0000-0000-0000-000000000002'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000227');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000228', 'Gucci Silk Evening Scarf - Edition 18', 'Engineered by Gucci. The Silk Evening Scarf comes equipped Water-Repellent DWR Finish. Designed for superior performance, premium durability, and daily reliability.', 359.44, 86, 'https://images.unsplash.com/photo-1551028719-00167b16eac5?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Fashion' LIMIT 1), '10000000-0000-0000-0000-000000000002'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000228');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000229', 'Uniqlo Waterproof Parka - Edition 19', 'Engineered by Uniqlo. The Waterproof Parka comes equipped Tailored Modern Silhouette. Designed for superior performance, premium durability, and daily reliability.', 344.15, 99, 'https://images.unsplash.com/photo-1543163521-1bf539c55dd2?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Fashion' LIMIT 1), '10000000-0000-0000-0000-000000000002'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000229');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000230', 'Puma Canvas High-Top Shoes - Edition 20', 'Engineered by Puma. The Canvas High-Top Shoes comes equipped Vintage Indigo Wash. Designed for superior performance, premium durability, and daily reliability.', 350.56, 27, 'https://images.unsplash.com/photo-1594938298603-c8148c4dae35?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Fashion' LIMIT 1), '10000000-0000-0000-0000-000000000002'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000230');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000231', 'Patagonia Slim Fit Dress Shirt - Edition 01', 'Engineered by Patagonia. The Slim Fit Dress Shirt comes equipped 100% Breathable Combed Cotton. Designed for superior performance, premium durability, and daily reliability.', 356.97, 40, 'https://images.unsplash.com/photo-1542291026-7eec264c27ff?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Fashion' LIMIT 1), '10000000-0000-0000-0000-000000000002'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000231');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000232', 'Ray-Ban Minimalist Chronograph Watch - Edition 02', 'Engineered by Ray-Ban. The Minimalist Chronograph Watch comes equipped Genuine Full-Grain Leather. Designed for superior performance, premium durability, and daily reliability.', 363.37, 53, 'https://images.unsplash.com/photo-1584917865442-de89df76afd3?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Fashion' LIMIT 1), '10000000-0000-0000-0000-000000000002'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000232');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000233', 'Coach Casual Chelsea Boots - Edition 03', 'Engineered by Coach. The Casual Chelsea Boots comes equipped Reflective Night Running Accents. Designed for superior performance, premium durability, and daily reliability.', 369.78, 66, 'https://images.unsplash.com/photo-1591047139829-d91aecb6caea?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Fashion' LIMIT 1), '10000000-0000-0000-0000-000000000002'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000233');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000234', 'Under Armour Fleece Zip Hoodie - Edition 04', 'Engineered by Under Armour. The Fleece Zip Hoodie comes equipped All-Weather Thermal Lining. Designed for superior performance, premium durability, and daily reliability.', 376.19, 79, 'https://images.unsplash.com/photo-1521572267360-ee0c2909d518?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Fashion' LIMIT 1), '10000000-0000-0000-0000-000000000002'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000234');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000235', 'The North Face Puffer Winter Vest - Edition 05', 'Engineered by The North Face. The Puffer Winter Vest comes equipped Hand-Crafted Italian Stitching. Designed for superior performance, premium durability, and daily reliability.', 382.6, 92, 'https://images.unsplash.com/photo-1576995853123-5a10305d93c0?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Fashion' LIMIT 1), '10000000-0000-0000-0000-000000000002'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000235');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000236', 'Nike Classic Denim Jacket - Edition 06', 'Engineered by Nike. The Classic Denim Jacket comes equipped Anti-Crease Performance Fabric. Designed for superior performance, premium durability, and daily reliability.', 367.31, 20, 'https://images.unsplash.com/photo-1608231387042-66d1773070a5?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Fashion' LIMIT 1), '10000000-0000-0000-0000-000000000002'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000236');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000237', 'Levi''s Running Sneakers - Edition 07', 'Engineered by Levi''s. The Running Sneakers comes equipped UV400 Protection Lenses. Designed for superior performance, premium durability, and daily reliability.', 373.71, 33, 'https://images.unsplash.com/photo-1509695503495-ac9986b51052?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Fashion' LIMIT 1), '10000000-0000-0000-0000-000000000002'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000237');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000238', 'Adidas Leather Crossbody Bag - Edition 08', 'Engineered by Adidas. The Leather Crossbody Bag comes equipped Water-Repellent DWR Finish. Designed for superior performance, premium durability, and daily reliability.', 380.12, 46, 'https://images.unsplash.com/photo-1551028719-00167b16eac5?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Fashion' LIMIT 1), '10000000-0000-0000-0000-000000000002'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000238');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000239', 'Zara Organic Cotton T-Shirt - Edition 09', 'Engineered by Zara. The Organic Cotton T-Shirt comes equipped Tailored Modern Silhouette. Designed for superior performance, premium durability, and daily reliability.', 386.53, 59, 'https://images.unsplash.com/photo-1543163521-1bf539c55dd2?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Fashion' LIMIT 1), '10000000-0000-0000-0000-000000000002'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000239');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000240', 'Ralph Lauren Merino Wool Sweater - Edition 10', 'Engineered by Ralph Lauren. The Merino Wool Sweater comes equipped Vintage Indigo Wash. Designed for superior performance, premium durability, and daily reliability.', 392.94, 72, 'https://images.unsplash.com/photo-1594938298603-c8148c4dae35?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Fashion' LIMIT 1), '10000000-0000-0000-0000-000000000002'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000240');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000241', 'Tommy Hilfiger Tailored Chino Pants - Edition 11', 'Engineered by Tommy Hilfiger. The Tailored Chino Pants comes equipped 100% Breathable Combed Cotton. Designed for superior performance, premium durability, and daily reliability.', 399.34, 85, 'https://images.unsplash.com/photo-1542291026-7eec264c27ff?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Fashion' LIMIT 1), '10000000-0000-0000-0000-000000000002'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000241');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000242', 'Calvin Klein Polarized Sunglasses - Edition 12', 'Engineered by Calvin Klein. The Polarized Sunglasses comes equipped Genuine Full-Grain Leather. Designed for superior performance, premium durability, and daily reliability.', 405.75, 98, 'https://images.unsplash.com/photo-1584917865442-de89df76afd3?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Fashion' LIMIT 1), '10000000-0000-0000-0000-000000000002'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000242');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000243', 'Gucci Silk Evening Scarf - Edition 13', 'Engineered by Gucci. The Silk Evening Scarf comes equipped Reflective Night Running Accents. Designed for superior performance, premium durability, and daily reliability.', 390.46, 26, 'https://images.unsplash.com/photo-1591047139829-d91aecb6caea?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Fashion' LIMIT 1), '10000000-0000-0000-0000-000000000002'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000243');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000244', 'Uniqlo Waterproof Parka - Edition 14', 'Engineered by Uniqlo. The Waterproof Parka comes equipped All-Weather Thermal Lining. Designed for superior performance, premium durability, and daily reliability.', 396.87, 39, 'https://images.unsplash.com/photo-1521572267360-ee0c2909d518?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Fashion' LIMIT 1), '10000000-0000-0000-0000-000000000002'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000244');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000245', 'Puma Canvas High-Top Shoes - Edition 15', 'Engineered by Puma. The Canvas High-Top Shoes comes equipped Hand-Crafted Italian Stitching. Designed for superior performance, premium durability, and daily reliability.', 403.28, 52, 'https://images.unsplash.com/photo-1576995853123-5a10305d93c0?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Fashion' LIMIT 1), '10000000-0000-0000-0000-000000000002'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000245');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000246', 'Patagonia Slim Fit Dress Shirt - Edition 16', 'Engineered by Patagonia. The Slim Fit Dress Shirt comes equipped Anti-Crease Performance Fabric. Designed for superior performance, premium durability, and daily reliability.', 409.68, 65, 'https://images.unsplash.com/photo-1608231387042-66d1773070a5?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Fashion' LIMIT 1), '10000000-0000-0000-0000-000000000002'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000246');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000247', 'Ray-Ban Minimalist Chronograph Watch - Edition 17', 'Engineered by Ray-Ban. The Minimalist Chronograph Watch comes equipped UV400 Protection Lenses. Designed for superior performance, premium durability, and daily reliability.', 416.09, 78, 'https://images.unsplash.com/photo-1509695503495-ac9986b51052?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Fashion' LIMIT 1), '10000000-0000-0000-0000-000000000002'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000247');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000248', 'Coach Casual Chelsea Boots - Edition 18', 'Engineered by Coach. The Casual Chelsea Boots comes equipped Water-Repellent DWR Finish. Designed for superior performance, premium durability, and daily reliability.', 422.5, 91, 'https://images.unsplash.com/photo-1551028719-00167b16eac5?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Fashion' LIMIT 1), '10000000-0000-0000-0000-000000000002'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000248');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000249', 'Under Armour Fleece Zip Hoodie - Edition 19', 'Engineered by Under Armour. The Fleece Zip Hoodie comes equipped Tailored Modern Silhouette. Designed for superior performance, premium durability, and daily reliability.', 428.91, 19, 'https://images.unsplash.com/photo-1543163521-1bf539c55dd2?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Fashion' LIMIT 1), '10000000-0000-0000-0000-000000000002'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000249');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000250', 'The North Face Puffer Winter Vest - Edition 20', 'Engineered by The North Face. The Puffer Winter Vest comes equipped Vintage Indigo Wash. Designed for superior performance, premium durability, and daily reliability.', 413.61, 32, 'https://images.unsplash.com/photo-1594938298603-c8148c4dae35?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Fashion' LIMIT 1), '10000000-0000-0000-0000-000000000002'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000250');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000251', 'Nike Classic Denim Jacket - Edition 01', 'Engineered by Nike. The Classic Denim Jacket comes equipped 100% Breathable Combed Cotton. Designed for superior performance, premium durability, and daily reliability.', 420.02, 45, 'https://images.unsplash.com/photo-1542291026-7eec264c27ff?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Fashion' LIMIT 1), '10000000-0000-0000-0000-000000000002'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000251');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000252', 'Levi''s Running Sneakers - Edition 02', 'Engineered by Levi''s. The Running Sneakers comes equipped Genuine Full-Grain Leather. Designed for superior performance, premium durability, and daily reliability.', 426.43, 58, 'https://images.unsplash.com/photo-1584917865442-de89df76afd3?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Fashion' LIMIT 1), '10000000-0000-0000-0000-000000000002'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000252');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000253', 'Adidas Leather Crossbody Bag - Edition 03', 'Engineered by Adidas. The Leather Crossbody Bag comes equipped Reflective Night Running Accents. Designed for superior performance, premium durability, and daily reliability.', 432.84, 71, 'https://images.unsplash.com/photo-1591047139829-d91aecb6caea?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Fashion' LIMIT 1), '10000000-0000-0000-0000-000000000002'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000253');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000254', 'Zara Organic Cotton T-Shirt - Edition 04', 'Engineered by Zara. The Organic Cotton T-Shirt comes equipped All-Weather Thermal Lining. Designed for superior performance, premium durability, and daily reliability.', 439.25, 84, 'https://images.unsplash.com/photo-1521572267360-ee0c2909d518?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Fashion' LIMIT 1), '10000000-0000-0000-0000-000000000002'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000254');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000255', 'Ralph Lauren Merino Wool Sweater - Edition 05', 'Engineered by Ralph Lauren. The Merino Wool Sweater comes equipped Hand-Crafted Italian Stitching. Designed for superior performance, premium durability, and daily reliability.', 445.65, 97, 'https://images.unsplash.com/photo-1576995853123-5a10305d93c0?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Fashion' LIMIT 1), '10000000-0000-0000-0000-000000000002'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000255');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000256', 'Tommy Hilfiger Tailored Chino Pants - Edition 06', 'Engineered by Tommy Hilfiger. The Tailored Chino Pants comes equipped Anti-Crease Performance Fabric. Designed for superior performance, premium durability, and daily reliability.', 450.0, 25, 'https://images.unsplash.com/photo-1608231387042-66d1773070a5?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Fashion' LIMIT 1), '10000000-0000-0000-0000-000000000002'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000256');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000257', 'Calvin Klein Polarized Sunglasses - Edition 07', 'Engineered by Calvin Klein. The Polarized Sunglasses comes equipped UV400 Protection Lenses. Designed for superior performance, premium durability, and daily reliability.', 436.77, 38, 'https://images.unsplash.com/photo-1509695503495-ac9986b51052?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Fashion' LIMIT 1), '10000000-0000-0000-0000-000000000002'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000257');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000258', 'Gucci Silk Evening Scarf - Edition 08', 'Engineered by Gucci. The Silk Evening Scarf comes equipped Water-Repellent DWR Finish. Designed for superior performance, premium durability, and daily reliability.', 443.18, 51, 'https://images.unsplash.com/photo-1551028719-00167b16eac5?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Fashion' LIMIT 1), '10000000-0000-0000-0000-000000000002'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000258');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000259', 'Uniqlo Waterproof Parka - Edition 09', 'Engineered by Uniqlo. The Waterproof Parka comes equipped Tailored Modern Silhouette. Designed for superior performance, premium durability, and daily reliability.', 449.58, 64, 'https://images.unsplash.com/photo-1543163521-1bf539c55dd2?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Fashion' LIMIT 1), '10000000-0000-0000-0000-000000000002'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000259');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000260', 'Puma Canvas High-Top Shoes - Edition 10', 'Engineered by Puma. The Canvas High-Top Shoes comes equipped Vintage Indigo Wash. Designed for superior performance, premium durability, and daily reliability.', 446.0, 77, 'https://images.unsplash.com/photo-1594938298603-c8148c4dae35?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Fashion' LIMIT 1), '10000000-0000-0000-0000-000000000002'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000260');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000261', 'IKEA Barista Espresso Machine - Edition 01', 'Engineered by IKEA. The Barista Espresso Machine comes equipped Enamelled Non-Stick Coating. Designed for superior performance, premium durability, and daily reliability.', 24.99, 15, 'https://images.unsplash.com/photo-1513694203232-719a280e022f?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Home & Living' LIMIT 1), '10000000-0000-0000-0000-000000000003'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000261');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000262', 'Breville Ergonomic Desk Chair - Edition 02', 'Engineered by Breville. The Ergonomic Desk Chair comes equipped HEPA Filtration System. Designed for superior performance, premium durability, and daily reliability.', 34.81, 28, 'https://images.unsplash.com/photo-1586023492125-27b2c045efd7?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Home & Living' LIMIT 1), '10000000-0000-0000-0000-000000000003'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000262');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000263', 'Dyson Cast Iron Dutch Oven - Edition 03', 'Engineered by Dyson. The Cast Iron Dutch Oven comes equipped Dimmer Touch & App Control. Designed for superior performance, premium durability, and daily reliability.', 44.64, 41, 'https://images.unsplash.com/photo-1538688525198-9b88f6f53126?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Home & Living' LIMIT 1), '10000000-0000-0000-0000-000000000003'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000263');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000264', 'KitchenAid Cordless Vacuum Cleaner - Edition 04', 'Engineered by KitchenAid. The Cordless Vacuum Cleaner comes equipped Handmade Artisan Stoneware. Designed for superior performance, premium durability, and daily reliability.', 54.46, 54, 'https://images.unsplash.com/photo-1583847268964-b28dc8f51f92?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Home & Living' LIMIT 1), '10000000-0000-0000-0000-000000000003'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000264');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000265', 'Philips Smart LED Floor Lamp - Edition 05', 'Engineered by Philips. The Smart LED Floor Lamp comes equipped Cooling Gel Infused Core. Designed for superior performance, premium durability, and daily reliability.', 64.28, 67, 'https://images.unsplash.com/photo-1507473885765-e6ed057f782c?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Home & Living' LIMIT 1), '10000000-0000-0000-0000-000000000003'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000265');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000266', 'West Elm Ceramic Dinnerware Set - Edition 06', 'Engineered by West Elm. The Ceramic Dinnerware Set comes equipped Whisper-Quiet Ultrasonic Mode. Designed for superior performance, premium durability, and daily reliability.', 74.11, 80, 'https://images.unsplash.com/photo-1513519245088-0e12902e5a38?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Home & Living' LIMIT 1), '10000000-0000-0000-0000-000000000003'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000266');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000267', 'Nespresso Memory Foam Pillow - Edition 07', 'Engineered by Nespresso. The Memory Foam Pillow comes equipped Pre-Seasoned Heavy Duty. Designed for superior performance, premium durability, and daily reliability.', 83.93, 93, 'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Home & Living' LIMIT 1), '10000000-0000-0000-0000-000000000003'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000267');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000268', 'Le Creuset Aromatherapy Diffuser - Edition 08', 'Engineered by Le Creuset. The Aromatherapy Diffuser comes equipped Dishwasher Safe & PFOA-Free. Designed for superior performance, premium durability, and daily reliability.', 72.05, 21, 'https://images.unsplash.com/photo-1540574163026-643ea20ade25?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Home & Living' LIMIT 1), '10000000-0000-0000-0000-000000000003'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000268');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000269', 'Cuisinart Air Fryer Convection Oven - Edition 09', 'Engineered by Cuisinart. The Air Fryer Convection Oven comes equipped 15-Bar High Pressure Extraction. Designed for superior performance, premium durability, and daily reliability.', 81.88, 34, 'https://images.unsplash.com/photo-1567016432779-094069958ea5?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Home & Living' LIMIT 1), '10000000-0000-0000-0000-000000000003'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000269');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000270', 'Herman Miller Walnut Coffee Table - Edition 10', 'Engineered by Herman Miller. The Walnut Coffee Table comes equipped Solid Scandinavian Oak Legs. Designed for superior performance, premium durability, and daily reliability.', 91.7, 47, 'https://images.unsplash.com/photo-1544816155-12df9643f363?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Home & Living' LIMIT 1), '10000000-0000-0000-0000-000000000003'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000270');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000271', 'Castlery Linen Bedding Sheet Set - Edition 11', 'Engineered by Castlery. The Linen Bedding Sheet Set comes equipped Enamelled Non-Stick Coating. Designed for superior performance, premium durability, and daily reliability.', 101.52, 60, 'https://images.unsplash.com/photo-1513694203232-719a280e022f?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Home & Living' LIMIT 1), '10000000-0000-0000-0000-000000000003'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000271');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000272', 'Lodge Stainless Steel Cookware - Edition 12', 'Engineered by Lodge. The Stainless Steel Cookware comes equipped HEPA Filtration System. Designed for superior performance, premium durability, and daily reliability.', 111.34, 73, 'https://images.unsplash.com/photo-1586023492125-27b2c045efd7?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Home & Living' LIMIT 1), '10000000-0000-0000-0000-000000000003'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000272');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000273', 'Ninja Automatic Milk Frother - Edition 13', 'Engineered by Ninja. The Automatic Milk Frother comes equipped Dimmer Touch & App Control. Designed for superior performance, premium durability, and daily reliability.', 121.17, 86, 'https://images.unsplash.com/photo-1538688525198-9b88f6f53126?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Home & Living' LIMIT 1), '10000000-0000-0000-0000-000000000003'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000273');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000274', 'Smeg Velvet Accent Armchair - Edition 14', 'Engineered by Smeg. The Velvet Accent Armchair comes equipped Handmade Artisan Stoneware. Designed for superior performance, premium durability, and daily reliability.', 130.99, 99, 'https://images.unsplash.com/photo-1583847268964-b28dc8f51f92?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Home & Living' LIMIT 1), '10000000-0000-0000-0000-000000000003'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000274');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000275', 'MUJI Electric Kettle with Temp Control - Edition 15', 'Engineered by MUJI. The Electric Kettle with Temp Control comes equipped Cooling Gel Infused Core. Designed for superior performance, premium durability, and daily reliability.', 119.11, 27, 'https://images.unsplash.com/photo-1507473885765-e6ed057f782c?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Home & Living' LIMIT 1), '10000000-0000-0000-0000-000000000003'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000275');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000276', 'IKEA Barista Espresso Machine - Edition 16', 'Engineered by IKEA. The Barista Espresso Machine comes equipped Whisper-Quiet Ultrasonic Mode. Designed for superior performance, premium durability, and daily reliability.', 128.94, 40, 'https://images.unsplash.com/photo-1513519245088-0e12902e5a38?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Home & Living' LIMIT 1), '10000000-0000-0000-0000-000000000003'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000276');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000277', 'Breville Ergonomic Desk Chair - Edition 17', 'Engineered by Breville. The Ergonomic Desk Chair comes equipped Pre-Seasoned Heavy Duty. Designed for superior performance, premium durability, and daily reliability.', 138.76, 53, 'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Home & Living' LIMIT 1), '10000000-0000-0000-0000-000000000003'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000277');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000278', 'Dyson Cast Iron Dutch Oven - Edition 18', 'Engineered by Dyson. The Cast Iron Dutch Oven comes equipped Dishwasher Safe & PFOA-Free. Designed for superior performance, premium durability, and daily reliability.', 148.58, 66, 'https://images.unsplash.com/photo-1540574163026-643ea20ade25?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Home & Living' LIMIT 1), '10000000-0000-0000-0000-000000000003'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000278');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000279', 'KitchenAid Cordless Vacuum Cleaner - Edition 19', 'Engineered by KitchenAid. The Cordless Vacuum Cleaner comes equipped 15-Bar High Pressure Extraction. Designed for superior performance, premium durability, and daily reliability.', 158.41, 79, 'https://images.unsplash.com/photo-1567016432779-094069958ea5?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Home & Living' LIMIT 1), '10000000-0000-0000-0000-000000000003'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000279');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000280', 'Philips Smart LED Floor Lamp - Edition 20', 'Engineered by Philips. The Smart LED Floor Lamp comes equipped Solid Scandinavian Oak Legs. Designed for superior performance, premium durability, and daily reliability.', 168.23, 92, 'https://images.unsplash.com/photo-1544816155-12df9643f363?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Home & Living' LIMIT 1), '10000000-0000-0000-0000-000000000003'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000280');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000281', 'West Elm Ceramic Dinnerware Set - Edition 01', 'Engineered by West Elm. The Ceramic Dinnerware Set comes equipped Enamelled Non-Stick Coating. Designed for superior performance, premium durability, and daily reliability.', 178.05, 20, 'https://images.unsplash.com/photo-1513694203232-719a280e022f?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Home & Living' LIMIT 1), '10000000-0000-0000-0000-000000000003'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000281');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000282', 'Nespresso Memory Foam Pillow - Edition 02', 'Engineered by Nespresso. The Memory Foam Pillow comes equipped HEPA Filtration System. Designed for superior performance, premium durability, and daily reliability.', 166.18, 33, 'https://images.unsplash.com/photo-1586023492125-27b2c045efd7?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Home & Living' LIMIT 1), '10000000-0000-0000-0000-000000000003'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000282');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000283', 'Le Creuset Aromatherapy Diffuser - Edition 03', 'Engineered by Le Creuset. The Aromatherapy Diffuser comes equipped Dimmer Touch & App Control. Designed for superior performance, premium durability, and daily reliability.', 176.0, 46, 'https://images.unsplash.com/photo-1538688525198-9b88f6f53126?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Home & Living' LIMIT 1), '10000000-0000-0000-0000-000000000003'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000283');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000284', 'Cuisinart Air Fryer Convection Oven - Edition 04', 'Engineered by Cuisinart. The Air Fryer Convection Oven comes equipped Handmade Artisan Stoneware. Designed for superior performance, premium durability, and daily reliability.', 185.82, 59, 'https://images.unsplash.com/photo-1583847268964-b28dc8f51f92?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Home & Living' LIMIT 1), '10000000-0000-0000-0000-000000000003'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000284');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000285', 'Herman Miller Walnut Coffee Table - Edition 05', 'Engineered by Herman Miller. The Walnut Coffee Table comes equipped Cooling Gel Infused Core. Designed for superior performance, premium durability, and daily reliability.', 195.65, 72, 'https://images.unsplash.com/photo-1507473885765-e6ed057f782c?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Home & Living' LIMIT 1), '10000000-0000-0000-0000-000000000003'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000285');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000286', 'Castlery Linen Bedding Sheet Set - Edition 06', 'Engineered by Castlery. The Linen Bedding Sheet Set comes equipped Whisper-Quiet Ultrasonic Mode. Designed for superior performance, premium durability, and daily reliability.', 205.47, 85, 'https://images.unsplash.com/photo-1513519245088-0e12902e5a38?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Home & Living' LIMIT 1), '10000000-0000-0000-0000-000000000003'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000286');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000287', 'Lodge Stainless Steel Cookware - Edition 07', 'Engineered by Lodge. The Stainless Steel Cookware comes equipped Pre-Seasoned Heavy Duty. Designed for superior performance, premium durability, and daily reliability.', 215.29, 98, 'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Home & Living' LIMIT 1), '10000000-0000-0000-0000-000000000003'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000287');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000288', 'Ninja Automatic Milk Frother - Edition 08', 'Engineered by Ninja. The Automatic Milk Frother comes equipped Dishwasher Safe & PFOA-Free. Designed for superior performance, premium durability, and daily reliability.', 225.12, 26, 'https://images.unsplash.com/photo-1540574163026-643ea20ade25?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Home & Living' LIMIT 1), '10000000-0000-0000-0000-000000000003'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000288');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000289', 'Smeg Velvet Accent Armchair - Edition 09', 'Engineered by Smeg. The Velvet Accent Armchair comes equipped 15-Bar High Pressure Extraction. Designed for superior performance, premium durability, and daily reliability.', 213.24, 39, 'https://images.unsplash.com/photo-1567016432779-094069958ea5?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Home & Living' LIMIT 1), '10000000-0000-0000-0000-000000000003'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000289');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000290', 'MUJI Electric Kettle with Temp Control - Edition 10', 'Engineered by MUJI. The Electric Kettle with Temp Control comes equipped Solid Scandinavian Oak Legs. Designed for superior performance, premium durability, and daily reliability.', 223.06, 52, 'https://images.unsplash.com/photo-1544816155-12df9643f363?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Home & Living' LIMIT 1), '10000000-0000-0000-0000-000000000003'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000290');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000291', 'IKEA Barista Espresso Machine - Edition 11', 'Engineered by IKEA. The Barista Espresso Machine comes equipped Enamelled Non-Stick Coating. Designed for superior performance, premium durability, and daily reliability.', 232.88, 65, 'https://images.unsplash.com/photo-1513694203232-719a280e022f?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Home & Living' LIMIT 1), '10000000-0000-0000-0000-000000000003'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000291');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000292', 'Breville Ergonomic Desk Chair - Edition 12', 'Engineered by Breville. The Ergonomic Desk Chair comes equipped HEPA Filtration System. Designed for superior performance, premium durability, and daily reliability.', 242.71, 78, 'https://images.unsplash.com/photo-1586023492125-27b2c045efd7?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Home & Living' LIMIT 1), '10000000-0000-0000-0000-000000000003'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000292');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000293', 'Dyson Cast Iron Dutch Oven - Edition 13', 'Engineered by Dyson. The Cast Iron Dutch Oven comes equipped Dimmer Touch & App Control. Designed for superior performance, premium durability, and daily reliability.', 252.53, 91, 'https://images.unsplash.com/photo-1538688525198-9b88f6f53126?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Home & Living' LIMIT 1), '10000000-0000-0000-0000-000000000003'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000293');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000294', 'KitchenAid Cordless Vacuum Cleaner - Edition 14', 'Engineered by KitchenAid. The Cordless Vacuum Cleaner comes equipped Handmade Artisan Stoneware. Designed for superior performance, premium durability, and daily reliability.', 262.35, 19, 'https://images.unsplash.com/photo-1583847268964-b28dc8f51f92?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Home & Living' LIMIT 1), '10000000-0000-0000-0000-000000000003'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000294');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000295', 'Philips Smart LED Floor Lamp - Edition 15', 'Engineered by Philips. The Smart LED Floor Lamp comes equipped Cooling Gel Infused Core. Designed for superior performance, premium durability, and daily reliability.', 272.18, 32, 'https://images.unsplash.com/photo-1507473885765-e6ed057f782c?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Home & Living' LIMIT 1), '10000000-0000-0000-0000-000000000003'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000295');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000296', 'West Elm Ceramic Dinnerware Set - Edition 16', 'Engineered by West Elm. The Ceramic Dinnerware Set comes equipped Whisper-Quiet Ultrasonic Mode. Designed for superior performance, premium durability, and daily reliability.', 260.3, 45, 'https://images.unsplash.com/photo-1513519245088-0e12902e5a38?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Home & Living' LIMIT 1), '10000000-0000-0000-0000-000000000003'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000296');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000297', 'Nespresso Memory Foam Pillow - Edition 17', 'Engineered by Nespresso. The Memory Foam Pillow comes equipped Pre-Seasoned Heavy Duty. Designed for superior performance, premium durability, and daily reliability.', 270.12, 58, 'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Home & Living' LIMIT 1), '10000000-0000-0000-0000-000000000003'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000297');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000298', 'Le Creuset Aromatherapy Diffuser - Edition 18', 'Engineered by Le Creuset. The Aromatherapy Diffuser comes equipped Dishwasher Safe & PFOA-Free. Designed for superior performance, premium durability, and daily reliability.', 279.95, 71, 'https://images.unsplash.com/photo-1540574163026-643ea20ade25?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Home & Living' LIMIT 1), '10000000-0000-0000-0000-000000000003'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000298');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000299', 'Cuisinart Air Fryer Convection Oven - Edition 19', 'Engineered by Cuisinart. The Air Fryer Convection Oven comes equipped 15-Bar High Pressure Extraction. Designed for superior performance, premium durability, and daily reliability.', 289.77, 84, 'https://images.unsplash.com/photo-1567016432779-094069958ea5?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Home & Living' LIMIT 1), '10000000-0000-0000-0000-000000000003'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000299');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000300', 'Herman Miller Walnut Coffee Table - Edition 20', 'Engineered by Herman Miller. The Walnut Coffee Table comes equipped Solid Scandinavian Oak Legs. Designed for superior performance, premium durability, and daily reliability.', 299.59, 97, 'https://images.unsplash.com/photo-1544816155-12df9643f363?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Home & Living' LIMIT 1), '10000000-0000-0000-0000-000000000003'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000300');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000301', 'Castlery Linen Bedding Sheet Set - Edition 01', 'Engineered by Castlery. The Linen Bedding Sheet Set comes equipped Enamelled Non-Stick Coating. Designed for superior performance, premium durability, and daily reliability.', 309.42, 25, 'https://images.unsplash.com/photo-1513694203232-719a280e022f?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Home & Living' LIMIT 1), '10000000-0000-0000-0000-000000000003'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000301');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000302', 'Lodge Stainless Steel Cookware - Edition 02', 'Engineered by Lodge. The Stainless Steel Cookware comes equipped HEPA Filtration System. Designed for superior performance, premium durability, and daily reliability.', 319.24, 38, 'https://images.unsplash.com/photo-1586023492125-27b2c045efd7?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Home & Living' LIMIT 1), '10000000-0000-0000-0000-000000000003'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000302');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000303', 'Ninja Automatic Milk Frother - Edition 03', 'Engineered by Ninja. The Automatic Milk Frother comes equipped Dimmer Touch & App Control. Designed for superior performance, premium durability, and daily reliability.', 307.36, 51, 'https://images.unsplash.com/photo-1538688525198-9b88f6f53126?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Home & Living' LIMIT 1), '10000000-0000-0000-0000-000000000003'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000303');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000304', 'Smeg Velvet Accent Armchair - Edition 04', 'Engineered by Smeg. The Velvet Accent Armchair comes equipped Handmade Artisan Stoneware. Designed for superior performance, premium durability, and daily reliability.', 317.19, 64, 'https://images.unsplash.com/photo-1583847268964-b28dc8f51f92?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Home & Living' LIMIT 1), '10000000-0000-0000-0000-000000000003'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000304');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000305', 'MUJI Electric Kettle with Temp Control - Edition 05', 'Engineered by MUJI. The Electric Kettle with Temp Control comes equipped Cooling Gel Infused Core. Designed for superior performance, premium durability, and daily reliability.', 327.01, 77, 'https://images.unsplash.com/photo-1507473885765-e6ed057f782c?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Home & Living' LIMIT 1), '10000000-0000-0000-0000-000000000003'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000305');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000306', 'IKEA Barista Espresso Machine - Edition 06', 'Engineered by IKEA. The Barista Espresso Machine comes equipped Whisper-Quiet Ultrasonic Mode. Designed for superior performance, premium durability, and daily reliability.', 336.83, 90, 'https://images.unsplash.com/photo-1513519245088-0e12902e5a38?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Home & Living' LIMIT 1), '10000000-0000-0000-0000-000000000003'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000306');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000307', 'Breville Ergonomic Desk Chair - Edition 07', 'Engineered by Breville. The Ergonomic Desk Chair comes equipped Pre-Seasoned Heavy Duty. Designed for superior performance, premium durability, and daily reliability.', 346.66, 18, 'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Home & Living' LIMIT 1), '10000000-0000-0000-0000-000000000003'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000307');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000308', 'Dyson Cast Iron Dutch Oven - Edition 08', 'Engineered by Dyson. The Cast Iron Dutch Oven comes equipped Dishwasher Safe & PFOA-Free. Designed for superior performance, premium durability, and daily reliability.', 356.48, 31, 'https://images.unsplash.com/photo-1540574163026-643ea20ade25?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Home & Living' LIMIT 1), '10000000-0000-0000-0000-000000000003'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000308');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000309', 'KitchenAid Cordless Vacuum Cleaner - Edition 09', 'Engineered by KitchenAid. The Cordless Vacuum Cleaner comes equipped 15-Bar High Pressure Extraction. Designed for superior performance, premium durability, and daily reliability.', 366.3, 44, 'https://images.unsplash.com/photo-1567016432779-094069958ea5?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Home & Living' LIMIT 1), '10000000-0000-0000-0000-000000000003'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000309');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000310', 'Philips Smart LED Floor Lamp - Edition 10', 'Engineered by Philips. The Smart LED Floor Lamp comes equipped Solid Scandinavian Oak Legs. Designed for superior performance, premium durability, and daily reliability.', 354.42, 57, 'https://images.unsplash.com/photo-1544816155-12df9643f363?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Home & Living' LIMIT 1), '10000000-0000-0000-0000-000000000003'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000310');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000311', 'West Elm Ceramic Dinnerware Set - Edition 11', 'Engineered by West Elm. The Ceramic Dinnerware Set comes equipped Enamelled Non-Stick Coating. Designed for superior performance, premium durability, and daily reliability.', 364.25, 70, 'https://images.unsplash.com/photo-1513694203232-719a280e022f?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Home & Living' LIMIT 1), '10000000-0000-0000-0000-000000000003'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000311');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000312', 'Nespresso Memory Foam Pillow - Edition 12', 'Engineered by Nespresso. The Memory Foam Pillow comes equipped HEPA Filtration System. Designed for superior performance, premium durability, and daily reliability.', 374.07, 83, 'https://images.unsplash.com/photo-1586023492125-27b2c045efd7?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Home & Living' LIMIT 1), '10000000-0000-0000-0000-000000000003'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000312');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000313', 'Le Creuset Aromatherapy Diffuser - Edition 13', 'Engineered by Le Creuset. The Aromatherapy Diffuser comes equipped Dimmer Touch & App Control. Designed for superior performance, premium durability, and daily reliability.', 383.89, 96, 'https://images.unsplash.com/photo-1538688525198-9b88f6f53126?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Home & Living' LIMIT 1), '10000000-0000-0000-0000-000000000003'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000313');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000314', 'Cuisinart Air Fryer Convection Oven - Edition 14', 'Engineered by Cuisinart. The Air Fryer Convection Oven comes equipped Handmade Artisan Stoneware. Designed for superior performance, premium durability, and daily reliability.', 393.72, 24, 'https://images.unsplash.com/photo-1583847268964-b28dc8f51f92?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Home & Living' LIMIT 1), '10000000-0000-0000-0000-000000000003'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000314');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000315', 'Herman Miller Walnut Coffee Table - Edition 15', 'Engineered by Herman Miller. The Walnut Coffee Table comes equipped Cooling Gel Infused Core. Designed for superior performance, premium durability, and daily reliability.', 403.54, 37, 'https://images.unsplash.com/photo-1507473885765-e6ed057f782c?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Home & Living' LIMIT 1), '10000000-0000-0000-0000-000000000003'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000315');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000316', 'Castlery Linen Bedding Sheet Set - Edition 16', 'Engineered by Castlery. The Linen Bedding Sheet Set comes equipped Whisper-Quiet Ultrasonic Mode. Designed for superior performance, premium durability, and daily reliability.', 413.36, 50, 'https://images.unsplash.com/photo-1513519245088-0e12902e5a38?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Home & Living' LIMIT 1), '10000000-0000-0000-0000-000000000003'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000316');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000317', 'Lodge Stainless Steel Cookware - Edition 17', 'Engineered by Lodge. The Stainless Steel Cookware comes equipped Pre-Seasoned Heavy Duty. Designed for superior performance, premium durability, and daily reliability.', 401.49, 63, 'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Home & Living' LIMIT 1), '10000000-0000-0000-0000-000000000003'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000317');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000318', 'Ninja Automatic Milk Frother - Edition 18', 'Engineered by Ninja. The Automatic Milk Frother comes equipped Dishwasher Safe & PFOA-Free. Designed for superior performance, premium durability, and daily reliability.', 411.31, 76, 'https://images.unsplash.com/photo-1540574163026-643ea20ade25?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Home & Living' LIMIT 1), '10000000-0000-0000-0000-000000000003'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000318');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000319', 'Smeg Velvet Accent Armchair - Edition 19', 'Engineered by Smeg. The Velvet Accent Armchair comes equipped 15-Bar High Pressure Extraction. Designed for superior performance, premium durability, and daily reliability.', 421.13, 89, 'https://images.unsplash.com/photo-1567016432779-094069958ea5?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Home & Living' LIMIT 1), '10000000-0000-0000-0000-000000000003'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000319');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000320', 'MUJI Electric Kettle with Temp Control - Edition 20', 'Engineered by MUJI. The Electric Kettle with Temp Control comes equipped Solid Scandinavian Oak Legs. Designed for superior performance, premium durability, and daily reliability.', 430.96, 17, 'https://images.unsplash.com/photo-1544816155-12df9643f363?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Home & Living' LIMIT 1), '10000000-0000-0000-0000-000000000003'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000320');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000321', 'IKEA Barista Espresso Machine - Edition 01', 'Engineered by IKEA. The Barista Espresso Machine comes equipped Enamelled Non-Stick Coating. Designed for superior performance, premium durability, and daily reliability.', 440.78, 30, 'https://images.unsplash.com/photo-1513694203232-719a280e022f?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Home & Living' LIMIT 1), '10000000-0000-0000-0000-000000000003'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000321');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000322', 'Breville Ergonomic Desk Chair - Edition 02', 'Engineered by Breville. The Ergonomic Desk Chair comes equipped HEPA Filtration System. Designed for superior performance, premium durability, and daily reliability.', 450.6, 43, 'https://images.unsplash.com/photo-1586023492125-27b2c045efd7?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Home & Living' LIMIT 1), '10000000-0000-0000-0000-000000000003'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000322');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000323', 'Dyson Cast Iron Dutch Oven - Edition 03', 'Engineered by Dyson. The Cast Iron Dutch Oven comes equipped Dimmer Touch & App Control. Designed for superior performance, premium durability, and daily reliability.', 460.43, 56, 'https://images.unsplash.com/photo-1538688525198-9b88f6f53126?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Home & Living' LIMIT 1), '10000000-0000-0000-0000-000000000003'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000323');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000324', 'KitchenAid Cordless Vacuum Cleaner - Edition 04', 'Engineered by KitchenAid. The Cordless Vacuum Cleaner comes equipped Handmade Artisan Stoneware. Designed for superior performance, premium durability, and daily reliability.', 448.55, 69, 'https://images.unsplash.com/photo-1583847268964-b28dc8f51f92?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Home & Living' LIMIT 1), '10000000-0000-0000-0000-000000000003'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000324');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000325', 'Philips Smart LED Floor Lamp - Edition 05', 'Engineered by Philips. The Smart LED Floor Lamp comes equipped Cooling Gel Infused Core. Designed for superior performance, premium durability, and daily reliability.', 458.37, 82, 'https://images.unsplash.com/photo-1507473885765-e6ed057f782c?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Home & Living' LIMIT 1), '10000000-0000-0000-0000-000000000003'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000325');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000326', 'West Elm Ceramic Dinnerware Set - Edition 06', 'Engineered by West Elm. The Ceramic Dinnerware Set comes equipped Whisper-Quiet Ultrasonic Mode. Designed for superior performance, premium durability, and daily reliability.', 468.19, 95, 'https://images.unsplash.com/photo-1513519245088-0e12902e5a38?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Home & Living' LIMIT 1), '10000000-0000-0000-0000-000000000003'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000326');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000327', 'Nespresso Memory Foam Pillow - Edition 07', 'Engineered by Nespresso. The Memory Foam Pillow comes equipped Pre-Seasoned Heavy Duty. Designed for superior performance, premium durability, and daily reliability.', 478.02, 23, 'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Home & Living' LIMIT 1), '10000000-0000-0000-0000-000000000003'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000327');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000328', 'Le Creuset Aromatherapy Diffuser - Edition 08', 'Engineered by Le Creuset. The Aromatherapy Diffuser comes equipped Dishwasher Safe & PFOA-Free. Designed for superior performance, premium durability, and daily reliability.', 487.84, 36, 'https://images.unsplash.com/photo-1540574163026-643ea20ade25?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Home & Living' LIMIT 1), '10000000-0000-0000-0000-000000000003'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000328');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000329', 'Cuisinart Air Fryer Convection Oven - Edition 09', 'Engineered by Cuisinart. The Air Fryer Convection Oven comes equipped 15-Bar High Pressure Extraction. Designed for superior performance, premium durability, and daily reliability.', 497.66, 49, 'https://images.unsplash.com/photo-1567016432779-094069958ea5?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Home & Living' LIMIT 1), '10000000-0000-0000-0000-000000000003'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000329');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000330', 'Herman Miller Walnut Coffee Table - Edition 10', 'Engineered by Herman Miller. The Walnut Coffee Table comes equipped Solid Scandinavian Oak Legs. Designed for superior performance, premium durability, and daily reliability.', 507.49, 62, 'https://images.unsplash.com/photo-1544816155-12df9643f363?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Home & Living' LIMIT 1), '10000000-0000-0000-0000-000000000003'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000330');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000331', 'Castlery Linen Bedding Sheet Set - Edition 11', 'Engineered by Castlery. The Linen Bedding Sheet Set comes equipped Enamelled Non-Stick Coating. Designed for superior performance, premium durability, and daily reliability.', 495.61, 75, 'https://images.unsplash.com/photo-1513694203232-719a280e022f?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Home & Living' LIMIT 1), '10000000-0000-0000-0000-000000000003'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000331');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000332', 'Lodge Stainless Steel Cookware - Edition 12', 'Engineered by Lodge. The Stainless Steel Cookware comes equipped HEPA Filtration System. Designed for superior performance, premium durability, and daily reliability.', 505.43, 88, 'https://images.unsplash.com/photo-1586023492125-27b2c045efd7?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Home & Living' LIMIT 1), '10000000-0000-0000-0000-000000000003'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000332');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000333', 'Ninja Automatic Milk Frother - Edition 13', 'Engineered by Ninja. The Automatic Milk Frother comes equipped Dimmer Touch & App Control. Designed for superior performance, premium durability, and daily reliability.', 515.26, 16, 'https://images.unsplash.com/photo-1538688525198-9b88f6f53126?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Home & Living' LIMIT 1), '10000000-0000-0000-0000-000000000003'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000333');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000334', 'Smeg Velvet Accent Armchair - Edition 14', 'Engineered by Smeg. The Velvet Accent Armchair comes equipped Handmade Artisan Stoneware. Designed for superior performance, premium durability, and daily reliability.', 525.08, 29, 'https://images.unsplash.com/photo-1583847268964-b28dc8f51f92?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Home & Living' LIMIT 1), '10000000-0000-0000-0000-000000000003'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000334');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000335', 'MUJI Electric Kettle with Temp Control - Edition 15', 'Engineered by MUJI. The Electric Kettle with Temp Control comes equipped Cooling Gel Infused Core. Designed for superior performance, premium durability, and daily reliability.', 534.9, 42, 'https://images.unsplash.com/photo-1507473885765-e6ed057f782c?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Home & Living' LIMIT 1), '10000000-0000-0000-0000-000000000003'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000335');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000336', 'IKEA Barista Espresso Machine - Edition 16', 'Engineered by IKEA. The Barista Espresso Machine comes equipped Whisper-Quiet Ultrasonic Mode. Designed for superior performance, premium durability, and daily reliability.', 544.73, 55, 'https://images.unsplash.com/photo-1513519245088-0e12902e5a38?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Home & Living' LIMIT 1), '10000000-0000-0000-0000-000000000003'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000336');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000337', 'Breville Ergonomic Desk Chair - Edition 17', 'Engineered by Breville. The Ergonomic Desk Chair comes equipped Pre-Seasoned Heavy Duty. Designed for superior performance, premium durability, and daily reliability.', 554.55, 68, 'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Home & Living' LIMIT 1), '10000000-0000-0000-0000-000000000003'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000337');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000338', 'Dyson Cast Iron Dutch Oven - Edition 18', 'Engineered by Dyson. The Cast Iron Dutch Oven comes equipped Dishwasher Safe & PFOA-Free. Designed for superior performance, premium durability, and daily reliability.', 542.67, 81, 'https://images.unsplash.com/photo-1540574163026-643ea20ade25?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Home & Living' LIMIT 1), '10000000-0000-0000-0000-000000000003'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000338');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000339', 'KitchenAid Cordless Vacuum Cleaner - Edition 19', 'Engineered by KitchenAid. The Cordless Vacuum Cleaner comes equipped 15-Bar High Pressure Extraction. Designed for superior performance, premium durability, and daily reliability.', 552.5, 94, 'https://images.unsplash.com/photo-1567016432779-094069958ea5?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Home & Living' LIMIT 1), '10000000-0000-0000-0000-000000000003'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000339');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000340', 'Philips Smart LED Floor Lamp - Edition 20', 'Engineered by Philips. The Smart LED Floor Lamp comes equipped Solid Scandinavian Oak Legs. Designed for superior performance, premium durability, and daily reliability.', 562.32, 22, 'https://images.unsplash.com/photo-1544816155-12df9643f363?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Home & Living' LIMIT 1), '10000000-0000-0000-0000-000000000003'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000340');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000341', 'West Elm Ceramic Dinnerware Set - Edition 01', 'Engineered by West Elm. The Ceramic Dinnerware Set comes equipped Enamelled Non-Stick Coating. Designed for superior performance, premium durability, and daily reliability.', 572.14, 35, 'https://images.unsplash.com/photo-1513694203232-719a280e022f?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Home & Living' LIMIT 1), '10000000-0000-0000-0000-000000000003'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000341');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000342', 'Nespresso Memory Foam Pillow - Edition 02', 'Engineered by Nespresso. The Memory Foam Pillow comes equipped HEPA Filtration System. Designed for superior performance, premium durability, and daily reliability.', 581.97, 48, 'https://images.unsplash.com/photo-1586023492125-27b2c045efd7?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Home & Living' LIMIT 1), '10000000-0000-0000-0000-000000000003'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000342');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000343', 'Le Creuset Aromatherapy Diffuser - Edition 03', 'Engineered by Le Creuset. The Aromatherapy Diffuser comes equipped Dimmer Touch & App Control. Designed for superior performance, premium durability, and daily reliability.', 591.79, 61, 'https://images.unsplash.com/photo-1538688525198-9b88f6f53126?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Home & Living' LIMIT 1), '10000000-0000-0000-0000-000000000003'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000343');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000344', 'Cuisinart Air Fryer Convection Oven - Edition 04', 'Engineered by Cuisinart. The Air Fryer Convection Oven comes equipped Handmade Artisan Stoneware. Designed for superior performance, premium durability, and daily reliability.', 601.61, 74, 'https://images.unsplash.com/photo-1583847268964-b28dc8f51f92?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Home & Living' LIMIT 1), '10000000-0000-0000-0000-000000000003'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000344');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000345', 'Herman Miller Walnut Coffee Table - Edition 05', 'Engineered by Herman Miller. The Walnut Coffee Table comes equipped Cooling Gel Infused Core. Designed for superior performance, premium durability, and daily reliability.', 589.73, 87, 'https://images.unsplash.com/photo-1507473885765-e6ed057f782c?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Home & Living' LIMIT 1), '10000000-0000-0000-0000-000000000003'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000345');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000346', 'Castlery Linen Bedding Sheet Set - Edition 06', 'Engineered by Castlery. The Linen Bedding Sheet Set comes equipped Whisper-Quiet Ultrasonic Mode. Designed for superior performance, premium durability, and daily reliability.', 599.56, 15, 'https://images.unsplash.com/photo-1513519245088-0e12902e5a38?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Home & Living' LIMIT 1), '10000000-0000-0000-0000-000000000003'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000346');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000347', 'Lodge Stainless Steel Cookware - Edition 07', 'Engineered by Lodge. The Stainless Steel Cookware comes equipped Pre-Seasoned Heavy Duty. Designed for superior performance, premium durability, and daily reliability.', 609.38, 28, 'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Home & Living' LIMIT 1), '10000000-0000-0000-0000-000000000003'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000347');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000348', 'Ninja Automatic Milk Frother - Edition 08', 'Engineered by Ninja. The Automatic Milk Frother comes equipped Dishwasher Safe & PFOA-Free. Designed for superior performance, premium durability, and daily reliability.', 619.2, 41, 'https://images.unsplash.com/photo-1540574163026-643ea20ade25?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Home & Living' LIMIT 1), '10000000-0000-0000-0000-000000000003'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000348');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000349', 'Smeg Velvet Accent Armchair - Edition 09', 'Engineered by Smeg. The Velvet Accent Armchair comes equipped 15-Bar High Pressure Extraction. Designed for superior performance, premium durability, and daily reliability.', 629.03, 54, 'https://images.unsplash.com/photo-1567016432779-094069958ea5?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Home & Living' LIMIT 1), '10000000-0000-0000-0000-000000000003'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000349');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000350', 'MUJI Electric Kettle with Temp Control - Edition 10', 'Engineered by MUJI. The Electric Kettle with Temp Control comes equipped Solid Scandinavian Oak Legs. Designed for superior performance, premium durability, and daily reliability.', 638.85, 67, 'https://images.unsplash.com/photo-1544816155-12df9643f363?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Home & Living' LIMIT 1), '10000000-0000-0000-0000-000000000003'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000350');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000351', 'IKEA Barista Espresso Machine - Edition 11', 'Engineered by IKEA. The Barista Espresso Machine comes equipped Enamelled Non-Stick Coating. Designed for superior performance, premium durability, and daily reliability.', 648.67, 80, 'https://images.unsplash.com/photo-1513694203232-719a280e022f?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Home & Living' LIMIT 1), '10000000-0000-0000-0000-000000000003'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000351');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000352', 'Breville Ergonomic Desk Chair - Edition 12', 'Engineered by Breville. The Ergonomic Desk Chair comes equipped HEPA Filtration System. Designed for superior performance, premium durability, and daily reliability.', 636.8, 93, 'https://images.unsplash.com/photo-1586023492125-27b2c045efd7?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Home & Living' LIMIT 1), '10000000-0000-0000-0000-000000000003'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000352');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000353', 'Dyson Cast Iron Dutch Oven - Edition 13', 'Engineered by Dyson. The Cast Iron Dutch Oven comes equipped Dimmer Touch & App Control. Designed for superior performance, premium durability, and daily reliability.', 646.62, 21, 'https://images.unsplash.com/photo-1538688525198-9b88f6f53126?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Home & Living' LIMIT 1), '10000000-0000-0000-0000-000000000003'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000353');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000354', 'KitchenAid Cordless Vacuum Cleaner - Edition 14', 'Engineered by KitchenAid. The Cordless Vacuum Cleaner comes equipped Handmade Artisan Stoneware. Designed for superior performance, premium durability, and daily reliability.', 656.44, 34, 'https://images.unsplash.com/photo-1583847268964-b28dc8f51f92?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Home & Living' LIMIT 1), '10000000-0000-0000-0000-000000000003'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000354');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000355', 'Philips Smart LED Floor Lamp - Edition 15', 'Engineered by Philips. The Smart LED Floor Lamp comes equipped Cooling Gel Infused Core. Designed for superior performance, premium durability, and daily reliability.', 666.27, 47, 'https://images.unsplash.com/photo-1507473885765-e6ed057f782c?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Home & Living' LIMIT 1), '10000000-0000-0000-0000-000000000003'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000355');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000356', 'West Elm Ceramic Dinnerware Set - Edition 16', 'Engineered by West Elm. The Ceramic Dinnerware Set comes equipped Whisper-Quiet Ultrasonic Mode. Designed for superior performance, premium durability, and daily reliability.', 676.09, 60, 'https://images.unsplash.com/photo-1513519245088-0e12902e5a38?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Home & Living' LIMIT 1), '10000000-0000-0000-0000-000000000003'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000356');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000357', 'Nespresso Memory Foam Pillow - Edition 17', 'Engineered by Nespresso. The Memory Foam Pillow comes equipped Pre-Seasoned Heavy Duty. Designed for superior performance, premium durability, and daily reliability.', 685.91, 73, 'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Home & Living' LIMIT 1), '10000000-0000-0000-0000-000000000003'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000357');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000358', 'Le Creuset Aromatherapy Diffuser - Edition 18', 'Engineered by Le Creuset. The Aromatherapy Diffuser comes equipped Dishwasher Safe & PFOA-Free. Designed for superior performance, premium durability, and daily reliability.', 695.74, 86, 'https://images.unsplash.com/photo-1540574163026-643ea20ade25?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Home & Living' LIMIT 1), '10000000-0000-0000-0000-000000000003'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000358');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000359', 'Cuisinart Air Fryer Convection Oven - Edition 19', 'Engineered by Cuisinart. The Air Fryer Convection Oven comes equipped 15-Bar High Pressure Extraction. Designed for superior performance, premium durability, and daily reliability.', 683.86, 99, 'https://images.unsplash.com/photo-1567016432779-094069958ea5?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Home & Living' LIMIT 1), '10000000-0000-0000-0000-000000000003'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000359');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000360', 'Herman Miller Walnut Coffee Table - Edition 20', 'Engineered by Herman Miller. The Walnut Coffee Table comes equipped Solid Scandinavian Oak Legs. Designed for superior performance, premium durability, and daily reliability.', 693.68, 27, 'https://images.unsplash.com/photo-1544816155-12df9643f363?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Home & Living' LIMIT 1), '10000000-0000-0000-0000-000000000003'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000360');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000361', 'Castlery Linen Bedding Sheet Set - Edition 01', 'Engineered by Castlery. The Linen Bedding Sheet Set comes equipped Enamelled Non-Stick Coating. Designed for superior performance, premium durability, and daily reliability.', 703.51, 40, 'https://images.unsplash.com/photo-1513694203232-719a280e022f?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Home & Living' LIMIT 1), '10000000-0000-0000-0000-000000000003'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000361');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000362', 'Lodge Stainless Steel Cookware - Edition 02', 'Engineered by Lodge. The Stainless Steel Cookware comes equipped HEPA Filtration System. Designed for superior performance, premium durability, and daily reliability.', 713.33, 53, 'https://images.unsplash.com/photo-1586023492125-27b2c045efd7?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Home & Living' LIMIT 1), '10000000-0000-0000-0000-000000000003'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000362');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000363', 'Ninja Automatic Milk Frother - Edition 03', 'Engineered by Ninja. The Automatic Milk Frother comes equipped Dimmer Touch & App Control. Designed for superior performance, premium durability, and daily reliability.', 723.15, 66, 'https://images.unsplash.com/photo-1538688525198-9b88f6f53126?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Home & Living' LIMIT 1), '10000000-0000-0000-0000-000000000003'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000363');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000364', 'Smeg Velvet Accent Armchair - Edition 04', 'Engineered by Smeg. The Velvet Accent Armchair comes equipped Handmade Artisan Stoneware. Designed for superior performance, premium durability, and daily reliability.', 732.97, 79, 'https://images.unsplash.com/photo-1583847268964-b28dc8f51f92?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Home & Living' LIMIT 1), '10000000-0000-0000-0000-000000000003'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000364');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000365', 'MUJI Electric Kettle with Temp Control - Edition 05', 'Engineered by MUJI. The Electric Kettle with Temp Control comes equipped Cooling Gel Infused Core. Designed for superior performance, premium durability, and daily reliability.', 742.8, 92, 'https://images.unsplash.com/photo-1507473885765-e6ed057f782c?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Home & Living' LIMIT 1), '10000000-0000-0000-0000-000000000003'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000365');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000366', 'IKEA Barista Espresso Machine - Edition 06', 'Engineered by IKEA. The Barista Espresso Machine comes equipped Whisper-Quiet Ultrasonic Mode. Designed for superior performance, premium durability, and daily reliability.', 730.92, 20, 'https://images.unsplash.com/photo-1513519245088-0e12902e5a38?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Home & Living' LIMIT 1), '10000000-0000-0000-0000-000000000003'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000366');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000367', 'Breville Ergonomic Desk Chair - Edition 07', 'Engineered by Breville. The Ergonomic Desk Chair comes equipped Pre-Seasoned Heavy Duty. Designed for superior performance, premium durability, and daily reliability.', 740.74, 33, 'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Home & Living' LIMIT 1), '10000000-0000-0000-0000-000000000003'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000367');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000368', 'Dyson Cast Iron Dutch Oven - Edition 08', 'Engineered by Dyson. The Cast Iron Dutch Oven comes equipped Dishwasher Safe & PFOA-Free. Designed for superior performance, premium durability, and daily reliability.', 750.57, 46, 'https://images.unsplash.com/photo-1540574163026-643ea20ade25?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Home & Living' LIMIT 1), '10000000-0000-0000-0000-000000000003'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000368');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000369', 'KitchenAid Cordless Vacuum Cleaner - Edition 09', 'Engineered by KitchenAid. The Cordless Vacuum Cleaner comes equipped 15-Bar High Pressure Extraction. Designed for superior performance, premium durability, and daily reliability.', 760.39, 59, 'https://images.unsplash.com/photo-1567016432779-094069958ea5?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Home & Living' LIMIT 1), '10000000-0000-0000-0000-000000000003'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000369');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000370', 'Philips Smart LED Floor Lamp - Edition 10', 'Engineered by Philips. The Smart LED Floor Lamp comes equipped Solid Scandinavian Oak Legs. Designed for superior performance, premium durability, and daily reliability.', 770.21, 72, 'https://images.unsplash.com/photo-1544816155-12df9643f363?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Home & Living' LIMIT 1), '10000000-0000-0000-0000-000000000003'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000370');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000371', 'West Elm Ceramic Dinnerware Set - Edition 11', 'Engineered by West Elm. The Ceramic Dinnerware Set comes equipped Enamelled Non-Stick Coating. Designed for superior performance, premium durability, and daily reliability.', 780.04, 85, 'https://images.unsplash.com/photo-1513694203232-719a280e022f?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Home & Living' LIMIT 1), '10000000-0000-0000-0000-000000000003'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000371');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000372', 'Nespresso Memory Foam Pillow - Edition 12', 'Engineered by Nespresso. The Memory Foam Pillow comes equipped HEPA Filtration System. Designed for superior performance, premium durability, and daily reliability.', 789.86, 98, 'https://images.unsplash.com/photo-1586023492125-27b2c045efd7?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Home & Living' LIMIT 1), '10000000-0000-0000-0000-000000000003'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000372');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000373', 'Le Creuset Aromatherapy Diffuser - Edition 13', 'Engineered by Le Creuset. The Aromatherapy Diffuser comes equipped Dimmer Touch & App Control. Designed for superior performance, premium durability, and daily reliability.', 777.98, 26, 'https://images.unsplash.com/photo-1538688525198-9b88f6f53126?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Home & Living' LIMIT 1), '10000000-0000-0000-0000-000000000003'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000373');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000374', 'Cuisinart Air Fryer Convection Oven - Edition 14', 'Engineered by Cuisinart. The Air Fryer Convection Oven comes equipped Handmade Artisan Stoneware. Designed for superior performance, premium durability, and daily reliability.', 787.81, 39, 'https://images.unsplash.com/photo-1583847268964-b28dc8f51f92?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Home & Living' LIMIT 1), '10000000-0000-0000-0000-000000000003'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000374');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000375', 'Herman Miller Walnut Coffee Table - Edition 15', 'Engineered by Herman Miller. The Walnut Coffee Table comes equipped Cooling Gel Infused Core. Designed for superior performance, premium durability, and daily reliability.', 797.63, 52, 'https://images.unsplash.com/photo-1507473885765-e6ed057f782c?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Home & Living' LIMIT 1), '10000000-0000-0000-0000-000000000003'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000375');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000376', 'Castlery Linen Bedding Sheet Set - Edition 16', 'Engineered by Castlery. The Linen Bedding Sheet Set comes equipped Whisper-Quiet Ultrasonic Mode. Designed for superior performance, premium durability, and daily reliability.', 807.45, 65, 'https://images.unsplash.com/photo-1513519245088-0e12902e5a38?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Home & Living' LIMIT 1), '10000000-0000-0000-0000-000000000003'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000376');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000377', 'Lodge Stainless Steel Cookware - Edition 17', 'Engineered by Lodge. The Stainless Steel Cookware comes equipped Pre-Seasoned Heavy Duty. Designed for superior performance, premium durability, and daily reliability.', 817.28, 78, 'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Home & Living' LIMIT 1), '10000000-0000-0000-0000-000000000003'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000377');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000378', 'Ninja Automatic Milk Frother - Edition 18', 'Engineered by Ninja. The Automatic Milk Frother comes equipped Dishwasher Safe & PFOA-Free. Designed for superior performance, premium durability, and daily reliability.', 827.1, 91, 'https://images.unsplash.com/photo-1540574163026-643ea20ade25?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Home & Living' LIMIT 1), '10000000-0000-0000-0000-000000000003'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000378');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000379', 'Smeg Velvet Accent Armchair - Edition 19', 'Engineered by Smeg. The Velvet Accent Armchair comes equipped 15-Bar High Pressure Extraction. Designed for superior performance, premium durability, and daily reliability.', 836.92, 19, 'https://images.unsplash.com/photo-1567016432779-094069958ea5?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Home & Living' LIMIT 1), '10000000-0000-0000-0000-000000000003'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000379');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000380', 'MUJI Electric Kettle with Temp Control - Edition 20', 'Engineered by MUJI. The Electric Kettle with Temp Control comes equipped Solid Scandinavian Oak Legs. Designed for superior performance, premium durability, and daily reliability.', 825.05, 32, 'https://images.unsplash.com/photo-1544816155-12df9643f363?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Home & Living' LIMIT 1), '10000000-0000-0000-0000-000000000003'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000380');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000381', 'IKEA Barista Espresso Machine - Edition 01', 'Engineered by IKEA. The Barista Espresso Machine comes equipped Enamelled Non-Stick Coating. Designed for superior performance, premium durability, and daily reliability.', 834.87, 45, 'https://images.unsplash.com/photo-1513694203232-719a280e022f?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Home & Living' LIMIT 1), '10000000-0000-0000-0000-000000000003'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000381');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000382', 'Breville Ergonomic Desk Chair - Edition 02', 'Engineered by Breville. The Ergonomic Desk Chair comes equipped HEPA Filtration System. Designed for superior performance, premium durability, and daily reliability.', 844.69, 58, 'https://images.unsplash.com/photo-1586023492125-27b2c045efd7?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Home & Living' LIMIT 1), '10000000-0000-0000-0000-000000000003'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000382');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000383', 'Dyson Cast Iron Dutch Oven - Edition 03', 'Engineered by Dyson. The Cast Iron Dutch Oven comes equipped Dimmer Touch & App Control. Designed for superior performance, premium durability, and daily reliability.', 854.51, 71, 'https://images.unsplash.com/photo-1538688525198-9b88f6f53126?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Home & Living' LIMIT 1), '10000000-0000-0000-0000-000000000003'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000383');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000384', 'KitchenAid Cordless Vacuum Cleaner - Edition 04', 'Engineered by KitchenAid. The Cordless Vacuum Cleaner comes equipped Handmade Artisan Stoneware. Designed for superior performance, premium durability, and daily reliability.', 864.34, 84, 'https://images.unsplash.com/photo-1583847268964-b28dc8f51f92?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Home & Living' LIMIT 1), '10000000-0000-0000-0000-000000000003'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000384');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000385', 'Philips Smart LED Floor Lamp - Edition 05', 'Engineered by Philips. The Smart LED Floor Lamp comes equipped Cooling Gel Infused Core. Designed for superior performance, premium durability, and daily reliability.', 874.16, 97, 'https://images.unsplash.com/photo-1507473885765-e6ed057f782c?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Home & Living' LIMIT 1), '10000000-0000-0000-0000-000000000003'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000385');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000386', 'West Elm Ceramic Dinnerware Set - Edition 06', 'Engineered by West Elm. The Ceramic Dinnerware Set comes equipped Whisper-Quiet Ultrasonic Mode. Designed for superior performance, premium durability, and daily reliability.', 883.98, 25, 'https://images.unsplash.com/photo-1513519245088-0e12902e5a38?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Home & Living' LIMIT 1), '10000000-0000-0000-0000-000000000003'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000386');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000387', 'Nespresso Memory Foam Pillow - Edition 07', 'Engineered by Nespresso. The Memory Foam Pillow comes equipped Pre-Seasoned Heavy Duty. Designed for superior performance, premium durability, and daily reliability.', 872.11, 38, 'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Home & Living' LIMIT 1), '10000000-0000-0000-0000-000000000003'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000387');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000388', 'Le Creuset Aromatherapy Diffuser - Edition 08', 'Engineered by Le Creuset. The Aromatherapy Diffuser comes equipped Dishwasher Safe & PFOA-Free. Designed for superior performance, premium durability, and daily reliability.', 881.93, 51, 'https://images.unsplash.com/photo-1540574163026-643ea20ade25?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Home & Living' LIMIT 1), '10000000-0000-0000-0000-000000000003'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000388');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000389', 'Cuisinart Air Fryer Convection Oven - Edition 09', 'Engineered by Cuisinart. The Air Fryer Convection Oven comes equipped 15-Bar High Pressure Extraction. Designed for superior performance, premium durability, and daily reliability.', 891.75, 64, 'https://images.unsplash.com/photo-1567016432779-094069958ea5?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Home & Living' LIMIT 1), '10000000-0000-0000-0000-000000000003'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000389');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000390', 'Herman Miller Walnut Coffee Table - Edition 10', 'Engineered by Herman Miller. The Walnut Coffee Table comes equipped Solid Scandinavian Oak Legs. Designed for superior performance, premium durability, and daily reliability.', 895.0, 77, 'https://images.unsplash.com/photo-1544816155-12df9643f363?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Home & Living' LIMIT 1), '10000000-0000-0000-0000-000000000003'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000390');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000391', 'Chanel Hyaluronic Acid Hydrating Serum - Edition 01', 'Engineered by Chanel. The Hyaluronic Acid Hydrating Serum comes equipped Sulfate-Free & Fragrance-Free. Designed for superior performance, premium durability, and daily reliability.', 12.99, 15, 'https://images.unsplash.com/photo-1535585209827-a15fcdbc4c2d?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Beauty & Personal Care' LIMIT 1), '10000000-0000-0000-0000-000000000004'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000391');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000392', 'The Ordinary Eau de Parfum Spray - Edition 02', 'Engineered by The Ordinary. The Eau de Parfum Spray comes equipped Enriched with Vitamin C & E. Designed for superior performance, premium durability, and daily reliability.', 18.14, 28, 'https://images.unsplash.com/photo-1556228720-195a672e8a03?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Beauty & Personal Care' LIMIT 1), '10000000-0000-0000-0000-000000000004'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000392');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000393', 'Dior Restorative Hair Mask - Edition 03', 'Engineered by Dior. The Restorative Hair Mask comes equipped Broad Spectrum SPF 50+. Designed for superior performance, premium durability, and daily reliability.', 23.3, 41, 'https://images.unsplash.com/photo-1512496015851-a90fb38ba796?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Beauty & Personal Care' LIMIT 1), '10000000-0000-0000-0000-000000000004'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000393');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000394', 'Kiehl''s Revitalizing Face Cleanser - Edition 04', 'Engineered by Kiehl''s. The Revitalizing Face Cleanser comes equipped Cruelty-Free & 100% Vegan. Designed for superior performance, premium durability, and daily reliability.', 28.45, 54, 'https://images.unsplash.com/photo-1598440947619-2c35fc9aa908?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Beauty & Personal Care' LIMIT 1), '10000000-0000-0000-0000-000000000004'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000394');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000395', 'Aesop Botanical Body Wash - Edition 05', 'Engineered by Aesop. The Botanical Body Wash comes equipped Dermatologist Tested for Sensitive Skin. Designed for superior performance, premium durability, and daily reliability.', 33.61, 67, 'https://images.unsplash.com/photo-1617897903246-719242758050?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Beauty & Personal Care' LIMIT 1), '10000000-0000-0000-0000-000000000004'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000395');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000396', 'La Mer Niacinamide Glow Tonic - Edition 06', 'Engineered by La Mer. The Niacinamide Glow Tonic comes equipped Intense Overnight Hydration. Designed for superior performance, premium durability, and daily reliability.', 38.76, 80, 'https://images.unsplash.com/photo-1608248597359-597495085e68?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Beauty & Personal Care' LIMIT 1), '10000000-0000-0000-0000-000000000004'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000396');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000397', 'Olaplex Anti-Aging Night Cream - Edition 07', 'Engineered by Olaplex. The Anti-Aging Night Cream comes equipped Naturally Derived Organic Botanicals. Designed for superior performance, premium durability, and daily reliability.', 43.91, 93, 'https://images.unsplash.com/photo-1571781926291-c477ebfd024b?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Beauty & Personal Care' LIMIT 1), '10000000-0000-0000-0000-000000000004'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000397');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000398', 'Estée Lauder Lip Sleeping Mask - Edition 08', 'Engineered by Estée Lauder. The Lip Sleeping Mask comes equipped Formulated with 2% Pure Hyaluronic Acid. Designed for superior performance, premium durability, and daily reliability.', 27.37, 21, 'https://images.unsplash.com/photo-1527799820374-dcf8d9d4a388?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Beauty & Personal Care' LIMIT 1), '10000000-0000-0000-0000-000000000004'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000398');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000399', 'Glossier Velvet Matte Lipstick - Edition 09', 'Engineered by Glossier. The Velvet Matte Lipstick comes equipped Long-Lasting 12-Hour Fragrance. Designed for superior performance, premium durability, and daily reliability.', 32.52, 34, 'https://images.unsplash.com/photo-1585238342024-78d387f4a707?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Beauty & Personal Care' LIMIT 1), '10000000-0000-0000-0000-000000000004'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000399');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000400', 'Fenty Beauty Hydrating Mineral Sunscreen - Edition 10', 'Engineered by Fenty Beauty. The Hydrating Mineral Sunscreen comes equipped Bond Building Repair Formula. Designed for superior performance, premium durability, and daily reliability.', 37.68, 47, 'https://images.unsplash.com/photo-1522337360788-8b13dee7a37e?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Beauty & Personal Care' LIMIT 1), '10000000-0000-0000-0000-000000000004'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000400');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000401', 'CeraVe Exfoliating BHA Liquid - Edition 11', 'Engineered by CeraVe. The Exfoliating BHA Liquid comes equipped Sulfate-Free & Fragrance-Free. Designed for superior performance, premium durability, and daily reliability.', 42.83, 60, 'https://images.unsplash.com/photo-1535585209827-a15fcdbc4c2d?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Beauty & Personal Care' LIMIT 1), '10000000-0000-0000-0000-000000000004'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000401');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000402', 'L''Occitane Shea Butter Hand Balm - Edition 12', 'Engineered by L''Occitane. The Shea Butter Hand Balm comes equipped Enriched with Vitamin C & E. Designed for superior performance, premium durability, and daily reliability.', 47.98, 73, 'https://images.unsplash.com/photo-1556228720-195a672e8a03?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Beauty & Personal Care' LIMIT 1), '10000000-0000-0000-0000-000000000004'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000402');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000403', 'Laneige Peptide Eye Repair Gel - Edition 13', 'Engineered by Laneige. The Peptide Eye Repair Gel comes equipped Broad Spectrum SPF 50+. Designed for superior performance, premium durability, and daily reliability.', 53.14, 86, 'https://images.unsplash.com/photo-1512496015851-a90fb38ba796?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Beauty & Personal Care' LIMIT 1), '10000000-0000-0000-0000-000000000004'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000403');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000404', 'Paula''s Choice Deep Conditioning Hair Oil - Edition 14', 'Engineered by Paula''s Choice. The Deep Conditioning Hair Oil comes equipped Cruelty-Free & 100% Vegan. Designed for superior performance, premium durability, and daily reliability.', 58.29, 99, 'https://images.unsplash.com/photo-1598440947619-2c35fc9aa908?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Beauty & Personal Care' LIMIT 1), '10000000-0000-0000-0000-000000000004'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000404');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000405', 'Drunk Elephant Bamboo Charcoal Clay Mask - Edition 15', 'Engineered by Drunk Elephant. The Bamboo Charcoal Clay Mask comes equipped Dermatologist Tested for Sensitive Skin. Designed for superior performance, premium durability, and daily reliability.', 41.74, 27, 'https://images.unsplash.com/photo-1617897903246-719242758050?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Beauty & Personal Care' LIMIT 1), '10000000-0000-0000-0000-000000000004'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000405');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000406', 'Chanel Hyaluronic Acid Hydrating Serum - Edition 16', 'Engineered by Chanel. The Hyaluronic Acid Hydrating Serum comes equipped Intense Overnight Hydration. Designed for superior performance, premium durability, and daily reliability.', 46.9, 40, 'https://images.unsplash.com/photo-1608248597359-597495085e68?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Beauty & Personal Care' LIMIT 1), '10000000-0000-0000-0000-000000000004'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000406');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000407', 'The Ordinary Eau de Parfum Spray - Edition 17', 'Engineered by The Ordinary. The Eau de Parfum Spray comes equipped Naturally Derived Organic Botanicals. Designed for superior performance, premium durability, and daily reliability.', 52.05, 53, 'https://images.unsplash.com/photo-1571781926291-c477ebfd024b?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Beauty & Personal Care' LIMIT 1), '10000000-0000-0000-0000-000000000004'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000407');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000408', 'Dior Restorative Hair Mask - Edition 18', 'Engineered by Dior. The Restorative Hair Mask comes equipped Formulated with 2% Pure Hyaluronic Acid. Designed for superior performance, premium durability, and daily reliability.', 57.21, 66, 'https://images.unsplash.com/photo-1527799820374-dcf8d9d4a388?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Beauty & Personal Care' LIMIT 1), '10000000-0000-0000-0000-000000000004'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000408');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000409', 'Kiehl''s Revitalizing Face Cleanser - Edition 19', 'Engineered by Kiehl''s. The Revitalizing Face Cleanser comes equipped Long-Lasting 12-Hour Fragrance. Designed for superior performance, premium durability, and daily reliability.', 62.36, 79, 'https://images.unsplash.com/photo-1585238342024-78d387f4a707?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Beauty & Personal Care' LIMIT 1), '10000000-0000-0000-0000-000000000004'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000409');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000410', 'Aesop Botanical Body Wash - Edition 20', 'Engineered by Aesop. The Botanical Body Wash comes equipped Bond Building Repair Formula. Designed for superior performance, premium durability, and daily reliability.', 67.51, 92, 'https://images.unsplash.com/photo-1522337360788-8b13dee7a37e?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Beauty & Personal Care' LIMIT 1), '10000000-0000-0000-0000-000000000004'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000410');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000411', 'La Mer Niacinamide Glow Tonic - Edition 01', 'Engineered by La Mer. The Niacinamide Glow Tonic comes equipped Sulfate-Free & Fragrance-Free. Designed for superior performance, premium durability, and daily reliability.', 72.67, 20, 'https://images.unsplash.com/photo-1535585209827-a15fcdbc4c2d?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Beauty & Personal Care' LIMIT 1), '10000000-0000-0000-0000-000000000004'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000411');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000412', 'Olaplex Anti-Aging Night Cream - Edition 02', 'Engineered by Olaplex. The Anti-Aging Night Cream comes equipped Enriched with Vitamin C & E. Designed for superior performance, premium durability, and daily reliability.', 56.12, 33, 'https://images.unsplash.com/photo-1556228720-195a672e8a03?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Beauty & Personal Care' LIMIT 1), '10000000-0000-0000-0000-000000000004'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000412');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000413', 'Estée Lauder Lip Sleeping Mask - Edition 03', 'Engineered by Estée Lauder. The Lip Sleeping Mask comes equipped Broad Spectrum SPF 50+. Designed for superior performance, premium durability, and daily reliability.', 61.28, 46, 'https://images.unsplash.com/photo-1512496015851-a90fb38ba796?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Beauty & Personal Care' LIMIT 1), '10000000-0000-0000-0000-000000000004'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000413');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000414', 'Glossier Velvet Matte Lipstick - Edition 04', 'Engineered by Glossier. The Velvet Matte Lipstick comes equipped Cruelty-Free & 100% Vegan. Designed for superior performance, premium durability, and daily reliability.', 66.43, 59, 'https://images.unsplash.com/photo-1598440947619-2c35fc9aa908?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Beauty & Personal Care' LIMIT 1), '10000000-0000-0000-0000-000000000004'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000414');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000415', 'Fenty Beauty Hydrating Mineral Sunscreen - Edition 05', 'Engineered by Fenty Beauty. The Hydrating Mineral Sunscreen comes equipped Dermatologist Tested for Sensitive Skin. Designed for superior performance, premium durability, and daily reliability.', 71.58, 72, 'https://images.unsplash.com/photo-1617897903246-719242758050?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Beauty & Personal Care' LIMIT 1), '10000000-0000-0000-0000-000000000004'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000415');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000416', 'CeraVe Exfoliating BHA Liquid - Edition 06', 'Engineered by CeraVe. The Exfoliating BHA Liquid comes equipped Intense Overnight Hydration. Designed for superior performance, premium durability, and daily reliability.', 76.74, 85, 'https://images.unsplash.com/photo-1608248597359-597495085e68?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Beauty & Personal Care' LIMIT 1), '10000000-0000-0000-0000-000000000004'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000416');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000417', 'L''Occitane Shea Butter Hand Balm - Edition 07', 'Engineered by L''Occitane. The Shea Butter Hand Balm comes equipped Naturally Derived Organic Botanicals. Designed for superior performance, premium durability, and daily reliability.', 81.89, 98, 'https://images.unsplash.com/photo-1571781926291-c477ebfd024b?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Beauty & Personal Care' LIMIT 1), '10000000-0000-0000-0000-000000000004'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000417');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000418', 'Laneige Peptide Eye Repair Gel - Edition 08', 'Engineered by Laneige. The Peptide Eye Repair Gel comes equipped Formulated with 2% Pure Hyaluronic Acid. Designed for superior performance, premium durability, and daily reliability.', 87.05, 26, 'https://images.unsplash.com/photo-1527799820374-dcf8d9d4a388?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Beauty & Personal Care' LIMIT 1), '10000000-0000-0000-0000-000000000004'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000418');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000419', 'Paula''s Choice Deep Conditioning Hair Oil - Edition 09', 'Engineered by Paula''s Choice. The Deep Conditioning Hair Oil comes equipped Long-Lasting 12-Hour Fragrance. Designed for superior performance, premium durability, and daily reliability.', 70.5, 39, 'https://images.unsplash.com/photo-1585238342024-78d387f4a707?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Beauty & Personal Care' LIMIT 1), '10000000-0000-0000-0000-000000000004'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000419');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000420', 'Drunk Elephant Bamboo Charcoal Clay Mask - Edition 10', 'Engineered by Drunk Elephant. The Bamboo Charcoal Clay Mask comes equipped Bond Building Repair Formula. Designed for superior performance, premium durability, and daily reliability.', 75.65, 52, 'https://images.unsplash.com/photo-1522337360788-8b13dee7a37e?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Beauty & Personal Care' LIMIT 1), '10000000-0000-0000-0000-000000000004'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000420');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000421', 'Chanel Hyaluronic Acid Hydrating Serum - Edition 11', 'Engineered by Chanel. The Hyaluronic Acid Hydrating Serum comes equipped Sulfate-Free & Fragrance-Free. Designed for superior performance, premium durability, and daily reliability.', 80.81, 65, 'https://images.unsplash.com/photo-1535585209827-a15fcdbc4c2d?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Beauty & Personal Care' LIMIT 1), '10000000-0000-0000-0000-000000000004'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000421');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000422', 'The Ordinary Eau de Parfum Spray - Edition 12', 'Engineered by The Ordinary. The Eau de Parfum Spray comes equipped Enriched with Vitamin C & E. Designed for superior performance, premium durability, and daily reliability.', 85.96, 78, 'https://images.unsplash.com/photo-1556228720-195a672e8a03?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Beauty & Personal Care' LIMIT 1), '10000000-0000-0000-0000-000000000004'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000422');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000423', 'Dior Restorative Hair Mask - Edition 13', 'Engineered by Dior. The Restorative Hair Mask comes equipped Broad Spectrum SPF 50+. Designed for superior performance, premium durability, and daily reliability.', 91.12, 91, 'https://images.unsplash.com/photo-1512496015851-a90fb38ba796?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Beauty & Personal Care' LIMIT 1), '10000000-0000-0000-0000-000000000004'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000423');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000424', 'Kiehl''s Revitalizing Face Cleanser - Edition 14', 'Engineered by Kiehl''s. The Revitalizing Face Cleanser comes equipped Cruelty-Free & 100% Vegan. Designed for superior performance, premium durability, and daily reliability.', 96.27, 19, 'https://images.unsplash.com/photo-1598440947619-2c35fc9aa908?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Beauty & Personal Care' LIMIT 1), '10000000-0000-0000-0000-000000000004'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000424');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000425', 'Aesop Botanical Body Wash - Edition 15', 'Engineered by Aesop. The Botanical Body Wash comes equipped Dermatologist Tested for Sensitive Skin. Designed for superior performance, premium durability, and daily reliability.', 101.42, 32, 'https://images.unsplash.com/photo-1617897903246-719242758050?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Beauty & Personal Care' LIMIT 1), '10000000-0000-0000-0000-000000000004'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000425');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000426', 'La Mer Niacinamide Glow Tonic - Edition 16', 'Engineered by La Mer. The Niacinamide Glow Tonic comes equipped Intense Overnight Hydration. Designed for superior performance, premium durability, and daily reliability.', 84.88, 45, 'https://images.unsplash.com/photo-1608248597359-597495085e68?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Beauty & Personal Care' LIMIT 1), '10000000-0000-0000-0000-000000000004'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000426');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000427', 'Olaplex Anti-Aging Night Cream - Edition 17', 'Engineered by Olaplex. The Anti-Aging Night Cream comes equipped Naturally Derived Organic Botanicals. Designed for superior performance, premium durability, and daily reliability.', 90.03, 58, 'https://images.unsplash.com/photo-1571781926291-c477ebfd024b?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Beauty & Personal Care' LIMIT 1), '10000000-0000-0000-0000-000000000004'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000427');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000428', 'Estée Lauder Lip Sleeping Mask - Edition 18', 'Engineered by Estée Lauder. The Lip Sleeping Mask comes equipped Formulated with 2% Pure Hyaluronic Acid. Designed for superior performance, premium durability, and daily reliability.', 95.19, 71, 'https://images.unsplash.com/photo-1527799820374-dcf8d9d4a388?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Beauty & Personal Care' LIMIT 1), '10000000-0000-0000-0000-000000000004'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000428');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000429', 'Glossier Velvet Matte Lipstick - Edition 19', 'Engineered by Glossier. The Velvet Matte Lipstick comes equipped Long-Lasting 12-Hour Fragrance. Designed for superior performance, premium durability, and daily reliability.', 100.34, 84, 'https://images.unsplash.com/photo-1585238342024-78d387f4a707?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Beauty & Personal Care' LIMIT 1), '10000000-0000-0000-0000-000000000004'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000429');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000430', 'Fenty Beauty Hydrating Mineral Sunscreen - Edition 20', 'Engineered by Fenty Beauty. The Hydrating Mineral Sunscreen comes equipped Bond Building Repair Formula. Designed for superior performance, premium durability, and daily reliability.', 105.49, 97, 'https://images.unsplash.com/photo-1522337360788-8b13dee7a37e?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Beauty & Personal Care' LIMIT 1), '10000000-0000-0000-0000-000000000004'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000430');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000431', 'CeraVe Exfoliating BHA Liquid - Edition 01', 'Engineered by CeraVe. The Exfoliating BHA Liquid comes equipped Sulfate-Free & Fragrance-Free. Designed for superior performance, premium durability, and daily reliability.', 110.65, 25, 'https://images.unsplash.com/photo-1535585209827-a15fcdbc4c2d?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Beauty & Personal Care' LIMIT 1), '10000000-0000-0000-0000-000000000004'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000431');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000432', 'L''Occitane Shea Butter Hand Balm - Edition 02', 'Engineered by L''Occitane. The Shea Butter Hand Balm comes equipped Enriched with Vitamin C & E. Designed for superior performance, premium durability, and daily reliability.', 115.8, 38, 'https://images.unsplash.com/photo-1556228720-195a672e8a03?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Beauty & Personal Care' LIMIT 1), '10000000-0000-0000-0000-000000000004'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000432');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000433', 'Laneige Peptide Eye Repair Gel - Edition 03', 'Engineered by Laneige. The Peptide Eye Repair Gel comes equipped Broad Spectrum SPF 50+. Designed for superior performance, premium durability, and daily reliability.', 99.25, 51, 'https://images.unsplash.com/photo-1512496015851-a90fb38ba796?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Beauty & Personal Care' LIMIT 1), '10000000-0000-0000-0000-000000000004'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000433');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000434', 'Paula''s Choice Deep Conditioning Hair Oil - Edition 04', 'Engineered by Paula''s Choice. The Deep Conditioning Hair Oil comes equipped Cruelty-Free & 100% Vegan. Designed for superior performance, premium durability, and daily reliability.', 104.41, 64, 'https://images.unsplash.com/photo-1598440947619-2c35fc9aa908?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Beauty & Personal Care' LIMIT 1), '10000000-0000-0000-0000-000000000004'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000434');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000435', 'Drunk Elephant Bamboo Charcoal Clay Mask - Edition 05', 'Engineered by Drunk Elephant. The Bamboo Charcoal Clay Mask comes equipped Dermatologist Tested for Sensitive Skin. Designed for superior performance, premium durability, and daily reliability.', 109.56, 77, 'https://images.unsplash.com/photo-1617897903246-719242758050?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Beauty & Personal Care' LIMIT 1), '10000000-0000-0000-0000-000000000004'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000435');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000436', 'Chanel Hyaluronic Acid Hydrating Serum - Edition 06', 'Engineered by Chanel. The Hyaluronic Acid Hydrating Serum comes equipped Intense Overnight Hydration. Designed for superior performance, premium durability, and daily reliability.', 114.72, 90, 'https://images.unsplash.com/photo-1608248597359-597495085e68?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Beauty & Personal Care' LIMIT 1), '10000000-0000-0000-0000-000000000004'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000436');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000437', 'The Ordinary Eau de Parfum Spray - Edition 07', 'Engineered by The Ordinary. The Eau de Parfum Spray comes equipped Naturally Derived Organic Botanicals. Designed for superior performance, premium durability, and daily reliability.', 119.87, 18, 'https://images.unsplash.com/photo-1571781926291-c477ebfd024b?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Beauty & Personal Care' LIMIT 1), '10000000-0000-0000-0000-000000000004'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000437');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000438', 'Dior Restorative Hair Mask - Edition 08', 'Engineered by Dior. The Restorative Hair Mask comes equipped Formulated with 2% Pure Hyaluronic Acid. Designed for superior performance, premium durability, and daily reliability.', 125.02, 31, 'https://images.unsplash.com/photo-1527799820374-dcf8d9d4a388?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Beauty & Personal Care' LIMIT 1), '10000000-0000-0000-0000-000000000004'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000438');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000439', 'Kiehl''s Revitalizing Face Cleanser - Edition 09', 'Engineered by Kiehl''s. The Revitalizing Face Cleanser comes equipped Long-Lasting 12-Hour Fragrance. Designed for superior performance, premium durability, and daily reliability.', 130.18, 44, 'https://images.unsplash.com/photo-1585238342024-78d387f4a707?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Beauty & Personal Care' LIMIT 1), '10000000-0000-0000-0000-000000000004'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000439');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000440', 'Aesop Botanical Body Wash - Edition 10', 'Engineered by Aesop. The Botanical Body Wash comes equipped Bond Building Repair Formula. Designed for superior performance, premium durability, and daily reliability.', 113.63, 57, 'https://images.unsplash.com/photo-1522337360788-8b13dee7a37e?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Beauty & Personal Care' LIMIT 1), '10000000-0000-0000-0000-000000000004'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000440');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000441', 'La Mer Niacinamide Glow Tonic - Edition 11', 'Engineered by La Mer. The Niacinamide Glow Tonic comes equipped Sulfate-Free & Fragrance-Free. Designed for superior performance, premium durability, and daily reliability.', 118.79, 70, 'https://images.unsplash.com/photo-1535585209827-a15fcdbc4c2d?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Beauty & Personal Care' LIMIT 1), '10000000-0000-0000-0000-000000000004'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000441');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000442', 'Olaplex Anti-Aging Night Cream - Edition 12', 'Engineered by Olaplex. The Anti-Aging Night Cream comes equipped Enriched with Vitamin C & E. Designed for superior performance, premium durability, and daily reliability.', 123.94, 83, 'https://images.unsplash.com/photo-1556228720-195a672e8a03?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Beauty & Personal Care' LIMIT 1), '10000000-0000-0000-0000-000000000004'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000442');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000443', 'Estée Lauder Lip Sleeping Mask - Edition 13', 'Engineered by Estée Lauder. The Lip Sleeping Mask comes equipped Broad Spectrum SPF 50+. Designed for superior performance, premium durability, and daily reliability.', 129.09, 96, 'https://images.unsplash.com/photo-1512496015851-a90fb38ba796?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Beauty & Personal Care' LIMIT 1), '10000000-0000-0000-0000-000000000004'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000443');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000444', 'Glossier Velvet Matte Lipstick - Edition 14', 'Engineered by Glossier. The Velvet Matte Lipstick comes equipped Cruelty-Free & 100% Vegan. Designed for superior performance, premium durability, and daily reliability.', 134.25, 24, 'https://images.unsplash.com/photo-1598440947619-2c35fc9aa908?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Beauty & Personal Care' LIMIT 1), '10000000-0000-0000-0000-000000000004'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000444');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000445', 'Fenty Beauty Hydrating Mineral Sunscreen - Edition 15', 'Engineered by Fenty Beauty. The Hydrating Mineral Sunscreen comes equipped Dermatologist Tested for Sensitive Skin. Designed for superior performance, premium durability, and daily reliability.', 139.4, 37, 'https://images.unsplash.com/photo-1617897903246-719242758050?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Beauty & Personal Care' LIMIT 1), '10000000-0000-0000-0000-000000000004'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000445');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000446', 'CeraVe Exfoliating BHA Liquid - Edition 16', 'Engineered by CeraVe. The Exfoliating BHA Liquid comes equipped Intense Overnight Hydration. Designed for superior performance, premium durability, and daily reliability.', 144.56, 50, 'https://images.unsplash.com/photo-1608248597359-597495085e68?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Beauty & Personal Care' LIMIT 1), '10000000-0000-0000-0000-000000000004'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000446');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000447', 'L''Occitane Shea Butter Hand Balm - Edition 17', 'Engineered by L''Occitane. The Shea Butter Hand Balm comes equipped Naturally Derived Organic Botanicals. Designed for superior performance, premium durability, and daily reliability.', 128.01, 63, 'https://images.unsplash.com/photo-1571781926291-c477ebfd024b?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Beauty & Personal Care' LIMIT 1), '10000000-0000-0000-0000-000000000004'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000447');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000448', 'Laneige Peptide Eye Repair Gel - Edition 18', 'Engineered by Laneige. The Peptide Eye Repair Gel comes equipped Formulated with 2% Pure Hyaluronic Acid. Designed for superior performance, premium durability, and daily reliability.', 133.16, 76, 'https://images.unsplash.com/photo-1527799820374-dcf8d9d4a388?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Beauty & Personal Care' LIMIT 1), '10000000-0000-0000-0000-000000000004'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000448');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000449', 'Paula''s Choice Deep Conditioning Hair Oil - Edition 19', 'Engineered by Paula''s Choice. The Deep Conditioning Hair Oil comes equipped Long-Lasting 12-Hour Fragrance. Designed for superior performance, premium durability, and daily reliability.', 138.32, 89, 'https://images.unsplash.com/photo-1585238342024-78d387f4a707?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Beauty & Personal Care' LIMIT 1), '10000000-0000-0000-0000-000000000004'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000449');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000450', 'Drunk Elephant Bamboo Charcoal Clay Mask - Edition 20', 'Engineered by Drunk Elephant. The Bamboo Charcoal Clay Mask comes equipped Bond Building Repair Formula. Designed for superior performance, premium durability, and daily reliability.', 143.47, 17, 'https://images.unsplash.com/photo-1522337360788-8b13dee7a37e?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Beauty & Personal Care' LIMIT 1), '10000000-0000-0000-0000-000000000004'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000450');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000451', 'Chanel Hyaluronic Acid Hydrating Serum - Edition 01', 'Engineered by Chanel. The Hyaluronic Acid Hydrating Serum comes equipped Sulfate-Free & Fragrance-Free. Designed for superior performance, premium durability, and daily reliability.', 148.63, 30, 'https://images.unsplash.com/photo-1535585209827-a15fcdbc4c2d?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Beauty & Personal Care' LIMIT 1), '10000000-0000-0000-0000-000000000004'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000451');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000452', 'The Ordinary Eau de Parfum Spray - Edition 02', 'Engineered by The Ordinary. The Eau de Parfum Spray comes equipped Enriched with Vitamin C & E. Designed for superior performance, premium durability, and daily reliability.', 153.78, 43, 'https://images.unsplash.com/photo-1556228720-195a672e8a03?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Beauty & Personal Care' LIMIT 1), '10000000-0000-0000-0000-000000000004'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000452');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000453', 'Dior Restorative Hair Mask - Edition 03', 'Engineered by Dior. The Restorative Hair Mask comes equipped Broad Spectrum SPF 50+. Designed for superior performance, premium durability, and daily reliability.', 158.93, 56, 'https://images.unsplash.com/photo-1512496015851-a90fb38ba796?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Beauty & Personal Care' LIMIT 1), '10000000-0000-0000-0000-000000000004'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000453');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000454', 'Kiehl''s Revitalizing Face Cleanser - Edition 04', 'Engineered by Kiehl''s. The Revitalizing Face Cleanser comes equipped Cruelty-Free & 100% Vegan. Designed for superior performance, premium durability, and daily reliability.', 142.39, 69, 'https://images.unsplash.com/photo-1598440947619-2c35fc9aa908?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Beauty & Personal Care' LIMIT 1), '10000000-0000-0000-0000-000000000004'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000454');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000455', 'Aesop Botanical Body Wash - Edition 05', 'Engineered by Aesop. The Botanical Body Wash comes equipped Dermatologist Tested for Sensitive Skin. Designed for superior performance, premium durability, and daily reliability.', 147.54, 82, 'https://images.unsplash.com/photo-1617897903246-719242758050?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Beauty & Personal Care' LIMIT 1), '10000000-0000-0000-0000-000000000004'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000455');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000456', 'La Mer Niacinamide Glow Tonic - Edition 06', 'Engineered by La Mer. The Niacinamide Glow Tonic comes equipped Intense Overnight Hydration. Designed for superior performance, premium durability, and daily reliability.', 152.69, 95, 'https://images.unsplash.com/photo-1608248597359-597495085e68?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Beauty & Personal Care' LIMIT 1), '10000000-0000-0000-0000-000000000004'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000456');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000457', 'Olaplex Anti-Aging Night Cream - Edition 07', 'Engineered by Olaplex. The Anti-Aging Night Cream comes equipped Naturally Derived Organic Botanicals. Designed for superior performance, premium durability, and daily reliability.', 157.85, 23, 'https://images.unsplash.com/photo-1571781926291-c477ebfd024b?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Beauty & Personal Care' LIMIT 1), '10000000-0000-0000-0000-000000000004'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000457');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000458', 'Estée Lauder Lip Sleeping Mask - Edition 08', 'Engineered by Estée Lauder. The Lip Sleeping Mask comes equipped Formulated with 2% Pure Hyaluronic Acid. Designed for superior performance, premium durability, and daily reliability.', 163.0, 36, 'https://images.unsplash.com/photo-1527799820374-dcf8d9d4a388?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Beauty & Personal Care' LIMIT 1), '10000000-0000-0000-0000-000000000004'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000458');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000459', 'Glossier Velvet Matte Lipstick - Edition 09', 'Engineered by Glossier. The Velvet Matte Lipstick comes equipped Long-Lasting 12-Hour Fragrance. Designed for superior performance, premium durability, and daily reliability.', 168.16, 49, 'https://images.unsplash.com/photo-1585238342024-78d387f4a707?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Beauty & Personal Care' LIMIT 1), '10000000-0000-0000-0000-000000000004'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000459');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000460', 'Fenty Beauty Hydrating Mineral Sunscreen - Edition 10', 'Engineered by Fenty Beauty. The Hydrating Mineral Sunscreen comes equipped Bond Building Repair Formula. Designed for superior performance, premium durability, and daily reliability.', 173.31, 62, 'https://images.unsplash.com/photo-1522337360788-8b13dee7a37e?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Beauty & Personal Care' LIMIT 1), '10000000-0000-0000-0000-000000000004'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000460');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000461', 'CeraVe Exfoliating BHA Liquid - Edition 11', 'Engineered by CeraVe. The Exfoliating BHA Liquid comes equipped Sulfate-Free & Fragrance-Free. Designed for superior performance, premium durability, and daily reliability.', 156.76, 75, 'https://images.unsplash.com/photo-1535585209827-a15fcdbc4c2d?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Beauty & Personal Care' LIMIT 1), '10000000-0000-0000-0000-000000000004'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000461');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000462', 'L''Occitane Shea Butter Hand Balm - Edition 12', 'Engineered by L''Occitane. The Shea Butter Hand Balm comes equipped Enriched with Vitamin C & E. Designed for superior performance, premium durability, and daily reliability.', 161.92, 88, 'https://images.unsplash.com/photo-1556228720-195a672e8a03?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Beauty & Personal Care' LIMIT 1), '10000000-0000-0000-0000-000000000004'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000462');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000463', 'Laneige Peptide Eye Repair Gel - Edition 13', 'Engineered by Laneige. The Peptide Eye Repair Gel comes equipped Broad Spectrum SPF 50+. Designed for superior performance, premium durability, and daily reliability.', 167.07, 16, 'https://images.unsplash.com/photo-1512496015851-a90fb38ba796?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Beauty & Personal Care' LIMIT 1), '10000000-0000-0000-0000-000000000004'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000463');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000464', 'Paula''s Choice Deep Conditioning Hair Oil - Edition 14', 'Engineered by Paula''s Choice. The Deep Conditioning Hair Oil comes equipped Cruelty-Free & 100% Vegan. Designed for superior performance, premium durability, and daily reliability.', 172.23, 29, 'https://images.unsplash.com/photo-1598440947619-2c35fc9aa908?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Beauty & Personal Care' LIMIT 1), '10000000-0000-0000-0000-000000000004'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000464');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000465', 'Drunk Elephant Bamboo Charcoal Clay Mask - Edition 15', 'Engineered by Drunk Elephant. The Bamboo Charcoal Clay Mask comes equipped Dermatologist Tested for Sensitive Skin. Designed for superior performance, premium durability, and daily reliability.', 177.38, 42, 'https://images.unsplash.com/photo-1617897903246-719242758050?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Beauty & Personal Care' LIMIT 1), '10000000-0000-0000-0000-000000000004'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000465');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000466', 'Chanel Hyaluronic Acid Hydrating Serum - Edition 16', 'Engineered by Chanel. The Hyaluronic Acid Hydrating Serum comes equipped Intense Overnight Hydration. Designed for superior performance, premium durability, and daily reliability.', 182.53, 55, 'https://images.unsplash.com/photo-1608248597359-597495085e68?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Beauty & Personal Care' LIMIT 1), '10000000-0000-0000-0000-000000000004'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000466');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000467', 'The Ordinary Eau de Parfum Spray - Edition 17', 'Engineered by The Ordinary. The Eau de Parfum Spray comes equipped Naturally Derived Organic Botanicals. Designed for superior performance, premium durability, and daily reliability.', 187.69, 68, 'https://images.unsplash.com/photo-1571781926291-c477ebfd024b?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Beauty & Personal Care' LIMIT 1), '10000000-0000-0000-0000-000000000004'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000467');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000468', 'Dior Restorative Hair Mask - Edition 18', 'Engineered by Dior. The Restorative Hair Mask comes equipped Formulated with 2% Pure Hyaluronic Acid. Designed for superior performance, premium durability, and daily reliability.', 171.14, 81, 'https://images.unsplash.com/photo-1527799820374-dcf8d9d4a388?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Beauty & Personal Care' LIMIT 1), '10000000-0000-0000-0000-000000000004'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000468');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000469', 'Kiehl''s Revitalizing Face Cleanser - Edition 19', 'Engineered by Kiehl''s. The Revitalizing Face Cleanser comes equipped Long-Lasting 12-Hour Fragrance. Designed for superior performance, premium durability, and daily reliability.', 176.3, 94, 'https://images.unsplash.com/photo-1585238342024-78d387f4a707?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Beauty & Personal Care' LIMIT 1), '10000000-0000-0000-0000-000000000004'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000469');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000470', 'Aesop Botanical Body Wash - Edition 20', 'Engineered by Aesop. The Botanical Body Wash comes equipped Bond Building Repair Formula. Designed for superior performance, premium durability, and daily reliability.', 181.45, 22, 'https://images.unsplash.com/photo-1522337360788-8b13dee7a37e?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Beauty & Personal Care' LIMIT 1), '10000000-0000-0000-0000-000000000004'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000470');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000471', 'La Mer Niacinamide Glow Tonic - Edition 01', 'Engineered by La Mer. The Niacinamide Glow Tonic comes equipped Sulfate-Free & Fragrance-Free. Designed for superior performance, premium durability, and daily reliability.', 186.6, 35, 'https://images.unsplash.com/photo-1535585209827-a15fcdbc4c2d?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Beauty & Personal Care' LIMIT 1), '10000000-0000-0000-0000-000000000004'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000471');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000472', 'Olaplex Anti-Aging Night Cream - Edition 02', 'Engineered by Olaplex. The Anti-Aging Night Cream comes equipped Enriched with Vitamin C & E. Designed for superior performance, premium durability, and daily reliability.', 191.76, 48, 'https://images.unsplash.com/photo-1556228720-195a672e8a03?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Beauty & Personal Care' LIMIT 1), '10000000-0000-0000-0000-000000000004'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000472');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000473', 'Estée Lauder Lip Sleeping Mask - Edition 03', 'Engineered by Estée Lauder. The Lip Sleeping Mask comes equipped Broad Spectrum SPF 50+. Designed for superior performance, premium durability, and daily reliability.', 196.91, 61, 'https://images.unsplash.com/photo-1512496015851-a90fb38ba796?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Beauty & Personal Care' LIMIT 1), '10000000-0000-0000-0000-000000000004'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000473');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000474', 'Glossier Velvet Matte Lipstick - Edition 04', 'Engineered by Glossier. The Velvet Matte Lipstick comes equipped Cruelty-Free & 100% Vegan. Designed for superior performance, premium durability, and daily reliability.', 202.07, 74, 'https://images.unsplash.com/photo-1598440947619-2c35fc9aa908?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Beauty & Personal Care' LIMIT 1), '10000000-0000-0000-0000-000000000004'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000474');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000475', 'Fenty Beauty Hydrating Mineral Sunscreen - Edition 05', 'Engineered by Fenty Beauty. The Hydrating Mineral Sunscreen comes equipped Dermatologist Tested for Sensitive Skin. Designed for superior performance, premium durability, and daily reliability.', 185.52, 87, 'https://images.unsplash.com/photo-1617897903246-719242758050?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Beauty & Personal Care' LIMIT 1), '10000000-0000-0000-0000-000000000004'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000475');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000476', 'CeraVe Exfoliating BHA Liquid - Edition 06', 'Engineered by CeraVe. The Exfoliating BHA Liquid comes equipped Intense Overnight Hydration. Designed for superior performance, premium durability, and daily reliability.', 190.67, 15, 'https://images.unsplash.com/photo-1608248597359-597495085e68?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Beauty & Personal Care' LIMIT 1), '10000000-0000-0000-0000-000000000004'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000476');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000477', 'L''Occitane Shea Butter Hand Balm - Edition 07', 'Engineered by L''Occitane. The Shea Butter Hand Balm comes equipped Naturally Derived Organic Botanicals. Designed for superior performance, premium durability, and daily reliability.', 195.83, 28, 'https://images.unsplash.com/photo-1571781926291-c477ebfd024b?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Beauty & Personal Care' LIMIT 1), '10000000-0000-0000-0000-000000000004'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000477');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000478', 'Laneige Peptide Eye Repair Gel - Edition 08', 'Engineered by Laneige. The Peptide Eye Repair Gel comes equipped Formulated with 2% Pure Hyaluronic Acid. Designed for superior performance, premium durability, and daily reliability.', 200.98, 41, 'https://images.unsplash.com/photo-1527799820374-dcf8d9d4a388?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Beauty & Personal Care' LIMIT 1), '10000000-0000-0000-0000-000000000004'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000478');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000479', 'Paula''s Choice Deep Conditioning Hair Oil - Edition 09', 'Engineered by Paula''s Choice. The Deep Conditioning Hair Oil comes equipped Long-Lasting 12-Hour Fragrance. Designed for superior performance, premium durability, and daily reliability.', 206.14, 54, 'https://images.unsplash.com/photo-1585238342024-78d387f4a707?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Beauty & Personal Care' LIMIT 1), '10000000-0000-0000-0000-000000000004'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000479');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000480', 'Drunk Elephant Bamboo Charcoal Clay Mask - Edition 10', 'Engineered by Drunk Elephant. The Bamboo Charcoal Clay Mask comes equipped Bond Building Repair Formula. Designed for superior performance, premium durability, and daily reliability.', 211.29, 67, 'https://images.unsplash.com/photo-1522337360788-8b13dee7a37e?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Beauty & Personal Care' LIMIT 1), '10000000-0000-0000-0000-000000000004'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000480');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000481', 'Chanel Hyaluronic Acid Hydrating Serum - Edition 11', 'Engineered by Chanel. The Hyaluronic Acid Hydrating Serum comes equipped Sulfate-Free & Fragrance-Free. Designed for superior performance, premium durability, and daily reliability.', 216.44, 80, 'https://images.unsplash.com/photo-1535585209827-a15fcdbc4c2d?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Beauty & Personal Care' LIMIT 1), '10000000-0000-0000-0000-000000000004'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000481');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000482', 'The Ordinary Eau de Parfum Spray - Edition 12', 'Engineered by The Ordinary. The Eau de Parfum Spray comes equipped Enriched with Vitamin C & E. Designed for superior performance, premium durability, and daily reliability.', 199.9, 93, 'https://images.unsplash.com/photo-1556228720-195a672e8a03?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Beauty & Personal Care' LIMIT 1), '10000000-0000-0000-0000-000000000004'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000482');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000483', 'Dior Restorative Hair Mask - Edition 13', 'Engineered by Dior. The Restorative Hair Mask comes equipped Broad Spectrum SPF 50+. Designed for superior performance, premium durability, and daily reliability.', 205.05, 21, 'https://images.unsplash.com/photo-1512496015851-a90fb38ba796?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Beauty & Personal Care' LIMIT 1), '10000000-0000-0000-0000-000000000004'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000483');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000484', 'Kiehl''s Revitalizing Face Cleanser - Edition 14', 'Engineered by Kiehl''s. The Revitalizing Face Cleanser comes equipped Cruelty-Free & 100% Vegan. Designed for superior performance, premium durability, and daily reliability.', 210.2, 34, 'https://images.unsplash.com/photo-1598440947619-2c35fc9aa908?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Beauty & Personal Care' LIMIT 1), '10000000-0000-0000-0000-000000000004'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000484');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000485', 'Aesop Botanical Body Wash - Edition 15', 'Engineered by Aesop. The Botanical Body Wash comes equipped Dermatologist Tested for Sensitive Skin. Designed for superior performance, premium durability, and daily reliability.', 215.36, 47, 'https://images.unsplash.com/photo-1617897903246-719242758050?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Beauty & Personal Care' LIMIT 1), '10000000-0000-0000-0000-000000000004'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000485');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000486', 'La Mer Niacinamide Glow Tonic - Edition 16', 'Engineered by La Mer. The Niacinamide Glow Tonic comes equipped Intense Overnight Hydration. Designed for superior performance, premium durability, and daily reliability.', 220.51, 60, 'https://images.unsplash.com/photo-1608248597359-597495085e68?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Beauty & Personal Care' LIMIT 1), '10000000-0000-0000-0000-000000000004'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000486');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000487', 'Olaplex Anti-Aging Night Cream - Edition 17', 'Engineered by Olaplex. The Anti-Aging Night Cream comes equipped Naturally Derived Organic Botanicals. Designed for superior performance, premium durability, and daily reliability.', 225.67, 73, 'https://images.unsplash.com/photo-1571781926291-c477ebfd024b?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Beauty & Personal Care' LIMIT 1), '10000000-0000-0000-0000-000000000004'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000487');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000488', 'Estée Lauder Lip Sleeping Mask - Edition 18', 'Engineered by Estée Lauder. The Lip Sleeping Mask comes equipped Formulated with 2% Pure Hyaluronic Acid. Designed for superior performance, premium durability, and daily reliability.', 230.82, 86, 'https://images.unsplash.com/photo-1527799820374-dcf8d9d4a388?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Beauty & Personal Care' LIMIT 1), '10000000-0000-0000-0000-000000000004'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000488');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000489', 'Glossier Velvet Matte Lipstick - Edition 19', 'Engineered by Glossier. The Velvet Matte Lipstick comes equipped Long-Lasting 12-Hour Fragrance. Designed for superior performance, premium durability, and daily reliability.', 214.27, 99, 'https://images.unsplash.com/photo-1585238342024-78d387f4a707?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Beauty & Personal Care' LIMIT 1), '10000000-0000-0000-0000-000000000004'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000489');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000490', 'Fenty Beauty Hydrating Mineral Sunscreen - Edition 20', 'Engineered by Fenty Beauty. The Hydrating Mineral Sunscreen comes equipped Bond Building Repair Formula. Designed for superior performance, premium durability, and daily reliability.', 219.43, 27, 'https://images.unsplash.com/photo-1522337360788-8b13dee7a37e?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Beauty & Personal Care' LIMIT 1), '10000000-0000-0000-0000-000000000004'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000490');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000491', 'CeraVe Exfoliating BHA Liquid - Edition 01', 'Engineered by CeraVe. The Exfoliating BHA Liquid comes equipped Sulfate-Free & Fragrance-Free. Designed for superior performance, premium durability, and daily reliability.', 224.58, 40, 'https://images.unsplash.com/photo-1535585209827-a15fcdbc4c2d?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Beauty & Personal Care' LIMIT 1), '10000000-0000-0000-0000-000000000004'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000491');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000492', 'L''Occitane Shea Butter Hand Balm - Edition 02', 'Engineered by L''Occitane. The Shea Butter Hand Balm comes equipped Enriched with Vitamin C & E. Designed for superior performance, premium durability, and daily reliability.', 229.74, 53, 'https://images.unsplash.com/photo-1556228720-195a672e8a03?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Beauty & Personal Care' LIMIT 1), '10000000-0000-0000-0000-000000000004'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000492');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000493', 'Laneige Peptide Eye Repair Gel - Edition 03', 'Engineered by Laneige. The Peptide Eye Repair Gel comes equipped Broad Spectrum SPF 50+. Designed for superior performance, premium durability, and daily reliability.', 234.89, 66, 'https://images.unsplash.com/photo-1512496015851-a90fb38ba796?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Beauty & Personal Care' LIMIT 1), '10000000-0000-0000-0000-000000000004'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000493');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000494', 'Paula''s Choice Deep Conditioning Hair Oil - Edition 04', 'Engineered by Paula''s Choice. The Deep Conditioning Hair Oil comes equipped Cruelty-Free & 100% Vegan. Designed for superior performance, premium durability, and daily reliability.', 240.04, 79, 'https://images.unsplash.com/photo-1598440947619-2c35fc9aa908?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Beauty & Personal Care' LIMIT 1), '10000000-0000-0000-0000-000000000004'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000494');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000495', 'Drunk Elephant Bamboo Charcoal Clay Mask - Edition 05', 'Engineered by Drunk Elephant. The Bamboo Charcoal Clay Mask comes equipped Dermatologist Tested for Sensitive Skin. Designed for superior performance, premium durability, and daily reliability.', 245.2, 92, 'https://images.unsplash.com/photo-1617897903246-719242758050?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Beauty & Personal Care' LIMIT 1), '10000000-0000-0000-0000-000000000004'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000495');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000496', 'Chanel Hyaluronic Acid Hydrating Serum - Edition 06', 'Engineered by Chanel. The Hyaluronic Acid Hydrating Serum comes equipped Intense Overnight Hydration. Designed for superior performance, premium durability, and daily reliability.', 228.65, 20, 'https://images.unsplash.com/photo-1608248597359-597495085e68?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Beauty & Personal Care' LIMIT 1), '10000000-0000-0000-0000-000000000004'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000496');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000497', 'The Ordinary Eau de Parfum Spray - Edition 07', 'Engineered by The Ordinary. The Eau de Parfum Spray comes equipped Naturally Derived Organic Botanicals. Designed for superior performance, premium durability, and daily reliability.', 233.81, 33, 'https://images.unsplash.com/photo-1571781926291-c477ebfd024b?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Beauty & Personal Care' LIMIT 1), '10000000-0000-0000-0000-000000000004'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000497');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000498', 'Dior Restorative Hair Mask - Edition 08', 'Engineered by Dior. The Restorative Hair Mask comes equipped Formulated with 2% Pure Hyaluronic Acid. Designed for superior performance, premium durability, and daily reliability.', 238.96, 46, 'https://images.unsplash.com/photo-1527799820374-dcf8d9d4a388?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Beauty & Personal Care' LIMIT 1), '10000000-0000-0000-0000-000000000004'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000498');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000499', 'Kiehl''s Revitalizing Face Cleanser - Edition 09', 'Engineered by Kiehl''s. The Revitalizing Face Cleanser comes equipped Long-Lasting 12-Hour Fragrance. Designed for superior performance, premium durability, and daily reliability.', 244.11, 59, 'https://images.unsplash.com/photo-1585238342024-78d387f4a707?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Beauty & Personal Care' LIMIT 1), '10000000-0000-0000-0000-000000000004'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000499');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000500', 'Aesop Botanical Body Wash - Edition 10', 'Engineered by Aesop. The Botanical Body Wash comes equipped Bond Building Repair Formula. Designed for superior performance, premium durability, and daily reliability.', 249.27, 72, 'https://images.unsplash.com/photo-1522337360788-8b13dee7a37e?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Beauty & Personal Care' LIMIT 1), '10000000-0000-0000-0000-000000000004'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000500');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000501', 'La Mer Niacinamide Glow Tonic - Edition 11', 'Engineered by La Mer. The Niacinamide Glow Tonic comes equipped Sulfate-Free & Fragrance-Free. Designed for superior performance, premium durability, and daily reliability.', 254.42, 85, 'https://images.unsplash.com/photo-1535585209827-a15fcdbc4c2d?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Beauty & Personal Care' LIMIT 1), '10000000-0000-0000-0000-000000000004'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000501');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000502', 'Olaplex Anti-Aging Night Cream - Edition 12', 'Engineered by Olaplex. The Anti-Aging Night Cream comes equipped Enriched with Vitamin C & E. Designed for superior performance, premium durability, and daily reliability.', 259.58, 98, 'https://images.unsplash.com/photo-1556228720-195a672e8a03?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Beauty & Personal Care' LIMIT 1), '10000000-0000-0000-0000-000000000004'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000502');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000503', 'Estée Lauder Lip Sleeping Mask - Edition 13', 'Engineered by Estée Lauder. The Lip Sleeping Mask comes equipped Broad Spectrum SPF 50+. Designed for superior performance, premium durability, and daily reliability.', 243.03, 26, 'https://images.unsplash.com/photo-1512496015851-a90fb38ba796?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Beauty & Personal Care' LIMIT 1), '10000000-0000-0000-0000-000000000004'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000503');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000504', 'Glossier Velvet Matte Lipstick - Edition 14', 'Engineered by Glossier. The Velvet Matte Lipstick comes equipped Cruelty-Free & 100% Vegan. Designed for superior performance, premium durability, and daily reliability.', 248.18, 39, 'https://images.unsplash.com/photo-1598440947619-2c35fc9aa908?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Beauty & Personal Care' LIMIT 1), '10000000-0000-0000-0000-000000000004'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000504');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000505', 'Fenty Beauty Hydrating Mineral Sunscreen - Edition 15', 'Engineered by Fenty Beauty. The Hydrating Mineral Sunscreen comes equipped Dermatologist Tested for Sensitive Skin. Designed for superior performance, premium durability, and daily reliability.', 253.34, 52, 'https://images.unsplash.com/photo-1617897903246-719242758050?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Beauty & Personal Care' LIMIT 1), '10000000-0000-0000-0000-000000000004'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000505');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000506', 'CeraVe Exfoliating BHA Liquid - Edition 16', 'Engineered by CeraVe. The Exfoliating BHA Liquid comes equipped Intense Overnight Hydration. Designed for superior performance, premium durability, and daily reliability.', 258.49, 65, 'https://images.unsplash.com/photo-1608248597359-597495085e68?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Beauty & Personal Care' LIMIT 1), '10000000-0000-0000-0000-000000000004'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000506');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000507', 'L''Occitane Shea Butter Hand Balm - Edition 17', 'Engineered by L''Occitane. The Shea Butter Hand Balm comes equipped Naturally Derived Organic Botanicals. Designed for superior performance, premium durability, and daily reliability.', 263.65, 78, 'https://images.unsplash.com/photo-1571781926291-c477ebfd024b?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Beauty & Personal Care' LIMIT 1), '10000000-0000-0000-0000-000000000004'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000507');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000508', 'Laneige Peptide Eye Repair Gel - Edition 18', 'Engineered by Laneige. The Peptide Eye Repair Gel comes equipped Formulated with 2% Pure Hyaluronic Acid. Designed for superior performance, premium durability, and daily reliability.', 268.8, 91, 'https://images.unsplash.com/photo-1527799820374-dcf8d9d4a388?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Beauty & Personal Care' LIMIT 1), '10000000-0000-0000-0000-000000000004'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000508');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000509', 'Paula''s Choice Deep Conditioning Hair Oil - Edition 19', 'Engineered by Paula''s Choice. The Deep Conditioning Hair Oil comes equipped Long-Lasting 12-Hour Fragrance. Designed for superior performance, premium durability, and daily reliability.', 273.95, 19, 'https://images.unsplash.com/photo-1585238342024-78d387f4a707?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Beauty & Personal Care' LIMIT 1), '10000000-0000-0000-0000-000000000004'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000509');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000510', 'Drunk Elephant Bamboo Charcoal Clay Mask - Edition 20', 'Engineered by Drunk Elephant. The Bamboo Charcoal Clay Mask comes equipped Bond Building Repair Formula. Designed for superior performance, premium durability, and daily reliability.', 257.41, 32, 'https://images.unsplash.com/photo-1522337360788-8b13dee7a37e?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Beauty & Personal Care' LIMIT 1), '10000000-0000-0000-0000-000000000004'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000510');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000511', 'Chanel Hyaluronic Acid Hydrating Serum - Edition 01', 'Engineered by Chanel. The Hyaluronic Acid Hydrating Serum comes equipped Sulfate-Free & Fragrance-Free. Designed for superior performance, premium durability, and daily reliability.', 262.56, 45, 'https://images.unsplash.com/photo-1535585209827-a15fcdbc4c2d?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Beauty & Personal Care' LIMIT 1), '10000000-0000-0000-0000-000000000004'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000511');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000512', 'The Ordinary Eau de Parfum Spray - Edition 02', 'Engineered by The Ordinary. The Eau de Parfum Spray comes equipped Enriched with Vitamin C & E. Designed for superior performance, premium durability, and daily reliability.', 267.71, 58, 'https://images.unsplash.com/photo-1556228720-195a672e8a03?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Beauty & Personal Care' LIMIT 1), '10000000-0000-0000-0000-000000000004'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000512');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000513', 'Dior Restorative Hair Mask - Edition 03', 'Engineered by Dior. The Restorative Hair Mask comes equipped Broad Spectrum SPF 50+. Designed for superior performance, premium durability, and daily reliability.', 272.87, 71, 'https://images.unsplash.com/photo-1512496015851-a90fb38ba796?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Beauty & Personal Care' LIMIT 1), '10000000-0000-0000-0000-000000000004'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000513');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000514', 'Kiehl''s Revitalizing Face Cleanser - Edition 04', 'Engineered by Kiehl''s. The Revitalizing Face Cleanser comes equipped Cruelty-Free & 100% Vegan. Designed for superior performance, premium durability, and daily reliability.', 278.02, 84, 'https://images.unsplash.com/photo-1598440947619-2c35fc9aa908?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Beauty & Personal Care' LIMIT 1), '10000000-0000-0000-0000-000000000004'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000514');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000515', 'Aesop Botanical Body Wash - Edition 05', 'Engineered by Aesop. The Botanical Body Wash comes equipped Dermatologist Tested for Sensitive Skin. Designed for superior performance, premium durability, and daily reliability.', 276.0, 97, 'https://images.unsplash.com/photo-1617897903246-719242758050?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Beauty & Personal Care' LIMIT 1), '10000000-0000-0000-0000-000000000004'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000515');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000516', 'La Mer Niacinamide Glow Tonic - Edition 06', 'Engineered by La Mer. The Niacinamide Glow Tonic comes equipped Intense Overnight Hydration. Designed for superior performance, premium durability, and daily reliability.', 280.0, 25, 'https://images.unsplash.com/photo-1608248597359-597495085e68?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Beauty & Personal Care' LIMIT 1), '10000000-0000-0000-0000-000000000004'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000516');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000517', 'Olaplex Anti-Aging Night Cream - Edition 07', 'Engineered by Olaplex. The Anti-Aging Night Cream comes equipped Naturally Derived Organic Botanicals. Designed for superior performance, premium durability, and daily reliability.', 271.78, 38, 'https://images.unsplash.com/photo-1571781926291-c477ebfd024b?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Beauty & Personal Care' LIMIT 1), '10000000-0000-0000-0000-000000000004'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000517');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000518', 'Estée Lauder Lip Sleeping Mask - Edition 08', 'Engineered by Estée Lauder. The Lip Sleeping Mask comes equipped Formulated with 2% Pure Hyaluronic Acid. Designed for superior performance, premium durability, and daily reliability.', 276.94, 51, 'https://images.unsplash.com/photo-1527799820374-dcf8d9d4a388?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Beauty & Personal Care' LIMIT 1), '10000000-0000-0000-0000-000000000004'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000518');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000519', 'Glossier Velvet Matte Lipstick - Edition 09', 'Engineered by Glossier. The Velvet Matte Lipstick comes equipped Long-Lasting 12-Hour Fragrance. Designed for superior performance, premium durability, and daily reliability.', 277.0, 64, 'https://images.unsplash.com/photo-1585238342024-78d387f4a707?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Beauty & Personal Care' LIMIT 1), '10000000-0000-0000-0000-000000000004'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000519');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000520', 'Fenty Beauty Hydrating Mineral Sunscreen - Edition 10', 'Engineered by Fenty Beauty. The Hydrating Mineral Sunscreen comes equipped Bond Building Repair Formula. Designed for superior performance, premium durability, and daily reliability.', 276.0, 77, 'https://images.unsplash.com/photo-1522337360788-8b13dee7a37e?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Beauty & Personal Care' LIMIT 1), '10000000-0000-0000-0000-000000000004'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000520');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000521', 'Bowflex Adjustable Dumbbell Set - Edition 01', 'Engineered by Bowflex. The Adjustable Dumbbell Set comes equipped Ultra-Quiet 5-Speed Motor. Designed for superior performance, premium durability, and daily reliability.', 15.99, 15, 'https://images.unsplash.com/photo-1534438327276-14e5300c3a48?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Sports & Outdoors' LIMIT 1), '10000000-0000-0000-0000-000000000005'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000521');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000522', 'Lululemon Non-Slip Pro Yoga Mat - Edition 02', 'Engineered by Lululemon. The Non-Slip Pro Yoga Mat comes equipped Waterproof Ripstop Nylon Fabric. Designed for superior performance, premium durability, and daily reliability.', 24.34, 28, 'https://images.unsplash.com/photo-1526506118085-60ce8714f8c5?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Sports & Outdoors' LIMIT 1), '10000000-0000-0000-0000-000000000005'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000522');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000523', 'Garmin GPS Multisport Fitness Watch - Edition 03', 'Engineered by Garmin. The GPS Multisport Fitness Watch comes equipped Ergonomic Breathable Mesh Backing. Designed for superior performance, premium durability, and daily reliability.', 32.7, 41, 'https://images.unsplash.com/photo-1517838277536-f5f99be501cd?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Sports & Outdoors' LIMIT 1), '10000000-0000-0000-0000-000000000005'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000523');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000524', 'Hydro Flask Insulated Stainless Water Bottle - Edition 04', 'Engineered by Hydro Flask. The Insulated Stainless Water Bottle comes equipped Aerodynamic Ultra-Lightweight Shell. Designed for superior performance, premium durability, and daily reliability.', 41.05, 54, 'https://images.unsplash.com/photo-1517649763962-0c623266ddc0?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Sports & Outdoors' LIMIT 1), '10000000-0000-0000-0000-000000000005'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000524');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000525', 'Theragun Percussive Massage Gun - Edition 05', 'Engineered by Theragun. The Percussive Massage Gun comes equipped Non-Tangle Steel Cable Core. Designed for superior performance, premium durability, and daily reliability.', 49.41, 67, 'https://images.unsplash.com/photo-1518611012118-696072aa579a?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Sports & Outdoors' LIMIT 1), '10000000-0000-0000-0000-000000000005'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000525');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000526', 'Wilson Backcountry Hiking Backpack - Edition 06', 'Engineered by Wilson. The Backcountry Hiking Backpack comes equipped Heavy-Duty Double-Wall Insulation. Designed for superior performance, premium durability, and daily reliability.', 57.76, 80, 'https://images.unsplash.com/photo-1519505907962-0a6cb0167c73?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Sports & Outdoors' LIMIT 1), '10000000-0000-0000-0000-000000000005'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000526');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000527', 'Salomon All-Weather Camping Tent - Edition 07', 'Engineered by Salomon. The All-Weather Camping Tent comes equipped 5-52.5 lbs Quick Select Dial. Designed for superior performance, premium durability, and daily reliability.', 66.11, 93, 'https://images.unsplash.com/photo-1574680096145-d05b474e2155?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Sports & Outdoors' LIMIT 1), '10000000-0000-0000-0000-000000000005'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000527');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000528', 'Shimano Trail Running Shoes - Edition 08', 'Engineered by Shimano. The Trail Running Shoes comes equipped 6mm High Density Eco-TPE Cushion. Designed for superior performance, premium durability, and daily reliability.', 52.77, 21, 'https://images.unsplash.com/photo-1540497077202-7c8a3999166f?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Sports & Outdoors' LIMIT 1), '10000000-0000-0000-0000-000000000005'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000528');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000529', 'Black Diamond Resistance Loop Bands Set - Edition 09', 'Engineered by Black Diamond. The Resistance Loop Bands Set comes equipped Heart Rate & Pulse Ox Sensor. Designed for superior performance, premium durability, and daily reliability.', 61.12, 34, 'https://images.unsplash.com/photo-1461896836934-ffe607ba8211?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Sports & Outdoors' LIMIT 1), '10000000-0000-0000-0000-000000000005'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000529');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000530', 'YETI Carbon Fiber Road Bike Helmet - Edition 10', 'Engineered by YETI. The Carbon Fiber Road Bike Helmet comes equipped Keeps Cold 24hrs / Hot 12hrs. Designed for superior performance, premium durability, and daily reliability.', 69.48, 47, 'https://images.unsplash.com/photo-1584735935682-2f2b69dff9d2?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Sports & Outdoors' LIMIT 1), '10000000-0000-0000-0000-000000000005'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000530');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000531', 'Manduka Competition Basketball - Edition 11', 'Engineered by Manduka. The Competition Basketball comes equipped Ultra-Quiet 5-Speed Motor. Designed for superior performance, premium durability, and daily reliability.', 77.83, 60, 'https://images.unsplash.com/photo-1534438327276-14e5300c3a48?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Sports & Outdoors' LIMIT 1), '10000000-0000-0000-0000-000000000005'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000531');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000532', 'Osprey Titanium Trekking Poles - Edition 12', 'Engineered by Osprey. The Titanium Trekking Poles comes equipped Waterproof Ripstop Nylon Fabric. Designed for superior performance, premium durability, and daily reliability.', 86.18, 73, 'https://images.unsplash.com/photo-1526506118085-60ce8714f8c5?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Sports & Outdoors' LIMIT 1), '10000000-0000-0000-0000-000000000005'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000532');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000533', 'Peloton Thermal Insulated Cooler 35L - Edition 13', 'Engineered by Peloton. The Thermal Insulated Cooler 35L comes equipped Ergonomic Breathable Mesh Backing. Designed for superior performance, premium durability, and daily reliability.', 94.54, 86, 'https://images.unsplash.com/photo-1517838277536-f5f99be501cd?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Sports & Outdoors' LIMIT 1), '10000000-0000-0000-0000-000000000005'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000533');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000534', 'Rogue Fitness Speed Jump Rope with Ball Bearings - Edition 14', 'Engineered by Rogue Fitness. The Speed Jump Rope with Ball Bearings comes equipped Aerodynamic Ultra-Lightweight Shell. Designed for superior performance, premium durability, and daily reliability.', 102.89, 99, 'https://images.unsplash.com/photo-1517649763962-0c623266ddc0?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Sports & Outdoors' LIMIT 1), '10000000-0000-0000-0000-000000000005'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000534');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000535', 'Callaway Golf Driver Carbonwood - Edition 15', 'Engineered by Callaway. The Golf Driver Carbonwood comes equipped Non-Tangle Steel Cable Core. Designed for superior performance, premium durability, and daily reliability.', 89.54, 27, 'https://images.unsplash.com/photo-1518611012118-696072aa579a?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Sports & Outdoors' LIMIT 1), '10000000-0000-0000-0000-000000000005'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000535');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000536', 'Bowflex Adjustable Dumbbell Set - Edition 16', 'Engineered by Bowflex. The Adjustable Dumbbell Set comes equipped Heavy-Duty Double-Wall Insulation. Designed for superior performance, premium durability, and daily reliability.', 97.9, 40, 'https://images.unsplash.com/photo-1519505907962-0a6cb0167c73?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Sports & Outdoors' LIMIT 1), '10000000-0000-0000-0000-000000000005'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000536');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000537', 'Lululemon Non-Slip Pro Yoga Mat - Edition 17', 'Engineered by Lululemon. The Non-Slip Pro Yoga Mat comes equipped 5-52.5 lbs Quick Select Dial. Designed for superior performance, premium durability, and daily reliability.', 106.25, 53, 'https://images.unsplash.com/photo-1574680096145-d05b474e2155?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Sports & Outdoors' LIMIT 1), '10000000-0000-0000-0000-000000000005'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000537');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000538', 'Garmin GPS Multisport Fitness Watch - Edition 18', 'Engineered by Garmin. The GPS Multisport Fitness Watch comes equipped 6mm High Density Eco-TPE Cushion. Designed for superior performance, premium durability, and daily reliability.', 114.61, 66, 'https://images.unsplash.com/photo-1540497077202-7c8a3999166f?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Sports & Outdoors' LIMIT 1), '10000000-0000-0000-0000-000000000005'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000538');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000539', 'Hydro Flask Insulated Stainless Water Bottle - Edition 19', 'Engineered by Hydro Flask. The Insulated Stainless Water Bottle comes equipped Heart Rate & Pulse Ox Sensor. Designed for superior performance, premium durability, and daily reliability.', 122.96, 79, 'https://images.unsplash.com/photo-1461896836934-ffe607ba8211?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Sports & Outdoors' LIMIT 1), '10000000-0000-0000-0000-000000000005'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000539');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000540', 'Theragun Percussive Massage Gun - Edition 20', 'Engineered by Theragun. The Percussive Massage Gun comes equipped Keeps Cold 24hrs / Hot 12hrs. Designed for superior performance, premium durability, and daily reliability.', 131.31, 92, 'https://images.unsplash.com/photo-1584735935682-2f2b69dff9d2?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Sports & Outdoors' LIMIT 1), '10000000-0000-0000-0000-000000000005'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000540');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000541', 'Wilson Backcountry Hiking Backpack - Edition 01', 'Engineered by Wilson. The Backcountry Hiking Backpack comes equipped Ultra-Quiet 5-Speed Motor. Designed for superior performance, premium durability, and daily reliability.', 139.67, 20, 'https://images.unsplash.com/photo-1534438327276-14e5300c3a48?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Sports & Outdoors' LIMIT 1), '10000000-0000-0000-0000-000000000005'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000541');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000542', 'Salomon All-Weather Camping Tent - Edition 02', 'Engineered by Salomon. The All-Weather Camping Tent comes equipped Waterproof Ripstop Nylon Fabric. Designed for superior performance, premium durability, and daily reliability.', 126.32, 33, 'https://images.unsplash.com/photo-1526506118085-60ce8714f8c5?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Sports & Outdoors' LIMIT 1), '10000000-0000-0000-0000-000000000005'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000542');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000543', 'Shimano Trail Running Shoes - Edition 03', 'Engineered by Shimano. The Trail Running Shoes comes equipped Ergonomic Breathable Mesh Backing. Designed for superior performance, premium durability, and daily reliability.', 134.68, 46, 'https://images.unsplash.com/photo-1517838277536-f5f99be501cd?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Sports & Outdoors' LIMIT 1), '10000000-0000-0000-0000-000000000005'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000543');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000544', 'Black Diamond Resistance Loop Bands Set - Edition 04', 'Engineered by Black Diamond. The Resistance Loop Bands Set comes equipped Aerodynamic Ultra-Lightweight Shell. Designed for superior performance, premium durability, and daily reliability.', 143.03, 59, 'https://images.unsplash.com/photo-1517649763962-0c623266ddc0?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Sports & Outdoors' LIMIT 1), '10000000-0000-0000-0000-000000000005'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000544');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000545', 'YETI Carbon Fiber Road Bike Helmet - Edition 05', 'Engineered by YETI. The Carbon Fiber Road Bike Helmet comes equipped Non-Tangle Steel Cable Core. Designed for superior performance, premium durability, and daily reliability.', 151.38, 72, 'https://images.unsplash.com/photo-1518611012118-696072aa579a?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Sports & Outdoors' LIMIT 1), '10000000-0000-0000-0000-000000000005'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000545');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000546', 'Manduka Competition Basketball - Edition 06', 'Engineered by Manduka. The Competition Basketball comes equipped Heavy-Duty Double-Wall Insulation. Designed for superior performance, premium durability, and daily reliability.', 159.74, 85, 'https://images.unsplash.com/photo-1519505907962-0a6cb0167c73?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Sports & Outdoors' LIMIT 1), '10000000-0000-0000-0000-000000000005'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000546');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000547', 'Osprey Titanium Trekking Poles - Edition 07', 'Engineered by Osprey. The Titanium Trekking Poles comes equipped 5-52.5 lbs Quick Select Dial. Designed for superior performance, premium durability, and daily reliability.', 168.09, 98, 'https://images.unsplash.com/photo-1574680096145-d05b474e2155?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Sports & Outdoors' LIMIT 1), '10000000-0000-0000-0000-000000000005'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000547');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000548', 'Peloton Thermal Insulated Cooler 35L - Edition 08', 'Engineered by Peloton. The Thermal Insulated Cooler 35L comes equipped 6mm High Density Eco-TPE Cushion. Designed for superior performance, premium durability, and daily reliability.', 176.45, 26, 'https://images.unsplash.com/photo-1540497077202-7c8a3999166f?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Sports & Outdoors' LIMIT 1), '10000000-0000-0000-0000-000000000005'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000548');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000549', 'Rogue Fitness Speed Jump Rope with Ball Bearings - Edition 09', 'Engineered by Rogue Fitness. The Speed Jump Rope with Ball Bearings comes equipped Heart Rate & Pulse Ox Sensor. Designed for superior performance, premium durability, and daily reliability.', 163.1, 39, 'https://images.unsplash.com/photo-1461896836934-ffe607ba8211?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Sports & Outdoors' LIMIT 1), '10000000-0000-0000-0000-000000000005'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000549');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000550', 'Callaway Golf Driver Carbonwood - Edition 10', 'Engineered by Callaway. The Golf Driver Carbonwood comes equipped Keeps Cold 24hrs / Hot 12hrs. Designed for superior performance, premium durability, and daily reliability.', 171.45, 52, 'https://images.unsplash.com/photo-1584735935682-2f2b69dff9d2?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Sports & Outdoors' LIMIT 1), '10000000-0000-0000-0000-000000000005'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000550');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000551', 'Bowflex Adjustable Dumbbell Set - Edition 11', 'Engineered by Bowflex. The Adjustable Dumbbell Set comes equipped Ultra-Quiet 5-Speed Motor. Designed for superior performance, premium durability, and daily reliability.', 179.81, 65, 'https://images.unsplash.com/photo-1534438327276-14e5300c3a48?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Sports & Outdoors' LIMIT 1), '10000000-0000-0000-0000-000000000005'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000551');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000552', 'Lululemon Non-Slip Pro Yoga Mat - Edition 12', 'Engineered by Lululemon. The Non-Slip Pro Yoga Mat comes equipped Waterproof Ripstop Nylon Fabric. Designed for superior performance, premium durability, and daily reliability.', 188.16, 78, 'https://images.unsplash.com/photo-1526506118085-60ce8714f8c5?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Sports & Outdoors' LIMIT 1), '10000000-0000-0000-0000-000000000005'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000552');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000553', 'Garmin GPS Multisport Fitness Watch - Edition 13', 'Engineered by Garmin. The GPS Multisport Fitness Watch comes equipped Ergonomic Breathable Mesh Backing. Designed for superior performance, premium durability, and daily reliability.', 196.52, 91, 'https://images.unsplash.com/photo-1517838277536-f5f99be501cd?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Sports & Outdoors' LIMIT 1), '10000000-0000-0000-0000-000000000005'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000553');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000554', 'Hydro Flask Insulated Stainless Water Bottle - Edition 14', 'Engineered by Hydro Flask. The Insulated Stainless Water Bottle comes equipped Aerodynamic Ultra-Lightweight Shell. Designed for superior performance, premium durability, and daily reliability.', 204.87, 19, 'https://images.unsplash.com/photo-1517649763962-0c623266ddc0?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Sports & Outdoors' LIMIT 1), '10000000-0000-0000-0000-000000000005'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000554');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000555', 'Theragun Percussive Massage Gun - Edition 15', 'Engineered by Theragun. The Percussive Massage Gun comes equipped Non-Tangle Steel Cable Core. Designed for superior performance, premium durability, and daily reliability.', 213.22, 32, 'https://images.unsplash.com/photo-1518611012118-696072aa579a?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Sports & Outdoors' LIMIT 1), '10000000-0000-0000-0000-000000000005'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000555');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000556', 'Wilson Backcountry Hiking Backpack - Edition 16', 'Engineered by Wilson. The Backcountry Hiking Backpack comes equipped Heavy-Duty Double-Wall Insulation. Designed for superior performance, premium durability, and daily reliability.', 199.88, 45, 'https://images.unsplash.com/photo-1519505907962-0a6cb0167c73?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Sports & Outdoors' LIMIT 1), '10000000-0000-0000-0000-000000000005'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000556');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000557', 'Salomon All-Weather Camping Tent - Edition 17', 'Engineered by Salomon. The All-Weather Camping Tent comes equipped 5-52.5 lbs Quick Select Dial. Designed for superior performance, premium durability, and daily reliability.', 208.23, 58, 'https://images.unsplash.com/photo-1574680096145-d05b474e2155?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Sports & Outdoors' LIMIT 1), '10000000-0000-0000-0000-000000000005'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000557');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000558', 'Shimano Trail Running Shoes - Edition 18', 'Engineered by Shimano. The Trail Running Shoes comes equipped 6mm High Density Eco-TPE Cushion. Designed for superior performance, premium durability, and daily reliability.', 216.59, 71, 'https://images.unsplash.com/photo-1540497077202-7c8a3999166f?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Sports & Outdoors' LIMIT 1), '10000000-0000-0000-0000-000000000005'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000558');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000559', 'Black Diamond Resistance Loop Bands Set - Edition 19', 'Engineered by Black Diamond. The Resistance Loop Bands Set comes equipped Heart Rate & Pulse Ox Sensor. Designed for superior performance, premium durability, and daily reliability.', 224.94, 84, 'https://images.unsplash.com/photo-1461896836934-ffe607ba8211?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Sports & Outdoors' LIMIT 1), '10000000-0000-0000-0000-000000000005'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000559');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000560', 'YETI Carbon Fiber Road Bike Helmet - Edition 20', 'Engineered by YETI. The Carbon Fiber Road Bike Helmet comes equipped Keeps Cold 24hrs / Hot 12hrs. Designed for superior performance, premium durability, and daily reliability.', 233.29, 97, 'https://images.unsplash.com/photo-1584735935682-2f2b69dff9d2?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Sports & Outdoors' LIMIT 1), '10000000-0000-0000-0000-000000000005'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000560');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000561', 'Manduka Competition Basketball - Edition 01', 'Engineered by Manduka. The Competition Basketball comes equipped Ultra-Quiet 5-Speed Motor. Designed for superior performance, premium durability, and daily reliability.', 241.65, 25, 'https://images.unsplash.com/photo-1534438327276-14e5300c3a48?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Sports & Outdoors' LIMIT 1), '10000000-0000-0000-0000-000000000005'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000561');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000562', 'Osprey Titanium Trekking Poles - Edition 02', 'Engineered by Osprey. The Titanium Trekking Poles comes equipped Waterproof Ripstop Nylon Fabric. Designed for superior performance, premium durability, and daily reliability.', 250.0, 38, 'https://images.unsplash.com/photo-1526506118085-60ce8714f8c5?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Sports & Outdoors' LIMIT 1), '10000000-0000-0000-0000-000000000005'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000562');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000563', 'Peloton Thermal Insulated Cooler 35L - Edition 03', 'Engineered by Peloton. The Thermal Insulated Cooler 35L comes equipped Ergonomic Breathable Mesh Backing. Designed for superior performance, premium durability, and daily reliability.', 236.65, 51, 'https://images.unsplash.com/photo-1517838277536-f5f99be501cd?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Sports & Outdoors' LIMIT 1), '10000000-0000-0000-0000-000000000005'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000563');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000564', 'Rogue Fitness Speed Jump Rope with Ball Bearings - Edition 04', 'Engineered by Rogue Fitness. The Speed Jump Rope with Ball Bearings comes equipped Aerodynamic Ultra-Lightweight Shell. Designed for superior performance, premium durability, and daily reliability.', 245.01, 64, 'https://images.unsplash.com/photo-1517649763962-0c623266ddc0?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Sports & Outdoors' LIMIT 1), '10000000-0000-0000-0000-000000000005'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000564');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000565', 'Callaway Golf Driver Carbonwood - Edition 05', 'Engineered by Callaway. The Golf Driver Carbonwood comes equipped Non-Tangle Steel Cable Core. Designed for superior performance, premium durability, and daily reliability.', 253.36, 77, 'https://images.unsplash.com/photo-1518611012118-696072aa579a?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Sports & Outdoors' LIMIT 1), '10000000-0000-0000-0000-000000000005'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000565');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000566', 'Bowflex Adjustable Dumbbell Set - Edition 06', 'Engineered by Bowflex. The Adjustable Dumbbell Set comes equipped Heavy-Duty Double-Wall Insulation. Designed for superior performance, premium durability, and daily reliability.', 261.72, 90, 'https://images.unsplash.com/photo-1519505907962-0a6cb0167c73?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Sports & Outdoors' LIMIT 1), '10000000-0000-0000-0000-000000000005'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000566');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000567', 'Lululemon Non-Slip Pro Yoga Mat - Edition 07', 'Engineered by Lululemon. The Non-Slip Pro Yoga Mat comes equipped 5-52.5 lbs Quick Select Dial. Designed for superior performance, premium durability, and daily reliability.', 270.07, 18, 'https://images.unsplash.com/photo-1574680096145-d05b474e2155?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Sports & Outdoors' LIMIT 1), '10000000-0000-0000-0000-000000000005'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000567');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000568', 'Garmin GPS Multisport Fitness Watch - Edition 08', 'Engineered by Garmin. The GPS Multisport Fitness Watch comes equipped 6mm High Density Eco-TPE Cushion. Designed for superior performance, premium durability, and daily reliability.', 278.42, 31, 'https://images.unsplash.com/photo-1540497077202-7c8a3999166f?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Sports & Outdoors' LIMIT 1), '10000000-0000-0000-0000-000000000005'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000568');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000569', 'Hydro Flask Insulated Stainless Water Bottle - Edition 09', 'Engineered by Hydro Flask. The Insulated Stainless Water Bottle comes equipped Heart Rate & Pulse Ox Sensor. Designed for superior performance, premium durability, and daily reliability.', 286.78, 44, 'https://images.unsplash.com/photo-1461896836934-ffe607ba8211?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Sports & Outdoors' LIMIT 1), '10000000-0000-0000-0000-000000000005'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000569');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000570', 'Theragun Percussive Massage Gun - Edition 10', 'Engineered by Theragun. The Percussive Massage Gun comes equipped Keeps Cold 24hrs / Hot 12hrs. Designed for superior performance, premium durability, and daily reliability.', 273.43, 57, 'https://images.unsplash.com/photo-1584735935682-2f2b69dff9d2?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Sports & Outdoors' LIMIT 1), '10000000-0000-0000-0000-000000000005'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000570');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000571', 'Wilson Backcountry Hiking Backpack - Edition 11', 'Engineered by Wilson. The Backcountry Hiking Backpack comes equipped Ultra-Quiet 5-Speed Motor. Designed for superior performance, premium durability, and daily reliability.', 281.79, 70, 'https://images.unsplash.com/photo-1534438327276-14e5300c3a48?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Sports & Outdoors' LIMIT 1), '10000000-0000-0000-0000-000000000005'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000571');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000572', 'Salomon All-Weather Camping Tent - Edition 12', 'Engineered by Salomon. The All-Weather Camping Tent comes equipped Waterproof Ripstop Nylon Fabric. Designed for superior performance, premium durability, and daily reliability.', 290.14, 83, 'https://images.unsplash.com/photo-1526506118085-60ce8714f8c5?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Sports & Outdoors' LIMIT 1), '10000000-0000-0000-0000-000000000005'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000572');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000573', 'Shimano Trail Running Shoes - Edition 13', 'Engineered by Shimano. The Trail Running Shoes comes equipped Ergonomic Breathable Mesh Backing. Designed for superior performance, premium durability, and daily reliability.', 298.49, 96, 'https://images.unsplash.com/photo-1517838277536-f5f99be501cd?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Sports & Outdoors' LIMIT 1), '10000000-0000-0000-0000-000000000005'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000573');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000574', 'Black Diamond Resistance Loop Bands Set - Edition 14', 'Engineered by Black Diamond. The Resistance Loop Bands Set comes equipped Aerodynamic Ultra-Lightweight Shell. Designed for superior performance, premium durability, and daily reliability.', 306.85, 24, 'https://images.unsplash.com/photo-1517649763962-0c623266ddc0?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Sports & Outdoors' LIMIT 1), '10000000-0000-0000-0000-000000000005'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000574');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000575', 'YETI Carbon Fiber Road Bike Helmet - Edition 15', 'Engineered by YETI. The Carbon Fiber Road Bike Helmet comes equipped Non-Tangle Steel Cable Core. Designed for superior performance, premium durability, and daily reliability.', 315.2, 37, 'https://images.unsplash.com/photo-1518611012118-696072aa579a?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Sports & Outdoors' LIMIT 1), '10000000-0000-0000-0000-000000000005'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000575');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000576', 'Manduka Competition Basketball - Edition 16', 'Engineered by Manduka. The Competition Basketball comes equipped Heavy-Duty Double-Wall Insulation. Designed for superior performance, premium durability, and daily reliability.', 323.56, 50, 'https://images.unsplash.com/photo-1519505907962-0a6cb0167c73?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Sports & Outdoors' LIMIT 1), '10000000-0000-0000-0000-000000000005'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000576');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000577', 'Osprey Titanium Trekking Poles - Edition 17', 'Engineered by Osprey. The Titanium Trekking Poles comes equipped 5-52.5 lbs Quick Select Dial. Designed for superior performance, premium durability, and daily reliability.', 310.21, 63, 'https://images.unsplash.com/photo-1574680096145-d05b474e2155?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Sports & Outdoors' LIMIT 1), '10000000-0000-0000-0000-000000000005'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000577');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000578', 'Peloton Thermal Insulated Cooler 35L - Edition 18', 'Engineered by Peloton. The Thermal Insulated Cooler 35L comes equipped 6mm High Density Eco-TPE Cushion. Designed for superior performance, premium durability, and daily reliability.', 318.56, 76, 'https://images.unsplash.com/photo-1540497077202-7c8a3999166f?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Sports & Outdoors' LIMIT 1), '10000000-0000-0000-0000-000000000005'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000578');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000579', 'Rogue Fitness Speed Jump Rope with Ball Bearings - Edition 19', 'Engineered by Rogue Fitness. The Speed Jump Rope with Ball Bearings comes equipped Heart Rate & Pulse Ox Sensor. Designed for superior performance, premium durability, and daily reliability.', 326.92, 89, 'https://images.unsplash.com/photo-1461896836934-ffe607ba8211?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Sports & Outdoors' LIMIT 1), '10000000-0000-0000-0000-000000000005'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000579');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000580', 'Callaway Golf Driver Carbonwood - Edition 20', 'Engineered by Callaway. The Golf Driver Carbonwood comes equipped Keeps Cold 24hrs / Hot 12hrs. Designed for superior performance, premium durability, and daily reliability.', 335.27, 17, 'https://images.unsplash.com/photo-1584735935682-2f2b69dff9d2?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Sports & Outdoors' LIMIT 1), '10000000-0000-0000-0000-000000000005'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000580');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000581', 'Bowflex Adjustable Dumbbell Set - Edition 01', 'Engineered by Bowflex. The Adjustable Dumbbell Set comes equipped Ultra-Quiet 5-Speed Motor. Designed for superior performance, premium durability, and daily reliability.', 343.63, 30, 'https://images.unsplash.com/photo-1534438327276-14e5300c3a48?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Sports & Outdoors' LIMIT 1), '10000000-0000-0000-0000-000000000005'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000581');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000582', 'Lululemon Non-Slip Pro Yoga Mat - Edition 02', 'Engineered by Lululemon. The Non-Slip Pro Yoga Mat comes equipped Waterproof Ripstop Nylon Fabric. Designed for superior performance, premium durability, and daily reliability.', 351.98, 43, 'https://images.unsplash.com/photo-1526506118085-60ce8714f8c5?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Sports & Outdoors' LIMIT 1), '10000000-0000-0000-0000-000000000005'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000582');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000583', 'Garmin GPS Multisport Fitness Watch - Edition 03', 'Engineered by Garmin. The GPS Multisport Fitness Watch comes equipped Ergonomic Breathable Mesh Backing. Designed for superior performance, premium durability, and daily reliability.', 360.33, 56, 'https://images.unsplash.com/photo-1517838277536-f5f99be501cd?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Sports & Outdoors' LIMIT 1), '10000000-0000-0000-0000-000000000005'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000583');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000584', 'Hydro Flask Insulated Stainless Water Bottle - Edition 04', 'Engineered by Hydro Flask. The Insulated Stainless Water Bottle comes equipped Aerodynamic Ultra-Lightweight Shell. Designed for superior performance, premium durability, and daily reliability.', 346.99, 69, 'https://images.unsplash.com/photo-1517649763962-0c623266ddc0?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Sports & Outdoors' LIMIT 1), '10000000-0000-0000-0000-000000000005'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000584');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000585', 'Theragun Percussive Massage Gun - Edition 05', 'Engineered by Theragun. The Percussive Massage Gun comes equipped Non-Tangle Steel Cable Core. Designed for superior performance, premium durability, and daily reliability.', 355.34, 82, 'https://images.unsplash.com/photo-1518611012118-696072aa579a?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Sports & Outdoors' LIMIT 1), '10000000-0000-0000-0000-000000000005'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000585');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000586', 'Wilson Backcountry Hiking Backpack - Edition 06', 'Engineered by Wilson. The Backcountry Hiking Backpack comes equipped Heavy-Duty Double-Wall Insulation. Designed for superior performance, premium durability, and daily reliability.', 363.69, 95, 'https://images.unsplash.com/photo-1519505907962-0a6cb0167c73?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Sports & Outdoors' LIMIT 1), '10000000-0000-0000-0000-000000000005'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000586');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000587', 'Salomon All-Weather Camping Tent - Edition 07', 'Engineered by Salomon. The All-Weather Camping Tent comes equipped 5-52.5 lbs Quick Select Dial. Designed for superior performance, premium durability, and daily reliability.', 372.05, 23, 'https://images.unsplash.com/photo-1574680096145-d05b474e2155?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Sports & Outdoors' LIMIT 1), '10000000-0000-0000-0000-000000000005'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000587');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000588', 'Shimano Trail Running Shoes - Edition 08', 'Engineered by Shimano. The Trail Running Shoes comes equipped 6mm High Density Eco-TPE Cushion. Designed for superior performance, premium durability, and daily reliability.', 380.4, 36, 'https://images.unsplash.com/photo-1540497077202-7c8a3999166f?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Sports & Outdoors' LIMIT 1), '10000000-0000-0000-0000-000000000005'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000588');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000589', 'Black Diamond Resistance Loop Bands Set - Edition 09', 'Engineered by Black Diamond. The Resistance Loop Bands Set comes equipped Heart Rate & Pulse Ox Sensor. Designed for superior performance, premium durability, and daily reliability.', 388.76, 49, 'https://images.unsplash.com/photo-1461896836934-ffe607ba8211?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Sports & Outdoors' LIMIT 1), '10000000-0000-0000-0000-000000000005'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000589');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000590', 'YETI Carbon Fiber Road Bike Helmet - Edition 10', 'Engineered by YETI. The Carbon Fiber Road Bike Helmet comes equipped Keeps Cold 24hrs / Hot 12hrs. Designed for superior performance, premium durability, and daily reliability.', 397.11, 62, 'https://images.unsplash.com/photo-1584735935682-2f2b69dff9d2?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Sports & Outdoors' LIMIT 1), '10000000-0000-0000-0000-000000000005'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000590');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000591', 'Manduka Competition Basketball - Edition 11', 'Engineered by Manduka. The Competition Basketball comes equipped Ultra-Quiet 5-Speed Motor. Designed for superior performance, premium durability, and daily reliability.', 383.76, 75, 'https://images.unsplash.com/photo-1534438327276-14e5300c3a48?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Sports & Outdoors' LIMIT 1), '10000000-0000-0000-0000-000000000005'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000591');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000592', 'Osprey Titanium Trekking Poles - Edition 12', 'Engineered by Osprey. The Titanium Trekking Poles comes equipped Waterproof Ripstop Nylon Fabric. Designed for superior performance, premium durability, and daily reliability.', 392.12, 88, 'https://images.unsplash.com/photo-1526506118085-60ce8714f8c5?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Sports & Outdoors' LIMIT 1), '10000000-0000-0000-0000-000000000005'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000592');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000593', 'Peloton Thermal Insulated Cooler 35L - Edition 13', 'Engineered by Peloton. The Thermal Insulated Cooler 35L comes equipped Ergonomic Breathable Mesh Backing. Designed for superior performance, premium durability, and daily reliability.', 400.47, 16, 'https://images.unsplash.com/photo-1517838277536-f5f99be501cd?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Sports & Outdoors' LIMIT 1), '10000000-0000-0000-0000-000000000005'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000593');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000594', 'Rogue Fitness Speed Jump Rope with Ball Bearings - Edition 14', 'Engineered by Rogue Fitness. The Speed Jump Rope with Ball Bearings comes equipped Aerodynamic Ultra-Lightweight Shell. Designed for superior performance, premium durability, and daily reliability.', 408.83, 29, 'https://images.unsplash.com/photo-1517649763962-0c623266ddc0?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Sports & Outdoors' LIMIT 1), '10000000-0000-0000-0000-000000000005'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000594');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000595', 'Callaway Golf Driver Carbonwood - Edition 15', 'Engineered by Callaway. The Golf Driver Carbonwood comes equipped Non-Tangle Steel Cable Core. Designed for superior performance, premium durability, and daily reliability.', 417.18, 42, 'https://images.unsplash.com/photo-1518611012118-696072aa579a?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Sports & Outdoors' LIMIT 1), '10000000-0000-0000-0000-000000000005'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000595');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000596', 'Bowflex Adjustable Dumbbell Set - Edition 16', 'Engineered by Bowflex. The Adjustable Dumbbell Set comes equipped Heavy-Duty Double-Wall Insulation. Designed for superior performance, premium durability, and daily reliability.', 425.53, 55, 'https://images.unsplash.com/photo-1519505907962-0a6cb0167c73?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Sports & Outdoors' LIMIT 1), '10000000-0000-0000-0000-000000000005'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000596');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000597', 'Lululemon Non-Slip Pro Yoga Mat - Edition 17', 'Engineered by Lululemon. The Non-Slip Pro Yoga Mat comes equipped 5-52.5 lbs Quick Select Dial. Designed for superior performance, premium durability, and daily reliability.', 433.89, 68, 'https://images.unsplash.com/photo-1574680096145-d05b474e2155?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Sports & Outdoors' LIMIT 1), '10000000-0000-0000-0000-000000000005'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000597');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000598', 'Garmin GPS Multisport Fitness Watch - Edition 18', 'Engineered by Garmin. The GPS Multisport Fitness Watch comes equipped 6mm High Density Eco-TPE Cushion. Designed for superior performance, premium durability, and daily reliability.', 420.54, 81, 'https://images.unsplash.com/photo-1540497077202-7c8a3999166f?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Sports & Outdoors' LIMIT 1), '10000000-0000-0000-0000-000000000005'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000598');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000599', 'Hydro Flask Insulated Stainless Water Bottle - Edition 19', 'Engineered by Hydro Flask. The Insulated Stainless Water Bottle comes equipped Heart Rate & Pulse Ox Sensor. Designed for superior performance, premium durability, and daily reliability.', 428.9, 94, 'https://images.unsplash.com/photo-1461896836934-ffe607ba8211?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Sports & Outdoors' LIMIT 1), '10000000-0000-0000-0000-000000000005'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000599');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000600', 'Theragun Percussive Massage Gun - Edition 20', 'Engineered by Theragun. The Percussive Massage Gun comes equipped Keeps Cold 24hrs / Hot 12hrs. Designed for superior performance, premium durability, and daily reliability.', 437.25, 22, 'https://images.unsplash.com/photo-1584735935682-2f2b69dff9d2?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Sports & Outdoors' LIMIT 1), '10000000-0000-0000-0000-000000000005'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000600');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000601', 'Wilson Backcountry Hiking Backpack - Edition 01', 'Engineered by Wilson. The Backcountry Hiking Backpack comes equipped Ultra-Quiet 5-Speed Motor. Designed for superior performance, premium durability, and daily reliability.', 445.6, 35, 'https://images.unsplash.com/photo-1534438327276-14e5300c3a48?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Sports & Outdoors' LIMIT 1), '10000000-0000-0000-0000-000000000005'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000601');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000602', 'Salomon All-Weather Camping Tent - Edition 02', 'Engineered by Salomon. The All-Weather Camping Tent comes equipped Waterproof Ripstop Nylon Fabric. Designed for superior performance, premium durability, and daily reliability.', 453.96, 48, 'https://images.unsplash.com/photo-1526506118085-60ce8714f8c5?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Sports & Outdoors' LIMIT 1), '10000000-0000-0000-0000-000000000005'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000602');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000603', 'Shimano Trail Running Shoes - Edition 03', 'Engineered by Shimano. The Trail Running Shoes comes equipped Ergonomic Breathable Mesh Backing. Designed for superior performance, premium durability, and daily reliability.', 462.31, 61, 'https://images.unsplash.com/photo-1517838277536-f5f99be501cd?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Sports & Outdoors' LIMIT 1), '10000000-0000-0000-0000-000000000005'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000603');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000604', 'Black Diamond Resistance Loop Bands Set - Edition 04', 'Engineered by Black Diamond. The Resistance Loop Bands Set comes equipped Aerodynamic Ultra-Lightweight Shell. Designed for superior performance, premium durability, and daily reliability.', 470.67, 74, 'https://images.unsplash.com/photo-1517649763962-0c623266ddc0?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Sports & Outdoors' LIMIT 1), '10000000-0000-0000-0000-000000000005'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000604');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000605', 'YETI Carbon Fiber Road Bike Helmet - Edition 05', 'Engineered by YETI. The Carbon Fiber Road Bike Helmet comes equipped Non-Tangle Steel Cable Core. Designed for superior performance, premium durability, and daily reliability.', 457.32, 87, 'https://images.unsplash.com/photo-1518611012118-696072aa579a?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Sports & Outdoors' LIMIT 1), '10000000-0000-0000-0000-000000000005'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000605');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000606', 'Manduka Competition Basketball - Edition 06', 'Engineered by Manduka. The Competition Basketball comes equipped Heavy-Duty Double-Wall Insulation. Designed for superior performance, premium durability, and daily reliability.', 465.67, 15, 'https://images.unsplash.com/photo-1519505907962-0a6cb0167c73?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Sports & Outdoors' LIMIT 1), '10000000-0000-0000-0000-000000000005'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000606');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000607', 'Osprey Titanium Trekking Poles - Edition 07', 'Engineered by Osprey. The Titanium Trekking Poles comes equipped 5-52.5 lbs Quick Select Dial. Designed for superior performance, premium durability, and daily reliability.', 474.03, 28, 'https://images.unsplash.com/photo-1574680096145-d05b474e2155?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Sports & Outdoors' LIMIT 1), '10000000-0000-0000-0000-000000000005'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000607');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000608', 'Peloton Thermal Insulated Cooler 35L - Edition 08', 'Engineered by Peloton. The Thermal Insulated Cooler 35L comes equipped 6mm High Density Eco-TPE Cushion. Designed for superior performance, premium durability, and daily reliability.', 482.38, 41, 'https://images.unsplash.com/photo-1540497077202-7c8a3999166f?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Sports & Outdoors' LIMIT 1), '10000000-0000-0000-0000-000000000005'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000608');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000609', 'Rogue Fitness Speed Jump Rope with Ball Bearings - Edition 09', 'Engineered by Rogue Fitness. The Speed Jump Rope with Ball Bearings comes equipped Heart Rate & Pulse Ox Sensor. Designed for superior performance, premium durability, and daily reliability.', 490.74, 54, 'https://images.unsplash.com/photo-1461896836934-ffe607ba8211?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Sports & Outdoors' LIMIT 1), '10000000-0000-0000-0000-000000000005'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000609');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000610', 'Callaway Golf Driver Carbonwood - Edition 10', 'Engineered by Callaway. The Golf Driver Carbonwood comes equipped Keeps Cold 24hrs / Hot 12hrs. Designed for superior performance, premium durability, and daily reliability.', 499.09, 67, 'https://images.unsplash.com/photo-1584735935682-2f2b69dff9d2?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Sports & Outdoors' LIMIT 1), '10000000-0000-0000-0000-000000000005'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000610');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000611', 'Bowflex Adjustable Dumbbell Set - Edition 11', 'Engineered by Bowflex. The Adjustable Dumbbell Set comes equipped Ultra-Quiet 5-Speed Motor. Designed for superior performance, premium durability, and daily reliability.', 507.44, 80, 'https://images.unsplash.com/photo-1534438327276-14e5300c3a48?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Sports & Outdoors' LIMIT 1), '10000000-0000-0000-0000-000000000005'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000611');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000612', 'Lululemon Non-Slip Pro Yoga Mat - Edition 12', 'Engineered by Lululemon. The Non-Slip Pro Yoga Mat comes equipped Waterproof Ripstop Nylon Fabric. Designed for superior performance, premium durability, and daily reliability.', 494.1, 93, 'https://images.unsplash.com/photo-1526506118085-60ce8714f8c5?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Sports & Outdoors' LIMIT 1), '10000000-0000-0000-0000-000000000005'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000612');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000613', 'Garmin GPS Multisport Fitness Watch - Edition 13', 'Engineered by Garmin. The GPS Multisport Fitness Watch comes equipped Ergonomic Breathable Mesh Backing. Designed for superior performance, premium durability, and daily reliability.', 502.45, 21, 'https://images.unsplash.com/photo-1517838277536-f5f99be501cd?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Sports & Outdoors' LIMIT 1), '10000000-0000-0000-0000-000000000005'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000613');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000614', 'Hydro Flask Insulated Stainless Water Bottle - Edition 14', 'Engineered by Hydro Flask. The Insulated Stainless Water Bottle comes equipped Aerodynamic Ultra-Lightweight Shell. Designed for superior performance, premium durability, and daily reliability.', 510.8, 34, 'https://images.unsplash.com/photo-1517649763962-0c623266ddc0?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Sports & Outdoors' LIMIT 1), '10000000-0000-0000-0000-000000000005'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000614');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000615', 'Theragun Percussive Massage Gun - Edition 15', 'Engineered by Theragun. The Percussive Massage Gun comes equipped Non-Tangle Steel Cable Core. Designed for superior performance, premium durability, and daily reliability.', 519.16, 47, 'https://images.unsplash.com/photo-1518611012118-696072aa579a?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Sports & Outdoors' LIMIT 1), '10000000-0000-0000-0000-000000000005'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000615');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000616', 'Wilson Backcountry Hiking Backpack - Edition 16', 'Engineered by Wilson. The Backcountry Hiking Backpack comes equipped Heavy-Duty Double-Wall Insulation. Designed for superior performance, premium durability, and daily reliability.', 527.51, 60, 'https://images.unsplash.com/photo-1519505907962-0a6cb0167c73?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Sports & Outdoors' LIMIT 1), '10000000-0000-0000-0000-000000000005'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000616');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000617', 'Salomon All-Weather Camping Tent - Edition 17', 'Engineered by Salomon. The All-Weather Camping Tent comes equipped 5-52.5 lbs Quick Select Dial. Designed for superior performance, premium durability, and daily reliability.', 535.87, 73, 'https://images.unsplash.com/photo-1574680096145-d05b474e2155?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Sports & Outdoors' LIMIT 1), '10000000-0000-0000-0000-000000000005'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000617');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000618', 'Shimano Trail Running Shoes - Edition 18', 'Engineered by Shimano. The Trail Running Shoes comes equipped 6mm High Density Eco-TPE Cushion. Designed for superior performance, premium durability, and daily reliability.', 544.22, 86, 'https://images.unsplash.com/photo-1540497077202-7c8a3999166f?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Sports & Outdoors' LIMIT 1), '10000000-0000-0000-0000-000000000005'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000618');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000619', 'Black Diamond Resistance Loop Bands Set - Edition 19', 'Engineered by Black Diamond. The Resistance Loop Bands Set comes equipped Heart Rate & Pulse Ox Sensor. Designed for superior performance, premium durability, and daily reliability.', 530.87, 99, 'https://images.unsplash.com/photo-1461896836934-ffe607ba8211?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Sports & Outdoors' LIMIT 1), '10000000-0000-0000-0000-000000000005'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000619');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000620', 'YETI Carbon Fiber Road Bike Helmet - Edition 20', 'Engineered by YETI. The Carbon Fiber Road Bike Helmet comes equipped Keeps Cold 24hrs / Hot 12hrs. Designed for superior performance, premium durability, and daily reliability.', 539.23, 27, 'https://images.unsplash.com/photo-1584735935682-2f2b69dff9d2?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Sports & Outdoors' LIMIT 1), '10000000-0000-0000-0000-000000000005'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000620');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000621', 'Manduka Competition Basketball - Edition 01', 'Engineered by Manduka. The Competition Basketball comes equipped Ultra-Quiet 5-Speed Motor. Designed for superior performance, premium durability, and daily reliability.', 547.58, 40, 'https://images.unsplash.com/photo-1534438327276-14e5300c3a48?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Sports & Outdoors' LIMIT 1), '10000000-0000-0000-0000-000000000005'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000621');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000622', 'Osprey Titanium Trekking Poles - Edition 02', 'Engineered by Osprey. The Titanium Trekking Poles comes equipped Waterproof Ripstop Nylon Fabric. Designed for superior performance, premium durability, and daily reliability.', 555.94, 53, 'https://images.unsplash.com/photo-1526506118085-60ce8714f8c5?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Sports & Outdoors' LIMIT 1), '10000000-0000-0000-0000-000000000005'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000622');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000623', 'Peloton Thermal Insulated Cooler 35L - Edition 03', 'Engineered by Peloton. The Thermal Insulated Cooler 35L comes equipped Ergonomic Breathable Mesh Backing. Designed for superior performance, premium durability, and daily reliability.', 564.29, 66, 'https://images.unsplash.com/photo-1517838277536-f5f99be501cd?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Sports & Outdoors' LIMIT 1), '10000000-0000-0000-0000-000000000005'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000623');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000624', 'Rogue Fitness Speed Jump Rope with Ball Bearings - Edition 04', 'Engineered by Rogue Fitness. The Speed Jump Rope with Ball Bearings comes equipped Aerodynamic Ultra-Lightweight Shell. Designed for superior performance, premium durability, and daily reliability.', 572.64, 79, 'https://images.unsplash.com/photo-1517649763962-0c623266ddc0?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Sports & Outdoors' LIMIT 1), '10000000-0000-0000-0000-000000000005'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000624');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000625', 'Callaway Golf Driver Carbonwood - Edition 05', 'Engineered by Callaway. The Golf Driver Carbonwood comes equipped Non-Tangle Steel Cable Core. Designed for superior performance, premium durability, and daily reliability.', 581.0, 92, 'https://images.unsplash.com/photo-1518611012118-696072aa579a?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Sports & Outdoors' LIMIT 1), '10000000-0000-0000-0000-000000000005'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000625');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000626', 'Bowflex Adjustable Dumbbell Set - Edition 06', 'Engineered by Bowflex. The Adjustable Dumbbell Set comes equipped Heavy-Duty Double-Wall Insulation. Designed for superior performance, premium durability, and daily reliability.', 567.65, 20, 'https://images.unsplash.com/photo-1519505907962-0a6cb0167c73?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Sports & Outdoors' LIMIT 1), '10000000-0000-0000-0000-000000000005'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000626');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000627', 'Lululemon Non-Slip Pro Yoga Mat - Edition 07', 'Engineered by Lululemon. The Non-Slip Pro Yoga Mat comes equipped 5-52.5 lbs Quick Select Dial. Designed for superior performance, premium durability, and daily reliability.', 576.01, 33, 'https://images.unsplash.com/photo-1574680096145-d05b474e2155?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Sports & Outdoors' LIMIT 1), '10000000-0000-0000-0000-000000000005'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000627');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000628', 'Garmin GPS Multisport Fitness Watch - Edition 08', 'Engineered by Garmin. The GPS Multisport Fitness Watch comes equipped 6mm High Density Eco-TPE Cushion. Designed for superior performance, premium durability, and daily reliability.', 584.36, 46, 'https://images.unsplash.com/photo-1540497077202-7c8a3999166f?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Sports & Outdoors' LIMIT 1), '10000000-0000-0000-0000-000000000005'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000628');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000629', 'Hydro Flask Insulated Stainless Water Bottle - Edition 09', 'Engineered by Hydro Flask. The Insulated Stainless Water Bottle comes equipped Heart Rate & Pulse Ox Sensor. Designed for superior performance, premium durability, and daily reliability.', 592.71, 59, 'https://images.unsplash.com/photo-1461896836934-ffe607ba8211?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Sports & Outdoors' LIMIT 1), '10000000-0000-0000-0000-000000000005'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000629');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000630', 'Theragun Percussive Massage Gun - Edition 10', 'Engineered by Theragun. The Percussive Massage Gun comes equipped Keeps Cold 24hrs / Hot 12hrs. Designed for superior performance, premium durability, and daily reliability.', 601.07, 72, 'https://images.unsplash.com/photo-1584735935682-2f2b69dff9d2?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Sports & Outdoors' LIMIT 1), '10000000-0000-0000-0000-000000000005'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000630');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000631', 'Wilson Backcountry Hiking Backpack - Edition 11', 'Engineered by Wilson. The Backcountry Hiking Backpack comes equipped Ultra-Quiet 5-Speed Motor. Designed for superior performance, premium durability, and daily reliability.', 609.42, 85, 'https://images.unsplash.com/photo-1534438327276-14e5300c3a48?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Sports & Outdoors' LIMIT 1), '10000000-0000-0000-0000-000000000005'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000631');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000632', 'Salomon All-Weather Camping Tent - Edition 12', 'Engineered by Salomon. The All-Weather Camping Tent comes equipped Waterproof Ripstop Nylon Fabric. Designed for superior performance, premium durability, and daily reliability.', 617.78, 98, 'https://images.unsplash.com/photo-1526506118085-60ce8714f8c5?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Sports & Outdoors' LIMIT 1), '10000000-0000-0000-0000-000000000005'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000632');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000633', 'Shimano Trail Running Shoes - Edition 13', 'Engineered by Shimano. The Trail Running Shoes comes equipped Ergonomic Breathable Mesh Backing. Designed for superior performance, premium durability, and daily reliability.', 604.43, 26, 'https://images.unsplash.com/photo-1517838277536-f5f99be501cd?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Sports & Outdoors' LIMIT 1), '10000000-0000-0000-0000-000000000005'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000633');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000634', 'Black Diamond Resistance Loop Bands Set - Edition 14', 'Engineered by Black Diamond. The Resistance Loop Bands Set comes equipped Aerodynamic Ultra-Lightweight Shell. Designed for superior performance, premium durability, and daily reliability.', 612.78, 39, 'https://images.unsplash.com/photo-1517649763962-0c623266ddc0?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Sports & Outdoors' LIMIT 1), '10000000-0000-0000-0000-000000000005'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000634');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000635', 'YETI Carbon Fiber Road Bike Helmet - Edition 15', 'Engineered by YETI. The Carbon Fiber Road Bike Helmet comes equipped Non-Tangle Steel Cable Core. Designed for superior performance, premium durability, and daily reliability.', 621.14, 52, 'https://images.unsplash.com/photo-1518611012118-696072aa579a?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Sports & Outdoors' LIMIT 1), '10000000-0000-0000-0000-000000000005'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000635');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000636', 'Manduka Competition Basketball - Edition 16', 'Engineered by Manduka. The Competition Basketball comes equipped Heavy-Duty Double-Wall Insulation. Designed for superior performance, premium durability, and daily reliability.', 629.49, 65, 'https://images.unsplash.com/photo-1519505907962-0a6cb0167c73?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Sports & Outdoors' LIMIT 1), '10000000-0000-0000-0000-000000000005'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000636');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000637', 'Osprey Titanium Trekking Poles - Edition 17', 'Engineered by Osprey. The Titanium Trekking Poles comes equipped 5-52.5 lbs Quick Select Dial. Designed for superior performance, premium durability, and daily reliability.', 637.85, 78, 'https://images.unsplash.com/photo-1574680096145-d05b474e2155?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Sports & Outdoors' LIMIT 1), '10000000-0000-0000-0000-000000000005'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000637');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000638', 'Peloton Thermal Insulated Cooler 35L - Edition 18', 'Engineered by Peloton. The Thermal Insulated Cooler 35L comes equipped 6mm High Density Eco-TPE Cushion. Designed for superior performance, premium durability, and daily reliability.', 646.2, 91, 'https://images.unsplash.com/photo-1540497077202-7c8a3999166f?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Sports & Outdoors' LIMIT 1), '10000000-0000-0000-0000-000000000005'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000638');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000639', 'Rogue Fitness Speed Jump Rope with Ball Bearings - Edition 19', 'Engineered by Rogue Fitness. The Speed Jump Rope with Ball Bearings comes equipped Heart Rate & Pulse Ox Sensor. Designed for superior performance, premium durability, and daily reliability.', 654.55, 19, 'https://images.unsplash.com/photo-1461896836934-ffe607ba8211?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Sports & Outdoors' LIMIT 1), '10000000-0000-0000-0000-000000000005'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000639');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000640', 'Callaway Golf Driver Carbonwood - Edition 20', 'Engineered by Callaway. The Golf Driver Carbonwood comes equipped Keeps Cold 24hrs / Hot 12hrs. Designed for superior performance, premium durability, and daily reliability.', 641.21, 32, 'https://images.unsplash.com/photo-1584735935682-2f2b69dff9d2?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Sports & Outdoors' LIMIT 1), '10000000-0000-0000-0000-000000000005'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000640');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000641', 'Bowflex Adjustable Dumbbell Set - Edition 01', 'Engineered by Bowflex. The Adjustable Dumbbell Set comes equipped Ultra-Quiet 5-Speed Motor. Designed for superior performance, premium durability, and daily reliability.', 649.56, 45, 'https://images.unsplash.com/photo-1534438327276-14e5300c3a48?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Sports & Outdoors' LIMIT 1), '10000000-0000-0000-0000-000000000005'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000641');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000642', 'Lululemon Non-Slip Pro Yoga Mat - Edition 02', 'Engineered by Lululemon. The Non-Slip Pro Yoga Mat comes equipped Waterproof Ripstop Nylon Fabric. Designed for superior performance, premium durability, and daily reliability.', 657.91, 58, 'https://images.unsplash.com/photo-1526506118085-60ce8714f8c5?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Sports & Outdoors' LIMIT 1), '10000000-0000-0000-0000-000000000005'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000642');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000643', 'Garmin GPS Multisport Fitness Watch - Edition 03', 'Engineered by Garmin. The GPS Multisport Fitness Watch comes equipped Ergonomic Breathable Mesh Backing. Designed for superior performance, premium durability, and daily reliability.', 666.27, 71, 'https://images.unsplash.com/photo-1517838277536-f5f99be501cd?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Sports & Outdoors' LIMIT 1), '10000000-0000-0000-0000-000000000005'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000643');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000644', 'Hydro Flask Insulated Stainless Water Bottle - Edition 04', 'Engineered by Hydro Flask. The Insulated Stainless Water Bottle comes equipped Aerodynamic Ultra-Lightweight Shell. Designed for superior performance, premium durability, and daily reliability.', 674.62, 84, 'https://images.unsplash.com/photo-1517649763962-0c623266ddc0?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Sports & Outdoors' LIMIT 1), '10000000-0000-0000-0000-000000000005'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000644');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000645', 'Theragun Percussive Massage Gun - Edition 05', 'Engineered by Theragun. The Percussive Massage Gun comes equipped Non-Tangle Steel Cable Core. Designed for superior performance, premium durability, and daily reliability.', 682.98, 97, 'https://images.unsplash.com/photo-1518611012118-696072aa579a?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Sports & Outdoors' LIMIT 1), '10000000-0000-0000-0000-000000000005'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000645');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000646', 'Wilson Backcountry Hiking Backpack - Edition 06', 'Engineered by Wilson. The Backcountry Hiking Backpack comes equipped Heavy-Duty Double-Wall Insulation. Designed for superior performance, premium durability, and daily reliability.', 691.33, 25, 'https://images.unsplash.com/photo-1519505907962-0a6cb0167c73?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Sports & Outdoors' LIMIT 1), '10000000-0000-0000-0000-000000000005'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000646');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000647', 'Salomon All-Weather Camping Tent - Edition 07', 'Engineered by Salomon. The All-Weather Camping Tent comes equipped 5-52.5 lbs Quick Select Dial. Designed for superior performance, premium durability, and daily reliability.', 677.98, 38, 'https://images.unsplash.com/photo-1574680096145-d05b474e2155?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Sports & Outdoors' LIMIT 1), '10000000-0000-0000-0000-000000000005'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000647');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000648', 'Shimano Trail Running Shoes - Edition 08', 'Engineered by Shimano. The Trail Running Shoes comes equipped 6mm High Density Eco-TPE Cushion. Designed for superior performance, premium durability, and daily reliability.', 686.34, 51, 'https://images.unsplash.com/photo-1540497077202-7c8a3999166f?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Sports & Outdoors' LIMIT 1), '10000000-0000-0000-0000-000000000005'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000648');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000649', 'Black Diamond Resistance Loop Bands Set - Edition 09', 'Engineered by Black Diamond. The Resistance Loop Bands Set comes equipped Heart Rate & Pulse Ox Sensor. Designed for superior performance, premium durability, and daily reliability.', 694.69, 64, 'https://images.unsplash.com/photo-1461896836934-ffe607ba8211?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Sports & Outdoors' LIMIT 1), '10000000-0000-0000-0000-000000000005'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000649');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000650', 'YETI Carbon Fiber Road Bike Helmet - Edition 10', 'Engineered by YETI. The Carbon Fiber Road Bike Helmet comes equipped Keeps Cold 24hrs / Hot 12hrs. Designed for superior performance, premium durability, and daily reliability.', 695.0, 77, 'https://images.unsplash.com/photo-1584735935682-2f2b69dff9d2?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Sports & Outdoors' LIMIT 1), '10000000-0000-0000-0000-000000000005'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000650');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000651', 'Moleskine Hardcover Dotted Journal - Edition 01', 'Engineered by Moleskine. The Hardcover Dotted Journal comes equipped Lay-Flat 180 Degree Binding. Designed for superior performance, premium durability, and daily reliability.', 9.99, 15, 'https://images.unsplash.com/photo-1506880018603-83d5b814b5a6?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Books & Stationery' LIMIT 1), '10000000-0000-0000-0000-000000000006'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000651');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000652', 'O''Reilly Designing Data-Intensive Applications - Edition 02', 'Engineered by O''Reilly. The Designing Data-Intensive Applications comes equipped Smooth Japanese Precision Tip. Designed for superior performance, premium durability, and daily reliability.', 13.94, 28, 'https://images.unsplash.com/photo-1457369804613-52c61a468e7d?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Books & Stationery' LIMIT 1), '10000000-0000-0000-0000-000000000006'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000652');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000653', 'Penguin Classics Fountain Pen Fine Nib - Edition 03', 'Engineered by Penguin Classics. The Fountain Pen Fine Nib comes equipped Gold Foil Edge Lettering. Designed for superior performance, premium durability, and daily reliability.', 17.88, 41, 'https://images.unsplash.com/photo-1512820790803-83ca734da794?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Books & Stationery' LIMIT 1), '10000000-0000-0000-0000-000000000006'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000653');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000654', 'Lamy Architect Mechanical Pencil - Edition 04', 'Engineered by Lamy. The Architect Mechanical Pencil comes equipped Durable Water-Resistant Hardcover. Designed for superior performance, premium durability, and daily reliability.', 21.83, 54, 'https://images.unsplash.com/photo-1543002588-bfa74002ed7e?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Books & Stationery' LIMIT 1), '10000000-0000-0000-0000-000000000006'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000654');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000655', 'Leuchtturm1917 Productivity Daily Planner - Edition 05', 'Engineered by Leuchtturm1917. The Productivity Daily Planner comes equipped Includes 2 Ribbon Page Markers. Designed for superior performance, premium durability, and daily reliability.', 25.77, 67, 'https://images.unsplash.com/photo-1532012164546-f432f2e3777f?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Books & Stationery' LIMIT 1), '10000000-0000-0000-0000-000000000006'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000655');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000656', 'Parker Clean Code Handbook - Edition 06', 'Engineered by Parker. The Clean Code Handbook comes equipped 120gsm Ink-Proof Acid-Free Paper. Designed for superior performance, premium durability, and daily reliability.', 29.72, 80, 'https://images.unsplash.com/photo-1544716278-ca5e3f4abd8c?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Books & Stationery' LIMIT 1), '10000000-0000-0000-0000-000000000006'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000656');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000657', 'Rhodia Calligraphy Brush Pen Set - Edition 07', 'Engineered by Rhodia. The Calligraphy Brush Pen Set comes equipped Comprehensive Engineering Edition. Designed for superior performance, premium durability, and daily reliability.', 33.67, 93, 'https://images.unsplash.com/photo-1589829085413-56de8ae18c73?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Books & Stationery' LIMIT 1), '10000000-0000-0000-0000-000000000006'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000657');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000658', 'Faber-Castell Leather Bound Sketchbook - Edition 08', 'Engineered by Faber-Castell. The Leather Bound Sketchbook comes equipped Hand-Polished Stainless Steel Nib. Designed for superior performance, premium durability, and daily reliability.', 15.91, 21, 'https://images.unsplash.com/photo-1585776245991-cf89dd7fc73a?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Books & Stationery' LIMIT 1), '10000000-0000-0000-0000-000000000006'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000658');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000659', 'Harvard Business Review Executive Rollerball Pen - Edition 09', 'Engineered by Harvard Business Review. The Executive Rollerball Pen comes equipped Numbered Pages with Gusseted Pocket. Designed for superior performance, premium durability, and daily reliability.', 19.86, 34, 'https://images.unsplash.com/photo-1476275466078-4007374efbbe?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Books & Stationery' LIMIT 1), '10000000-0000-0000-0000-000000000006'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000659');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000660', 'Oxford Noise-Cancelling Book Stand - Edition 10', 'Engineered by Oxford. The Noise-Cancelling Book Stand comes equipped Refillable Archival Black Ink. Designed for superior performance, premium durability, and daily reliability.', 23.81, 47, 'https://images.unsplash.com/photo-1497633762265-9d179a990aa6?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Books & Stationery' LIMIT 1), '10000000-0000-0000-0000-000000000006'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000660');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000661', 'Midori Atomic Habits Guide - Edition 11', 'Engineered by Midori. The Atomic Habits Guide comes equipped Lay-Flat 180 Degree Binding. Designed for superior performance, premium durability, and daily reliability.', 27.75, 60, 'https://images.unsplash.com/photo-1506880018603-83d5b814b5a6?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Books & Stationery' LIMIT 1), '10000000-0000-0000-0000-000000000006'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000661');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000662', 'Pilot Graphite Sketching Pencil Set 12x - Edition 12', 'Engineered by Pilot. The Graphite Sketching Pencil Set 12x comes equipped Smooth Japanese Precision Tip. Designed for superior performance, premium durability, and daily reliability.', 31.7, 73, 'https://images.unsplash.com/photo-1457369804613-52c61a468e7d?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Books & Stationery' LIMIT 1), '10000000-0000-0000-0000-000000000006'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000662');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000663', 'Kaweco Self-Healing Cutting Mat - Edition 13', 'Engineered by Kaweco. The Self-Healing Cutting Mat comes equipped Gold Foil Edge Lettering. Designed for superior performance, premium durability, and daily reliability.', 35.64, 86, 'https://images.unsplash.com/photo-1512820790803-83ca734da794?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Books & Stationery' LIMIT 1), '10000000-0000-0000-0000-000000000006'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000663');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000664', 'Chronicle Books Wax Seal Stamp Kit - Edition 14', 'Engineered by Chronicle Books. The Wax Seal Stamp Kit comes equipped Durable Water-Resistant Hardcover. Designed for superior performance, premium durability, and daily reliability.', 39.59, 99, 'https://images.unsplash.com/photo-1543002588-bfa74002ed7e?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Books & Stationery' LIMIT 1), '10000000-0000-0000-0000-000000000006'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000664');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000665', 'Cambridge Modern Typography Workbook - Edition 15', 'Engineered by Cambridge. The Modern Typography Workbook comes equipped Includes 2 Ribbon Page Markers. Designed for superior performance, premium durability, and daily reliability.', 21.84, 27, 'https://images.unsplash.com/photo-1532012164546-f432f2e3777f?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Books & Stationery' LIMIT 1), '10000000-0000-0000-0000-000000000006'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000665');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000666', 'Moleskine Hardcover Dotted Journal - Edition 16', 'Engineered by Moleskine. The Hardcover Dotted Journal comes equipped 120gsm Ink-Proof Acid-Free Paper. Designed for superior performance, premium durability, and daily reliability.', 25.78, 40, 'https://images.unsplash.com/photo-1544716278-ca5e3f4abd8c?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Books & Stationery' LIMIT 1), '10000000-0000-0000-0000-000000000006'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000666');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000667', 'O''Reilly Designing Data-Intensive Applications - Edition 17', 'Engineered by O''Reilly. The Designing Data-Intensive Applications comes equipped Comprehensive Engineering Edition. Designed for superior performance, premium durability, and daily reliability.', 29.73, 53, 'https://images.unsplash.com/photo-1589829085413-56de8ae18c73?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Books & Stationery' LIMIT 1), '10000000-0000-0000-0000-000000000006'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000667');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000668', 'Penguin Classics Fountain Pen Fine Nib - Edition 18', 'Engineered by Penguin Classics. The Fountain Pen Fine Nib comes equipped Hand-Polished Stainless Steel Nib. Designed for superior performance, premium durability, and daily reliability.', 33.68, 66, 'https://images.unsplash.com/photo-1585776245991-cf89dd7fc73a?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Books & Stationery' LIMIT 1), '10000000-0000-0000-0000-000000000006'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000668');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000669', 'Lamy Architect Mechanical Pencil - Edition 19', 'Engineered by Lamy. The Architect Mechanical Pencil comes equipped Numbered Pages with Gusseted Pocket. Designed for superior performance, premium durability, and daily reliability.', 37.62, 79, 'https://images.unsplash.com/photo-1476275466078-4007374efbbe?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Books & Stationery' LIMIT 1), '10000000-0000-0000-0000-000000000006'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000669');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000670', 'Leuchtturm1917 Productivity Daily Planner - Edition 20', 'Engineered by Leuchtturm1917. The Productivity Daily Planner comes equipped Refillable Archival Black Ink. Designed for superior performance, premium durability, and daily reliability.', 41.57, 92, 'https://images.unsplash.com/photo-1497633762265-9d179a990aa6?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Books & Stationery' LIMIT 1), '10000000-0000-0000-0000-000000000006'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000670');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000671', 'Parker Clean Code Handbook - Edition 01', 'Engineered by Parker. The Clean Code Handbook comes equipped Lay-Flat 180 Degree Binding. Designed for superior performance, premium durability, and daily reliability.', 45.51, 20, 'https://images.unsplash.com/photo-1506880018603-83d5b814b5a6?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Books & Stationery' LIMIT 1), '10000000-0000-0000-0000-000000000006'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000671');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000672', 'Rhodia Calligraphy Brush Pen Set - Edition 02', 'Engineered by Rhodia. The Calligraphy Brush Pen Set comes equipped Smooth Japanese Precision Tip. Designed for superior performance, premium durability, and daily reliability.', 27.76, 33, 'https://images.unsplash.com/photo-1457369804613-52c61a468e7d?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Books & Stationery' LIMIT 1), '10000000-0000-0000-0000-000000000006'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000672');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000673', 'Faber-Castell Leather Bound Sketchbook - Edition 03', 'Engineered by Faber-Castell. The Leather Bound Sketchbook comes equipped Gold Foil Edge Lettering. Designed for superior performance, premium durability, and daily reliability.', 31.71, 46, 'https://images.unsplash.com/photo-1512820790803-83ca734da794?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Books & Stationery' LIMIT 1), '10000000-0000-0000-0000-000000000006'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000673');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000674', 'Harvard Business Review Executive Rollerball Pen - Edition 04', 'Engineered by Harvard Business Review. The Executive Rollerball Pen comes equipped Durable Water-Resistant Hardcover. Designed for superior performance, premium durability, and daily reliability.', 35.65, 59, 'https://images.unsplash.com/photo-1543002588-bfa74002ed7e?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Books & Stationery' LIMIT 1), '10000000-0000-0000-0000-000000000006'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000674');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000675', 'Oxford Noise-Cancelling Book Stand - Edition 05', 'Engineered by Oxford. The Noise-Cancelling Book Stand comes equipped Includes 2 Ribbon Page Markers. Designed for superior performance, premium durability, and daily reliability.', 39.6, 72, 'https://images.unsplash.com/photo-1532012164546-f432f2e3777f?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Books & Stationery' LIMIT 1), '10000000-0000-0000-0000-000000000006'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000675');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000676', 'Midori Atomic Habits Guide - Edition 06', 'Engineered by Midori. The Atomic Habits Guide comes equipped 120gsm Ink-Proof Acid-Free Paper. Designed for superior performance, premium durability, and daily reliability.', 43.55, 85, 'https://images.unsplash.com/photo-1544716278-ca5e3f4abd8c?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Books & Stationery' LIMIT 1), '10000000-0000-0000-0000-000000000006'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000676');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000677', 'Pilot Graphite Sketching Pencil Set 12x - Edition 07', 'Engineered by Pilot. The Graphite Sketching Pencil Set 12x comes equipped Comprehensive Engineering Edition. Designed for superior performance, premium durability, and daily reliability.', 47.49, 98, 'https://images.unsplash.com/photo-1589829085413-56de8ae18c73?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Books & Stationery' LIMIT 1), '10000000-0000-0000-0000-000000000006'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000677');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000678', 'Kaweco Self-Healing Cutting Mat - Edition 08', 'Engineered by Kaweco. The Self-Healing Cutting Mat comes equipped Hand-Polished Stainless Steel Nib. Designed for superior performance, premium durability, and daily reliability.', 51.44, 26, 'https://images.unsplash.com/photo-1585776245991-cf89dd7fc73a?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Books & Stationery' LIMIT 1), '10000000-0000-0000-0000-000000000006'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000678');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000679', 'Chronicle Books Wax Seal Stamp Kit - Edition 09', 'Engineered by Chronicle Books. The Wax Seal Stamp Kit comes equipped Numbered Pages with Gusseted Pocket. Designed for superior performance, premium durability, and daily reliability.', 33.68, 39, 'https://images.unsplash.com/photo-1476275466078-4007374efbbe?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Books & Stationery' LIMIT 1), '10000000-0000-0000-0000-000000000006'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000679');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000680', 'Cambridge Modern Typography Workbook - Edition 10', 'Engineered by Cambridge. The Modern Typography Workbook comes equipped Refillable Archival Black Ink. Designed for superior performance, premium durability, and daily reliability.', 37.63, 52, 'https://images.unsplash.com/photo-1497633762265-9d179a990aa6?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Books & Stationery' LIMIT 1), '10000000-0000-0000-0000-000000000006'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000680');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000681', 'Moleskine Hardcover Dotted Journal - Edition 11', 'Engineered by Moleskine. The Hardcover Dotted Journal comes equipped Lay-Flat 180 Degree Binding. Designed for superior performance, premium durability, and daily reliability.', 41.58, 65, 'https://images.unsplash.com/photo-1506880018603-83d5b814b5a6?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Books & Stationery' LIMIT 1), '10000000-0000-0000-0000-000000000006'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000681');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000682', 'O''Reilly Designing Data-Intensive Applications - Edition 12', 'Engineered by O''Reilly. The Designing Data-Intensive Applications comes equipped Smooth Japanese Precision Tip. Designed for superior performance, premium durability, and daily reliability.', 45.52, 78, 'https://images.unsplash.com/photo-1457369804613-52c61a468e7d?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Books & Stationery' LIMIT 1), '10000000-0000-0000-0000-000000000006'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000682');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000683', 'Penguin Classics Fountain Pen Fine Nib - Edition 13', 'Engineered by Penguin Classics. The Fountain Pen Fine Nib comes equipped Gold Foil Edge Lettering. Designed for superior performance, premium durability, and daily reliability.', 49.47, 91, 'https://images.unsplash.com/photo-1512820790803-83ca734da794?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Books & Stationery' LIMIT 1), '10000000-0000-0000-0000-000000000006'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000683');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000684', 'Lamy Architect Mechanical Pencil - Edition 14', 'Engineered by Lamy. The Architect Mechanical Pencil comes equipped Durable Water-Resistant Hardcover. Designed for superior performance, premium durability, and daily reliability.', 53.42, 19, 'https://images.unsplash.com/photo-1543002588-bfa74002ed7e?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Books & Stationery' LIMIT 1), '10000000-0000-0000-0000-000000000006'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000684');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000685', 'Leuchtturm1917 Productivity Daily Planner - Edition 15', 'Engineered by Leuchtturm1917. The Productivity Daily Planner comes equipped Includes 2 Ribbon Page Markers. Designed for superior performance, premium durability, and daily reliability.', 57.36, 32, 'https://images.unsplash.com/photo-1532012164546-f432f2e3777f?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Books & Stationery' LIMIT 1), '10000000-0000-0000-0000-000000000006'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000685');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000686', 'Parker Clean Code Handbook - Edition 16', 'Engineered by Parker. The Clean Code Handbook comes equipped 120gsm Ink-Proof Acid-Free Paper. Designed for superior performance, premium durability, and daily reliability.', 39.61, 45, 'https://images.unsplash.com/photo-1544716278-ca5e3f4abd8c?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Books & Stationery' LIMIT 1), '10000000-0000-0000-0000-000000000006'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000686');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000687', 'Rhodia Calligraphy Brush Pen Set - Edition 17', 'Engineered by Rhodia. The Calligraphy Brush Pen Set comes equipped Comprehensive Engineering Edition. Designed for superior performance, premium durability, and daily reliability.', 43.55, 58, 'https://images.unsplash.com/photo-1589829085413-56de8ae18c73?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Books & Stationery' LIMIT 1), '10000000-0000-0000-0000-000000000006'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000687');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000688', 'Faber-Castell Leather Bound Sketchbook - Edition 18', 'Engineered by Faber-Castell. The Leather Bound Sketchbook comes equipped Hand-Polished Stainless Steel Nib. Designed for superior performance, premium durability, and daily reliability.', 47.5, 71, 'https://images.unsplash.com/photo-1585776245991-cf89dd7fc73a?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Books & Stationery' LIMIT 1), '10000000-0000-0000-0000-000000000006'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000688');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000689', 'Harvard Business Review Executive Rollerball Pen - Edition 19', 'Engineered by Harvard Business Review. The Executive Rollerball Pen comes equipped Numbered Pages with Gusseted Pocket. Designed for superior performance, premium durability, and daily reliability.', 51.45, 84, 'https://images.unsplash.com/photo-1476275466078-4007374efbbe?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Books & Stationery' LIMIT 1), '10000000-0000-0000-0000-000000000006'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000689');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000690', 'Oxford Noise-Cancelling Book Stand - Edition 20', 'Engineered by Oxford. The Noise-Cancelling Book Stand comes equipped Refillable Archival Black Ink. Designed for superior performance, premium durability, and daily reliability.', 55.39, 97, 'https://images.unsplash.com/photo-1497633762265-9d179a990aa6?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Books & Stationery' LIMIT 1), '10000000-0000-0000-0000-000000000006'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000690');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000691', 'Midori Atomic Habits Guide - Edition 01', 'Engineered by Midori. The Atomic Habits Guide comes equipped Lay-Flat 180 Degree Binding. Designed for superior performance, premium durability, and daily reliability.', 59.34, 25, 'https://images.unsplash.com/photo-1506880018603-83d5b814b5a6?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Books & Stationery' LIMIT 1), '10000000-0000-0000-0000-000000000006'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000691');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000692', 'Pilot Graphite Sketching Pencil Set 12x - Edition 02', 'Engineered by Pilot. The Graphite Sketching Pencil Set 12x comes equipped Smooth Japanese Precision Tip. Designed for superior performance, premium durability, and daily reliability.', 63.29, 38, 'https://images.unsplash.com/photo-1457369804613-52c61a468e7d?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Books & Stationery' LIMIT 1), '10000000-0000-0000-0000-000000000006'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000692');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000693', 'Kaweco Self-Healing Cutting Mat - Edition 03', 'Engineered by Kaweco. The Self-Healing Cutting Mat comes equipped Gold Foil Edge Lettering. Designed for superior performance, premium durability, and daily reliability.', 45.53, 51, 'https://images.unsplash.com/photo-1512820790803-83ca734da794?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Books & Stationery' LIMIT 1), '10000000-0000-0000-0000-000000000006'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000693');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000694', 'Chronicle Books Wax Seal Stamp Kit - Edition 04', 'Engineered by Chronicle Books. The Wax Seal Stamp Kit comes equipped Durable Water-Resistant Hardcover. Designed for superior performance, premium durability, and daily reliability.', 49.48, 64, 'https://images.unsplash.com/photo-1543002588-bfa74002ed7e?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Books & Stationery' LIMIT 1), '10000000-0000-0000-0000-000000000006'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000694');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000695', 'Cambridge Modern Typography Workbook - Edition 05', 'Engineered by Cambridge. The Modern Typography Workbook comes equipped Includes 2 Ribbon Page Markers. Designed for superior performance, premium durability, and daily reliability.', 53.42, 77, 'https://images.unsplash.com/photo-1532012164546-f432f2e3777f?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Books & Stationery' LIMIT 1), '10000000-0000-0000-0000-000000000006'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000695');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000696', 'Moleskine Hardcover Dotted Journal - Edition 06', 'Engineered by Moleskine. The Hardcover Dotted Journal comes equipped 120gsm Ink-Proof Acid-Free Paper. Designed for superior performance, premium durability, and daily reliability.', 57.37, 90, 'https://images.unsplash.com/photo-1544716278-ca5e3f4abd8c?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Books & Stationery' LIMIT 1), '10000000-0000-0000-0000-000000000006'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000696');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000697', 'O''Reilly Designing Data-Intensive Applications - Edition 07', 'Engineered by O''Reilly. The Designing Data-Intensive Applications comes equipped Comprehensive Engineering Edition. Designed for superior performance, premium durability, and daily reliability.', 61.32, 18, 'https://images.unsplash.com/photo-1589829085413-56de8ae18c73?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Books & Stationery' LIMIT 1), '10000000-0000-0000-0000-000000000006'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000697');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000698', 'Penguin Classics Fountain Pen Fine Nib - Edition 08', 'Engineered by Penguin Classics. The Fountain Pen Fine Nib comes equipped Hand-Polished Stainless Steel Nib. Designed for superior performance, premium durability, and daily reliability.', 65.26, 31, 'https://images.unsplash.com/photo-1585776245991-cf89dd7fc73a?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Books & Stationery' LIMIT 1), '10000000-0000-0000-0000-000000000006'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000698');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000699', 'Lamy Architect Mechanical Pencil - Edition 09', 'Engineered by Lamy. The Architect Mechanical Pencil comes equipped Numbered Pages with Gusseted Pocket. Designed for superior performance, premium durability, and daily reliability.', 69.21, 44, 'https://images.unsplash.com/photo-1476275466078-4007374efbbe?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Books & Stationery' LIMIT 1), '10000000-0000-0000-0000-000000000006'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000699');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000700', 'Leuchtturm1917 Productivity Daily Planner - Edition 10', 'Engineered by Leuchtturm1917. The Productivity Daily Planner comes equipped Refillable Archival Black Ink. Designed for superior performance, premium durability, and daily reliability.', 51.46, 57, 'https://images.unsplash.com/photo-1497633762265-9d179a990aa6?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Books & Stationery' LIMIT 1), '10000000-0000-0000-0000-000000000006'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000700');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000701', 'Parker Clean Code Handbook - Edition 11', 'Engineered by Parker. The Clean Code Handbook comes equipped Lay-Flat 180 Degree Binding. Designed for superior performance, premium durability, and daily reliability.', 55.4, 70, 'https://images.unsplash.com/photo-1506880018603-83d5b814b5a6?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Books & Stationery' LIMIT 1), '10000000-0000-0000-0000-000000000006'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000701');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000702', 'Rhodia Calligraphy Brush Pen Set - Edition 12', 'Engineered by Rhodia. The Calligraphy Brush Pen Set comes equipped Smooth Japanese Precision Tip. Designed for superior performance, premium durability, and daily reliability.', 59.35, 83, 'https://images.unsplash.com/photo-1457369804613-52c61a468e7d?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Books & Stationery' LIMIT 1), '10000000-0000-0000-0000-000000000006'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000702');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000703', 'Faber-Castell Leather Bound Sketchbook - Edition 13', 'Engineered by Faber-Castell. The Leather Bound Sketchbook comes equipped Gold Foil Edge Lettering. Designed for superior performance, premium durability, and daily reliability.', 63.29, 96, 'https://images.unsplash.com/photo-1512820790803-83ca734da794?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Books & Stationery' LIMIT 1), '10000000-0000-0000-0000-000000000006'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000703');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000704', 'Harvard Business Review Executive Rollerball Pen - Edition 14', 'Engineered by Harvard Business Review. The Executive Rollerball Pen comes equipped Durable Water-Resistant Hardcover. Designed for superior performance, premium durability, and daily reliability.', 67.24, 24, 'https://images.unsplash.com/photo-1543002588-bfa74002ed7e?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Books & Stationery' LIMIT 1), '10000000-0000-0000-0000-000000000006'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000704');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000705', 'Oxford Noise-Cancelling Book Stand - Edition 15', 'Engineered by Oxford. The Noise-Cancelling Book Stand comes equipped Includes 2 Ribbon Page Markers. Designed for superior performance, premium durability, and daily reliability.', 71.19, 37, 'https://images.unsplash.com/photo-1532012164546-f432f2e3777f?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Books & Stationery' LIMIT 1), '10000000-0000-0000-0000-000000000006'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000705');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000706', 'Midori Atomic Habits Guide - Edition 16', 'Engineered by Midori. The Atomic Habits Guide comes equipped 120gsm Ink-Proof Acid-Free Paper. Designed for superior performance, premium durability, and daily reliability.', 75.13, 50, 'https://images.unsplash.com/photo-1544716278-ca5e3f4abd8c?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Books & Stationery' LIMIT 1), '10000000-0000-0000-0000-000000000006'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000706');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000707', 'Pilot Graphite Sketching Pencil Set 12x - Edition 17', 'Engineered by Pilot. The Graphite Sketching Pencil Set 12x comes equipped Comprehensive Engineering Edition. Designed for superior performance, premium durability, and daily reliability.', 57.38, 63, 'https://images.unsplash.com/photo-1589829085413-56de8ae18c73?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Books & Stationery' LIMIT 1), '10000000-0000-0000-0000-000000000006'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000707');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000708', 'Kaweco Self-Healing Cutting Mat - Edition 18', 'Engineered by Kaweco. The Self-Healing Cutting Mat comes equipped Hand-Polished Stainless Steel Nib. Designed for superior performance, premium durability, and daily reliability.', 61.33, 76, 'https://images.unsplash.com/photo-1585776245991-cf89dd7fc73a?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Books & Stationery' LIMIT 1), '10000000-0000-0000-0000-000000000006'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000708');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000709', 'Chronicle Books Wax Seal Stamp Kit - Edition 19', 'Engineered by Chronicle Books. The Wax Seal Stamp Kit comes equipped Numbered Pages with Gusseted Pocket. Designed for superior performance, premium durability, and daily reliability.', 65.27, 89, 'https://images.unsplash.com/photo-1476275466078-4007374efbbe?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Books & Stationery' LIMIT 1), '10000000-0000-0000-0000-000000000006'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000709');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000710', 'Cambridge Modern Typography Workbook - Edition 20', 'Engineered by Cambridge. The Modern Typography Workbook comes equipped Refillable Archival Black Ink. Designed for superior performance, premium durability, and daily reliability.', 69.22, 17, 'https://images.unsplash.com/photo-1497633762265-9d179a990aa6?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Books & Stationery' LIMIT 1), '10000000-0000-0000-0000-000000000006'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000710');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000711', 'Moleskine Hardcover Dotted Journal - Edition 01', 'Engineered by Moleskine. The Hardcover Dotted Journal comes equipped Lay-Flat 180 Degree Binding. Designed for superior performance, premium durability, and daily reliability.', 73.16, 30, 'https://images.unsplash.com/photo-1506880018603-83d5b814b5a6?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Books & Stationery' LIMIT 1), '10000000-0000-0000-0000-000000000006'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000711');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000712', 'O''Reilly Designing Data-Intensive Applications - Edition 02', 'Engineered by O''Reilly. The Designing Data-Intensive Applications comes equipped Smooth Japanese Precision Tip. Designed for superior performance, premium durability, and daily reliability.', 77.11, 43, 'https://images.unsplash.com/photo-1457369804613-52c61a468e7d?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Books & Stationery' LIMIT 1), '10000000-0000-0000-0000-000000000006'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000712');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000713', 'Penguin Classics Fountain Pen Fine Nib - Edition 03', 'Engineered by Penguin Classics. The Fountain Pen Fine Nib comes equipped Gold Foil Edge Lettering. Designed for superior performance, premium durability, and daily reliability.', 81.06, 56, 'https://images.unsplash.com/photo-1512820790803-83ca734da794?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Books & Stationery' LIMIT 1), '10000000-0000-0000-0000-000000000006'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000713');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000714', 'Lamy Architect Mechanical Pencil - Edition 04', 'Engineered by Lamy. The Architect Mechanical Pencil comes equipped Durable Water-Resistant Hardcover. Designed for superior performance, premium durability, and daily reliability.', 63.3, 69, 'https://images.unsplash.com/photo-1543002588-bfa74002ed7e?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Books & Stationery' LIMIT 1), '10000000-0000-0000-0000-000000000006'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000714');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000715', 'Leuchtturm1917 Productivity Daily Planner - Edition 05', 'Engineered by Leuchtturm1917. The Productivity Daily Planner comes equipped Includes 2 Ribbon Page Markers. Designed for superior performance, premium durability, and daily reliability.', 67.25, 82, 'https://images.unsplash.com/photo-1532012164546-f432f2e3777f?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Books & Stationery' LIMIT 1), '10000000-0000-0000-0000-000000000006'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000715');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000716', 'Parker Clean Code Handbook - Edition 06', 'Engineered by Parker. The Clean Code Handbook comes equipped 120gsm Ink-Proof Acid-Free Paper. Designed for superior performance, premium durability, and daily reliability.', 71.2, 95, 'https://images.unsplash.com/photo-1544716278-ca5e3f4abd8c?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Books & Stationery' LIMIT 1), '10000000-0000-0000-0000-000000000006'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000716');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000717', 'Rhodia Calligraphy Brush Pen Set - Edition 07', 'Engineered by Rhodia. The Calligraphy Brush Pen Set comes equipped Comprehensive Engineering Edition. Designed for superior performance, premium durability, and daily reliability.', 75.14, 23, 'https://images.unsplash.com/photo-1589829085413-56de8ae18c73?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Books & Stationery' LIMIT 1), '10000000-0000-0000-0000-000000000006'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000717');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000718', 'Faber-Castell Leather Bound Sketchbook - Edition 08', 'Engineered by Faber-Castell. The Leather Bound Sketchbook comes equipped Hand-Polished Stainless Steel Nib. Designed for superior performance, premium durability, and daily reliability.', 79.09, 36, 'https://images.unsplash.com/photo-1585776245991-cf89dd7fc73a?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Books & Stationery' LIMIT 1), '10000000-0000-0000-0000-000000000006'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000718');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000719', 'Harvard Business Review Executive Rollerball Pen - Edition 09', 'Engineered by Harvard Business Review. The Executive Rollerball Pen comes equipped Numbered Pages with Gusseted Pocket. Designed for superior performance, premium durability, and daily reliability.', 83.03, 49, 'https://images.unsplash.com/photo-1476275466078-4007374efbbe?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Books & Stationery' LIMIT 1), '10000000-0000-0000-0000-000000000006'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000719');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000720', 'Oxford Noise-Cancelling Book Stand - Edition 10', 'Engineered by Oxford. The Noise-Cancelling Book Stand comes equipped Refillable Archival Black Ink. Designed for superior performance, premium durability, and daily reliability.', 86.98, 62, 'https://images.unsplash.com/photo-1497633762265-9d179a990aa6?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Books & Stationery' LIMIT 1), '10000000-0000-0000-0000-000000000006'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000720');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000721', 'Midori Atomic Habits Guide - Edition 11', 'Engineered by Midori. The Atomic Habits Guide comes equipped Lay-Flat 180 Degree Binding. Designed for superior performance, premium durability, and daily reliability.', 69.23, 75, 'https://images.unsplash.com/photo-1506880018603-83d5b814b5a6?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Books & Stationery' LIMIT 1), '10000000-0000-0000-0000-000000000006'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000721');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000722', 'Pilot Graphite Sketching Pencil Set 12x - Edition 12', 'Engineered by Pilot. The Graphite Sketching Pencil Set 12x comes equipped Smooth Japanese Precision Tip. Designed for superior performance, premium durability, and daily reliability.', 73.17, 88, 'https://images.unsplash.com/photo-1457369804613-52c61a468e7d?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Books & Stationery' LIMIT 1), '10000000-0000-0000-0000-000000000006'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000722');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000723', 'Kaweco Self-Healing Cutting Mat - Edition 13', 'Engineered by Kaweco. The Self-Healing Cutting Mat comes equipped Gold Foil Edge Lettering. Designed for superior performance, premium durability, and daily reliability.', 77.12, 16, 'https://images.unsplash.com/photo-1512820790803-83ca734da794?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Books & Stationery' LIMIT 1), '10000000-0000-0000-0000-000000000006'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000723');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000724', 'Chronicle Books Wax Seal Stamp Kit - Edition 14', 'Engineered by Chronicle Books. The Wax Seal Stamp Kit comes equipped Durable Water-Resistant Hardcover. Designed for superior performance, premium durability, and daily reliability.', 81.06, 29, 'https://images.unsplash.com/photo-1543002588-bfa74002ed7e?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Books & Stationery' LIMIT 1), '10000000-0000-0000-0000-000000000006'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000724');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000725', 'Cambridge Modern Typography Workbook - Edition 15', 'Engineered by Cambridge. The Modern Typography Workbook comes equipped Includes 2 Ribbon Page Markers. Designed for superior performance, premium durability, and daily reliability.', 85.01, 42, 'https://images.unsplash.com/photo-1532012164546-f432f2e3777f?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Books & Stationery' LIMIT 1), '10000000-0000-0000-0000-000000000006'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000725');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000726', 'Moleskine Hardcover Dotted Journal - Edition 16', 'Engineered by Moleskine. The Hardcover Dotted Journal comes equipped 120gsm Ink-Proof Acid-Free Paper. Designed for superior performance, premium durability, and daily reliability.', 88.96, 55, 'https://images.unsplash.com/photo-1544716278-ca5e3f4abd8c?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Books & Stationery' LIMIT 1), '10000000-0000-0000-0000-000000000006'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000726');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000727', 'O''Reilly Designing Data-Intensive Applications - Edition 17', 'Engineered by O''Reilly. The Designing Data-Intensive Applications comes equipped Comprehensive Engineering Edition. Designed for superior performance, premium durability, and daily reliability.', 92.9, 68, 'https://images.unsplash.com/photo-1589829085413-56de8ae18c73?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Books & Stationery' LIMIT 1), '10000000-0000-0000-0000-000000000006'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000727');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000728', 'Penguin Classics Fountain Pen Fine Nib - Edition 18', 'Engineered by Penguin Classics. The Fountain Pen Fine Nib comes equipped Hand-Polished Stainless Steel Nib. Designed for superior performance, premium durability, and daily reliability.', 75.15, 81, 'https://images.unsplash.com/photo-1585776245991-cf89dd7fc73a?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Books & Stationery' LIMIT 1), '10000000-0000-0000-0000-000000000006'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000728');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000729', 'Lamy Architect Mechanical Pencil - Edition 19', 'Engineered by Lamy. The Architect Mechanical Pencil comes equipped Numbered Pages with Gusseted Pocket. Designed for superior performance, premium durability, and daily reliability.', 79.1, 94, 'https://images.unsplash.com/photo-1476275466078-4007374efbbe?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Books & Stationery' LIMIT 1), '10000000-0000-0000-0000-000000000006'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000729');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000730', 'Leuchtturm1917 Productivity Daily Planner - Edition 20', 'Engineered by Leuchtturm1917. The Productivity Daily Planner comes equipped Refillable Archival Black Ink. Designed for superior performance, premium durability, and daily reliability.', 83.04, 22, 'https://images.unsplash.com/photo-1497633762265-9d179a990aa6?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Books & Stationery' LIMIT 1), '10000000-0000-0000-0000-000000000006'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000730');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000731', 'Parker Clean Code Handbook - Edition 01', 'Engineered by Parker. The Clean Code Handbook comes equipped Lay-Flat 180 Degree Binding. Designed for superior performance, premium durability, and daily reliability.', 86.99, 35, 'https://images.unsplash.com/photo-1506880018603-83d5b814b5a6?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Books & Stationery' LIMIT 1), '10000000-0000-0000-0000-000000000006'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000731');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000732', 'Rhodia Calligraphy Brush Pen Set - Edition 02', 'Engineered by Rhodia. The Calligraphy Brush Pen Set comes equipped Smooth Japanese Precision Tip. Designed for superior performance, premium durability, and daily reliability.', 90.93, 48, 'https://images.unsplash.com/photo-1457369804613-52c61a468e7d?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Books & Stationery' LIMIT 1), '10000000-0000-0000-0000-000000000006'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000732');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000733', 'Faber-Castell Leather Bound Sketchbook - Edition 03', 'Engineered by Faber-Castell. The Leather Bound Sketchbook comes equipped Gold Foil Edge Lettering. Designed for superior performance, premium durability, and daily reliability.', 94.88, 61, 'https://images.unsplash.com/photo-1512820790803-83ca734da794?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Books & Stationery' LIMIT 1), '10000000-0000-0000-0000-000000000006'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000733');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000734', 'Harvard Business Review Executive Rollerball Pen - Edition 04', 'Engineered by Harvard Business Review. The Executive Rollerball Pen comes equipped Durable Water-Resistant Hardcover. Designed for superior performance, premium durability, and daily reliability.', 98.83, 74, 'https://images.unsplash.com/photo-1543002588-bfa74002ed7e?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Books & Stationery' LIMIT 1), '10000000-0000-0000-0000-000000000006'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000734');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000735', 'Oxford Noise-Cancelling Book Stand - Edition 05', 'Engineered by Oxford. The Noise-Cancelling Book Stand comes equipped Includes 2 Ribbon Page Markers. Designed for superior performance, premium durability, and daily reliability.', 81.07, 87, 'https://images.unsplash.com/photo-1532012164546-f432f2e3777f?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Books & Stationery' LIMIT 1), '10000000-0000-0000-0000-000000000006'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000735');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000736', 'Midori Atomic Habits Guide - Edition 06', 'Engineered by Midori. The Atomic Habits Guide comes equipped 120gsm Ink-Proof Acid-Free Paper. Designed for superior performance, premium durability, and daily reliability.', 85.02, 15, 'https://images.unsplash.com/photo-1544716278-ca5e3f4abd8c?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Books & Stationery' LIMIT 1), '10000000-0000-0000-0000-000000000006'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000736');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000737', 'Pilot Graphite Sketching Pencil Set 12x - Edition 07', 'Engineered by Pilot. The Graphite Sketching Pencil Set 12x comes equipped Comprehensive Engineering Edition. Designed for superior performance, premium durability, and daily reliability.', 88.97, 28, 'https://images.unsplash.com/photo-1589829085413-56de8ae18c73?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Books & Stationery' LIMIT 1), '10000000-0000-0000-0000-000000000006'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000737');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000738', 'Kaweco Self-Healing Cutting Mat - Edition 08', 'Engineered by Kaweco. The Self-Healing Cutting Mat comes equipped Hand-Polished Stainless Steel Nib. Designed for superior performance, premium durability, and daily reliability.', 92.91, 41, 'https://images.unsplash.com/photo-1585776245991-cf89dd7fc73a?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Books & Stationery' LIMIT 1), '10000000-0000-0000-0000-000000000006'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000738');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000739', 'Chronicle Books Wax Seal Stamp Kit - Edition 09', 'Engineered by Chronicle Books. The Wax Seal Stamp Kit comes equipped Numbered Pages with Gusseted Pocket. Designed for superior performance, premium durability, and daily reliability.', 96.86, 54, 'https://images.unsplash.com/photo-1476275466078-4007374efbbe?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Books & Stationery' LIMIT 1), '10000000-0000-0000-0000-000000000006'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000739');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000740', 'Cambridge Modern Typography Workbook - Edition 10', 'Engineered by Cambridge. The Modern Typography Workbook comes equipped Refillable Archival Black Ink. Designed for superior performance, premium durability, and daily reliability.', 100.8, 67, 'https://images.unsplash.com/photo-1497633762265-9d179a990aa6?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Books & Stationery' LIMIT 1), '10000000-0000-0000-0000-000000000006'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000740');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000741', 'Moleskine Hardcover Dotted Journal - Edition 11', 'Engineered by Moleskine. The Hardcover Dotted Journal comes equipped Lay-Flat 180 Degree Binding. Designed for superior performance, premium durability, and daily reliability.', 104.75, 80, 'https://images.unsplash.com/photo-1506880018603-83d5b814b5a6?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Books & Stationery' LIMIT 1), '10000000-0000-0000-0000-000000000006'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000741');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000742', 'O''Reilly Designing Data-Intensive Applications - Edition 12', 'Engineered by O''Reilly. The Designing Data-Intensive Applications comes equipped Smooth Japanese Precision Tip. Designed for superior performance, premium durability, and daily reliability.', 87.0, 93, 'https://images.unsplash.com/photo-1457369804613-52c61a468e7d?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Books & Stationery' LIMIT 1), '10000000-0000-0000-0000-000000000006'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000742');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000743', 'Penguin Classics Fountain Pen Fine Nib - Edition 13', 'Engineered by Penguin Classics. The Fountain Pen Fine Nib comes equipped Gold Foil Edge Lettering. Designed for superior performance, premium durability, and daily reliability.', 90.94, 21, 'https://images.unsplash.com/photo-1512820790803-83ca734da794?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Books & Stationery' LIMIT 1), '10000000-0000-0000-0000-000000000006'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000743');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000744', 'Lamy Architect Mechanical Pencil - Edition 14', 'Engineered by Lamy. The Architect Mechanical Pencil comes equipped Durable Water-Resistant Hardcover. Designed for superior performance, premium durability, and daily reliability.', 94.89, 34, 'https://images.unsplash.com/photo-1543002588-bfa74002ed7e?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Books & Stationery' LIMIT 1), '10000000-0000-0000-0000-000000000006'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000744');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000745', 'Leuchtturm1917 Productivity Daily Planner - Edition 15', 'Engineered by Leuchtturm1917. The Productivity Daily Planner comes equipped Includes 2 Ribbon Page Markers. Designed for superior performance, premium durability, and daily reliability.', 98.84, 47, 'https://images.unsplash.com/photo-1532012164546-f432f2e3777f?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Books & Stationery' LIMIT 1), '10000000-0000-0000-0000-000000000006'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000745');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000746', 'Parker Clean Code Handbook - Edition 16', 'Engineered by Parker. The Clean Code Handbook comes equipped 120gsm Ink-Proof Acid-Free Paper. Designed for superior performance, premium durability, and daily reliability.', 102.78, 60, 'https://images.unsplash.com/photo-1544716278-ca5e3f4abd8c?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Books & Stationery' LIMIT 1), '10000000-0000-0000-0000-000000000006'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000746');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000747', 'Rhodia Calligraphy Brush Pen Set - Edition 17', 'Engineered by Rhodia. The Calligraphy Brush Pen Set comes equipped Comprehensive Engineering Edition. Designed for superior performance, premium durability, and daily reliability.', 106.73, 73, 'https://images.unsplash.com/photo-1589829085413-56de8ae18c73?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Books & Stationery' LIMIT 1), '10000000-0000-0000-0000-000000000006'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000747');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000748', 'Faber-Castell Leather Bound Sketchbook - Edition 18', 'Engineered by Faber-Castell. The Leather Bound Sketchbook comes equipped Hand-Polished Stainless Steel Nib. Designed for superior performance, premium durability, and daily reliability.', 110.67, 86, 'https://images.unsplash.com/photo-1585776245991-cf89dd7fc73a?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Books & Stationery' LIMIT 1), '10000000-0000-0000-0000-000000000006'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000748');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000749', 'Harvard Business Review Executive Rollerball Pen - Edition 19', 'Engineered by Harvard Business Review. The Executive Rollerball Pen comes equipped Numbered Pages with Gusseted Pocket. Designed for superior performance, premium durability, and daily reliability.', 92.92, 99, 'https://images.unsplash.com/photo-1476275466078-4007374efbbe?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Books & Stationery' LIMIT 1), '10000000-0000-0000-0000-000000000006'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000749');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000750', 'Oxford Noise-Cancelling Book Stand - Edition 20', 'Engineered by Oxford. The Noise-Cancelling Book Stand comes equipped Refillable Archival Black Ink. Designed for superior performance, premium durability, and daily reliability.', 96.87, 27, 'https://images.unsplash.com/photo-1497633762265-9d179a990aa6?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Books & Stationery' LIMIT 1), '10000000-0000-0000-0000-000000000006'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000750');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000751', 'Midori Atomic Habits Guide - Edition 01', 'Engineered by Midori. The Atomic Habits Guide comes equipped Lay-Flat 180 Degree Binding. Designed for superior performance, premium durability, and daily reliability.', 100.81, 40, 'https://images.unsplash.com/photo-1506880018603-83d5b814b5a6?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Books & Stationery' LIMIT 1), '10000000-0000-0000-0000-000000000006'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000751');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000752', 'Pilot Graphite Sketching Pencil Set 12x - Edition 02', 'Engineered by Pilot. The Graphite Sketching Pencil Set 12x comes equipped Smooth Japanese Precision Tip. Designed for superior performance, premium durability, and daily reliability.', 104.76, 53, 'https://images.unsplash.com/photo-1457369804613-52c61a468e7d?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Books & Stationery' LIMIT 1), '10000000-0000-0000-0000-000000000006'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000752');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000753', 'Kaweco Self-Healing Cutting Mat - Edition 03', 'Engineered by Kaweco. The Self-Healing Cutting Mat comes equipped Gold Foil Edge Lettering. Designed for superior performance, premium durability, and daily reliability.', 108.71, 66, 'https://images.unsplash.com/photo-1512820790803-83ca734da794?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Books & Stationery' LIMIT 1), '10000000-0000-0000-0000-000000000006'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000753');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000754', 'Chronicle Books Wax Seal Stamp Kit - Edition 04', 'Engineered by Chronicle Books. The Wax Seal Stamp Kit comes equipped Durable Water-Resistant Hardcover. Designed for superior performance, premium durability, and daily reliability.', 112.65, 79, 'https://images.unsplash.com/photo-1543002588-bfa74002ed7e?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Books & Stationery' LIMIT 1), '10000000-0000-0000-0000-000000000006'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000754');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000755', 'Cambridge Modern Typography Workbook - Edition 05', 'Engineered by Cambridge. The Modern Typography Workbook comes equipped Includes 2 Ribbon Page Markers. Designed for superior performance, premium durability, and daily reliability.', 116.6, 92, 'https://images.unsplash.com/photo-1532012164546-f432f2e3777f?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Books & Stationery' LIMIT 1), '10000000-0000-0000-0000-000000000006'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000755');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000756', 'Moleskine Hardcover Dotted Journal - Edition 06', 'Engineered by Moleskine. The Hardcover Dotted Journal comes equipped 120gsm Ink-Proof Acid-Free Paper. Designed for superior performance, premium durability, and daily reliability.', 98.84, 20, 'https://images.unsplash.com/photo-1544716278-ca5e3f4abd8c?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Books & Stationery' LIMIT 1), '10000000-0000-0000-0000-000000000006'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000756');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000757', 'O''Reilly Designing Data-Intensive Applications - Edition 07', 'Engineered by O''Reilly. The Designing Data-Intensive Applications comes equipped Comprehensive Engineering Edition. Designed for superior performance, premium durability, and daily reliability.', 102.79, 33, 'https://images.unsplash.com/photo-1589829085413-56de8ae18c73?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Books & Stationery' LIMIT 1), '10000000-0000-0000-0000-000000000006'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000757');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000758', 'Penguin Classics Fountain Pen Fine Nib - Edition 08', 'Engineered by Penguin Classics. The Fountain Pen Fine Nib comes equipped Hand-Polished Stainless Steel Nib. Designed for superior performance, premium durability, and daily reliability.', 106.74, 46, 'https://images.unsplash.com/photo-1585776245991-cf89dd7fc73a?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Books & Stationery' LIMIT 1), '10000000-0000-0000-0000-000000000006'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000758');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000759', 'Lamy Architect Mechanical Pencil - Edition 09', 'Engineered by Lamy. The Architect Mechanical Pencil comes equipped Numbered Pages with Gusseted Pocket. Designed for superior performance, premium durability, and daily reliability.', 110.68, 59, 'https://images.unsplash.com/photo-1476275466078-4007374efbbe?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Books & Stationery' LIMIT 1), '10000000-0000-0000-0000-000000000006'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000759');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000760', 'Leuchtturm1917 Productivity Daily Planner - Edition 10', 'Engineered by Leuchtturm1917. The Productivity Daily Planner comes equipped Refillable Archival Black Ink. Designed for superior performance, premium durability, and daily reliability.', 114.63, 72, 'https://images.unsplash.com/photo-1497633762265-9d179a990aa6?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Books & Stationery' LIMIT 1), '10000000-0000-0000-0000-000000000006'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000760');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000761', 'Parker Clean Code Handbook - Edition 11', 'Engineered by Parker. The Clean Code Handbook comes equipped Lay-Flat 180 Degree Binding. Designed for superior performance, premium durability, and daily reliability.', 118.58, 85, 'https://images.unsplash.com/photo-1506880018603-83d5b814b5a6?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Books & Stationery' LIMIT 1), '10000000-0000-0000-0000-000000000006'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000761');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000762', 'Rhodia Calligraphy Brush Pen Set - Edition 12', 'Engineered by Rhodia. The Calligraphy Brush Pen Set comes equipped Smooth Japanese Precision Tip. Designed for superior performance, premium durability, and daily reliability.', 119.0, 98, 'https://images.unsplash.com/photo-1457369804613-52c61a468e7d?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Books & Stationery' LIMIT 1), '10000000-0000-0000-0000-000000000006'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000762');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000763', 'Faber-Castell Leather Bound Sketchbook - Edition 13', 'Engineered by Faber-Castell. The Leather Bound Sketchbook comes equipped Gold Foil Edge Lettering. Designed for superior performance, premium durability, and daily reliability.', 104.77, 26, 'https://images.unsplash.com/photo-1512820790803-83ca734da794?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Books & Stationery' LIMIT 1), '10000000-0000-0000-0000-000000000006'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000763');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000764', 'Harvard Business Review Executive Rollerball Pen - Edition 14', 'Engineered by Harvard Business Review. The Executive Rollerball Pen comes equipped Durable Water-Resistant Hardcover. Designed for superior performance, premium durability, and daily reliability.', 108.71, 39, 'https://images.unsplash.com/photo-1543002588-bfa74002ed7e?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Books & Stationery' LIMIT 1), '10000000-0000-0000-0000-000000000006'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000764');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000765', 'Oxford Noise-Cancelling Book Stand - Edition 15', 'Engineered by Oxford. The Noise-Cancelling Book Stand comes equipped Includes 2 Ribbon Page Markers. Designed for superior performance, premium durability, and daily reliability.', 112.66, 52, 'https://images.unsplash.com/photo-1532012164546-f432f2e3777f?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Books & Stationery' LIMIT 1), '10000000-0000-0000-0000-000000000006'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000765');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000766', 'Midori Atomic Habits Guide - Edition 16', 'Engineered by Midori. The Atomic Habits Guide comes equipped 120gsm Ink-Proof Acid-Free Paper. Designed for superior performance, premium durability, and daily reliability.', 116.61, 65, 'https://images.unsplash.com/photo-1544716278-ca5e3f4abd8c?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Books & Stationery' LIMIT 1), '10000000-0000-0000-0000-000000000006'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000766');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000767', 'Pilot Graphite Sketching Pencil Set 12x - Edition 17', 'Engineered by Pilot. The Graphite Sketching Pencil Set 12x comes equipped Comprehensive Engineering Edition. Designed for superior performance, premium durability, and daily reliability.', 119.0, 78, 'https://images.unsplash.com/photo-1589829085413-56de8ae18c73?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Books & Stationery' LIMIT 1), '10000000-0000-0000-0000-000000000006'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000767');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000768', 'Kaweco Self-Healing Cutting Mat - Edition 18', 'Engineered by Kaweco. The Self-Healing Cutting Mat comes equipped Hand-Polished Stainless Steel Nib. Designed for superior performance, premium durability, and daily reliability.', 118.0, 91, 'https://images.unsplash.com/photo-1585776245991-cf89dd7fc73a?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Books & Stationery' LIMIT 1), '10000000-0000-0000-0000-000000000006'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000768');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000769', 'Chronicle Books Wax Seal Stamp Kit - Edition 19', 'Engineered by Chronicle Books. The Wax Seal Stamp Kit comes equipped Numbered Pages with Gusseted Pocket. Designed for superior performance, premium durability, and daily reliability.', 117.0, 19, 'https://images.unsplash.com/photo-1476275466078-4007374efbbe?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Books & Stationery' LIMIT 1), '10000000-0000-0000-0000-000000000006'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000769');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000770', 'Cambridge Modern Typography Workbook - Edition 20', 'Engineered by Cambridge. The Modern Typography Workbook comes equipped Refillable Archival Black Ink. Designed for superior performance, premium durability, and daily reliability.', 110.69, 32, 'https://images.unsplash.com/photo-1497633762265-9d179a990aa6?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Books & Stationery' LIMIT 1), '10000000-0000-0000-0000-000000000006'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000770');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000771', 'Moleskine Hardcover Dotted Journal - Edition 01', 'Engineered by Moleskine. The Hardcover Dotted Journal comes equipped Lay-Flat 180 Degree Binding. Designed for superior performance, premium durability, and daily reliability.', 114.64, 45, 'https://images.unsplash.com/photo-1506880018603-83d5b814b5a6?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Books & Stationery' LIMIT 1), '10000000-0000-0000-0000-000000000006'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000771');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000772', 'O''Reilly Designing Data-Intensive Applications - Edition 02', 'Engineered by O''Reilly. The Designing Data-Intensive Applications comes equipped Smooth Japanese Precision Tip. Designed for superior performance, premium durability, and daily reliability.', 118.58, 58, 'https://images.unsplash.com/photo-1457369804613-52c61a468e7d?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Books & Stationery' LIMIT 1), '10000000-0000-0000-0000-000000000006'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000772');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000773', 'Penguin Classics Fountain Pen Fine Nib - Edition 03', 'Engineered by Penguin Classics. The Fountain Pen Fine Nib comes equipped Gold Foil Edge Lettering. Designed for superior performance, premium durability, and daily reliability.', 118.0, 71, 'https://images.unsplash.com/photo-1512820790803-83ca734da794?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Books & Stationery' LIMIT 1), '10000000-0000-0000-0000-000000000006'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000773');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000774', 'Lamy Architect Mechanical Pencil - Edition 04', 'Engineered by Lamy. The Architect Mechanical Pencil comes equipped Durable Water-Resistant Hardcover. Designed for superior performance, premium durability, and daily reliability.', 117.0, 84, 'https://images.unsplash.com/photo-1543002588-bfa74002ed7e?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Books & Stationery' LIMIT 1), '10000000-0000-0000-0000-000000000006'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000774');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000775', 'Leuchtturm1917 Productivity Daily Planner - Edition 05', 'Engineered by Leuchtturm1917. The Productivity Daily Planner comes equipped Includes 2 Ribbon Page Markers. Designed for superior performance, premium durability, and daily reliability.', 116.0, 97, 'https://images.unsplash.com/photo-1532012164546-f432f2e3777f?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Books & Stationery' LIMIT 1), '10000000-0000-0000-0000-000000000006'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000775');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000776', 'Parker Clean Code Handbook - Edition 06', 'Engineered by Parker. The Clean Code Handbook comes equipped 120gsm Ink-Proof Acid-Free Paper. Designed for superior performance, premium durability, and daily reliability.', 120.0, 25, 'https://images.unsplash.com/photo-1544716278-ca5e3f4abd8c?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Books & Stationery' LIMIT 1), '10000000-0000-0000-0000-000000000006'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000776');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000777', 'Rhodia Calligraphy Brush Pen Set - Edition 07', 'Engineered by Rhodia. The Calligraphy Brush Pen Set comes equipped Comprehensive Engineering Edition. Designed for superior performance, premium durability, and daily reliability.', 116.62, 38, 'https://images.unsplash.com/photo-1589829085413-56de8ae18c73?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Books & Stationery' LIMIT 1), '10000000-0000-0000-0000-000000000006'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000777');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000778', 'Faber-Castell Leather Bound Sketchbook - Edition 08', 'Engineered by Faber-Castell. The Leather Bound Sketchbook comes equipped Hand-Polished Stainless Steel Nib. Designed for superior performance, premium durability, and daily reliability.', 118.0, 51, 'https://images.unsplash.com/photo-1585776245991-cf89dd7fc73a?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Books & Stationery' LIMIT 1), '10000000-0000-0000-0000-000000000006'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000778');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000779', 'Harvard Business Review Executive Rollerball Pen - Edition 09', 'Engineered by Harvard Business Review. The Executive Rollerball Pen comes equipped Numbered Pages with Gusseted Pocket. Designed for superior performance, premium durability, and daily reliability.', 117.0, 64, 'https://images.unsplash.com/photo-1476275466078-4007374efbbe?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Books & Stationery' LIMIT 1), '10000000-0000-0000-0000-000000000006'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000779');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000780', 'Oxford Noise-Cancelling Book Stand - Edition 10', 'Engineered by Oxford. The Noise-Cancelling Book Stand comes equipped Refillable Archival Black Ink. Designed for superior performance, premium durability, and daily reliability.', 116.0, 77, 'https://images.unsplash.com/photo-1497633762265-9d179a990aa6?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Books & Stationery' LIMIT 1), '10000000-0000-0000-0000-000000000006'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000780');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000781', 'PlayStation Wireless Haptic Game Controller - Edition 01', 'Engineered by PlayStation. The Wireless Haptic Game Controller comes equipped Fully Programmable Macro Keys. Designed for superior performance, premium durability, and daily reliability.', 19.99, 15, 'https://images.unsplash.com/photo-1587202372775-e229f172b9d7?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Toys & Gaming' LIMIT 1), '10000000-0000-0000-0000-000000000007'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000781');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000782', 'Nintendo Technic Supercar Building Kit - Edition 02', 'Engineered by Nintendo. The Technic Supercar Building Kit comes equipped 30-Hour Rechargeable Battery Life. Designed for superior performance, premium durability, and daily reliability.', 26.77, 28, 'https://images.unsplash.com/photo-1511512578047-dfb367046420?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Toys & Gaming' LIMIT 1), '10000000-0000-0000-0000-000000000007'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000782');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000783', 'LEGO 7.1 Surround Gaming Headset - Edition 03', 'Engineered by LEGO. The 7.1 Surround Gaming Headset comes equipped High-Speed 45km/h Brushless Motor. Designed for superior performance, premium durability, and daily reliability.', 33.56, 41, 'https://images.unsplash.com/photo-1612287232230-6869408212e3?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Toys & Gaming' LIMIT 1), '10000000-0000-0000-0000-000000000007'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000783');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000784', 'Xbox Handheld Gaming Console OLED - Edition 04', 'Engineered by Xbox. The Handheld Gaming Console OLED comes equipped Universal PC / Console Compatibility. Designed for superior performance, premium durability, and daily reliability.', 40.34, 54, 'https://images.unsplash.com/photo-1592840496694-26d035b52b48?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Toys & Gaming' LIMIT 1), '10000000-0000-0000-0000-000000000007'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000784');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000785', 'Hasbro RGB Mousepad Extended - Edition 05', 'Engineered by Hasbro. The RGB Mousepad Extended comes equipped Adaptive Triggers & Force Feedback. Designed for superior performance, premium durability, and daily reliability.', 47.13, 67, 'https://images.unsplash.com/photo-1534423861386-85a16f5d13fd?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Toys & Gaming' LIMIT 1), '10000000-0000-0000-0000-000000000007'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000785');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000786', 'Razer Collectible Vinyl Figure - Edition 06', 'Engineered by Razer. The Collectible Vinyl Figure comes equipped 3,599 Precision Engineered Pieces. Designed for superior performance, premium durability, and daily reliability.', 53.91, 80, 'https://images.unsplash.com/photo-1550745165-9bc0b252726f?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Toys & Gaming' LIMIT 1), '10000000-0000-0000-0000-000000000007'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000786');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000787', 'SteelSeries Mechanical Gaming Keypad - Edition 07', 'Engineered by SteelSeries. The Mechanical Gaming Keypad comes equipped 50mm Neodymium Audio Drivers. Designed for superior performance, premium durability, and daily reliability.', 60.7, 93, 'https://images.unsplash.com/photo-1606144042614-b2417e99c4e3?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Toys & Gaming' LIMIT 1), '10000000-0000-0000-0000-000000000007'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000787');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000788', 'Bandai Modular Board Game Strategy - Edition 08', 'Engineered by Bandai. The Modular Board Game Strategy comes equipped 7-inch Vibrant Multi-Touch Display. Designed for superior performance, premium durability, and daily reliability.', 45.78, 21, 'https://images.unsplash.com/photo-1579373903781-fd5c0c30c4cd?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Toys & Gaming' LIMIT 1), '10000000-0000-0000-0000-000000000007'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000788');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000789', 'Hot Wheels High-Speed Remote Control Stunt Car - Edition 09', 'Engineered by Hot Wheels. The High-Speed Remote Control Stunt Car comes equipped Ultra-Fast 2.4GHz Slipstream Wireless. Designed for superior performance, premium durability, and daily reliability.', 52.57, 34, 'https://images.unsplash.com/photo-1607604276583-eef5d076aa5f?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Toys & Gaming' LIMIT 1), '10000000-0000-0000-0000-000000000007'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000789');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000790', 'Funko Streaming Microphone with Arm - Edition 10', 'Engineered by Funko. The Streaming Microphone with Arm comes equipped Detachable Noise-Filtering Boom Mic. Designed for superior performance, premium durability, and daily reliability.', 59.35, 47, 'https://images.unsplash.com/photo-1563089145-599997674d42?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Toys & Gaming' LIMIT 1), '10000000-0000-0000-0000-000000000007'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000790');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000791', 'Corsair Custom Arcade Fight Stick - Edition 11', 'Engineered by Corsair. The Custom Arcade Fight Stick comes equipped Fully Programmable Macro Keys. Designed for superior performance, premium durability, and daily reliability.', 66.14, 60, 'https://images.unsplash.com/photo-1587202372775-e229f172b9d7?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Toys & Gaming' LIMIT 1), '10000000-0000-0000-0000-000000000007'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000791');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000792', 'Mattel VR Headset All-in-One - Edition 12', 'Engineered by Mattel. The VR Headset All-in-One comes equipped 30-Hour Rechargeable Battery Life. Designed for superior performance, premium durability, and daily reliability.', 72.92, 73, 'https://images.unsplash.com/photo-1511512578047-dfb367046420?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Toys & Gaming' LIMIT 1), '10000000-0000-0000-0000-000000000007'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000792');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000793', 'Logitech G Precision Flight Simulator Joystick - Edition 13', 'Engineered by Logitech G. The Precision Flight Simulator Joystick comes equipped High-Speed 45km/h Brushless Motor. Designed for superior performance, premium durability, and daily reliability.', 79.71, 86, 'https://images.unsplash.com/photo-1612287232230-6869408212e3?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Toys & Gaming' LIMIT 1), '10000000-0000-0000-0000-000000000007'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000793');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000794', 'Oculus Magnetic Levitating Display Base - Edition 14', 'Engineered by Oculus. The Magnetic Levitating Display Base comes equipped Universal PC / Console Compatibility. Designed for superior performance, premium durability, and daily reliability.', 86.49, 99, 'https://images.unsplash.com/photo-1592840496694-26d035b52b48?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Toys & Gaming' LIMIT 1), '10000000-0000-0000-0000-000000000007'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000794');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000795', 'HyperX Gamer Ergonomic Footrest - Edition 15', 'Engineered by HyperX. The Gamer Ergonomic Footrest comes equipped Adaptive Triggers & Force Feedback. Designed for superior performance, premium durability, and daily reliability.', 71.58, 27, 'https://images.unsplash.com/photo-1534423861386-85a16f5d13fd?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Toys & Gaming' LIMIT 1), '10000000-0000-0000-0000-000000000007'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000795');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000796', 'PlayStation Wireless Haptic Game Controller - Edition 16', 'Engineered by PlayStation. The Wireless Haptic Game Controller comes equipped 3,599 Precision Engineered Pieces. Designed for superior performance, premium durability, and daily reliability.', 78.36, 40, 'https://images.unsplash.com/photo-1550745165-9bc0b252726f?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Toys & Gaming' LIMIT 1), '10000000-0000-0000-0000-000000000007'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000796');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000797', 'Nintendo Technic Supercar Building Kit - Edition 17', 'Engineered by Nintendo. The Technic Supercar Building Kit comes equipped 50mm Neodymium Audio Drivers. Designed for superior performance, premium durability, and daily reliability.', 85.15, 53, 'https://images.unsplash.com/photo-1606144042614-b2417e99c4e3?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Toys & Gaming' LIMIT 1), '10000000-0000-0000-0000-000000000007'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000797');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000798', 'LEGO 7.1 Surround Gaming Headset - Edition 18', 'Engineered by LEGO. The 7.1 Surround Gaming Headset comes equipped 7-inch Vibrant Multi-Touch Display. Designed for superior performance, premium durability, and daily reliability.', 91.93, 66, 'https://images.unsplash.com/photo-1579373903781-fd5c0c30c4cd?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Toys & Gaming' LIMIT 1), '10000000-0000-0000-0000-000000000007'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000798');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000799', 'Xbox Handheld Gaming Console OLED - Edition 19', 'Engineered by Xbox. The Handheld Gaming Console OLED comes equipped Ultra-Fast 2.4GHz Slipstream Wireless. Designed for superior performance, premium durability, and daily reliability.', 98.71, 79, 'https://images.unsplash.com/photo-1607604276583-eef5d076aa5f?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Toys & Gaming' LIMIT 1), '10000000-0000-0000-0000-000000000007'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000799');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000800', 'Hasbro RGB Mousepad Extended - Edition 20', 'Engineered by Hasbro. The RGB Mousepad Extended comes equipped Detachable Noise-Filtering Boom Mic. Designed for superior performance, premium durability, and daily reliability.', 105.5, 92, 'https://images.unsplash.com/photo-1563089145-599997674d42?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Toys & Gaming' LIMIT 1), '10000000-0000-0000-0000-000000000007'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000800');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000801', 'Razer Collectible Vinyl Figure - Edition 01', 'Engineered by Razer. The Collectible Vinyl Figure comes equipped Fully Programmable Macro Keys. Designed for superior performance, premium durability, and daily reliability.', 112.28, 20, 'https://images.unsplash.com/photo-1587202372775-e229f172b9d7?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Toys & Gaming' LIMIT 1), '10000000-0000-0000-0000-000000000007'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000801');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000802', 'SteelSeries Mechanical Gaming Keypad - Edition 02', 'Engineered by SteelSeries. The Mechanical Gaming Keypad comes equipped 30-Hour Rechargeable Battery Life. Designed for superior performance, premium durability, and daily reliability.', 97.37, 33, 'https://images.unsplash.com/photo-1511512578047-dfb367046420?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Toys & Gaming' LIMIT 1), '10000000-0000-0000-0000-000000000007'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000802');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000803', 'Bandai Modular Board Game Strategy - Edition 03', 'Engineered by Bandai. The Modular Board Game Strategy comes equipped High-Speed 45km/h Brushless Motor. Designed for superior performance, premium durability, and daily reliability.', 104.15, 46, 'https://images.unsplash.com/photo-1612287232230-6869408212e3?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Toys & Gaming' LIMIT 1), '10000000-0000-0000-0000-000000000007'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000803');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000804', 'Hot Wheels High-Speed Remote Control Stunt Car - Edition 04', 'Engineered by Hot Wheels. The High-Speed Remote Control Stunt Car comes equipped Universal PC / Console Compatibility. Designed for superior performance, premium durability, and daily reliability.', 110.94, 59, 'https://images.unsplash.com/photo-1592840496694-26d035b52b48?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Toys & Gaming' LIMIT 1), '10000000-0000-0000-0000-000000000007'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000804');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000805', 'Funko Streaming Microphone with Arm - Edition 05', 'Engineered by Funko. The Streaming Microphone with Arm comes equipped Adaptive Triggers & Force Feedback. Designed for superior performance, premium durability, and daily reliability.', 117.72, 72, 'https://images.unsplash.com/photo-1534423861386-85a16f5d13fd?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Toys & Gaming' LIMIT 1), '10000000-0000-0000-0000-000000000007'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000805');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000806', 'Corsair Custom Arcade Fight Stick - Edition 06', 'Engineered by Corsair. The Custom Arcade Fight Stick comes equipped 3,599 Precision Engineered Pieces. Designed for superior performance, premium durability, and daily reliability.', 124.51, 85, 'https://images.unsplash.com/photo-1550745165-9bc0b252726f?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Toys & Gaming' LIMIT 1), '10000000-0000-0000-0000-000000000007'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000806');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000807', 'Mattel VR Headset All-in-One - Edition 07', 'Engineered by Mattel. The VR Headset All-in-One comes equipped 50mm Neodymium Audio Drivers. Designed for superior performance, premium durability, and daily reliability.', 131.29, 98, 'https://images.unsplash.com/photo-1606144042614-b2417e99c4e3?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Toys & Gaming' LIMIT 1), '10000000-0000-0000-0000-000000000007'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000807');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000808', 'Logitech G Precision Flight Simulator Joystick - Edition 08', 'Engineered by Logitech G. The Precision Flight Simulator Joystick comes equipped 7-inch Vibrant Multi-Touch Display. Designed for superior performance, premium durability, and daily reliability.', 138.08, 26, 'https://images.unsplash.com/photo-1579373903781-fd5c0c30c4cd?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Toys & Gaming' LIMIT 1), '10000000-0000-0000-0000-000000000007'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000808');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000809', 'Oculus Magnetic Levitating Display Base - Edition 09', 'Engineered by Oculus. The Magnetic Levitating Display Base comes equipped Ultra-Fast 2.4GHz Slipstream Wireless. Designed for superior performance, premium durability, and daily reliability.', 123.16, 39, 'https://images.unsplash.com/photo-1607604276583-eef5d076aa5f?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Toys & Gaming' LIMIT 1), '10000000-0000-0000-0000-000000000007'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000809');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000810', 'HyperX Gamer Ergonomic Footrest - Edition 10', 'Engineered by HyperX. The Gamer Ergonomic Footrest comes equipped Detachable Noise-Filtering Boom Mic. Designed for superior performance, premium durability, and daily reliability.', 129.95, 52, 'https://images.unsplash.com/photo-1563089145-599997674d42?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Toys & Gaming' LIMIT 1), '10000000-0000-0000-0000-000000000007'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000810');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000811', 'PlayStation Wireless Haptic Game Controller - Edition 11', 'Engineered by PlayStation. The Wireless Haptic Game Controller comes equipped Fully Programmable Macro Keys. Designed for superior performance, premium durability, and daily reliability.', 136.73, 65, 'https://images.unsplash.com/photo-1587202372775-e229f172b9d7?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Toys & Gaming' LIMIT 1), '10000000-0000-0000-0000-000000000007'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000811');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000812', 'Nintendo Technic Supercar Building Kit - Edition 12', 'Engineered by Nintendo. The Technic Supercar Building Kit comes equipped 30-Hour Rechargeable Battery Life. Designed for superior performance, premium durability, and daily reliability.', 143.52, 78, 'https://images.unsplash.com/photo-1511512578047-dfb367046420?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Toys & Gaming' LIMIT 1), '10000000-0000-0000-0000-000000000007'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000812');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000813', 'LEGO 7.1 Surround Gaming Headset - Edition 13', 'Engineered by LEGO. The 7.1 Surround Gaming Headset comes equipped High-Speed 45km/h Brushless Motor. Designed for superior performance, premium durability, and daily reliability.', 150.3, 91, 'https://images.unsplash.com/photo-1612287232230-6869408212e3?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Toys & Gaming' LIMIT 1), '10000000-0000-0000-0000-000000000007'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000813');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000814', 'Xbox Handheld Gaming Console OLED - Edition 14', 'Engineered by Xbox. The Handheld Gaming Console OLED comes equipped Universal PC / Console Compatibility. Designed for superior performance, premium durability, and daily reliability.', 157.08, 19, 'https://images.unsplash.com/photo-1592840496694-26d035b52b48?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Toys & Gaming' LIMIT 1), '10000000-0000-0000-0000-000000000007'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000814');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000815', 'Hasbro RGB Mousepad Extended - Edition 15', 'Engineered by Hasbro. The RGB Mousepad Extended comes equipped Adaptive Triggers & Force Feedback. Designed for superior performance, premium durability, and daily reliability.', 163.87, 32, 'https://images.unsplash.com/photo-1534423861386-85a16f5d13fd?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Toys & Gaming' LIMIT 1), '10000000-0000-0000-0000-000000000007'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000815');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000816', 'Razer Collectible Vinyl Figure - Edition 16', 'Engineered by Razer. The Collectible Vinyl Figure comes equipped 3,599 Precision Engineered Pieces. Designed for superior performance, premium durability, and daily reliability.', 148.95, 45, 'https://images.unsplash.com/photo-1550745165-9bc0b252726f?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Toys & Gaming' LIMIT 1), '10000000-0000-0000-0000-000000000007'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000816');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000817', 'SteelSeries Mechanical Gaming Keypad - Edition 17', 'Engineered by SteelSeries. The Mechanical Gaming Keypad comes equipped 50mm Neodymium Audio Drivers. Designed for superior performance, premium durability, and daily reliability.', 155.74, 58, 'https://images.unsplash.com/photo-1606144042614-b2417e99c4e3?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Toys & Gaming' LIMIT 1), '10000000-0000-0000-0000-000000000007'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000817');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000818', 'Bandai Modular Board Game Strategy - Edition 18', 'Engineered by Bandai. The Modular Board Game Strategy comes equipped 7-inch Vibrant Multi-Touch Display. Designed for superior performance, premium durability, and daily reliability.', 162.52, 71, 'https://images.unsplash.com/photo-1579373903781-fd5c0c30c4cd?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Toys & Gaming' LIMIT 1), '10000000-0000-0000-0000-000000000007'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000818');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000819', 'Hot Wheels High-Speed Remote Control Stunt Car - Edition 19', 'Engineered by Hot Wheels. The High-Speed Remote Control Stunt Car comes equipped Ultra-Fast 2.4GHz Slipstream Wireless. Designed for superior performance, premium durability, and daily reliability.', 169.31, 84, 'https://images.unsplash.com/photo-1607604276583-eef5d076aa5f?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Toys & Gaming' LIMIT 1), '10000000-0000-0000-0000-000000000007'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000819');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000820', 'Funko Streaming Microphone with Arm - Edition 20', 'Engineered by Funko. The Streaming Microphone with Arm comes equipped Detachable Noise-Filtering Boom Mic. Designed for superior performance, premium durability, and daily reliability.', 176.09, 97, 'https://images.unsplash.com/photo-1563089145-599997674d42?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Toys & Gaming' LIMIT 1), '10000000-0000-0000-0000-000000000007'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000820');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000821', 'Corsair Custom Arcade Fight Stick - Edition 01', 'Engineered by Corsair. The Custom Arcade Fight Stick comes equipped Fully Programmable Macro Keys. Designed for superior performance, premium durability, and daily reliability.', 182.88, 25, 'https://images.unsplash.com/photo-1587202372775-e229f172b9d7?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Toys & Gaming' LIMIT 1), '10000000-0000-0000-0000-000000000007'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000821');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000822', 'Mattel VR Headset All-in-One - Edition 02', 'Engineered by Mattel. The VR Headset All-in-One comes equipped 30-Hour Rechargeable Battery Life. Designed for superior performance, premium durability, and daily reliability.', 189.66, 38, 'https://images.unsplash.com/photo-1511512578047-dfb367046420?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Toys & Gaming' LIMIT 1), '10000000-0000-0000-0000-000000000007'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000822');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000823', 'Logitech G Precision Flight Simulator Joystick - Edition 03', 'Engineered by Logitech G. The Precision Flight Simulator Joystick comes equipped High-Speed 45km/h Brushless Motor. Designed for superior performance, premium durability, and daily reliability.', 174.75, 51, 'https://images.unsplash.com/photo-1612287232230-6869408212e3?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Toys & Gaming' LIMIT 1), '10000000-0000-0000-0000-000000000007'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000823');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000824', 'Oculus Magnetic Levitating Display Base - Edition 04', 'Engineered by Oculus. The Magnetic Levitating Display Base comes equipped Universal PC / Console Compatibility. Designed for superior performance, premium durability, and daily reliability.', 181.53, 64, 'https://images.unsplash.com/photo-1592840496694-26d035b52b48?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Toys & Gaming' LIMIT 1), '10000000-0000-0000-0000-000000000007'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000824');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000825', 'HyperX Gamer Ergonomic Footrest - Edition 05', 'Engineered by HyperX. The Gamer Ergonomic Footrest comes equipped Adaptive Triggers & Force Feedback. Designed for superior performance, premium durability, and daily reliability.', 188.32, 77, 'https://images.unsplash.com/photo-1534423861386-85a16f5d13fd?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Toys & Gaming' LIMIT 1), '10000000-0000-0000-0000-000000000007'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000825');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000826', 'PlayStation Wireless Haptic Game Controller - Edition 06', 'Engineered by PlayStation. The Wireless Haptic Game Controller comes equipped 3,599 Precision Engineered Pieces. Designed for superior performance, premium durability, and daily reliability.', 195.1, 90, 'https://images.unsplash.com/photo-1550745165-9bc0b252726f?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Toys & Gaming' LIMIT 1), '10000000-0000-0000-0000-000000000007'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000826');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000827', 'Nintendo Technic Supercar Building Kit - Edition 07', 'Engineered by Nintendo. The Technic Supercar Building Kit comes equipped 50mm Neodymium Audio Drivers. Designed for superior performance, premium durability, and daily reliability.', 201.89, 18, 'https://images.unsplash.com/photo-1606144042614-b2417e99c4e3?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Toys & Gaming' LIMIT 1), '10000000-0000-0000-0000-000000000007'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000827');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000828', 'LEGO 7.1 Surround Gaming Headset - Edition 08', 'Engineered by LEGO. The 7.1 Surround Gaming Headset comes equipped 7-inch Vibrant Multi-Touch Display. Designed for superior performance, premium durability, and daily reliability.', 208.67, 31, 'https://images.unsplash.com/photo-1579373903781-fd5c0c30c4cd?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Toys & Gaming' LIMIT 1), '10000000-0000-0000-0000-000000000007'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000828');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000829', 'Xbox Handheld Gaming Console OLED - Edition 09', 'Engineered by Xbox. The Handheld Gaming Console OLED comes equipped Ultra-Fast 2.4GHz Slipstream Wireless. Designed for superior performance, premium durability, and daily reliability.', 215.46, 44, 'https://images.unsplash.com/photo-1607604276583-eef5d076aa5f?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Toys & Gaming' LIMIT 1), '10000000-0000-0000-0000-000000000007'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000829');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000830', 'Hasbro RGB Mousepad Extended - Edition 10', 'Engineered by Hasbro. The RGB Mousepad Extended comes equipped Detachable Noise-Filtering Boom Mic. Designed for superior performance, premium durability, and daily reliability.', 200.54, 57, 'https://images.unsplash.com/photo-1563089145-599997674d42?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Toys & Gaming' LIMIT 1), '10000000-0000-0000-0000-000000000007'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000830');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000831', 'Razer Collectible Vinyl Figure - Edition 11', 'Engineered by Razer. The Collectible Vinyl Figure comes equipped Fully Programmable Macro Keys. Designed for superior performance, premium durability, and daily reliability.', 207.32, 70, 'https://images.unsplash.com/photo-1587202372775-e229f172b9d7?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Toys & Gaming' LIMIT 1), '10000000-0000-0000-0000-000000000007'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000831');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000832', 'SteelSeries Mechanical Gaming Keypad - Edition 12', 'Engineered by SteelSeries. The Mechanical Gaming Keypad comes equipped 30-Hour Rechargeable Battery Life. Designed for superior performance, premium durability, and daily reliability.', 214.11, 83, 'https://images.unsplash.com/photo-1511512578047-dfb367046420?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Toys & Gaming' LIMIT 1), '10000000-0000-0000-0000-000000000007'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000832');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000833', 'Bandai Modular Board Game Strategy - Edition 13', 'Engineered by Bandai. The Modular Board Game Strategy comes equipped High-Speed 45km/h Brushless Motor. Designed for superior performance, premium durability, and daily reliability.', 220.89, 96, 'https://images.unsplash.com/photo-1612287232230-6869408212e3?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Toys & Gaming' LIMIT 1), '10000000-0000-0000-0000-000000000007'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000833');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000834', 'Hot Wheels High-Speed Remote Control Stunt Car - Edition 14', 'Engineered by Hot Wheels. The High-Speed Remote Control Stunt Car comes equipped Universal PC / Console Compatibility. Designed for superior performance, premium durability, and daily reliability.', 227.68, 24, 'https://images.unsplash.com/photo-1592840496694-26d035b52b48?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Toys & Gaming' LIMIT 1), '10000000-0000-0000-0000-000000000007'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000834');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000835', 'Funko Streaming Microphone with Arm - Edition 15', 'Engineered by Funko. The Streaming Microphone with Arm comes equipped Adaptive Triggers & Force Feedback. Designed for superior performance, premium durability, and daily reliability.', 234.46, 37, 'https://images.unsplash.com/photo-1534423861386-85a16f5d13fd?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Toys & Gaming' LIMIT 1), '10000000-0000-0000-0000-000000000007'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000835');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000836', 'Corsair Custom Arcade Fight Stick - Edition 16', 'Engineered by Corsair. The Custom Arcade Fight Stick comes equipped 3,599 Precision Engineered Pieces. Designed for superior performance, premium durability, and daily reliability.', 241.25, 50, 'https://images.unsplash.com/photo-1550745165-9bc0b252726f?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Toys & Gaming' LIMIT 1), '10000000-0000-0000-0000-000000000007'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000836');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000837', 'Mattel VR Headset All-in-One - Edition 17', 'Engineered by Mattel. The VR Headset All-in-One comes equipped 50mm Neodymium Audio Drivers. Designed for superior performance, premium durability, and daily reliability.', 226.33, 63, 'https://images.unsplash.com/photo-1606144042614-b2417e99c4e3?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Toys & Gaming' LIMIT 1), '10000000-0000-0000-0000-000000000007'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000837');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000838', 'Logitech G Precision Flight Simulator Joystick - Edition 18', 'Engineered by Logitech G. The Precision Flight Simulator Joystick comes equipped 7-inch Vibrant Multi-Touch Display. Designed for superior performance, premium durability, and daily reliability.', 233.12, 76, 'https://images.unsplash.com/photo-1579373903781-fd5c0c30c4cd?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Toys & Gaming' LIMIT 1), '10000000-0000-0000-0000-000000000007'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000838');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000839', 'Oculus Magnetic Levitating Display Base - Edition 19', 'Engineered by Oculus. The Magnetic Levitating Display Base comes equipped Ultra-Fast 2.4GHz Slipstream Wireless. Designed for superior performance, premium durability, and daily reliability.', 239.9, 89, 'https://images.unsplash.com/photo-1607604276583-eef5d076aa5f?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Toys & Gaming' LIMIT 1), '10000000-0000-0000-0000-000000000007'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000839');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000840', 'HyperX Gamer Ergonomic Footrest - Edition 20', 'Engineered by HyperX. The Gamer Ergonomic Footrest comes equipped Detachable Noise-Filtering Boom Mic. Designed for superior performance, premium durability, and daily reliability.', 246.69, 17, 'https://images.unsplash.com/photo-1563089145-599997674d42?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Toys & Gaming' LIMIT 1), '10000000-0000-0000-0000-000000000007'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000840');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000841', 'PlayStation Wireless Haptic Game Controller - Edition 01', 'Engineered by PlayStation. The Wireless Haptic Game Controller comes equipped Fully Programmable Macro Keys. Designed for superior performance, premium durability, and daily reliability.', 253.47, 30, 'https://images.unsplash.com/photo-1587202372775-e229f172b9d7?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Toys & Gaming' LIMIT 1), '10000000-0000-0000-0000-000000000007'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000841');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000842', 'Nintendo Technic Supercar Building Kit - Edition 02', 'Engineered by Nintendo. The Technic Supercar Building Kit comes equipped 30-Hour Rechargeable Battery Life. Designed for superior performance, premium durability, and daily reliability.', 260.26, 43, 'https://images.unsplash.com/photo-1511512578047-dfb367046420?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Toys & Gaming' LIMIT 1), '10000000-0000-0000-0000-000000000007'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000842');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000843', 'LEGO 7.1 Surround Gaming Headset - Edition 03', 'Engineered by LEGO. The 7.1 Surround Gaming Headset comes equipped High-Speed 45km/h Brushless Motor. Designed for superior performance, premium durability, and daily reliability.', 267.04, 56, 'https://images.unsplash.com/photo-1612287232230-6869408212e3?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Toys & Gaming' LIMIT 1), '10000000-0000-0000-0000-000000000007'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000843');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000844', 'Xbox Handheld Gaming Console OLED - Edition 04', 'Engineered by Xbox. The Handheld Gaming Console OLED comes equipped Universal PC / Console Compatibility. Designed for superior performance, premium durability, and daily reliability.', 252.13, 69, 'https://images.unsplash.com/photo-1592840496694-26d035b52b48?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Toys & Gaming' LIMIT 1), '10000000-0000-0000-0000-000000000007'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000844');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000845', 'Hasbro RGB Mousepad Extended - Edition 05', 'Engineered by Hasbro. The RGB Mousepad Extended comes equipped Adaptive Triggers & Force Feedback. Designed for superior performance, premium durability, and daily reliability.', 258.91, 82, 'https://images.unsplash.com/photo-1534423861386-85a16f5d13fd?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Toys & Gaming' LIMIT 1), '10000000-0000-0000-0000-000000000007'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000845');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000846', 'Razer Collectible Vinyl Figure - Edition 06', 'Engineered by Razer. The Collectible Vinyl Figure comes equipped 3,599 Precision Engineered Pieces. Designed for superior performance, premium durability, and daily reliability.', 265.69, 95, 'https://images.unsplash.com/photo-1550745165-9bc0b252726f?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Toys & Gaming' LIMIT 1), '10000000-0000-0000-0000-000000000007'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000846');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000847', 'SteelSeries Mechanical Gaming Keypad - Edition 07', 'Engineered by SteelSeries. The Mechanical Gaming Keypad comes equipped 50mm Neodymium Audio Drivers. Designed for superior performance, premium durability, and daily reliability.', 272.48, 23, 'https://images.unsplash.com/photo-1606144042614-b2417e99c4e3?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Toys & Gaming' LIMIT 1), '10000000-0000-0000-0000-000000000007'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000847');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000848', 'Bandai Modular Board Game Strategy - Edition 08', 'Engineered by Bandai. The Modular Board Game Strategy comes equipped 7-inch Vibrant Multi-Touch Display. Designed for superior performance, premium durability, and daily reliability.', 279.26, 36, 'https://images.unsplash.com/photo-1579373903781-fd5c0c30c4cd?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Toys & Gaming' LIMIT 1), '10000000-0000-0000-0000-000000000007'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000848');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000849', 'Hot Wheels High-Speed Remote Control Stunt Car - Edition 09', 'Engineered by Hot Wheels. The High-Speed Remote Control Stunt Car comes equipped Ultra-Fast 2.4GHz Slipstream Wireless. Designed for superior performance, premium durability, and daily reliability.', 286.05, 49, 'https://images.unsplash.com/photo-1607604276583-eef5d076aa5f?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Toys & Gaming' LIMIT 1), '10000000-0000-0000-0000-000000000007'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000849');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000850', 'Funko Streaming Microphone with Arm - Edition 10', 'Engineered by Funko. The Streaming Microphone with Arm comes equipped Detachable Noise-Filtering Boom Mic. Designed for superior performance, premium durability, and daily reliability.', 292.83, 62, 'https://images.unsplash.com/photo-1563089145-599997674d42?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Toys & Gaming' LIMIT 1), '10000000-0000-0000-0000-000000000007'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000850');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000851', 'Corsair Custom Arcade Fight Stick - Edition 11', 'Engineered by Corsair. The Custom Arcade Fight Stick comes equipped Fully Programmable Macro Keys. Designed for superior performance, premium durability, and daily reliability.', 277.92, 75, 'https://images.unsplash.com/photo-1587202372775-e229f172b9d7?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Toys & Gaming' LIMIT 1), '10000000-0000-0000-0000-000000000007'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000851');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000852', 'Mattel VR Headset All-in-One - Edition 12', 'Engineered by Mattel. The VR Headset All-in-One comes equipped 30-Hour Rechargeable Battery Life. Designed for superior performance, premium durability, and daily reliability.', 284.7, 88, 'https://images.unsplash.com/photo-1511512578047-dfb367046420?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Toys & Gaming' LIMIT 1), '10000000-0000-0000-0000-000000000007'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000852');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000853', 'Logitech G Precision Flight Simulator Joystick - Edition 13', 'Engineered by Logitech G. The Precision Flight Simulator Joystick comes equipped High-Speed 45km/h Brushless Motor. Designed for superior performance, premium durability, and daily reliability.', 291.49, 16, 'https://images.unsplash.com/photo-1612287232230-6869408212e3?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Toys & Gaming' LIMIT 1), '10000000-0000-0000-0000-000000000007'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000853');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000854', 'Oculus Magnetic Levitating Display Base - Edition 14', 'Engineered by Oculus. The Magnetic Levitating Display Base comes equipped Universal PC / Console Compatibility. Designed for superior performance, premium durability, and daily reliability.', 298.27, 29, 'https://images.unsplash.com/photo-1592840496694-26d035b52b48?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Toys & Gaming' LIMIT 1), '10000000-0000-0000-0000-000000000007'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000854');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000855', 'HyperX Gamer Ergonomic Footrest - Edition 15', 'Engineered by HyperX. The Gamer Ergonomic Footrest comes equipped Adaptive Triggers & Force Feedback. Designed for superior performance, premium durability, and daily reliability.', 305.06, 42, 'https://images.unsplash.com/photo-1534423861386-85a16f5d13fd?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Toys & Gaming' LIMIT 1), '10000000-0000-0000-0000-000000000007'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000855');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000856', 'PlayStation Wireless Haptic Game Controller - Edition 16', 'Engineered by PlayStation. The Wireless Haptic Game Controller comes equipped 3,599 Precision Engineered Pieces. Designed for superior performance, premium durability, and daily reliability.', 311.84, 55, 'https://images.unsplash.com/photo-1550745165-9bc0b252726f?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Toys & Gaming' LIMIT 1), '10000000-0000-0000-0000-000000000007'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000856');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000857', 'Nintendo Technic Supercar Building Kit - Edition 17', 'Engineered by Nintendo. The Technic Supercar Building Kit comes equipped 50mm Neodymium Audio Drivers. Designed for superior performance, premium durability, and daily reliability.', 318.63, 68, 'https://images.unsplash.com/photo-1606144042614-b2417e99c4e3?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Toys & Gaming' LIMIT 1), '10000000-0000-0000-0000-000000000007'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000857');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000858', 'LEGO 7.1 Surround Gaming Headset - Edition 18', 'Engineered by LEGO. The 7.1 Surround Gaming Headset comes equipped 7-inch Vibrant Multi-Touch Display. Designed for superior performance, premium durability, and daily reliability.', 303.71, 81, 'https://images.unsplash.com/photo-1579373903781-fd5c0c30c4cd?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Toys & Gaming' LIMIT 1), '10000000-0000-0000-0000-000000000007'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000858');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000859', 'Xbox Handheld Gaming Console OLED - Edition 19', 'Engineered by Xbox. The Handheld Gaming Console OLED comes equipped Ultra-Fast 2.4GHz Slipstream Wireless. Designed for superior performance, premium durability, and daily reliability.', 310.5, 94, 'https://images.unsplash.com/photo-1607604276583-eef5d076aa5f?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Toys & Gaming' LIMIT 1), '10000000-0000-0000-0000-000000000007'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000859');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000860', 'Hasbro RGB Mousepad Extended - Edition 20', 'Engineered by Hasbro. The RGB Mousepad Extended comes equipped Detachable Noise-Filtering Boom Mic. Designed for superior performance, premium durability, and daily reliability.', 317.28, 22, 'https://images.unsplash.com/photo-1563089145-599997674d42?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Toys & Gaming' LIMIT 1), '10000000-0000-0000-0000-000000000007'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000860');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000861', 'Razer Collectible Vinyl Figure - Edition 01', 'Engineered by Razer. The Collectible Vinyl Figure comes equipped Fully Programmable Macro Keys. Designed for superior performance, premium durability, and daily reliability.', 324.07, 35, 'https://images.unsplash.com/photo-1587202372775-e229f172b9d7?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Toys & Gaming' LIMIT 1), '10000000-0000-0000-0000-000000000007'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000861');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000862', 'SteelSeries Mechanical Gaming Keypad - Edition 02', 'Engineered by SteelSeries. The Mechanical Gaming Keypad comes equipped 30-Hour Rechargeable Battery Life. Designed for superior performance, premium durability, and daily reliability.', 330.85, 48, 'https://images.unsplash.com/photo-1511512578047-dfb367046420?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Toys & Gaming' LIMIT 1), '10000000-0000-0000-0000-000000000007'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000862');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000863', 'Bandai Modular Board Game Strategy - Edition 03', 'Engineered by Bandai. The Modular Board Game Strategy comes equipped High-Speed 45km/h Brushless Motor. Designed for superior performance, premium durability, and daily reliability.', 337.63, 61, 'https://images.unsplash.com/photo-1612287232230-6869408212e3?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Toys & Gaming' LIMIT 1), '10000000-0000-0000-0000-000000000007'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000863');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000864', 'Hot Wheels High-Speed Remote Control Stunt Car - Edition 04', 'Engineered by Hot Wheels. The High-Speed Remote Control Stunt Car comes equipped Universal PC / Console Compatibility. Designed for superior performance, premium durability, and daily reliability.', 344.42, 74, 'https://images.unsplash.com/photo-1592840496694-26d035b52b48?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Toys & Gaming' LIMIT 1), '10000000-0000-0000-0000-000000000007'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000864');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000865', 'Funko Streaming Microphone with Arm - Edition 05', 'Engineered by Funko. The Streaming Microphone with Arm comes equipped Adaptive Triggers & Force Feedback. Designed for superior performance, premium durability, and daily reliability.', 329.5, 87, 'https://images.unsplash.com/photo-1534423861386-85a16f5d13fd?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Toys & Gaming' LIMIT 1), '10000000-0000-0000-0000-000000000007'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000865');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000866', 'Corsair Custom Arcade Fight Stick - Edition 06', 'Engineered by Corsair. The Custom Arcade Fight Stick comes equipped 3,599 Precision Engineered Pieces. Designed for superior performance, premium durability, and daily reliability.', 336.29, 15, 'https://images.unsplash.com/photo-1550745165-9bc0b252726f?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Toys & Gaming' LIMIT 1), '10000000-0000-0000-0000-000000000007'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000866');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000867', 'Mattel VR Headset All-in-One - Edition 07', 'Engineered by Mattel. The VR Headset All-in-One comes equipped 50mm Neodymium Audio Drivers. Designed for superior performance, premium durability, and daily reliability.', 343.07, 28, 'https://images.unsplash.com/photo-1606144042614-b2417e99c4e3?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Toys & Gaming' LIMIT 1), '10000000-0000-0000-0000-000000000007'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000867');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000868', 'Logitech G Precision Flight Simulator Joystick - Edition 08', 'Engineered by Logitech G. The Precision Flight Simulator Joystick comes equipped 7-inch Vibrant Multi-Touch Display. Designed for superior performance, premium durability, and daily reliability.', 349.86, 41, 'https://images.unsplash.com/photo-1579373903781-fd5c0c30c4cd?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Toys & Gaming' LIMIT 1), '10000000-0000-0000-0000-000000000007'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000868');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000869', 'Oculus Magnetic Levitating Display Base - Edition 09', 'Engineered by Oculus. The Magnetic Levitating Display Base comes equipped Ultra-Fast 2.4GHz Slipstream Wireless. Designed for superior performance, premium durability, and daily reliability.', 356.64, 54, 'https://images.unsplash.com/photo-1607604276583-eef5d076aa5f?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Toys & Gaming' LIMIT 1), '10000000-0000-0000-0000-000000000007'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000869');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000870', 'HyperX Gamer Ergonomic Footrest - Edition 10', 'Engineered by HyperX. The Gamer Ergonomic Footrest comes equipped Detachable Noise-Filtering Boom Mic. Designed for superior performance, premium durability, and daily reliability.', 363.43, 67, 'https://images.unsplash.com/photo-1563089145-599997674d42?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Toys & Gaming' LIMIT 1), '10000000-0000-0000-0000-000000000007'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000870');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000871', 'PlayStation Wireless Haptic Game Controller - Edition 11', 'Engineered by PlayStation. The Wireless Haptic Game Controller comes equipped Fully Programmable Macro Keys. Designed for superior performance, premium durability, and daily reliability.', 370.21, 80, 'https://images.unsplash.com/photo-1587202372775-e229f172b9d7?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Toys & Gaming' LIMIT 1), '10000000-0000-0000-0000-000000000007'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000871');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000872', 'Nintendo Technic Supercar Building Kit - Edition 12', 'Engineered by Nintendo. The Technic Supercar Building Kit comes equipped 30-Hour Rechargeable Battery Life. Designed for superior performance, premium durability, and daily reliability.', 355.3, 93, 'https://images.unsplash.com/photo-1511512578047-dfb367046420?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Toys & Gaming' LIMIT 1), '10000000-0000-0000-0000-000000000007'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000872');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000873', 'LEGO 7.1 Surround Gaming Headset - Edition 13', 'Engineered by LEGO. The 7.1 Surround Gaming Headset comes equipped High-Speed 45km/h Brushless Motor. Designed for superior performance, premium durability, and daily reliability.', 362.08, 21, 'https://images.unsplash.com/photo-1612287232230-6869408212e3?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Toys & Gaming' LIMIT 1), '10000000-0000-0000-0000-000000000007'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000873');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000874', 'Xbox Handheld Gaming Console OLED - Edition 14', 'Engineered by Xbox. The Handheld Gaming Console OLED comes equipped Universal PC / Console Compatibility. Designed for superior performance, premium durability, and daily reliability.', 368.87, 34, 'https://images.unsplash.com/photo-1592840496694-26d035b52b48?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Toys & Gaming' LIMIT 1), '10000000-0000-0000-0000-000000000007'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000874');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000875', 'Hasbro RGB Mousepad Extended - Edition 15', 'Engineered by Hasbro. The RGB Mousepad Extended comes equipped Adaptive Triggers & Force Feedback. Designed for superior performance, premium durability, and daily reliability.', 375.65, 47, 'https://images.unsplash.com/photo-1534423861386-85a16f5d13fd?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Toys & Gaming' LIMIT 1), '10000000-0000-0000-0000-000000000007'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000875');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000876', 'Razer Collectible Vinyl Figure - Edition 16', 'Engineered by Razer. The Collectible Vinyl Figure comes equipped 3,599 Precision Engineered Pieces. Designed for superior performance, premium durability, and daily reliability.', 382.44, 60, 'https://images.unsplash.com/photo-1550745165-9bc0b252726f?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Toys & Gaming' LIMIT 1), '10000000-0000-0000-0000-000000000007'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000876');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000877', 'SteelSeries Mechanical Gaming Keypad - Edition 17', 'Engineered by SteelSeries. The Mechanical Gaming Keypad comes equipped 50mm Neodymium Audio Drivers. Designed for superior performance, premium durability, and daily reliability.', 389.22, 73, 'https://images.unsplash.com/photo-1606144042614-b2417e99c4e3?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Toys & Gaming' LIMIT 1), '10000000-0000-0000-0000-000000000007'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000877');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000878', 'Bandai Modular Board Game Strategy - Edition 18', 'Engineered by Bandai. The Modular Board Game Strategy comes equipped 7-inch Vibrant Multi-Touch Display. Designed for superior performance, premium durability, and daily reliability.', 396.01, 86, 'https://images.unsplash.com/photo-1579373903781-fd5c0c30c4cd?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Toys & Gaming' LIMIT 1), '10000000-0000-0000-0000-000000000007'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000878');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000879', 'Hot Wheels High-Speed Remote Control Stunt Car - Edition 19', 'Engineered by Hot Wheels. The High-Speed Remote Control Stunt Car comes equipped Ultra-Fast 2.4GHz Slipstream Wireless. Designed for superior performance, premium durability, and daily reliability.', 381.09, 99, 'https://images.unsplash.com/photo-1607604276583-eef5d076aa5f?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Toys & Gaming' LIMIT 1), '10000000-0000-0000-0000-000000000007'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000879');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000880', 'Funko Streaming Microphone with Arm - Edition 20', 'Engineered by Funko. The Streaming Microphone with Arm comes equipped Detachable Noise-Filtering Boom Mic. Designed for superior performance, premium durability, and daily reliability.', 387.87, 27, 'https://images.unsplash.com/photo-1563089145-599997674d42?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Toys & Gaming' LIMIT 1), '10000000-0000-0000-0000-000000000007'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000880');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000881', 'Corsair Custom Arcade Fight Stick - Edition 01', 'Engineered by Corsair. The Custom Arcade Fight Stick comes equipped Fully Programmable Macro Keys. Designed for superior performance, premium durability, and daily reliability.', 394.66, 40, 'https://images.unsplash.com/photo-1587202372775-e229f172b9d7?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Toys & Gaming' LIMIT 1), '10000000-0000-0000-0000-000000000007'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000881');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000882', 'Mattel VR Headset All-in-One - Edition 02', 'Engineered by Mattel. The VR Headset All-in-One comes equipped 30-Hour Rechargeable Battery Life. Designed for superior performance, premium durability, and daily reliability.', 401.44, 53, 'https://images.unsplash.com/photo-1511512578047-dfb367046420?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Toys & Gaming' LIMIT 1), '10000000-0000-0000-0000-000000000007'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000882');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000883', 'Logitech G Precision Flight Simulator Joystick - Edition 03', 'Engineered by Logitech G. The Precision Flight Simulator Joystick comes equipped High-Speed 45km/h Brushless Motor. Designed for superior performance, premium durability, and daily reliability.', 408.23, 66, 'https://images.unsplash.com/photo-1612287232230-6869408212e3?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Toys & Gaming' LIMIT 1), '10000000-0000-0000-0000-000000000007'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000883');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000884', 'Oculus Magnetic Levitating Display Base - Edition 04', 'Engineered by Oculus. The Magnetic Levitating Display Base comes equipped Universal PC / Console Compatibility. Designed for superior performance, premium durability, and daily reliability.', 415.01, 79, 'https://images.unsplash.com/photo-1592840496694-26d035b52b48?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Toys & Gaming' LIMIT 1), '10000000-0000-0000-0000-000000000007'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000884');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000885', 'HyperX Gamer Ergonomic Footrest - Edition 05', 'Engineered by HyperX. The Gamer Ergonomic Footrest comes equipped Adaptive Triggers & Force Feedback. Designed for superior performance, premium durability, and daily reliability.', 421.8, 92, 'https://images.unsplash.com/photo-1534423861386-85a16f5d13fd?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Toys & Gaming' LIMIT 1), '10000000-0000-0000-0000-000000000007'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000885');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000886', 'PlayStation Wireless Haptic Game Controller - Edition 06', 'Engineered by PlayStation. The Wireless Haptic Game Controller comes equipped 3,599 Precision Engineered Pieces. Designed for superior performance, premium durability, and daily reliability.', 406.88, 20, 'https://images.unsplash.com/photo-1550745165-9bc0b252726f?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Toys & Gaming' LIMIT 1), '10000000-0000-0000-0000-000000000007'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000886');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000887', 'Nintendo Technic Supercar Building Kit - Edition 07', 'Engineered by Nintendo. The Technic Supercar Building Kit comes equipped 50mm Neodymium Audio Drivers. Designed for superior performance, premium durability, and daily reliability.', 413.67, 33, 'https://images.unsplash.com/photo-1606144042614-b2417e99c4e3?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Toys & Gaming' LIMIT 1), '10000000-0000-0000-0000-000000000007'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000887');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000888', 'LEGO 7.1 Surround Gaming Headset - Edition 08', 'Engineered by LEGO. The 7.1 Surround Gaming Headset comes equipped 7-inch Vibrant Multi-Touch Display. Designed for superior performance, premium durability, and daily reliability.', 420.45, 46, 'https://images.unsplash.com/photo-1579373903781-fd5c0c30c4cd?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Toys & Gaming' LIMIT 1), '10000000-0000-0000-0000-000000000007'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000888');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000889', 'Xbox Handheld Gaming Console OLED - Edition 09', 'Engineered by Xbox. The Handheld Gaming Console OLED comes equipped Ultra-Fast 2.4GHz Slipstream Wireless. Designed for superior performance, premium durability, and daily reliability.', 427.24, 59, 'https://images.unsplash.com/photo-1607604276583-eef5d076aa5f?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Toys & Gaming' LIMIT 1), '10000000-0000-0000-0000-000000000007'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000889');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000890', 'Hasbro RGB Mousepad Extended - Edition 10', 'Engineered by Hasbro. The RGB Mousepad Extended comes equipped Detachable Noise-Filtering Boom Mic. Designed for superior performance, premium durability, and daily reliability.', 434.02, 72, 'https://images.unsplash.com/photo-1563089145-599997674d42?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Toys & Gaming' LIMIT 1), '10000000-0000-0000-0000-000000000007'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000890');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000891', 'Razer Collectible Vinyl Figure - Edition 11', 'Engineered by Razer. The Collectible Vinyl Figure comes equipped Fully Programmable Macro Keys. Designed for superior performance, premium durability, and daily reliability.', 440.81, 85, 'https://images.unsplash.com/photo-1587202372775-e229f172b9d7?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Toys & Gaming' LIMIT 1), '10000000-0000-0000-0000-000000000007'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000891');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000892', 'SteelSeries Mechanical Gaming Keypad - Edition 12', 'Engineered by SteelSeries. The Mechanical Gaming Keypad comes equipped 30-Hour Rechargeable Battery Life. Designed for superior performance, premium durability, and daily reliability.', 447.59, 98, 'https://images.unsplash.com/photo-1511512578047-dfb367046420?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Toys & Gaming' LIMIT 1), '10000000-0000-0000-0000-000000000007'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000892');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000893', 'Bandai Modular Board Game Strategy - Edition 13', 'Engineered by Bandai. The Modular Board Game Strategy comes equipped High-Speed 45km/h Brushless Motor. Designed for superior performance, premium durability, and daily reliability.', 432.68, 26, 'https://images.unsplash.com/photo-1612287232230-6869408212e3?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Toys & Gaming' LIMIT 1), '10000000-0000-0000-0000-000000000007'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000893');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000894', 'Hot Wheels High-Speed Remote Control Stunt Car - Edition 14', 'Engineered by Hot Wheels. The High-Speed Remote Control Stunt Car comes equipped Universal PC / Console Compatibility. Designed for superior performance, premium durability, and daily reliability.', 439.46, 39, 'https://images.unsplash.com/photo-1592840496694-26d035b52b48?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Toys & Gaming' LIMIT 1), '10000000-0000-0000-0000-000000000007'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000894');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000895', 'Funko Streaming Microphone with Arm - Edition 15', 'Engineered by Funko. The Streaming Microphone with Arm comes equipped Adaptive Triggers & Force Feedback. Designed for superior performance, premium durability, and daily reliability.', 446.24, 52, 'https://images.unsplash.com/photo-1534423861386-85a16f5d13fd?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Toys & Gaming' LIMIT 1), '10000000-0000-0000-0000-000000000007'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000895');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000896', 'Corsair Custom Arcade Fight Stick - Edition 16', 'Engineered by Corsair. The Custom Arcade Fight Stick comes equipped 3,599 Precision Engineered Pieces. Designed for superior performance, premium durability, and daily reliability.', 453.03, 65, 'https://images.unsplash.com/photo-1550745165-9bc0b252726f?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Toys & Gaming' LIMIT 1), '10000000-0000-0000-0000-000000000007'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000896');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000897', 'Mattel VR Headset All-in-One - Edition 17', 'Engineered by Mattel. The VR Headset All-in-One comes equipped 50mm Neodymium Audio Drivers. Designed for superior performance, premium durability, and daily reliability.', 459.81, 78, 'https://images.unsplash.com/photo-1606144042614-b2417e99c4e3?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Toys & Gaming' LIMIT 1), '10000000-0000-0000-0000-000000000007'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000897');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000898', 'Logitech G Precision Flight Simulator Joystick - Edition 18', 'Engineered by Logitech G. The Precision Flight Simulator Joystick comes equipped 7-inch Vibrant Multi-Touch Display. Designed for superior performance, premium durability, and daily reliability.', 466.6, 91, 'https://images.unsplash.com/photo-1579373903781-fd5c0c30c4cd?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Toys & Gaming' LIMIT 1), '10000000-0000-0000-0000-000000000007'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000898');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000899', 'Oculus Magnetic Levitating Display Base - Edition 19', 'Engineered by Oculus. The Magnetic Levitating Display Base comes equipped Ultra-Fast 2.4GHz Slipstream Wireless. Designed for superior performance, premium durability, and daily reliability.', 473.38, 19, 'https://images.unsplash.com/photo-1607604276583-eef5d076aa5f?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Toys & Gaming' LIMIT 1), '10000000-0000-0000-0000-000000000007'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000899');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000900', 'HyperX Gamer Ergonomic Footrest - Edition 20', 'Engineered by HyperX. The Gamer Ergonomic Footrest comes equipped Detachable Noise-Filtering Boom Mic. Designed for superior performance, premium durability, and daily reliability.', 458.47, 32, 'https://images.unsplash.com/photo-1563089145-599997674d42?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Toys & Gaming' LIMIT 1), '10000000-0000-0000-0000-000000000007'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000900');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000901', 'PlayStation Wireless Haptic Game Controller - Edition 01', 'Engineered by PlayStation. The Wireless Haptic Game Controller comes equipped Fully Programmable Macro Keys. Designed for superior performance, premium durability, and daily reliability.', 465.25, 45, 'https://images.unsplash.com/photo-1587202372775-e229f172b9d7?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Toys & Gaming' LIMIT 1), '10000000-0000-0000-0000-000000000007'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000901');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000902', 'Nintendo Technic Supercar Building Kit - Edition 02', 'Engineered by Nintendo. The Technic Supercar Building Kit comes equipped 30-Hour Rechargeable Battery Life. Designed for superior performance, premium durability, and daily reliability.', 472.04, 58, 'https://images.unsplash.com/photo-1511512578047-dfb367046420?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Toys & Gaming' LIMIT 1), '10000000-0000-0000-0000-000000000007'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000902');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000903', 'LEGO 7.1 Surround Gaming Headset - Edition 03', 'Engineered by LEGO. The 7.1 Surround Gaming Headset comes equipped High-Speed 45km/h Brushless Motor. Designed for superior performance, premium durability, and daily reliability.', 478.82, 71, 'https://images.unsplash.com/photo-1612287232230-6869408212e3?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Toys & Gaming' LIMIT 1), '10000000-0000-0000-0000-000000000007'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000903');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000904', 'Xbox Handheld Gaming Console OLED - Edition 04', 'Engineered by Xbox. The Handheld Gaming Console OLED comes equipped Universal PC / Console Compatibility. Designed for superior performance, premium durability, and daily reliability.', 485.61, 84, 'https://images.unsplash.com/photo-1592840496694-26d035b52b48?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Toys & Gaming' LIMIT 1), '10000000-0000-0000-0000-000000000007'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000904');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000905', 'Hasbro RGB Mousepad Extended - Edition 05', 'Engineered by Hasbro. The RGB Mousepad Extended comes equipped Adaptive Triggers & Force Feedback. Designed for superior performance, premium durability, and daily reliability.', 492.39, 97, 'https://images.unsplash.com/photo-1534423861386-85a16f5d13fd?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Toys & Gaming' LIMIT 1), '10000000-0000-0000-0000-000000000007'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000905');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000906', 'Razer Collectible Vinyl Figure - Edition 06', 'Engineered by Razer. The Collectible Vinyl Figure comes equipped 3,599 Precision Engineered Pieces. Designed for superior performance, premium durability, and daily reliability.', 499.0, 25, 'https://images.unsplash.com/photo-1550745165-9bc0b252726f?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Toys & Gaming' LIMIT 1), '10000000-0000-0000-0000-000000000007'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000906');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000907', 'SteelSeries Mechanical Gaming Keypad - Edition 07', 'Engineered by SteelSeries. The Mechanical Gaming Keypad comes equipped 50mm Neodymium Audio Drivers. Designed for superior performance, premium durability, and daily reliability.', 484.26, 38, 'https://images.unsplash.com/photo-1606144042614-b2417e99c4e3?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Toys & Gaming' LIMIT 1), '10000000-0000-0000-0000-000000000007'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000907');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000908', 'Bandai Modular Board Game Strategy - Edition 08', 'Engineered by Bandai. The Modular Board Game Strategy comes equipped 7-inch Vibrant Multi-Touch Display. Designed for superior performance, premium durability, and daily reliability.', 491.05, 51, 'https://images.unsplash.com/photo-1579373903781-fd5c0c30c4cd?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Toys & Gaming' LIMIT 1), '10000000-0000-0000-0000-000000000007'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000908');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000909', 'Hot Wheels High-Speed Remote Control Stunt Car - Edition 09', 'Engineered by Hot Wheels. The High-Speed Remote Control Stunt Car comes equipped Ultra-Fast 2.4GHz Slipstream Wireless. Designed for superior performance, premium durability, and daily reliability.', 497.83, 64, 'https://images.unsplash.com/photo-1607604276583-eef5d076aa5f?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Toys & Gaming' LIMIT 1), '10000000-0000-0000-0000-000000000007'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000909');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000910', 'Funko Streaming Microphone with Arm - Edition 10', 'Engineered by Funko. The Streaming Microphone with Arm comes equipped Detachable Noise-Filtering Boom Mic. Designed for superior performance, premium durability, and daily reliability.', 495.0, 77, 'https://images.unsplash.com/photo-1563089145-599997674d42?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Toys & Gaming' LIMIT 1), '10000000-0000-0000-0000-000000000007'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000910');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000911', 'Omron Digital Arm Blood Pressure Monitor - Edition 01', 'Engineered by Omron. The Digital Arm Blood Pressure Monitor comes equipped Zero Artificial Sugars & Non-GMO. Designed for superior performance, premium durability, and daily reliability.', 14.99, 15, 'https://images.unsplash.com/photo-1527613426441-4da17471b66d?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Health & Wellness' LIMIT 1), '10000000-0000-0000-0000-000000000008'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000911');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000912', 'Optimum Nutrition Gold Standard 100% Whey Protein 5lb - Edition 02', 'Engineered by Optimum Nutrition. The Gold Standard 100% Whey Protein 5lb comes equipped Medical-Grade Intermittent Compression. Designed for superior performance, premium durability, and daily reliability.', 21.44, 28, 'https://images.unsplash.com/photo-1505751172876-fa1923c5c528?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Health & Wellness' LIMIT 1), '10000000-0000-0000-0000-000000000008'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000912');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000913', 'Withings Smart Wi-Fi Body Composition Scale - Edition 03', 'Engineered by Withings. The Smart Wi-Fi Body Composition Scale comes equipped Ultra-Quiet 24dB Sleep Mode Filtration. Designed for superior performance, premium durability, and daily reliability.', 27.88, 41, 'https://images.unsplash.com/photo-1576091160550-2173dba999ef?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Health & Wellness' LIMIT 1), '10000000-0000-0000-0000-000000000008'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000913');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000914', 'Fitbit Organic Omega-3 Fish Oil Softgels - Edition 04', 'Engineered by Fitbit. The Organic Omega-3 Fish Oil Softgels comes equipped Clinically Validated Dual Sensor Precision. Designed for superior performance, premium durability, and daily reliability.', 34.33, 54, 'https://images.unsplash.com/photo-1616671285442-12797e8876e5?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Health & Wellness' LIMIT 1), '10000000-0000-0000-0000-000000000008'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000914');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000915', 'Garden of Life Heated Shiatsu Neck Massager - Edition 05', 'Engineered by Garden of Life. The Heated Shiatsu Neck Massager comes equipped 24g Protein & 5.5g BCAAs per Serving. Designed for superior performance, premium durability, and daily reliability.', 40.77, 67, 'https://images.unsplash.com/photo-1506126613408-eca07ce68773?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Health & Wellness' LIMIT 1), '10000000-0000-0000-0000-000000000008'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000915');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000916', 'Nordic Naturals Collagen Peptides Powder 20oz - Edition 06', 'Engineered by Nordic Naturals. The Collagen Peptides Powder 20oz comes equipped Measures Weight, Body Fat%, Heart Rate. Designed for superior performance, premium durability, and daily reliability.', 47.22, 80, 'https://images.unsplash.com/photo-1584308666744-24d5c474f2ae?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Health & Wellness' LIMIT 1), '10000000-0000-0000-0000-000000000008'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000916');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000917', 'Beurer Smart Pulse Oximeter Finger Sensor - Edition 07', 'Engineered by Beurer. The Smart Pulse Oximeter Finger Sensor comes equipped Molecularly Distilled EPA & DHA. Designed for superior performance, premium durability, and daily reliability.', 53.67, 93, 'https://images.unsplash.com/photo-1540555700478-4be289fbecef?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Health & Wellness' LIMIT 1), '10000000-0000-0000-0000-000000000008'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000917');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000918', 'Nature Made Ergonomic Memory Foam Lumbar Support - Edition 08', 'Engineered by Nature Made. The Ergonomic Memory Foam Lumbar Support comes equipped Infrared Soothing Heat Therapy Function. Designed for superior performance, premium durability, and daily reliability.', 38.41, 21, 'https://images.unsplash.com/photo-1512069772995-ec65ed45afd6?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Health & Wellness' LIMIT 1), '10000000-0000-0000-0000-000000000008'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000918');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000919', 'Vital Proteins Plant-Based Multivitamin Complex - Edition 09', 'Engineered by Vital Proteins. The Plant-Based Multivitamin Complex comes equipped Grass-Fed & Pasture-Raised Hydrolyzed. Designed for superior performance, premium durability, and daily reliability.', 44.86, 34, 'https://images.unsplash.com/photo-1544367567-0f2fcb009e0b?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Health & Wellness' LIMIT 1), '10000000-0000-0000-0000-000000000008'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000919');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000920', 'Therabody Compression Leg Recovery Boots - Edition 10', 'Engineered by Therabody. The Compression Leg Recovery Boots comes equipped FDA Cleared OLED Display. Designed for superior performance, premium durability, and daily reliability.', 51.31, 47, 'https://images.unsplash.com/photo-1579126038374-6064e9370f0f?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Health & Wellness' LIMIT 1), '10000000-0000-0000-0000-000000000008'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000920');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000921', 'Renpho Electric Heating Pad for Back Pain - Edition 11', 'Engineered by Renpho. The Electric Heating Pad for Back Pain comes equipped Zero Artificial Sugars & Non-GMO. Designed for superior performance, premium durability, and daily reliability.', 57.75, 60, 'https://images.unsplash.com/photo-1527613426441-4da17471b66d?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Health & Wellness' LIMIT 1), '10000000-0000-0000-0000-000000000008'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000921');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000922', 'Hyperice Melatonin Sleep Support Gummies 90ct - Edition 12', 'Engineered by Hyperice. The Melatonin Sleep Support Gummies 90ct comes equipped Medical-Grade Intermittent Compression. Designed for superior performance, premium durability, and daily reliability.', 64.2, 73, 'https://images.unsplash.com/photo-1505751172876-fa1923c5c528?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Health & Wellness' LIMIT 1), '10000000-0000-0000-0000-000000000008'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000922');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000923', 'NOW Foods Air Purifier with True HEPA Filter - Edition 13', 'Engineered by NOW Foods. The Air Purifier with True HEPA Filter comes equipped Ultra-Quiet 24dB Sleep Mode Filtration. Designed for superior performance, premium durability, and daily reliability.', 70.64, 86, 'https://images.unsplash.com/photo-1576091160550-2173dba999ef?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Health & Wellness' LIMIT 1), '10000000-0000-0000-0000-000000000008'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000923');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000924', 'Pure Encapsulations Deep Tissue Foam Roller 36-inch - Edition 14', 'Engineered by Pure Encapsulations. The Deep Tissue Foam Roller 36-inch comes equipped Clinically Validated Dual Sensor Precision. Designed for superior performance, premium durability, and daily reliability.', 77.09, 99, 'https://images.unsplash.com/photo-1616671285442-12797e8876e5?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Health & Wellness' LIMIT 1), '10000000-0000-0000-0000-000000000008'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000924');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000925', 'Thorne Vibrating Massage Ball Mobility Tool - Edition 15', 'Engineered by Thorne. The Vibrating Massage Ball Mobility Tool comes equipped 24g Protein & 5.5g BCAAs per Serving. Designed for superior performance, premium durability, and daily reliability.', 61.84, 27, 'https://images.unsplash.com/photo-1506126613408-eca07ce68773?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Health & Wellness' LIMIT 1), '10000000-0000-0000-0000-000000000008'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000925');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000926', 'Omron Digital Arm Blood Pressure Monitor - Edition 16', 'Engineered by Omron. The Digital Arm Blood Pressure Monitor comes equipped Measures Weight, Body Fat%, Heart Rate. Designed for superior performance, premium durability, and daily reliability.', 68.28, 40, 'https://images.unsplash.com/photo-1584308666744-24d5c474f2ae?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Health & Wellness' LIMIT 1), '10000000-0000-0000-0000-000000000008'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000926');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000927', 'Optimum Nutrition Gold Standard 100% Whey Protein 5lb - Edition 17', 'Engineered by Optimum Nutrition. The Gold Standard 100% Whey Protein 5lb comes equipped Molecularly Distilled EPA & DHA. Designed for superior performance, premium durability, and daily reliability.', 74.73, 53, 'https://images.unsplash.com/photo-1540555700478-4be289fbecef?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Health & Wellness' LIMIT 1), '10000000-0000-0000-0000-000000000008'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000927');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000928', 'Withings Smart Wi-Fi Body Composition Scale - Edition 18', 'Engineered by Withings. The Smart Wi-Fi Body Composition Scale comes equipped Infrared Soothing Heat Therapy Function. Designed for superior performance, premium durability, and daily reliability.', 81.18, 66, 'https://images.unsplash.com/photo-1512069772995-ec65ed45afd6?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Health & Wellness' LIMIT 1), '10000000-0000-0000-0000-000000000008'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000928');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000929', 'Fitbit Organic Omega-3 Fish Oil Softgels - Edition 19', 'Engineered by Fitbit. The Organic Omega-3 Fish Oil Softgels comes equipped Grass-Fed & Pasture-Raised Hydrolyzed. Designed for superior performance, premium durability, and daily reliability.', 87.62, 79, 'https://images.unsplash.com/photo-1544367567-0f2fcb009e0b?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Health & Wellness' LIMIT 1), '10000000-0000-0000-0000-000000000008'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000929');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000930', 'Garden of Life Heated Shiatsu Neck Massager - Edition 20', 'Engineered by Garden of Life. The Heated Shiatsu Neck Massager comes equipped FDA Cleared OLED Display. Designed for superior performance, premium durability, and daily reliability.', 94.07, 92, 'https://images.unsplash.com/photo-1579126038374-6064e9370f0f?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Health & Wellness' LIMIT 1), '10000000-0000-0000-0000-000000000008'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000930');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000931', 'Nordic Naturals Collagen Peptides Powder 20oz - Edition 01', 'Engineered by Nordic Naturals. The Collagen Peptides Powder 20oz comes equipped Zero Artificial Sugars & Non-GMO. Designed for superior performance, premium durability, and daily reliability.', 100.51, 20, 'https://images.unsplash.com/photo-1527613426441-4da17471b66d?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Health & Wellness' LIMIT 1), '10000000-0000-0000-0000-000000000008'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000931');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000932', 'Beurer Smart Pulse Oximeter Finger Sensor - Edition 02', 'Engineered by Beurer. The Smart Pulse Oximeter Finger Sensor comes equipped Medical-Grade Intermittent Compression. Designed for superior performance, premium durability, and daily reliability.', 85.26, 33, 'https://images.unsplash.com/photo-1505751172876-fa1923c5c528?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Health & Wellness' LIMIT 1), '10000000-0000-0000-0000-000000000008'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000932');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000933', 'Nature Made Ergonomic Memory Foam Lumbar Support - Edition 03', 'Engineered by Nature Made. The Ergonomic Memory Foam Lumbar Support comes equipped Ultra-Quiet 24dB Sleep Mode Filtration. Designed for superior performance, premium durability, and daily reliability.', 91.71, 46, 'https://images.unsplash.com/photo-1576091160550-2173dba999ef?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Health & Wellness' LIMIT 1), '10000000-0000-0000-0000-000000000008'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000933');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000934', 'Vital Proteins Plant-Based Multivitamin Complex - Edition 04', 'Engineered by Vital Proteins. The Plant-Based Multivitamin Complex comes equipped Clinically Validated Dual Sensor Precision. Designed for superior performance, premium durability, and daily reliability.', 98.15, 59, 'https://images.unsplash.com/photo-1616671285442-12797e8876e5?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Health & Wellness' LIMIT 1), '10000000-0000-0000-0000-000000000008'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000934');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000935', 'Therabody Compression Leg Recovery Boots - Edition 05', 'Engineered by Therabody. The Compression Leg Recovery Boots comes equipped 24g Protein & 5.5g BCAAs per Serving. Designed for superior performance, premium durability, and daily reliability.', 104.6, 72, 'https://images.unsplash.com/photo-1506126613408-eca07ce68773?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Health & Wellness' LIMIT 1), '10000000-0000-0000-0000-000000000008'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000935');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000936', 'Renpho Electric Heating Pad for Back Pain - Edition 06', 'Engineered by Renpho. The Electric Heating Pad for Back Pain comes equipped Measures Weight, Body Fat%, Heart Rate. Designed for superior performance, premium durability, and daily reliability.', 111.05, 85, 'https://images.unsplash.com/photo-1584308666744-24d5c474f2ae?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Health & Wellness' LIMIT 1), '10000000-0000-0000-0000-000000000008'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000936');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000937', 'Hyperice Melatonin Sleep Support Gummies 90ct - Edition 07', 'Engineered by Hyperice. The Melatonin Sleep Support Gummies 90ct comes equipped Molecularly Distilled EPA & DHA. Designed for superior performance, premium durability, and daily reliability.', 117.49, 98, 'https://images.unsplash.com/photo-1540555700478-4be289fbecef?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Health & Wellness' LIMIT 1), '10000000-0000-0000-0000-000000000008'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000937');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000938', 'NOW Foods Air Purifier with True HEPA Filter - Edition 08', 'Engineered by NOW Foods. The Air Purifier with True HEPA Filter comes equipped Infrared Soothing Heat Therapy Function. Designed for superior performance, premium durability, and daily reliability.', 123.94, 26, 'https://images.unsplash.com/photo-1512069772995-ec65ed45afd6?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Health & Wellness' LIMIT 1), '10000000-0000-0000-0000-000000000008'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000938');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000939', 'Pure Encapsulations Deep Tissue Foam Roller 36-inch - Edition 09', 'Engineered by Pure Encapsulations. The Deep Tissue Foam Roller 36-inch comes equipped Grass-Fed & Pasture-Raised Hydrolyzed. Designed for superior performance, premium durability, and daily reliability.', 108.68, 39, 'https://images.unsplash.com/photo-1544367567-0f2fcb009e0b?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Health & Wellness' LIMIT 1), '10000000-0000-0000-0000-000000000008'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000939');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000940', 'Thorne Vibrating Massage Ball Mobility Tool - Edition 10', 'Engineered by Thorne. The Vibrating Massage Ball Mobility Tool comes equipped FDA Cleared OLED Display. Designed for superior performance, premium durability, and daily reliability.', 115.13, 52, 'https://images.unsplash.com/photo-1579126038374-6064e9370f0f?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Health & Wellness' LIMIT 1), '10000000-0000-0000-0000-000000000008'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000940');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000941', 'Omron Digital Arm Blood Pressure Monitor - Edition 11', 'Engineered by Omron. The Digital Arm Blood Pressure Monitor comes equipped Zero Artificial Sugars & Non-GMO. Designed for superior performance, premium durability, and daily reliability.', 121.58, 65, 'https://images.unsplash.com/photo-1527613426441-4da17471b66d?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Health & Wellness' LIMIT 1), '10000000-0000-0000-0000-000000000008'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000941');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000942', 'Optimum Nutrition Gold Standard 100% Whey Protein 5lb - Edition 12', 'Engineered by Optimum Nutrition. The Gold Standard 100% Whey Protein 5lb comes equipped Medical-Grade Intermittent Compression. Designed for superior performance, premium durability, and daily reliability.', 128.02, 78, 'https://images.unsplash.com/photo-1505751172876-fa1923c5c528?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Health & Wellness' LIMIT 1), '10000000-0000-0000-0000-000000000008'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000942');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000943', 'Withings Smart Wi-Fi Body Composition Scale - Edition 13', 'Engineered by Withings. The Smart Wi-Fi Body Composition Scale comes equipped Ultra-Quiet 24dB Sleep Mode Filtration. Designed for superior performance, premium durability, and daily reliability.', 134.47, 91, 'https://images.unsplash.com/photo-1576091160550-2173dba999ef?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Health & Wellness' LIMIT 1), '10000000-0000-0000-0000-000000000008'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000943');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000944', 'Fitbit Organic Omega-3 Fish Oil Softgels - Edition 14', 'Engineered by Fitbit. The Organic Omega-3 Fish Oil Softgels comes equipped Clinically Validated Dual Sensor Precision. Designed for superior performance, premium durability, and daily reliability.', 140.92, 19, 'https://images.unsplash.com/photo-1616671285442-12797e8876e5?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Health & Wellness' LIMIT 1), '10000000-0000-0000-0000-000000000008'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000944');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000945', 'Garden of Life Heated Shiatsu Neck Massager - Edition 15', 'Engineered by Garden of Life. The Heated Shiatsu Neck Massager comes equipped 24g Protein & 5.5g BCAAs per Serving. Designed for superior performance, premium durability, and daily reliability.', 147.36, 32, 'https://images.unsplash.com/photo-1506126613408-eca07ce68773?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Health & Wellness' LIMIT 1), '10000000-0000-0000-0000-000000000008'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000945');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000946', 'Nordic Naturals Collagen Peptides Powder 20oz - Edition 16', 'Engineered by Nordic Naturals. The Collagen Peptides Powder 20oz comes equipped Measures Weight, Body Fat%, Heart Rate. Designed for superior performance, premium durability, and daily reliability.', 132.11, 45, 'https://images.unsplash.com/photo-1584308666744-24d5c474f2ae?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Health & Wellness' LIMIT 1), '10000000-0000-0000-0000-000000000008'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000946');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000947', 'Beurer Smart Pulse Oximeter Finger Sensor - Edition 17', 'Engineered by Beurer. The Smart Pulse Oximeter Finger Sensor comes equipped Molecularly Distilled EPA & DHA. Designed for superior performance, premium durability, and daily reliability.', 138.55, 58, 'https://images.unsplash.com/photo-1540555700478-4be289fbecef?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Health & Wellness' LIMIT 1), '10000000-0000-0000-0000-000000000008'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000947');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000948', 'Nature Made Ergonomic Memory Foam Lumbar Support - Edition 18', 'Engineered by Nature Made. The Ergonomic Memory Foam Lumbar Support comes equipped Infrared Soothing Heat Therapy Function. Designed for superior performance, premium durability, and daily reliability.', 145.0, 71, 'https://images.unsplash.com/photo-1512069772995-ec65ed45afd6?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Health & Wellness' LIMIT 1), '10000000-0000-0000-0000-000000000008'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000948');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000949', 'Vital Proteins Plant-Based Multivitamin Complex - Edition 19', 'Engineered by Vital Proteins. The Plant-Based Multivitamin Complex comes equipped Grass-Fed & Pasture-Raised Hydrolyzed. Designed for superior performance, premium durability, and daily reliability.', 151.45, 84, 'https://images.unsplash.com/photo-1544367567-0f2fcb009e0b?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Health & Wellness' LIMIT 1), '10000000-0000-0000-0000-000000000008'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000949');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000950', 'Therabody Compression Leg Recovery Boots - Edition 20', 'Engineered by Therabody. The Compression Leg Recovery Boots comes equipped FDA Cleared OLED Display. Designed for superior performance, premium durability, and daily reliability.', 157.89, 97, 'https://images.unsplash.com/photo-1579126038374-6064e9370f0f?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Health & Wellness' LIMIT 1), '10000000-0000-0000-0000-000000000008'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000950');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000951', 'Renpho Electric Heating Pad for Back Pain - Edition 01', 'Engineered by Renpho. The Electric Heating Pad for Back Pain comes equipped Zero Artificial Sugars & Non-GMO. Designed for superior performance, premium durability, and daily reliability.', 164.34, 25, 'https://images.unsplash.com/photo-1527613426441-4da17471b66d?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Health & Wellness' LIMIT 1), '10000000-0000-0000-0000-000000000008'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000951');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000952', 'Hyperice Melatonin Sleep Support Gummies 90ct - Edition 02', 'Engineered by Hyperice. The Melatonin Sleep Support Gummies 90ct comes equipped Medical-Grade Intermittent Compression. Designed for superior performance, premium durability, and daily reliability.', 170.79, 38, 'https://images.unsplash.com/photo-1505751172876-fa1923c5c528?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Health & Wellness' LIMIT 1), '10000000-0000-0000-0000-000000000008'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000952');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000953', 'NOW Foods Air Purifier with True HEPA Filter - Edition 03', 'Engineered by NOW Foods. The Air Purifier with True HEPA Filter comes equipped Ultra-Quiet 24dB Sleep Mode Filtration. Designed for superior performance, premium durability, and daily reliability.', 155.53, 51, 'https://images.unsplash.com/photo-1576091160550-2173dba999ef?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Health & Wellness' LIMIT 1), '10000000-0000-0000-0000-000000000008'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000953');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000954', 'Pure Encapsulations Deep Tissue Foam Roller 36-inch - Edition 04', 'Engineered by Pure Encapsulations. The Deep Tissue Foam Roller 36-inch comes equipped Clinically Validated Dual Sensor Precision. Designed for superior performance, premium durability, and daily reliability.', 161.98, 64, 'https://images.unsplash.com/photo-1616671285442-12797e8876e5?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Health & Wellness' LIMIT 1), '10000000-0000-0000-0000-000000000008'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000954');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000955', 'Thorne Vibrating Massage Ball Mobility Tool - Edition 05', 'Engineered by Thorne. The Vibrating Massage Ball Mobility Tool comes equipped 24g Protein & 5.5g BCAAs per Serving. Designed for superior performance, premium durability, and daily reliability.', 168.42, 77, 'https://images.unsplash.com/photo-1506126613408-eca07ce68773?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Health & Wellness' LIMIT 1), '10000000-0000-0000-0000-000000000008'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000955');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000956', 'Omron Digital Arm Blood Pressure Monitor - Edition 06', 'Engineered by Omron. The Digital Arm Blood Pressure Monitor comes equipped Measures Weight, Body Fat%, Heart Rate. Designed for superior performance, premium durability, and daily reliability.', 174.87, 90, 'https://images.unsplash.com/photo-1584308666744-24d5c474f2ae?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Health & Wellness' LIMIT 1), '10000000-0000-0000-0000-000000000008'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000956');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000957', 'Optimum Nutrition Gold Standard 100% Whey Protein 5lb - Edition 07', 'Engineered by Optimum Nutrition. The Gold Standard 100% Whey Protein 5lb comes equipped Molecularly Distilled EPA & DHA. Designed for superior performance, premium durability, and daily reliability.', 181.32, 18, 'https://images.unsplash.com/photo-1540555700478-4be289fbecef?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Health & Wellness' LIMIT 1), '10000000-0000-0000-0000-000000000008'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000957');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000958', 'Withings Smart Wi-Fi Body Composition Scale - Edition 08', 'Engineered by Withings. The Smart Wi-Fi Body Composition Scale comes equipped Infrared Soothing Heat Therapy Function. Designed for superior performance, premium durability, and daily reliability.', 187.76, 31, 'https://images.unsplash.com/photo-1512069772995-ec65ed45afd6?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Health & Wellness' LIMIT 1), '10000000-0000-0000-0000-000000000008'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000958');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000959', 'Fitbit Organic Omega-3 Fish Oil Softgels - Edition 09', 'Engineered by Fitbit. The Organic Omega-3 Fish Oil Softgels comes equipped Grass-Fed & Pasture-Raised Hydrolyzed. Designed for superior performance, premium durability, and daily reliability.', 194.21, 44, 'https://images.unsplash.com/photo-1544367567-0f2fcb009e0b?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Health & Wellness' LIMIT 1), '10000000-0000-0000-0000-000000000008'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000959');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000960', 'Garden of Life Heated Shiatsu Neck Massager - Edition 10', 'Engineered by Garden of Life. The Heated Shiatsu Neck Massager comes equipped FDA Cleared OLED Display. Designed for superior performance, premium durability, and daily reliability.', 178.96, 57, 'https://images.unsplash.com/photo-1579126038374-6064e9370f0f?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Health & Wellness' LIMIT 1), '10000000-0000-0000-0000-000000000008'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000960');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000961', 'Nordic Naturals Collagen Peptides Powder 20oz - Edition 11', 'Engineered by Nordic Naturals. The Collagen Peptides Powder 20oz comes equipped Zero Artificial Sugars & Non-GMO. Designed for superior performance, premium durability, and daily reliability.', 185.4, 70, 'https://images.unsplash.com/photo-1527613426441-4da17471b66d?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Health & Wellness' LIMIT 1), '10000000-0000-0000-0000-000000000008'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000961');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000962', 'Beurer Smart Pulse Oximeter Finger Sensor - Edition 12', 'Engineered by Beurer. The Smart Pulse Oximeter Finger Sensor comes equipped Medical-Grade Intermittent Compression. Designed for superior performance, premium durability, and daily reliability.', 191.85, 83, 'https://images.unsplash.com/photo-1505751172876-fa1923c5c528?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Health & Wellness' LIMIT 1), '10000000-0000-0000-0000-000000000008'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000962');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000963', 'Nature Made Ergonomic Memory Foam Lumbar Support - Edition 13', 'Engineered by Nature Made. The Ergonomic Memory Foam Lumbar Support comes equipped Ultra-Quiet 24dB Sleep Mode Filtration. Designed for superior performance, premium durability, and daily reliability.', 198.29, 96, 'https://images.unsplash.com/photo-1576091160550-2173dba999ef?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Health & Wellness' LIMIT 1), '10000000-0000-0000-0000-000000000008'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000963');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000964', 'Vital Proteins Plant-Based Multivitamin Complex - Edition 14', 'Engineered by Vital Proteins. The Plant-Based Multivitamin Complex comes equipped Clinically Validated Dual Sensor Precision. Designed for superior performance, premium durability, and daily reliability.', 204.74, 24, 'https://images.unsplash.com/photo-1616671285442-12797e8876e5?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Health & Wellness' LIMIT 1), '10000000-0000-0000-0000-000000000008'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000964');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000965', 'Therabody Compression Leg Recovery Boots - Edition 15', 'Engineered by Therabody. The Compression Leg Recovery Boots comes equipped 24g Protein & 5.5g BCAAs per Serving. Designed for superior performance, premium durability, and daily reliability.', 211.19, 37, 'https://images.unsplash.com/photo-1506126613408-eca07ce68773?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Health & Wellness' LIMIT 1), '10000000-0000-0000-0000-000000000008'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000965');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000966', 'Renpho Electric Heating Pad for Back Pain - Edition 16', 'Engineered by Renpho. The Electric Heating Pad for Back Pain comes equipped Measures Weight, Body Fat%, Heart Rate. Designed for superior performance, premium durability, and daily reliability.', 217.63, 50, 'https://images.unsplash.com/photo-1584308666744-24d5c474f2ae?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Health & Wellness' LIMIT 1), '10000000-0000-0000-0000-000000000008'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000966');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000967', 'Hyperice Melatonin Sleep Support Gummies 90ct - Edition 17', 'Engineered by Hyperice. The Melatonin Sleep Support Gummies 90ct comes equipped Molecularly Distilled EPA & DHA. Designed for superior performance, premium durability, and daily reliability.', 202.38, 63, 'https://images.unsplash.com/photo-1540555700478-4be289fbecef?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Health & Wellness' LIMIT 1), '10000000-0000-0000-0000-000000000008'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000967');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000968', 'NOW Foods Air Purifier with True HEPA Filter - Edition 18', 'Engineered by NOW Foods. The Air Purifier with True HEPA Filter comes equipped Infrared Soothing Heat Therapy Function. Designed for superior performance, premium durability, and daily reliability.', 208.83, 76, 'https://images.unsplash.com/photo-1512069772995-ec65ed45afd6?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Health & Wellness' LIMIT 1), '10000000-0000-0000-0000-000000000008'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000968');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000969', 'Pure Encapsulations Deep Tissue Foam Roller 36-inch - Edition 19', 'Engineered by Pure Encapsulations. The Deep Tissue Foam Roller 36-inch comes equipped Grass-Fed & Pasture-Raised Hydrolyzed. Designed for superior performance, premium durability, and daily reliability.', 215.27, 89, 'https://images.unsplash.com/photo-1544367567-0f2fcb009e0b?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Health & Wellness' LIMIT 1), '10000000-0000-0000-0000-000000000008'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000969');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000970', 'Thorne Vibrating Massage Ball Mobility Tool - Edition 20', 'Engineered by Thorne. The Vibrating Massage Ball Mobility Tool comes equipped FDA Cleared OLED Display. Designed for superior performance, premium durability, and daily reliability.', 221.72, 17, 'https://images.unsplash.com/photo-1579126038374-6064e9370f0f?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Health & Wellness' LIMIT 1), '10000000-0000-0000-0000-000000000008'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000970');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000971', 'Omron Digital Arm Blood Pressure Monitor - Edition 01', 'Engineered by Omron. The Digital Arm Blood Pressure Monitor comes equipped Zero Artificial Sugars & Non-GMO. Designed for superior performance, premium durability, and daily reliability.', 228.16, 30, 'https://images.unsplash.com/photo-1527613426441-4da17471b66d?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Health & Wellness' LIMIT 1), '10000000-0000-0000-0000-000000000008'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000971');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000972', 'Optimum Nutrition Gold Standard 100% Whey Protein 5lb - Edition 02', 'Engineered by Optimum Nutrition. The Gold Standard 100% Whey Protein 5lb comes equipped Medical-Grade Intermittent Compression. Designed for superior performance, premium durability, and daily reliability.', 234.61, 43, 'https://images.unsplash.com/photo-1505751172876-fa1923c5c528?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Health & Wellness' LIMIT 1), '10000000-0000-0000-0000-000000000008'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000972');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000973', 'Withings Smart Wi-Fi Body Composition Scale - Edition 03', 'Engineered by Withings. The Smart Wi-Fi Body Composition Scale comes equipped Ultra-Quiet 24dB Sleep Mode Filtration. Designed for superior performance, premium durability, and daily reliability.', 241.06, 56, 'https://images.unsplash.com/photo-1576091160550-2173dba999ef?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Health & Wellness' LIMIT 1), '10000000-0000-0000-0000-000000000008'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000973');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000974', 'Fitbit Organic Omega-3 Fish Oil Softgels - Edition 04', 'Engineered by Fitbit. The Organic Omega-3 Fish Oil Softgels comes equipped Clinically Validated Dual Sensor Precision. Designed for superior performance, premium durability, and daily reliability.', 225.8, 69, 'https://images.unsplash.com/photo-1616671285442-12797e8876e5?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Health & Wellness' LIMIT 1), '10000000-0000-0000-0000-000000000008'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000974');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000975', 'Garden of Life Heated Shiatsu Neck Massager - Edition 05', 'Engineered by Garden of Life. The Heated Shiatsu Neck Massager comes equipped 24g Protein & 5.5g BCAAs per Serving. Designed for superior performance, premium durability, and daily reliability.', 232.25, 82, 'https://images.unsplash.com/photo-1506126613408-eca07ce68773?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Health & Wellness' LIMIT 1), '10000000-0000-0000-0000-000000000008'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000975');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000976', 'Nordic Naturals Collagen Peptides Powder 20oz - Edition 06', 'Engineered by Nordic Naturals. The Collagen Peptides Powder 20oz comes equipped Measures Weight, Body Fat%, Heart Rate. Designed for superior performance, premium durability, and daily reliability.', 238.69, 95, 'https://images.unsplash.com/photo-1584308666744-24d5c474f2ae?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Health & Wellness' LIMIT 1), '10000000-0000-0000-0000-000000000008'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000976');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000977', 'Beurer Smart Pulse Oximeter Finger Sensor - Edition 07', 'Engineered by Beurer. The Smart Pulse Oximeter Finger Sensor comes equipped Molecularly Distilled EPA & DHA. Designed for superior performance, premium durability, and daily reliability.', 245.14, 23, 'https://images.unsplash.com/photo-1540555700478-4be289fbecef?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Health & Wellness' LIMIT 1), '10000000-0000-0000-0000-000000000008'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000977');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000978', 'Nature Made Ergonomic Memory Foam Lumbar Support - Edition 08', 'Engineered by Nature Made. The Ergonomic Memory Foam Lumbar Support comes equipped Infrared Soothing Heat Therapy Function. Designed for superior performance, premium durability, and daily reliability.', 251.59, 36, 'https://images.unsplash.com/photo-1512069772995-ec65ed45afd6?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Health & Wellness' LIMIT 1), '10000000-0000-0000-0000-000000000008'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000978');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000979', 'Vital Proteins Plant-Based Multivitamin Complex - Edition 09', 'Engineered by Vital Proteins. The Plant-Based Multivitamin Complex comes equipped Grass-Fed & Pasture-Raised Hydrolyzed. Designed for superior performance, premium durability, and daily reliability.', 258.03, 49, 'https://images.unsplash.com/photo-1544367567-0f2fcb009e0b?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Health & Wellness' LIMIT 1), '10000000-0000-0000-0000-000000000008'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000979');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000980', 'Therabody Compression Leg Recovery Boots - Edition 10', 'Engineered by Therabody. The Compression Leg Recovery Boots comes equipped FDA Cleared OLED Display. Designed for superior performance, premium durability, and daily reliability.', 264.48, 62, 'https://images.unsplash.com/photo-1579126038374-6064e9370f0f?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Health & Wellness' LIMIT 1), '10000000-0000-0000-0000-000000000008'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000980');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000981', 'Renpho Electric Heating Pad for Back Pain - Edition 11', 'Engineered by Renpho. The Electric Heating Pad for Back Pain comes equipped Zero Artificial Sugars & Non-GMO. Designed for superior performance, premium durability, and daily reliability.', 249.23, 75, 'https://images.unsplash.com/photo-1527613426441-4da17471b66d?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Health & Wellness' LIMIT 1), '10000000-0000-0000-0000-000000000008'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000981');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000982', 'Hyperice Melatonin Sleep Support Gummies 90ct - Edition 12', 'Engineered by Hyperice. The Melatonin Sleep Support Gummies 90ct comes equipped Medical-Grade Intermittent Compression. Designed for superior performance, premium durability, and daily reliability.', 255.67, 88, 'https://images.unsplash.com/photo-1505751172876-fa1923c5c528?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Health & Wellness' LIMIT 1), '10000000-0000-0000-0000-000000000008'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000982');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000983', 'NOW Foods Air Purifier with True HEPA Filter - Edition 13', 'Engineered by NOW Foods. The Air Purifier with True HEPA Filter comes equipped Ultra-Quiet 24dB Sleep Mode Filtration. Designed for superior performance, premium durability, and daily reliability.', 262.12, 16, 'https://images.unsplash.com/photo-1576091160550-2173dba999ef?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Health & Wellness' LIMIT 1), '10000000-0000-0000-0000-000000000008'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000983');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000984', 'Pure Encapsulations Deep Tissue Foam Roller 36-inch - Edition 14', 'Engineered by Pure Encapsulations. The Deep Tissue Foam Roller 36-inch comes equipped Clinically Validated Dual Sensor Precision. Designed for superior performance, premium durability, and daily reliability.', 268.56, 29, 'https://images.unsplash.com/photo-1616671285442-12797e8876e5?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Health & Wellness' LIMIT 1), '10000000-0000-0000-0000-000000000008'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000984');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000985', 'Thorne Vibrating Massage Ball Mobility Tool - Edition 15', 'Engineered by Thorne. The Vibrating Massage Ball Mobility Tool comes equipped 24g Protein & 5.5g BCAAs per Serving. Designed for superior performance, premium durability, and daily reliability.', 275.01, 42, 'https://images.unsplash.com/photo-1506126613408-eca07ce68773?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Health & Wellness' LIMIT 1), '10000000-0000-0000-0000-000000000008'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000985');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000986', 'Omron Digital Arm Blood Pressure Monitor - Edition 16', 'Engineered by Omron. The Digital Arm Blood Pressure Monitor comes equipped Measures Weight, Body Fat%, Heart Rate. Designed for superior performance, premium durability, and daily reliability.', 281.46, 55, 'https://images.unsplash.com/photo-1584308666744-24d5c474f2ae?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Health & Wellness' LIMIT 1), '10000000-0000-0000-0000-000000000008'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000986');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000987', 'Optimum Nutrition Gold Standard 100% Whey Protein 5lb - Edition 17', 'Engineered by Optimum Nutrition. The Gold Standard 100% Whey Protein 5lb comes equipped Molecularly Distilled EPA & DHA. Designed for superior performance, premium durability, and daily reliability.', 287.9, 68, 'https://images.unsplash.com/photo-1540555700478-4be289fbecef?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Health & Wellness' LIMIT 1), '10000000-0000-0000-0000-000000000008'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000987');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000988', 'Withings Smart Wi-Fi Body Composition Scale - Edition 18', 'Engineered by Withings. The Smart Wi-Fi Body Composition Scale comes equipped Infrared Soothing Heat Therapy Function. Designed for superior performance, premium durability, and daily reliability.', 272.65, 81, 'https://images.unsplash.com/photo-1512069772995-ec65ed45afd6?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Health & Wellness' LIMIT 1), '10000000-0000-0000-0000-000000000008'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000988');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000989', 'Fitbit Organic Omega-3 Fish Oil Softgels - Edition 19', 'Engineered by Fitbit. The Organic Omega-3 Fish Oil Softgels comes equipped Grass-Fed & Pasture-Raised Hydrolyzed. Designed for superior performance, premium durability, and daily reliability.', 279.1, 94, 'https://images.unsplash.com/photo-1544367567-0f2fcb009e0b?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Health & Wellness' LIMIT 1), '10000000-0000-0000-0000-000000000008'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000989');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000990', 'Garden of Life Heated Shiatsu Neck Massager - Edition 20', 'Engineered by Garden of Life. The Heated Shiatsu Neck Massager comes equipped FDA Cleared OLED Display. Designed for superior performance, premium durability, and daily reliability.', 285.54, 22, 'https://images.unsplash.com/photo-1579126038374-6064e9370f0f?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Health & Wellness' LIMIT 1), '10000000-0000-0000-0000-000000000008'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000990');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000991', 'Nordic Naturals Collagen Peptides Powder 20oz - Edition 01', 'Engineered by Nordic Naturals. The Collagen Peptides Powder 20oz comes equipped Zero Artificial Sugars & Non-GMO. Designed for superior performance, premium durability, and daily reliability.', 291.99, 35, 'https://images.unsplash.com/photo-1527613426441-4da17471b66d?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Health & Wellness' LIMIT 1), '10000000-0000-0000-0000-000000000008'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000991');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000992', 'Beurer Smart Pulse Oximeter Finger Sensor - Edition 02', 'Engineered by Beurer. The Smart Pulse Oximeter Finger Sensor comes equipped Medical-Grade Intermittent Compression. Designed for superior performance, premium durability, and daily reliability.', 298.43, 48, 'https://images.unsplash.com/photo-1505751172876-fa1923c5c528?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Health & Wellness' LIMIT 1), '10000000-0000-0000-0000-000000000008'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000992');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000993', 'Nature Made Ergonomic Memory Foam Lumbar Support - Edition 03', 'Engineered by Nature Made. The Ergonomic Memory Foam Lumbar Support comes equipped Ultra-Quiet 24dB Sleep Mode Filtration. Designed for superior performance, premium durability, and daily reliability.', 304.88, 61, 'https://images.unsplash.com/photo-1576091160550-2173dba999ef?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Health & Wellness' LIMIT 1), '10000000-0000-0000-0000-000000000008'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000993');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000994', 'Vital Proteins Plant-Based Multivitamin Complex - Edition 04', 'Engineered by Vital Proteins. The Plant-Based Multivitamin Complex comes equipped Clinically Validated Dual Sensor Precision. Designed for superior performance, premium durability, and daily reliability.', 311.33, 74, 'https://images.unsplash.com/photo-1616671285442-12797e8876e5?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Health & Wellness' LIMIT 1), '10000000-0000-0000-0000-000000000008'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000994');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000995', 'Therabody Compression Leg Recovery Boots - Edition 05', 'Engineered by Therabody. The Compression Leg Recovery Boots comes equipped 24g Protein & 5.5g BCAAs per Serving. Designed for superior performance, premium durability, and daily reliability.', 296.07, 87, 'https://images.unsplash.com/photo-1506126613408-eca07ce68773?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Health & Wellness' LIMIT 1), '10000000-0000-0000-0000-000000000008'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000995');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000996', 'Renpho Electric Heating Pad for Back Pain - Edition 06', 'Engineered by Renpho. The Electric Heating Pad for Back Pain comes equipped Measures Weight, Body Fat%, Heart Rate. Designed for superior performance, premium durability, and daily reliability.', 302.52, 15, 'https://images.unsplash.com/photo-1584308666744-24d5c474f2ae?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Health & Wellness' LIMIT 1), '10000000-0000-0000-0000-000000000008'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000996');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000997', 'Hyperice Melatonin Sleep Support Gummies 90ct - Edition 07', 'Engineered by Hyperice. The Melatonin Sleep Support Gummies 90ct comes equipped Molecularly Distilled EPA & DHA. Designed for superior performance, premium durability, and daily reliability.', 308.97, 28, 'https://images.unsplash.com/photo-1540555700478-4be289fbecef?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Health & Wellness' LIMIT 1), '10000000-0000-0000-0000-000000000008'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000997');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000998', 'NOW Foods Air Purifier with True HEPA Filter - Edition 08', 'Engineered by NOW Foods. The Air Purifier with True HEPA Filter comes equipped Infrared Soothing Heat Therapy Function. Designed for superior performance, premium durability, and daily reliability.', 315.41, 41, 'https://images.unsplash.com/photo-1512069772995-ec65ed45afd6?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Health & Wellness' LIMIT 1), '10000000-0000-0000-0000-000000000008'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000998');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000000999', 'Pure Encapsulations Deep Tissue Foam Roller 36-inch - Edition 09', 'Engineered by Pure Encapsulations. The Deep Tissue Foam Roller 36-inch comes equipped Grass-Fed & Pasture-Raised Hydrolyzed. Designed for superior performance, premium durability, and daily reliability.', 321.86, 54, 'https://images.unsplash.com/photo-1544367567-0f2fcb009e0b?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Health & Wellness' LIMIT 1), '10000000-0000-0000-0000-000000000008'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000000999');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000001000', 'Thorne Vibrating Massage Ball Mobility Tool - Edition 10', 'Engineered by Thorne. The Vibrating Massage Ball Mobility Tool comes equipped FDA Cleared OLED Display. Designed for superior performance, premium durability, and daily reliability.', 328.3, 67, 'https://images.unsplash.com/photo-1579126038374-6064e9370f0f?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Health & Wellness' LIMIT 1), '10000000-0000-0000-0000-000000000008'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000001000');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000001001', 'Omron Digital Arm Blood Pressure Monitor - Edition 11', 'Engineered by Omron. The Digital Arm Blood Pressure Monitor comes equipped Zero Artificial Sugars & Non-GMO. Designed for superior performance, premium durability, and daily reliability.', 334.75, 80, 'https://images.unsplash.com/photo-1527613426441-4da17471b66d?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Health & Wellness' LIMIT 1), '10000000-0000-0000-0000-000000000008'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000001001');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000001002', 'Optimum Nutrition Gold Standard 100% Whey Protein 5lb - Edition 12', 'Engineered by Optimum Nutrition. The Gold Standard 100% Whey Protein 5lb comes equipped Medical-Grade Intermittent Compression. Designed for superior performance, premium durability, and daily reliability.', 319.5, 93, 'https://images.unsplash.com/photo-1505751172876-fa1923c5c528?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Health & Wellness' LIMIT 1), '10000000-0000-0000-0000-000000000008'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000001002');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000001003', 'Withings Smart Wi-Fi Body Composition Scale - Edition 13', 'Engineered by Withings. The Smart Wi-Fi Body Composition Scale comes equipped Ultra-Quiet 24dB Sleep Mode Filtration. Designed for superior performance, premium durability, and daily reliability.', 325.94, 21, 'https://images.unsplash.com/photo-1576091160550-2173dba999ef?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Health & Wellness' LIMIT 1), '10000000-0000-0000-0000-000000000008'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000001003');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000001004', 'Fitbit Organic Omega-3 Fish Oil Softgels - Edition 14', 'Engineered by Fitbit. The Organic Omega-3 Fish Oil Softgels comes equipped Clinically Validated Dual Sensor Precision. Designed for superior performance, premium durability, and daily reliability.', 332.39, 34, 'https://images.unsplash.com/photo-1616671285442-12797e8876e5?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Health & Wellness' LIMIT 1), '10000000-0000-0000-0000-000000000008'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000001004');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000001005', 'Garden of Life Heated Shiatsu Neck Massager - Edition 15', 'Engineered by Garden of Life. The Heated Shiatsu Neck Massager comes equipped 24g Protein & 5.5g BCAAs per Serving. Designed for superior performance, premium durability, and daily reliability.', 338.84, 47, 'https://images.unsplash.com/photo-1506126613408-eca07ce68773?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Health & Wellness' LIMIT 1), '10000000-0000-0000-0000-000000000008'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000001005');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000001006', 'Nordic Naturals Collagen Peptides Powder 20oz - Edition 16', 'Engineered by Nordic Naturals. The Collagen Peptides Powder 20oz comes equipped Measures Weight, Body Fat%, Heart Rate. Designed for superior performance, premium durability, and daily reliability.', 345.28, 60, 'https://images.unsplash.com/photo-1584308666744-24d5c474f2ae?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Health & Wellness' LIMIT 1), '10000000-0000-0000-0000-000000000008'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000001006');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000001007', 'Beurer Smart Pulse Oximeter Finger Sensor - Edition 17', 'Engineered by Beurer. The Smart Pulse Oximeter Finger Sensor comes equipped Molecularly Distilled EPA & DHA. Designed for superior performance, premium durability, and daily reliability.', 351.73, 73, 'https://images.unsplash.com/photo-1540555700478-4be289fbecef?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Health & Wellness' LIMIT 1), '10000000-0000-0000-0000-000000000008'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000001007');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000001008', 'Nature Made Ergonomic Memory Foam Lumbar Support - Edition 18', 'Engineered by Nature Made. The Ergonomic Memory Foam Lumbar Support comes equipped Infrared Soothing Heat Therapy Function. Designed for superior performance, premium durability, and daily reliability.', 358.17, 86, 'https://images.unsplash.com/photo-1512069772995-ec65ed45afd6?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Health & Wellness' LIMIT 1), '10000000-0000-0000-0000-000000000008'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000001008');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000001009', 'Vital Proteins Plant-Based Multivitamin Complex - Edition 19', 'Engineered by Vital Proteins. The Plant-Based Multivitamin Complex comes equipped Grass-Fed & Pasture-Raised Hydrolyzed. Designed for superior performance, premium durability, and daily reliability.', 342.92, 99, 'https://images.unsplash.com/photo-1544367567-0f2fcb009e0b?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Health & Wellness' LIMIT 1), '10000000-0000-0000-0000-000000000008'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000001009');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000001010', 'Therabody Compression Leg Recovery Boots - Edition 20', 'Engineered by Therabody. The Compression Leg Recovery Boots comes equipped FDA Cleared OLED Display. Designed for superior performance, premium durability, and daily reliability.', 349.37, 27, 'https://images.unsplash.com/photo-1579126038374-6064e9370f0f?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Health & Wellness' LIMIT 1), '10000000-0000-0000-0000-000000000008'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000001010');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000001011', 'Renpho Electric Heating Pad for Back Pain - Edition 01', 'Engineered by Renpho. The Electric Heating Pad for Back Pain comes equipped Zero Artificial Sugars & Non-GMO. Designed for superior performance, premium durability, and daily reliability.', 355.81, 40, 'https://images.unsplash.com/photo-1527613426441-4da17471b66d?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Health & Wellness' LIMIT 1), '10000000-0000-0000-0000-000000000008'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000001011');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000001012', 'Hyperice Melatonin Sleep Support Gummies 90ct - Edition 02', 'Engineered by Hyperice. The Melatonin Sleep Support Gummies 90ct comes equipped Medical-Grade Intermittent Compression. Designed for superior performance, premium durability, and daily reliability.', 362.26, 53, 'https://images.unsplash.com/photo-1505751172876-fa1923c5c528?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Health & Wellness' LIMIT 1), '10000000-0000-0000-0000-000000000008'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000001012');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000001013', 'NOW Foods Air Purifier with True HEPA Filter - Edition 03', 'Engineered by NOW Foods. The Air Purifier with True HEPA Filter comes equipped Ultra-Quiet 24dB Sleep Mode Filtration. Designed for superior performance, premium durability, and daily reliability.', 368.71, 66, 'https://images.unsplash.com/photo-1576091160550-2173dba999ef?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Health & Wellness' LIMIT 1), '10000000-0000-0000-0000-000000000008'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000001013');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000001014', 'Pure Encapsulations Deep Tissue Foam Roller 36-inch - Edition 04', 'Engineered by Pure Encapsulations. The Deep Tissue Foam Roller 36-inch comes equipped Clinically Validated Dual Sensor Precision. Designed for superior performance, premium durability, and daily reliability.', 375.15, 79, 'https://images.unsplash.com/photo-1616671285442-12797e8876e5?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Health & Wellness' LIMIT 1), '10000000-0000-0000-0000-000000000008'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000001014');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000001015', 'Thorne Vibrating Massage Ball Mobility Tool - Edition 05', 'Engineered by Thorne. The Vibrating Massage Ball Mobility Tool comes equipped 24g Protein & 5.5g BCAAs per Serving. Designed for superior performance, premium durability, and daily reliability.', 381.6, 92, 'https://images.unsplash.com/photo-1506126613408-eca07ce68773?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Health & Wellness' LIMIT 1), '10000000-0000-0000-0000-000000000008'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000001015');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000001016', 'Omron Digital Arm Blood Pressure Monitor - Edition 06', 'Engineered by Omron. The Digital Arm Blood Pressure Monitor comes equipped Measures Weight, Body Fat%, Heart Rate. Designed for superior performance, premium durability, and daily reliability.', 366.34, 20, 'https://images.unsplash.com/photo-1584308666744-24d5c474f2ae?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Health & Wellness' LIMIT 1), '10000000-0000-0000-0000-000000000008'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000001016');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000001017', 'Optimum Nutrition Gold Standard 100% Whey Protein 5lb - Edition 07', 'Engineered by Optimum Nutrition. The Gold Standard 100% Whey Protein 5lb comes equipped Molecularly Distilled EPA & DHA. Designed for superior performance, premium durability, and daily reliability.', 372.79, 33, 'https://images.unsplash.com/photo-1540555700478-4be289fbecef?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Health & Wellness' LIMIT 1), '10000000-0000-0000-0000-000000000008'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000001017');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000001018', 'Withings Smart Wi-Fi Body Composition Scale - Edition 08', 'Engineered by Withings. The Smart Wi-Fi Body Composition Scale comes equipped Infrared Soothing Heat Therapy Function. Designed for superior performance, premium durability, and daily reliability.', 379.24, 46, 'https://images.unsplash.com/photo-1512069772995-ec65ed45afd6?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Health & Wellness' LIMIT 1), '10000000-0000-0000-0000-000000000008'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000001018');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000001019', 'Fitbit Organic Omega-3 Fish Oil Softgels - Edition 09', 'Engineered by Fitbit. The Organic Omega-3 Fish Oil Softgels comes equipped Grass-Fed & Pasture-Raised Hydrolyzed. Designed for superior performance, premium durability, and daily reliability.', 385.68, 59, 'https://images.unsplash.com/photo-1544367567-0f2fcb009e0b?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Health & Wellness' LIMIT 1), '10000000-0000-0000-0000-000000000008'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000001019');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000001020', 'Garden of Life Heated Shiatsu Neck Massager - Edition 10', 'Engineered by Garden of Life. The Heated Shiatsu Neck Massager comes equipped FDA Cleared OLED Display. Designed for superior performance, premium durability, and daily reliability.', 392.13, 72, 'https://images.unsplash.com/photo-1579126038374-6064e9370f0f?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Health & Wellness' LIMIT 1), '10000000-0000-0000-0000-000000000008'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000001020');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000001021', 'Nordic Naturals Collagen Peptides Powder 20oz - Edition 11', 'Engineered by Nordic Naturals. The Collagen Peptides Powder 20oz comes equipped Zero Artificial Sugars & Non-GMO. Designed for superior performance, premium durability, and daily reliability.', 398.58, 85, 'https://images.unsplash.com/photo-1527613426441-4da17471b66d?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Health & Wellness' LIMIT 1), '10000000-0000-0000-0000-000000000008'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000001021');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000001022', 'Beurer Smart Pulse Oximeter Finger Sensor - Edition 12', 'Engineered by Beurer. The Smart Pulse Oximeter Finger Sensor comes equipped Medical-Grade Intermittent Compression. Designed for superior performance, premium durability, and daily reliability.', 405.02, 98, 'https://images.unsplash.com/photo-1505751172876-fa1923c5c528?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Health & Wellness' LIMIT 1), '10000000-0000-0000-0000-000000000008'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000001022');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000001023', 'Nature Made Ergonomic Memory Foam Lumbar Support - Edition 13', 'Engineered by Nature Made. The Ergonomic Memory Foam Lumbar Support comes equipped Ultra-Quiet 24dB Sleep Mode Filtration. Designed for superior performance, premium durability, and daily reliability.', 389.77, 26, 'https://images.unsplash.com/photo-1576091160550-2173dba999ef?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Health & Wellness' LIMIT 1), '10000000-0000-0000-0000-000000000008'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000001023');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000001024', 'Vital Proteins Plant-Based Multivitamin Complex - Edition 14', 'Engineered by Vital Proteins. The Plant-Based Multivitamin Complex comes equipped Clinically Validated Dual Sensor Precision. Designed for superior performance, premium durability, and daily reliability.', 396.21, 39, 'https://images.unsplash.com/photo-1616671285442-12797e8876e5?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Health & Wellness' LIMIT 1), '10000000-0000-0000-0000-000000000008'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000001024');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000001025', 'Therabody Compression Leg Recovery Boots - Edition 15', 'Engineered by Therabody. The Compression Leg Recovery Boots comes equipped 24g Protein & 5.5g BCAAs per Serving. Designed for superior performance, premium durability, and daily reliability.', 402.66, 52, 'https://images.unsplash.com/photo-1506126613408-eca07ce68773?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Health & Wellness' LIMIT 1), '10000000-0000-0000-0000-000000000008'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000001025');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000001026', 'Renpho Electric Heating Pad for Back Pain - Edition 16', 'Engineered by Renpho. The Electric Heating Pad for Back Pain comes equipped Measures Weight, Body Fat%, Heart Rate. Designed for superior performance, premium durability, and daily reliability.', 409.11, 65, 'https://images.unsplash.com/photo-1584308666744-24d5c474f2ae?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Health & Wellness' LIMIT 1), '10000000-0000-0000-0000-000000000008'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000001026');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000001027', 'Hyperice Melatonin Sleep Support Gummies 90ct - Edition 17', 'Engineered by Hyperice. The Melatonin Sleep Support Gummies 90ct comes equipped Molecularly Distilled EPA & DHA. Designed for superior performance, premium durability, and daily reliability.', 415.55, 78, 'https://images.unsplash.com/photo-1540555700478-4be289fbecef?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Health & Wellness' LIMIT 1), '10000000-0000-0000-0000-000000000008'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000001027');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000001028', 'NOW Foods Air Purifier with True HEPA Filter - Edition 18', 'Engineered by NOW Foods. The Air Purifier with True HEPA Filter comes equipped Infrared Soothing Heat Therapy Function. Designed for superior performance, premium durability, and daily reliability.', 422.0, 91, 'https://images.unsplash.com/photo-1512069772995-ec65ed45afd6?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Health & Wellness' LIMIT 1), '10000000-0000-0000-0000-000000000008'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000001028');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000001029', 'Pure Encapsulations Deep Tissue Foam Roller 36-inch - Edition 19', 'Engineered by Pure Encapsulations. The Deep Tissue Foam Roller 36-inch comes equipped Grass-Fed & Pasture-Raised Hydrolyzed. Designed for superior performance, premium durability, and daily reliability.', 428.45, 19, 'https://images.unsplash.com/photo-1544367567-0f2fcb009e0b?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Health & Wellness' LIMIT 1), '10000000-0000-0000-0000-000000000008'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000001029');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000001030', 'Thorne Vibrating Massage Ball Mobility Tool - Edition 20', 'Engineered by Thorne. The Vibrating Massage Ball Mobility Tool comes equipped FDA Cleared OLED Display. Designed for superior performance, premium durability, and daily reliability.', 413.19, 32, 'https://images.unsplash.com/photo-1579126038374-6064e9370f0f?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Health & Wellness' LIMIT 1), '10000000-0000-0000-0000-000000000008'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000001030');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000001031', 'Omron Digital Arm Blood Pressure Monitor - Edition 01', 'Engineered by Omron. The Digital Arm Blood Pressure Monitor comes equipped Zero Artificial Sugars & Non-GMO. Designed for superior performance, premium durability, and daily reliability.', 419.64, 45, 'https://images.unsplash.com/photo-1527613426441-4da17471b66d?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Health & Wellness' LIMIT 1), '10000000-0000-0000-0000-000000000008'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000001031');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000001032', 'Optimum Nutrition Gold Standard 100% Whey Protein 5lb - Edition 02', 'Engineered by Optimum Nutrition. The Gold Standard 100% Whey Protein 5lb comes equipped Medical-Grade Intermittent Compression. Designed for superior performance, premium durability, and daily reliability.', 426.08, 58, 'https://images.unsplash.com/photo-1505751172876-fa1923c5c528?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Health & Wellness' LIMIT 1), '10000000-0000-0000-0000-000000000008'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000001032');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000001033', 'Withings Smart Wi-Fi Body Composition Scale - Edition 03', 'Engineered by Withings. The Smart Wi-Fi Body Composition Scale comes equipped Ultra-Quiet 24dB Sleep Mode Filtration. Designed for superior performance, premium durability, and daily reliability.', 432.53, 71, 'https://images.unsplash.com/photo-1576091160550-2173dba999ef?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Health & Wellness' LIMIT 1), '10000000-0000-0000-0000-000000000008'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000001033');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000001034', 'Fitbit Organic Omega-3 Fish Oil Softgels - Edition 04', 'Engineered by Fitbit. The Organic Omega-3 Fish Oil Softgels comes equipped Clinically Validated Dual Sensor Precision. Designed for superior performance, premium durability, and daily reliability.', 438.98, 84, 'https://images.unsplash.com/photo-1616671285442-12797e8876e5?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Health & Wellness' LIMIT 1), '10000000-0000-0000-0000-000000000008'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000001034');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000001035', 'Garden of Life Heated Shiatsu Neck Massager - Edition 05', 'Engineered by Garden of Life. The Heated Shiatsu Neck Massager comes equipped 24g Protein & 5.5g BCAAs per Serving. Designed for superior performance, premium durability, and daily reliability.', 445.42, 97, 'https://images.unsplash.com/photo-1506126613408-eca07ce68773?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Health & Wellness' LIMIT 1), '10000000-0000-0000-0000-000000000008'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000001035');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000001036', 'Nordic Naturals Collagen Peptides Powder 20oz - Edition 06', 'Engineered by Nordic Naturals. The Collagen Peptides Powder 20oz comes equipped Measures Weight, Body Fat%, Heart Rate. Designed for superior performance, premium durability, and daily reliability.', 450.0, 25, 'https://images.unsplash.com/photo-1584308666744-24d5c474f2ae?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Health & Wellness' LIMIT 1), '10000000-0000-0000-0000-000000000008'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000001036');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000001037', 'Beurer Smart Pulse Oximeter Finger Sensor - Edition 07', 'Engineered by Beurer. The Smart Pulse Oximeter Finger Sensor comes equipped Molecularly Distilled EPA & DHA. Designed for superior performance, premium durability, and daily reliability.', 436.62, 38, 'https://images.unsplash.com/photo-1540555700478-4be289fbecef?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Health & Wellness' LIMIT 1), '10000000-0000-0000-0000-000000000008'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000001037');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000001038', 'Nature Made Ergonomic Memory Foam Lumbar Support - Edition 08', 'Engineered by Nature Made. The Ergonomic Memory Foam Lumbar Support comes equipped Infrared Soothing Heat Therapy Function. Designed for superior performance, premium durability, and daily reliability.', 443.06, 51, 'https://images.unsplash.com/photo-1512069772995-ec65ed45afd6?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Health & Wellness' LIMIT 1), '10000000-0000-0000-0000-000000000008'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000001038');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000001039', 'Vital Proteins Plant-Based Multivitamin Complex - Edition 09', 'Engineered by Vital Proteins. The Plant-Based Multivitamin Complex comes equipped Grass-Fed & Pasture-Raised Hydrolyzed. Designed for superior performance, premium durability, and daily reliability.', 449.51, 64, 'https://images.unsplash.com/photo-1544367567-0f2fcb009e0b?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Health & Wellness' LIMIT 1), '10000000-0000-0000-0000-000000000008'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000001039');
INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '20000000-0000-0000-0000-000000001040', 'Therabody Compression Leg Recovery Boots - Edition 10', 'Engineered by Therabody. The Compression Leg Recovery Boots comes equipped FDA Cleared OLED Display. Designed for superior performance, premium durability, and daily reliability.', 446.0, 77, 'https://images.unsplash.com/photo-1579126038374-6064e9370f0f?auto=format&fit=crop&q=80&w=800', 
       COALESCE((SELECT id FROM categories WHERE name = 'Health & Wellness' LIMIT 1), '10000000-0000-0000-0000-000000000008'::uuid), 
       COALESCE((SELECT id FROM users WHERE email = 'merchant@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000020'::uuid), 
       CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '20000000-0000-0000-0000-000000001040');

-- 6. VERIFIED REVIEWS & RATINGS
INSERT INTO reviews (id, comment, rating, user_id, product_id, created_at)
SELECT '30000000-0000-0000-0000-000000000001', 'Outstanding product! Exceeded all my expectations. Build quality is top-notch.', 5, 
       COALESCE((SELECT id FROM users WHERE email = 'user@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000030'::uuid), 
       '20000000-0000-0000-0000-000000000001', CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM reviews WHERE id = '30000000-0000-0000-0000-000000000001');
INSERT INTO reviews (id, comment, rating, user_id, product_id, created_at)
SELECT '30000000-0000-0000-0000-000000000002', 'Very satisfied with the performance and design. Would definitely recommend to colleagues.', 5, 
       COALESCE((SELECT id FROM users WHERE email = 'user@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000030'::uuid), 
       '20000000-0000-0000-0000-000000000002', CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM reviews WHERE id = '30000000-0000-0000-0000-000000000002');
INSERT INTO reviews (id, comment, rating, user_id, product_id, created_at)
SELECT '30000000-0000-0000-0000-000000000003', 'Great value for money. Arrived on time and works flawlessly.', 4, 
       COALESCE((SELECT id FROM users WHERE email = 'user@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000030'::uuid), 
       '20000000-0000-0000-0000-000000000003', CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM reviews WHERE id = '30000000-0000-0000-0000-000000000003');
INSERT INTO reviews (id, comment, rating, user_id, product_id, created_at)
SELECT '30000000-0000-0000-0000-000000000004', 'Solid quality, premium packaging, and responsive customer service.', 5, 
       COALESCE((SELECT id FROM users WHERE email = 'user@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000030'::uuid), 
       '20000000-0000-0000-0000-000000000004', CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM reviews WHERE id = '30000000-0000-0000-0000-000000000004');
INSERT INTO reviews (id, comment, rating, user_id, product_id, created_at)
SELECT '30000000-0000-0000-0000-000000000005', 'Performs exactly as described in the specs. Sleek look and feel.', 4, 
       COALESCE((SELECT id FROM users WHERE email = 'user@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000030'::uuid), 
       '20000000-0000-0000-0000-000000000005', CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM reviews WHERE id = '30000000-0000-0000-0000-000000000005');
INSERT INTO reviews (id, comment, rating, user_id, product_id, created_at)
SELECT '30000000-0000-0000-0000-000000000006', 'Outstanding product! Exceeded all my expectations. Build quality is top-notch.', 5, 
       COALESCE((SELECT id FROM users WHERE email = 'user@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000030'::uuid), 
       '20000000-0000-0000-0000-000000000006', CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM reviews WHERE id = '30000000-0000-0000-0000-000000000006');
INSERT INTO reviews (id, comment, rating, user_id, product_id, created_at)
SELECT '30000000-0000-0000-0000-000000000007', 'Very satisfied with the performance and design. Would definitely recommend to colleagues.', 5, 
       COALESCE((SELECT id FROM users WHERE email = 'user@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000030'::uuid), 
       '20000000-0000-0000-0000-000000000007', CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM reviews WHERE id = '30000000-0000-0000-0000-000000000007');
INSERT INTO reviews (id, comment, rating, user_id, product_id, created_at)
SELECT '30000000-0000-0000-0000-000000000008', 'Great value for money. Arrived on time and works flawlessly.', 4, 
       COALESCE((SELECT id FROM users WHERE email = 'user@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000030'::uuid), 
       '20000000-0000-0000-0000-000000000008', CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM reviews WHERE id = '30000000-0000-0000-0000-000000000008');
INSERT INTO reviews (id, comment, rating, user_id, product_id, created_at)
SELECT '30000000-0000-0000-0000-000000000009', 'Solid quality, premium packaging, and responsive customer service.', 5, 
       COALESCE((SELECT id FROM users WHERE email = 'user@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000030'::uuid), 
       '20000000-0000-0000-0000-000000000009', CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM reviews WHERE id = '30000000-0000-0000-0000-000000000009');
INSERT INTO reviews (id, comment, rating, user_id, product_id, created_at)
SELECT '30000000-0000-0000-0000-000000000010', 'Performs exactly as described in the specs. Sleek look and feel.', 4, 
       COALESCE((SELECT id FROM users WHERE email = 'user@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000030'::uuid), 
       '20000000-0000-0000-0000-000000000010', CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM reviews WHERE id = '30000000-0000-0000-0000-000000000010');

-- 7. ORDERS & ORDER ITEMS
INSERT INTO orders (id, user_id, total_amount, status, shipping_address, order_date)
SELECT '40000000-0000-0000-0000-000000000001', 
       COALESCE((SELECT id FROM users WHERE email = 'user@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000030'::uuid), 
       429.98, 'DELIVERED', '124 Market Street, Suite 500, San Francisco, CA 94105', CURRENT_TIMESTAMP - INTERVAL '1 days'
WHERE NOT EXISTS (SELECT 1 FROM orders WHERE id = '40000000-0000-0000-0000-000000000001');
INSERT INTO order_items (id, order_id, product_id, quantity, price)
SELECT '50000000-0000-0000-0000-000000000001', '40000000-0000-0000-0000-000000000001', '20000000-0000-0000-0000-000000000001', 1, 299.99
WHERE NOT EXISTS (SELECT 1 FROM order_items WHERE id = '50000000-0000-0000-0000-000000000001');
INSERT INTO order_items (id, order_id, product_id, quantity, price)
SELECT '50000000-0000-0000-0000-000000000002', '40000000-0000-0000-0000-000000000001', '20000000-0000-0000-0000-000000000002', 1, 129.99
WHERE NOT EXISTS (SELECT 1 FROM order_items WHERE id = '50000000-0000-0000-0000-000000000002');
INSERT INTO orders (id, user_id, total_amount, status, shipping_address, order_date)
SELECT '40000000-0000-0000-0000-000000000002', 
       COALESCE((SELECT id FROM users WHERE email = 'user@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000030'::uuid), 
       189.5, 'SHIPPED', '789 Broadway Ave, Apt 14B, New York, NY 10003', CURRENT_TIMESTAMP - INTERVAL '4 days'
WHERE NOT EXISTS (SELECT 1 FROM orders WHERE id = '40000000-0000-0000-0000-000000000002');
INSERT INTO order_items (id, order_id, product_id, quantity, price)
SELECT '50000000-0000-0000-0000-000000000011', '40000000-0000-0000-0000-000000000002', '20000000-0000-0000-0000-000000000003', 1, 189.5
WHERE NOT EXISTS (SELECT 1 FROM order_items WHERE id = '50000000-0000-0000-0000-000000000011');
INSERT INTO orders (id, user_id, total_amount, status, shipping_address, order_date)
SELECT '40000000-0000-0000-0000-000000000003', 
       COALESCE((SELECT id FROM users WHERE email = 'user@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000030'::uuid), 
       599.0, 'PAID', '452 Ocean Drive, Miami Beach, FL 33139', CURRENT_TIMESTAMP - INTERVAL '7 days'
WHERE NOT EXISTS (SELECT 1 FROM orders WHERE id = '40000000-0000-0000-0000-000000000003');
INSERT INTO order_items (id, order_id, product_id, quantity, price)
SELECT '50000000-0000-0000-0000-000000000021', '40000000-0000-0000-0000-000000000003', '20000000-0000-0000-0000-000000000004', 1, 599.0
WHERE NOT EXISTS (SELECT 1 FROM order_items WHERE id = '50000000-0000-0000-0000-000000000021');
INSERT INTO orders (id, user_id, total_amount, status, shipping_address, order_date)
SELECT '40000000-0000-0000-0000-000000000004', 
       COALESCE((SELECT id FROM users WHERE email = 'user@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000030'::uuid), 
       89.99, 'PENDING', '101 Silicon Valley Way, San Jose, CA 95128', CURRENT_TIMESTAMP - INTERVAL '10 days'
WHERE NOT EXISTS (SELECT 1 FROM orders WHERE id = '40000000-0000-0000-0000-000000000004');
INSERT INTO order_items (id, order_id, product_id, quantity, price)
SELECT '50000000-0000-0000-0000-000000000031', '40000000-0000-0000-0000-000000000004', '20000000-0000-0000-0000-000000000005', 1, 89.99
WHERE NOT EXISTS (SELECT 1 FROM order_items WHERE id = '50000000-0000-0000-0000-000000000031');

-- 8. CUSTOMER ACTIVE CART (Ready for /cart and /checkout verification)
INSERT INTO carts (id, user_id, total_price)
SELECT '60000000-0000-0000-0000-000000000001', 
       COALESCE((SELECT id FROM users WHERE email = 'user@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000030'::uuid), 
       379.98
WHERE NOT EXISTS (SELECT 1 FROM carts WHERE user_id = COALESCE((SELECT id FROM users WHERE email = 'user@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000030'::uuid));
INSERT INTO cart_items (id, cart_id, product_id, quantity, price)
SELECT '70000000-0000-0000-0000-000000000001', '60000000-0000-0000-0000-000000000001', '20000000-0000-0000-0000-000000000001', 1, 299.99
WHERE NOT EXISTS (SELECT 1 FROM cart_items WHERE id = '70000000-0000-0000-0000-000000000001');
INSERT INTO cart_items (id, cart_id, product_id, quantity, price)
SELECT '70000000-0000-0000-0000-000000000002', '60000000-0000-0000-0000-000000000001', '20000000-0000-0000-0000-000000000006', 1, 79.99
WHERE NOT EXISTS (SELECT 1 FROM cart_items WHERE id = '70000000-0000-0000-0000-000000000002');

-- 9. CUSTOMER WISHLIST
INSERT INTO wishlists (id, user_id)
SELECT '80000000-0000-0000-0000-000000000001', 
       COALESCE((SELECT id FROM users WHERE email = 'user@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000030'::uuid)
WHERE NOT EXISTS (SELECT 1 FROM wishlists WHERE user_id = COALESCE((SELECT id FROM users WHERE email = 'user@gmail.com' LIMIT 1), '00000000-0000-0000-0000-000000000030'::uuid));
INSERT INTO wishlist_products (wishlist_id, product_id)
SELECT '80000000-0000-0000-0000-000000000001', '20000000-0000-0000-0000-000000000002'
WHERE NOT EXISTS (SELECT 1 FROM wishlist_products WHERE wishlist_id = '80000000-0000-0000-0000-000000000001' AND product_id = '20000000-0000-0000-0000-000000000002');
INSERT INTO wishlist_products (wishlist_id, product_id)
SELECT '80000000-0000-0000-0000-000000000001', '20000000-0000-0000-0000-000000000003'
WHERE NOT EXISTS (SELECT 1 FROM wishlist_products WHERE wishlist_id = '80000000-0000-0000-0000-000000000001' AND product_id = '20000000-0000-0000-0000-000000000003');
INSERT INTO wishlist_products (wishlist_id, product_id)
SELECT '80000000-0000-0000-0000-000000000001', '20000000-0000-0000-0000-000000000007'
WHERE NOT EXISTS (SELECT 1 FROM wishlist_products WHERE wishlist_id = '80000000-0000-0000-0000-000000000001' AND product_id = '20000000-0000-0000-0000-000000000007');

-- End of Seed Script
