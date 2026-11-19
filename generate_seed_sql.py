#!/usr/bin/env python3
import random

# Deterministic IDs for consistency across restarts
ROLE_USER_ID = '00000000-0000-0000-0000-000000000001'
ROLE_SELLER_ID = '00000000-0000-0000-0000-000000000002'
ROLE_ADMIN_ID = '00000000-0000-0000-0000-000000000003'

ADMIN_USER_ID = '00000000-0000-0000-0000-000000000010'
MERCHANT_USER_ID = '00000000-0000-0000-0000-000000000020'
CUSTOMER_USER_ID = '00000000-0000-0000-0000-000000000030'

# Verified BCrypt hashes for requested passwords
# admin -> admin
# merchant -> merchant
# user -> user
ADMIN_PW_HASH = '$2a$10$7Qa7vw7iOeelmMUDBWeRQ./r2TcV6W3Y/e0Cc1BTGKstWztW.UYkq'
MERCHANT_PW_HASH = '$2a$10$unXhzQheuAChbfGttvzQve9/E3AbeMMJCm4ZTgLzjqsQ9mFZF/DgK'
USER_PW_HASH = '$2a$10$VBRLLpwug8c8twSEKpdHfe4aQFVVgeeQjIIYofjaoz2gd9Cjj5Rw6'

