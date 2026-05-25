CREATE TABLE inventories (
  item_name VARCHAR(255),
  brand VARCHAR(50),
  quantity INT,
  price DECIMAL(19, 2)
);

INSERT INTO inventories (item_name, brand, quantity, price) VALUES
('Wireless Bluetooth Headphones', 'Sony', 150, 79.99);

INSERT INTO inventories (item_name, brand, quantity, price) VALUES
('4K Ultra HD Smart TV', 'Samsung', 45, 899.99);

INSERT INTO inventories (item_name, brand, quantity, price) VALUES
('Stainless Steel Water Bottle', 'Hydro Flask', 200, 34.95);

INSERT INTO inventories (item_name, brand, quantity, price) VALUES
('Organic Green Tea Bags', 'Twinings', 500, 12.49);

INSERT INTO inventories (item_name, brand, quantity, price) VALUES
('Men''s Running Shoes', 'Nike', 120, 129.99);

INSERT INTO inventories (item_name, brand, quantity, price) VALUES
('Ergonomic Office Chair', 'Herman Miller', 30, 1295.00);

INSERT INTO inventories (item_name, brand, quantity, price) VALUES
('USB-C Charging Cable', 'Anker', 1000, 9.99);

INSERT INTO inventories (item_name, brand, quantity, price) VALUES
('Professional Chef Knife', 'Wusthof', 75, 189.00);

INSERT INTO inventories (item_name, brand, quantity, price) VALUES
('Yoga Mat (6mm)', 'Manduka', 85, 68.00);

INSERT INTO inventories (item_name, brand, quantity, price) VALUES
('Electric Toothbrush', 'Philips Sonicare', 110, 49.99);

INSERT INTO inventories (item_name, brand, quantity, price) VALUES
('Noise-Canceling Earbuds', 'Bose', 60, 279.99);

INSERT INTO inventories (item_name, brand, quantity, price) VALUES
('Cast Iron Skillet 12-inch', 'Lodge', 90, 39.99);

INSERT INTO inventories (item_name, brand, quantity, price) VALUES
('Organic Almond Butter (16oz)', 'Justin''s', 140, 11.99);

INSERT INTO inventories (item_name, brand, quantity, price) VALUES
('MacBook Pro 14-inch M3', 'Apple', 25, 1999.00);

INSERT INTO inventories (item_name, brand, quantity, price) VALUES
('French Press Coffee Maker', 'Bodum', 70, 29.95);

INSERT INTO inventories (item_name, brand, quantity, price) VALUES
('Winter Down Jacket', 'The North Face', 55, 249.00);

INSERT INTO inventories (item_name, brand, quantity, price) VALUES
('Smart Home Thermostat', 'Google Nest', 80, 129.99);

INSERT INTO inventories (item_name, brand, quantity, price) VALUES
('Protein Powder (2lb)', 'Optimum Nutrition', 300, 44.99);

INSERT INTO inventories (item_name, brand, quantity, price) VALUES
('Mechanical Gaming Keyboard', 'Logitech', 95, 149.99);

INSERT INTO inventories (item_name, brand, quantity, price) VALUES
('Vitamin D3 2000 IU (120 ct)', 'Nature Made', 250, 15.99);

select * from inventories;