CATEGORIES = [
    {
        'id': '10000000-0000-0000-0000-000000000001',
        'name': 'Electronics',
        'desc': 'Smartphones, laptops, audio, wearables, and cutting-edge tech gadgets',
        'images': [
            'https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?auto=format&fit=crop&q=80&w=800',
            'https://images.unsplash.com/photo-1517336714731-489689fd1ca8?auto=format&fit=crop&q=80&w=800',
            'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?auto=format&fit=crop&q=80&w=800',
            'https://images.unsplash.com/photo-1546868871-7041f2a55e12?auto=format&fit=crop&q=80&w=800',
            'https://images.unsplash.com/photo-1523275335684-37898b6baf30?auto=format&fit=crop&q=80&w=800',
            'https://images.unsplash.com/photo-1583394838336-acd977736f90?auto=format&fit=crop&q=80&w=800',
            'https://images.unsplash.com/photo-1600080972464-8e5f35f63d08?auto=format&fit=crop&q=80&w=800',
            'https://images.unsplash.com/photo-1579586337278-3befd40fd17a?auto=format&fit=crop&q=80&w=800',
            'https://images.unsplash.com/photo-1608156639585-b3a032ef9689?auto=format&fit=crop&q=80&w=800',
            'https://images.unsplash.com/photo-1593642632823-8f785ba67e45?auto=format&fit=crop&q=80&w=800',
        ],
        'brands': ['Apple', 'Sony', 'Samsung', 'Dell', 'Logitech', 'Bose', 'Asus', 'Anker', 'Lenovo', 'LG', 'Sennheiser', 'Google', 'Razer', 'DJI', 'Xiaomi'],
        'types': ['Wireless Headphones', 'Pro Smartphone', 'Ultra Laptop', 'OLED Gaming Monitor', 'Smartwatch Series', 'Bluetooth Speaker', 'Mechanical Keyboard', '4K Webcam', 'ANC Earbuds', 'Fast Charger Dock', 'Mirrorless Camera', 'Drone Flycam', 'External SSD 2TB', 'Gaming Mouse', 'Tablet Pro'],
        'specs': ['with Active Noise Cancellation', 'M3 Max 32GB RAM Edition', '120Hz Fluid AMOLED Display', 'Spatial Audio & 40hr Battery', 'MagSafe Compatible', 'RGB Backlit Wireless', 'Titanium Frame Edition', 'Ultra-low Latency', 'Thunderbolt 4 Enabled', 'Waterproof IPX8 Rating', 'Custom EQ Acoustic Tuning', 'High-Res Audio Certified'],
        'price_range': (29.99, 1499.99)
    },
    {
        'id': '10000000-0000-0000-0000-000000000002',
        'name': 'Fashion',
        'desc': 'Premium apparel, designer shoes, luxury bags, and fashion accessories',
        'images': [
            'https://images.unsplash.com/photo-1521572267360-ee0c2909d518?auto=format&fit=crop&q=80&w=800',
            'https://images.unsplash.com/photo-1542291026-7eec264c27ff?auto=format&fit=crop&q=80&w=800',
            'https://images.unsplash.com/photo-1551028719-00167b16eac5?auto=format&fit=crop&q=80&w=800',
            'https://images.unsplash.com/photo-1576995853123-5a10305d93c0?auto=format&fit=crop&q=80&w=800',
            'https://images.unsplash.com/photo-1584917865442-de89df76afd3?auto=format&fit=crop&q=80&w=800',
            'https://images.unsplash.com/photo-1543163521-1bf539c55dd2?auto=format&fit=crop&q=80&w=800',
            'https://images.unsplash.com/photo-1608231387042-66d1773070a5?auto=format&fit=crop&q=80&w=800',
            'https://images.unsplash.com/photo-1591047139829-d91aecb6caea?auto=format&fit=crop&q=80&w=800',
            'https://images.unsplash.com/photo-1594938298603-c8148c4dae35?auto=format&fit=crop&q=80&w=800',
            'https://images.unsplash.com/photo-1509695503495-ac9986b51052?auto=format&fit=crop&q=80&w=800',
        ],
        'brands': ['Nike', 'Levi\'s', 'Adidas', 'Zara', 'Ralph Lauren', 'Tommy Hilfiger', 'Calvin Klein', 'Gucci', 'Uniqlo', 'Puma', 'Patagonia', 'Ray-Ban', 'Coach', 'Under Armour', 'The North Face'],
        'types': ['Classic Denim Jacket', 'Running Sneakers', 'Leather Crossbody Bag', 'Organic Cotton T-Shirt', 'Merino Wool Sweater', 'Tailored Chino Pants', 'Polarized Sunglasses', 'Silk Evening Scarf', 'Waterproof Parka', 'Canvas High-Top Shoes', 'Slim Fit Dress Shirt', 'Minimalist Chronograph Watch', 'Casual Chelsea Boots', 'Fleece Zip Hoodie', 'Puffer Winter Vest'],
        'specs': ['Vintage Indigo Wash', '100% Breathable Combed Cotton', 'Genuine Full-Grain Leather', 'Reflective Night Running Accents', 'All-Weather Thermal Lining', 'Hand-Crafted Italian Stitching', 'Anti-Crease Performance Fabric', 'UV400 Protection Lenses', 'Water-Repellent DWR Finish', 'Tailored Modern Silhouette'],
        'price_range': (19.99, 450.00)
    },
    {
        'id': '10000000-0000-0000-0000-000000000003',
        'name': 'Home & Living',
        'desc': 'Contemporary furniture, kitchen appliances, cookware, and modern home decor',
        'images': [
            'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?auto=format&fit=crop&q=80&w=800',
            'https://images.unsplash.com/photo-1583847268964-b28dc8f51f92?auto=format&fit=crop&q=80&w=800',
            'https://images.unsplash.com/photo-1513694203232-719a280e022f?auto=format&fit=crop&q=80&w=800',
            'https://images.unsplash.com/photo-1540574163026-643ea20ade25?auto=format&fit=crop&q=80&w=800',
            'https://images.unsplash.com/photo-1507473885765-e6ed057f782c?auto=format&fit=crop&q=80&w=800',
            'https://images.unsplash.com/photo-1586023492125-27b2c045efd7?auto=format&fit=crop&q=80&w=800',
            'https://images.unsplash.com/photo-1567016432779-094069958ea5?auto=format&fit=crop&q=80&w=800',
            'https://images.unsplash.com/photo-1513519245088-0e12902e5a38?auto=format&fit=crop&q=80&w=800',
            'https://images.unsplash.com/photo-1538688525198-9b88f6f53126?auto=format&fit=crop&q=80&w=800',
            'https://images.unsplash.com/photo-1544816155-12df9643f363?auto=format&fit=crop&q=80&w=800',
        ],
        'brands': ['IKEA', 'Breville', 'Dyson', 'KitchenAid', 'Philips', 'West Elm', 'Nespresso', 'Le Creuset', 'Cuisinart', 'Herman Miller', 'Castlery', 'Lodge', 'Ninja', 'Smeg', 'MUJI'],
        'types': ['Barista Espresso Machine', 'Ergonomic Desk Chair', 'Cast Iron Dutch Oven', 'Cordless Vacuum Cleaner', 'Smart LED Floor Lamp', 'Ceramic Dinnerware Set', 'Memory Foam Pillow', 'Aromatherapy Diffuser', 'Air Fryer Convection Oven', 'Walnut Coffee Table', 'Linen Bedding Sheet Set', 'Stainless Steel Cookware', 'Automatic Milk Frother', 'Velvet Accent Armchair', 'Electric Kettle with Temp Control'],
        'specs': ['15-Bar High Pressure Extraction', 'Solid Scandinavian Oak Legs', 'Enamelled Non-Stick Coating', 'HEPA Filtration System', 'Dimmer Touch & App Control', 'Handmade Artisan Stoneware', 'Cooling Gel Infused Core', 'Whisper-Quiet Ultrasonic Mode', 'Pre-Seasoned Heavy Duty', 'Dishwasher Safe & PFOA-Free'],
        'price_range': (24.99, 899.00)
    },
    {
        'id': '10000000-0000-0000-0000-000000000004',
        'name': 'Beauty & Personal Care',
        'desc': 'Skincare essentials, luxury fragrances, haircare, and wellness products',
        'images': [
            'https://images.unsplash.com/photo-1522337360788-8b13dee7a37e?auto=format&fit=crop&q=80&w=800',
            'https://images.unsplash.com/photo-1571781926291-c477ebfd024b?auto=format&fit=crop&q=80&w=800',
            'https://images.unsplash.com/photo-1598440947619-2c35fc9aa908?auto=format&fit=crop&q=80&w=800',
            'https://images.unsplash.com/photo-1535585209827-a15fcdbc4c2d?auto=format&fit=crop&q=80&w=800',
            'https://images.unsplash.com/photo-1527799820374-dcf8d9d4a388?auto=format&fit=crop&q=80&w=800',
            'https://images.unsplash.com/photo-1617897903246-719242758050?auto=format&fit=crop&q=80&w=800',
            'https://images.unsplash.com/photo-1556228720-195a672e8a03?auto=format&fit=crop&q=80&w=800',
            'https://images.unsplash.com/photo-1585238342024-78d387f4a707?auto=format&fit=crop&q=80&w=800',
            'https://images.unsplash.com/photo-1608248597359-597495085e68?auto=format&fit=crop&q=80&w=800',
            'https://images.unsplash.com/photo-1512496015851-a90fb38ba796?auto=format&fit=crop&q=80&w=800',
        ],
        'brands': ['Chanel', 'The Ordinary', 'Dior', 'Kiehl\'s', 'Aesop', 'La Mer', 'Olaplex', 'Estée Lauder', 'Glossier', 'Fenty Beauty', 'CeraVe', 'L\'Occitane', 'Laneige', 'Paula\'s Choice', 'Drunk Elephant'],
        'types': ['Hyaluronic Acid Hydrating Serum', 'Eau de Parfum Spray', 'Restorative Hair Mask', 'Revitalizing Face Cleanser', 'Botanical Body Wash', 'Niacinamide Glow Tonic', 'Anti-Aging Night Cream', 'Lip Sleeping Mask', 'Velvet Matte Lipstick', 'Hydrating Mineral Sunscreen', 'Exfoliating BHA Liquid', 'Shea Butter Hand Balm', 'Peptide Eye Repair Gel', 'Deep Conditioning Hair Oil', 'Bamboo Charcoal Clay Mask'],
        'specs': ['Formulated with 2% Pure Hyaluronic Acid', 'Long-Lasting 12-Hour Fragrance', 'Bond Building Repair Formula', 'Sulfate-Free & Fragrance-Free', 'Enriched with Vitamin C & E', 'Broad Spectrum SPF 50+', 'Cruelty-Free & 100% Vegan', 'Dermatologist Tested for Sensitive Skin', 'Intense Overnight Hydration', 'Naturally Derived Organic Botanicals'],
        'price_range': (12.99, 280.00)
    },
    {
        'id': '10000000-0000-0000-0000-000000000005',
        'name': 'Sports & Outdoors',
        'desc': 'Fitness equipment, athletic gear, outdoor recreation, and sports accessories',
        'images': [
            'https://images.unsplash.com/photo-1517838277536-f5f99be501cd?auto=format&fit=crop&q=80&w=800',
            'https://images.unsplash.com/photo-1584735935682-2f2b69dff9d2?auto=format&fit=crop&q=80&w=800',
            'https://images.unsplash.com/photo-1574680096145-d05b474e2155?auto=format&fit=crop&q=80&w=800',
            'https://images.unsplash.com/photo-1517649763962-0c623266ddc0?auto=format&fit=crop&q=80&w=800',
            'https://images.unsplash.com/photo-1534438327276-14e5300c3a48?auto=format&fit=crop&q=80&w=800',
            'https://images.unsplash.com/photo-1540497077202-7c8a3999166f?auto=format&fit=crop&q=80&w=800',
            'https://images.unsplash.com/photo-1518611012118-696072aa579a?auto=format&fit=crop&q=80&w=800',
            'https://images.unsplash.com/photo-1526506118085-60ce8714f8c5?auto=format&fit=crop&q=80&w=800',
            'https://images.unsplash.com/photo-1461896836934-ffe607ba8211?auto=format&fit=crop&q=80&w=800',
            'https://images.unsplash.com/photo-1519505907962-0a6cb0167c73?auto=format&fit=crop&q=80&w=800',
        ],
        'brands': ['Bowflex', 'Lululemon', 'Garmin', 'Hydro Flask', 'Theragun', 'Wilson', 'Salomon', 'Shimano', 'Black Diamond', 'YETI', 'Manduka', 'Osprey', 'Peloton', 'Rogue Fitness', 'Callaway'],
        'types': ['Adjustable Dumbbell Set', 'Non-Slip Pro Yoga Mat', 'GPS Multisport Fitness Watch', 'Insulated Stainless Water Bottle', 'Percussive Massage Gun', 'Backcountry Hiking Backpack', 'All-Weather Camping Tent', 'Trail Running Shoes', 'Resistance Loop Bands Set', 'Carbon Fiber Road Bike Helmet', 'Competition Basketball', 'Titanium Trekking Poles', 'Thermal Insulated Cooler 35L', 'Speed Jump Rope with Ball Bearings', 'Golf Driver Carbonwood'],
        'specs': ['5-52.5 lbs Quick Select Dial', '6mm High Density Eco-TPE Cushion', 'Heart Rate & Pulse Ox Sensor', 'Keeps Cold 24hrs / Hot 12hrs', 'Ultra-Quiet 5-Speed Motor', 'Waterproof Ripstop Nylon Fabric', 'Ergonomic Breathable Mesh Backing', 'Aerodynamic Ultra-Lightweight Shell', 'Non-Tangle Steel Cable Core', 'Heavy-Duty Double-Wall Insulation'],
        'price_range': (15.99, 699.00)
    },
    {
        'id': '10000000-0000-0000-0000-000000000006',
        'name': 'Books & Stationery',
        'desc': 'Bestsellers, technical manuals, productivity journals, and executive stationery',
        'images': [
            'https://images.unsplash.com/photo-1544716278-ca5e3f4abd8c?auto=format&fit=crop&q=80&w=800',
            'https://images.unsplash.com/photo-1512820790803-83ca734da794?auto=format&fit=crop&q=80&w=800',
            'https://images.unsplash.com/photo-1497633762265-9d179a990aa6?auto=format&fit=crop&q=80&w=800',
            'https://images.unsplash.com/photo-1589829085413-56de8ae18c73?auto=format&fit=crop&q=80&w=800',
            'https://images.unsplash.com/photo-1543002588-bfa74002ed7e?auto=format&fit=crop&q=80&w=800',
            'https://images.unsplash.com/photo-1506880018603-83d5b814b5a6?auto=format&fit=crop&q=80&w=800',
            'https://images.unsplash.com/photo-1585776245991-cf89dd7fc73a?auto=format&fit=crop&q=80&w=800',
            'https://images.unsplash.com/photo-1532012164546-f432f2e3777f?auto=format&fit=crop&q=80&w=800',
            'https://images.unsplash.com/photo-1457369804613-52c61a468e7d?auto=format&fit=crop&q=80&w=800',
            'https://images.unsplash.com/photo-1476275466078-4007374efbbe?auto=format&fit=crop&q=80&w=800',
        ],
        'brands': ['Moleskine', 'O\'Reilly', 'Penguin Classics', 'Lamy', 'Leuchtturm1917', 'Parker', 'Rhodia', 'Faber-Castell', 'Harvard Business Review', 'Oxford', 'Midori', 'Pilot', 'Kaweco', 'Chronicle Books', 'Cambridge'],
        'types': ['Hardcover Dotted Journal', 'Designing Data-Intensive Applications', 'Fountain Pen Fine Nib', 'Architect Mechanical Pencil', 'Productivity Daily Planner', 'Clean Code Handbook', 'Calligraphy Brush Pen Set', 'Leather Bound Sketchbook', 'Executive Rollerball Pen', 'Noise-Cancelling Book Stand', 'Atomic Habits Guide', 'Graphite Sketching Pencil Set 12x', 'Self-Healing Cutting Mat', 'Wax Seal Stamp Kit', 'Modern Typography Workbook'],
        'specs': ['120gsm Ink-Proof Acid-Free Paper', 'Comprehensive Engineering Edition', 'Hand-Polished Stainless Steel Nib', 'Numbered Pages with Gusseted Pocket', 'Refillable Archival Black Ink', 'Lay-Flat 180 Degree Binding', 'Smooth Japanese Precision Tip', 'Gold Foil Edge Lettering', 'Durable Water-Resistant Hardcover', 'Includes 2 Ribbon Page Markers'],
        'price_range': (9.99, 120.00)
    },
    {
        'id': '10000000-0000-0000-0000-000000000007',
        'name': 'Toys & Gaming',
        'desc': 'Gaming accessories, consoles, collectibles, and interactive toys',
        'images': [
            'https://images.unsplash.com/photo-1607604276583-eef5d076aa5f?auto=format&fit=crop&q=80&w=800',
            'https://images.unsplash.com/photo-1550745165-9bc0b252726f?auto=format&fit=crop&q=80&w=800',
            'https://images.unsplash.com/photo-1612287232230-6869408212e3?auto=format&fit=crop&q=80&w=800',
            'https://images.unsplash.com/photo-1563089145-599997674d42?auto=format&fit=crop&q=80&w=800',
            'https://images.unsplash.com/photo-1606144042614-b2417e99c4e3?auto=format&fit=crop&q=80&w=800',
            'https://images.unsplash.com/photo-1592840496694-26d035b52b48?auto=format&fit=crop&q=80&w=800',
            'https://images.unsplash.com/photo-1587202372775-e229f172b9d7?auto=format&fit=crop&q=80&w=800',
            'https://images.unsplash.com/photo-1579373903781-fd5c0c30c4cd?auto=format&fit=crop&q=80&w=800',
            'https://images.unsplash.com/photo-1534423861386-85a16f5d13fd?auto=format&fit=crop&q=80&w=800',
            'https://images.unsplash.com/photo-1511512578047-dfb367046420?auto=format&fit=crop&q=80&w=800',
        ],
        'brands': ['PlayStation', 'Nintendo', 'LEGO', 'Xbox', 'Hasbro', 'Razer', 'SteelSeries', 'Bandai', 'Hot Wheels', 'Funko', 'Corsair', 'Mattel', 'Logitech G', 'Oculus', 'HyperX'],
        'types': ['Wireless Haptic Game Controller', 'Technic Supercar Building Kit', '7.1 Surround Gaming Headset', 'Handheld Gaming Console OLED', 'RGB Mousepad Extended', 'Collectible Vinyl Figure', 'Mechanical Gaming Keypad', 'Modular Board Game Strategy', 'High-Speed Remote Control Stunt Car', 'Streaming Microphone with Arm', 'Custom Arcade Fight Stick', 'VR Headset All-in-One', 'Precision Flight Simulator Joystick', 'Magnetic Levitating Display Base', 'Gamer Ergonomic Footrest'],
        'specs': ['Adaptive Triggers & Force Feedback', '3,599 Precision Engineered Pieces', '50mm Neodymium Audio Drivers', '7-inch Vibrant Multi-Touch Display', 'Ultra-Fast 2.4GHz Slipstream Wireless', 'Detachable Noise-Filtering Boom Mic', 'Fully Programmable Macro Keys', '30-Hour Rechargeable Battery Life', 'High-Speed 45km/h Brushless Motor', 'Universal PC / Console Compatibility'],
        'price_range': (19.99, 499.00)
    },
    {
        'id': '10000000-0000-0000-0000-000000000008',
        'name': 'Health & Wellness',
        'desc': 'Organic supplements, posture correctors, massage equipment, and monitoring tools',
        'images': [
            'https://images.unsplash.com/photo-1505751172876-fa1923c5c528?auto=format&fit=crop&q=80&w=800',
            'https://images.unsplash.com/photo-1544367567-0f2fcb009e0b?auto=format&fit=crop&q=80&w=800',
            'https://images.unsplash.com/photo-1584308666744-24d5c474f2ae?auto=format&fit=crop&q=80&w=800',
            'https://images.unsplash.com/photo-1576091160550-2173dba999ef?auto=format&fit=crop&q=80&w=800',
            'https://images.unsplash.com/photo-1579126038374-6064e9370f0f?auto=format&fit=crop&q=80&w=800',
            'https://images.unsplash.com/photo-1540555700478-4be289fbecef?auto=format&fit=crop&q=80&w=800',
            'https://images.unsplash.com/photo-1616671285442-12797e8876e5?auto=format&fit=crop&q=80&w=800',
            'https://images.unsplash.com/photo-1527613426441-4da17471b66d?auto=format&fit=crop&q=80&w=800',
            'https://images.unsplash.com/photo-1512069772995-ec65ed45afd6?auto=format&fit=crop&q=80&w=800',
            'https://images.unsplash.com/photo-1506126613408-eca07ce68773?auto=format&fit=crop&q=80&w=800',
        ],
        'brands': ['Omron', 'Optimum Nutrition', 'Withings', 'Fitbit', 'Garden of Life', 'Nordic Naturals', 'Beurer', 'Nature Made', 'Vital Proteins', 'Therabody', 'Renpho', 'Hyperice', 'NOW Foods', 'Pure Encapsulations', 'Thorne'],
        'types': ['Digital Arm Blood Pressure Monitor', 'Gold Standard 100% Whey Protein 5lb', 'Smart Wi-Fi Body Composition Scale', 'Organic Omega-3 Fish Oil Softgels', 'Heated Shiatsu Neck Massager', 'Collagen Peptides Powder 20oz', 'Smart Pulse Oximeter Finger Sensor', 'Ergonomic Memory Foam Lumbar Support', 'Plant-Based Multivitamin Complex', 'Compression Leg Recovery Boots', 'Electric Heating Pad for Back Pain', 'Melatonin Sleep Support Gummies 90ct', 'Air Purifier with True HEPA Filter', 'Deep Tissue Foam Roller 36-inch', 'Vibrating Massage Ball Mobility Tool'],
        'specs': ['Clinically Validated Dual Sensor Precision', '24g Protein & 5.5g BCAAs per Serving', 'Measures Weight, Body Fat%, Heart Rate', 'Molecularly Distilled EPA & DHA', 'Infrared Soothing Heat Therapy Function', 'Grass-Fed & Pasture-Raised Hydrolyzed', 'FDA Cleared OLED Display', 'Zero Artificial Sugars & Non-GMO', 'Medical-Grade Intermittent Compression', 'Ultra-Quiet 24dB Sleep Mode Filtration'],
        'price_range': (14.99, 450.00)
    }
]

def make_uuid(prefix_char, index):
    # Generates format like: 'a0000000-0000-0000-0000-000000000001'
    idx_str = str(index).zfill(12)
    return f"{prefix_char}0000000-0000-0000-0000-{idx_str}"

def escape_sql(text):
    return text.replace("'", "''")

def generate():
    sql = []
    sql.append("-- ===========================================================================")
    sql.append("-- SHOPSTACK PRO: ENTERPRISE DATA SEED SCRIPT (1,000+ PRODUCTS + ROLES & USERS)")
    sql.append("-- Generated with realistic accounts for Admin, Merchant, Customer")
    sql.append("-- ===========================================================================\n")

    # 1. ROLES
    sql.append("-- 1. ROLES")
    sql.append(f"INSERT INTO roles (id, name) SELECT '{ROLE_USER_ID}', 'ROLE_USER' WHERE NOT EXISTS (SELECT 1 FROM roles WHERE name = 'ROLE_USER');")
    sql.append(f"INSERT INTO roles (id, name) SELECT '{ROLE_SELLER_ID}', 'ROLE_SELLER' WHERE NOT EXISTS (SELECT 1 FROM roles WHERE name = 'ROLE_SELLER');")
    sql.append(f"INSERT INTO roles (id, name) SELECT '{ROLE_ADMIN_ID}', 'ROLE_ADMIN' WHERE NOT EXISTS (SELECT 1 FROM roles WHERE name = 'ROLE_ADMIN');\n")

    # 2. USERS
    sql.append("-- 2. USERS (admin@gmail.com, merchant@gmail.com, user@gmail.com)")
    
    # Admin User
    sql.append(f"""INSERT INTO users (id, username, email, password, is_active, profile_image_url, created_at, updated_at)
SELECT '{ADMIN_USER_ID}', 'admin', 'admin@gmail.com', '{ADMIN_PW_HASH}', true, 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&q=80&w=200', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM users WHERE email = 'admin@gmail.com');""")

    # Merchant User
    sql.append(f"""INSERT INTO users (id, username, email, password, is_active, profile_image_url, created_at, updated_at)
SELECT '{MERCHANT_USER_ID}', 'merchant', 'merchant@gmail.com', '{MERCHANT_PW_HASH}', true, 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&q=80&w=200', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM users WHERE email = 'merchant@gmail.com');""")

    # Customer User
    sql.append(f"""INSERT INTO users (id, username, email, password, is_active, profile_image_url, created_at, updated_at)
SELECT '{CUSTOMER_USER_ID}', 'user', 'user@gmail.com', '{USER_PW_HASH}', true, 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?auto=format&fit=crop&q=80&w=200', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM users WHERE email = 'user@gmail.com');\n""")

    # 3. USER_ROLES
    sql.append("-- 3. USER_ROLES")
    # Admin gets ROLE_ADMIN + ROLE_USER
    sql.append(f"INSERT INTO user_roles (user_id, role_id) SELECT '{ADMIN_USER_ID}', '{ROLE_ADMIN_ID}' WHERE NOT EXISTS (SELECT 1 FROM user_roles WHERE user_id = '{ADMIN_USER_ID}' AND role_id = '{ROLE_ADMIN_ID}');")
    sql.append(f"INSERT INTO user_roles (user_id, role_id) SELECT '{ADMIN_USER_ID}', '{ROLE_USER_ID}' WHERE NOT EXISTS (SELECT 1 FROM user_roles WHERE user_id = '{ADMIN_USER_ID}' AND role_id = '{ROLE_USER_ID}');")
    
    # Merchant gets ROLE_SELLER + ROLE_USER
    sql.append(f"INSERT INTO user_roles (user_id, role_id) SELECT '{MERCHANT_USER_ID}', '{ROLE_SELLER_ID}' WHERE NOT EXISTS (SELECT 1 FROM user_roles WHERE user_id = '{MERCHANT_USER_ID}' AND role_id = '{ROLE_SELLER_ID}');")
    sql.append(f"INSERT INTO user_roles (user_id, role_id) SELECT '{MERCHANT_USER_ID}', '{ROLE_USER_ID}' WHERE NOT EXISTS (SELECT 1 FROM user_roles WHERE user_id = '{MERCHANT_USER_ID}' AND role_id = '{ROLE_USER_ID}');")

    # Customer gets ROLE_USER
    sql.append(f"INSERT INTO user_roles (user_id, role_id) SELECT '{CUSTOMER_USER_ID}', '{ROLE_USER_ID}' WHERE NOT EXISTS (SELECT 1 FROM user_roles WHERE user_id = '{CUSTOMER_USER_ID}' AND role_id = '{ROLE_USER_ID}');\n")

    # 4. CATEGORIES
    sql.append("-- 4. CATEGORIES")
    for cat in CATEGORIES:
        sql.append(f"""INSERT INTO categories (id, name, description)
SELECT '{cat['id']}', '{escape_sql(cat['name'])}', '{escape_sql(cat['desc'])}'
WHERE NOT EXISTS (SELECT 1 FROM categories WHERE id = '{cat['id']}');""")
    sql.append("")

    # 5. PRODUCTS (At least 1,000 products: 130 per category * 8 categories = 1,040 products)
    sql.append("-- 5. PRODUCTS (1,040 Realistically Categorized Items)")
    product_counter = 1
    sample_product_ids = []

    for cat_idx, cat in enumerate(CATEGORIES):
        cat_id = cat['id']
        brands = cat['brands']
        types = cat['types']
        specs = cat['specs']
        images = cat['images']
        p_min, p_max = cat['price_range']

        # 130 products per category
        for i in range(130):
            prod_id = make_uuid('2', product_counter)
            if product_counter <= 20:
                sample_product_ids.append(prod_id)

            brand = brands[i % len(brands)]
            ptype = types[(i * 3 + cat_idx) % len(types)]
            spec = specs[(i * 2 + cat_idx) % len(specs)]
            img = images[i % len(images)]

            name = f"{brand} {ptype} - Edition {((i % 7) + 1):02d}"
            desc = f"Engineered by {brand}. The {ptype} comes equipped {spec}. Designed for superior performance, premium durability, and daily reliability."
            
            # Deterministic price calculation
            base_price = p_min + ((p_max - p_min) * ((i * 17 + 23) % 100) / 100.0)
            price = round(base_price, 2)
            
            # Stock: few low stocks (2-5) for merchant low-stock alert testing, rest 15-200
            if i % 25 == 0:
                stock = random.choice([2, 3, 4, 5])
            else:
                stock = 15 + ((i * 13) % 180)

            sql.append(f"""INSERT INTO products (id, name, description, price, stock_quantity, image_url, category_id, seller_id, created_at, updated_at)
SELECT '{prod_id}', '{escape_sql(name)}', '{escape_sql(desc)}', {price}, {stock}, '{img}', '{cat_id}', '{MERCHANT_USER_ID}', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM products WHERE id = '{prod_id}');""")

            product_counter += 1

    sql.append(f"\n-- Total Products Seeded: {product_counter - 1}\n")

    # 6. REVIEWS (Sample ratings & reviews for top products)
    sql.append("-- 6. PRODUCT REVIEWS (For Customer Feedback & Rating Demonstration)")
    reviews_data = [
        ("Outstanding product! Exceeded all my expectations. Build quality is top-notch.", 5),
        ("Very satisfied with the performance and design. Would definitely recommend to colleagues.", 5),
        ("Great value for money. Arrived on time and works flawlessly.", 4),
        ("Solid quality, premium packaging, and responsive customer service.", 5),
        ("Performs exactly as described in the specs. Sleek look and feel.", 4),
    ]

    for r_idx, p_id in enumerate(sample_product_ids[:10]):
        rev_id = make_uuid('3', r_idx + 1)
        comment, rating = reviews_data[r_idx % len(reviews_data)]
        sql.append(f"""INSERT INTO reviews (id, comment, rating, user_id, product_id, created_at)
SELECT '{rev_id}', '{escape_sql(comment)}', {rating}, '{CUSTOMER_USER_ID}', '{p_id}', CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM reviews WHERE id = '{rev_id}');""")

    sql.append("")

    # 7. SAMPLE ORDERS (For customer history, merchant fulfillment, and admin dashboard)
    sql.append("-- 7. ORDERS & ORDER ITEMS")
    orders_spec = [
        ('DELIVERED', '124 Market Street, Suite 500, San Francisco, CA 94105', 429.98, [
            (sample_product_ids[0], 1, 299.99),
            (sample_product_ids[1], 1, 129.99),
        ]),
        ('SHIPPED', '789 Broadway Ave, Apt 14B, New York, NY 10003', 189.50, [
            (sample_product_ids[2], 1, 189.50),
        ]),
        ('PAID', '452 Ocean Drive, Miami Beach, FL 33139', 599.00, [
            (sample_product_ids[3], 1, 599.00),
        ]),
        ('PENDING', '101 Silicon Valley Way, San Jose, CA 95128', 89.99, [
            (sample_product_ids[4], 1, 89.99),
        ]),
    ]

    for o_idx, (status, addr, total, items) in enumerate(orders_spec):
        order_id = make_uuid('4', o_idx + 1)
        sql.append(f"""INSERT INTO orders (id, user_id, total_amount, status, shipping_address, order_date)
SELECT '{order_id}', '{CUSTOMER_USER_ID}', {total}, '{status}', '{escape_sql(addr)}', CURRENT_TIMESTAMP - INTERVAL '{o_idx * 3 + 1} days'
WHERE NOT EXISTS (SELECT 1 FROM orders WHERE id = '{order_id}');""")

        for it_idx, (p_id, qty, price) in enumerate(items):
            item_id = make_uuid('5', (o_idx * 10) + it_idx + 1)
            sql.append(f"""INSERT INTO order_items (id, order_id, product_id, quantity, price)
SELECT '{item_id}', '{order_id}', '{p_id}', {qty}, {price}
WHERE NOT EXISTS (SELECT 1 FROM order_items WHERE id = '{item_id}');""")

    sql.append("")

    # 8. ACTIVE CUSTOMER CART (Items ready in user cart for instant checkout testing)
    sql.append("-- 8. CUSTOMER ACTIVE CART (Ready for /cart and /checkout verification)")
    cart_id = make_uuid('6', 1)
    c_p1 = sample_product_ids[0]
    c_p2 = sample_product_ids[5]
    cart_total = 299.99 + 79.99

    sql.append(f"""INSERT INTO carts (id, user_id, total_price)
SELECT '{cart_id}', '{CUSTOMER_USER_ID}', {cart_total}
WHERE NOT EXISTS (SELECT 1 FROM carts WHERE user_id = '{CUSTOMER_USER_ID}');""")

    c_item1 = make_uuid('7', 1)
    c_item2 = make_uuid('7', 2)

    sql.append(f"""INSERT INTO cart_items (id, cart_id, product_id, quantity, price)
SELECT '{c_item1}', '{cart_id}', '{c_p1}', 1, 299.99
WHERE NOT EXISTS (SELECT 1 FROM cart_items WHERE id = '{c_item1}');""")

    sql.append(f"""INSERT INTO cart_items (id, cart_id, product_id, quantity, price)
SELECT '{c_item2}', '{cart_id}', '{c_p2}', 1, 79.99
WHERE NOT EXISTS (SELECT 1 FROM cart_items WHERE id = '{c_item2}');\n""")

    # 9. CUSTOMER WISHLIST (Saved items for /wishlist testing)
    sql.append("-- 9. CUSTOMER WISHLIST")
    wishlist_id = make_uuid('8', 1)
    sql.append(f"""INSERT INTO wishlists (id, user_id)
SELECT '{wishlist_id}', '{CUSTOMER_USER_ID}'
WHERE NOT EXISTS (SELECT 1 FROM wishlists WHERE user_id = '{CUSTOMER_USER_ID}');""")

    for w_idx in [1, 2, 6]:
        p_id = sample_product_ids[w_idx]
        sql.append(f"""INSERT INTO wishlist_products (wishlist_id, product_id)
SELECT '{wishlist_id}', '{p_id}'
WHERE NOT EXISTS (SELECT 1 FROM wishlist_products WHERE wishlist_id = '{wishlist_id}' AND product_id = '{p_id}');""")

    sql.append("\n-- End of Seed Script\n")
    return "\n".join(sql)

if __name__ == '__main__':
    content = generate()
    with open('backend/src/main/resources/data.sql', 'w') as f:
        f.write(content)
    with open('seed_data.sql', 'w') as f:
        f.write(content)
    print("Successfully generated 1,040 products and full seed ecosystem into:")
    print(" - backend/src/main/resources/data.sql")
    print(" - seed_data.sql")
