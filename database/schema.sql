-- DeshDarshan – MySQL schema (run once on your server)
CREATE DATABASE IF NOT EXISTS deshdarshan CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE deshdarshan;

CREATE TABLE admin_users (
  admin_id INT AUTO_INCREMENT PRIMARY KEY,
  username VARCHAR(50) NOT NULL UNIQUE,
  password_hash VARCHAR(64) NOT NULL
);

CREATE TABLE state (
  state_id INT AUTO_INCREMENT PRIMARY KEY,
  state_name VARCHAR(100) NOT NULL,
  capital VARCHAR(100) NOT NULL,
  population VARCHAR(80),
  language VARCHAR(120),
  area VARCHAR(80),
  climate VARCHAR(120),
  description TEXT,
  image_url VARCHAR(500)
);

CREATE TABLE famous_places (
  place_id INT AUTO_INCREMENT PRIMARY KEY,
  state_id INT NOT NULL,
  place_name VARCHAR(200) NOT NULL,
  description TEXT,
  image_url VARCHAR(500),
  CONSTRAINT fk_fp_state FOREIGN KEY (state_id) REFERENCES state(state_id) ON DELETE CASCADE
);

CREATE TABLE hidden_places (
  place_id INT AUTO_INCREMENT PRIMARY KEY,
  state_id INT NOT NULL,
  place_name VARCHAR(200) NOT NULL,
  description TEXT,
  image_url VARCHAR(500),
  CONSTRAINT fk_hp_state FOREIGN KEY (state_id) REFERENCES state(state_id) ON DELETE CASCADE
);

CREATE TABLE famous_foods (
  food_id INT AUTO_INCREMENT PRIMARY KEY,
  state_id INT NOT NULL,
  food_name VARCHAR(200) NOT NULL,
  description TEXT,
  CONSTRAINT fk_ff_state FOREIGN KEY (state_id) REFERENCES state(state_id) ON DELETE CASCADE
);

-- Default admin: admin / admin123 (SHA-256 hex)
INSERT INTO admin_users (username, password_hash) VALUES
('admin', '240be518fabd2724ddb6f04eeb1da5967448d7e831c08c8fa822809f74c720a9');

INSERT INTO state (state_name, capital, population, language, area, climate, description, image_url) VALUES
('Uttar Pradesh', 'Lucknow', 'Approx. 24 crore', 'Hindi', '2,40,928 sq km', 'Varied; hot summers, cool winters',
 'Heartland of North India — Ganga plains, Mughal heritage, spiritual centres, and vibrant crafts.',
 'https://images.unsplash.com/photo-1564507592333-c60657eea523?w=800'),
('Maharashtra', 'Mumbai', 'Approx. 12 crore', 'Marathi', '3,07,713 sq km', 'Coastal & tropical to moderate',
 'Western state known for Bollywood, caves, hill stations, and Konkan coastline.',
 'https://images.unsplash.com/photo-1570168007204-dfb528c6958f?w=800'),
('Rajasthan', 'Jaipur', 'Approx. 8 crore', 'Hindi', '3,42,239 sq km', 'Arid; hot days, cooler nights',
 'Land of forts, Thar desert, folk music, and colourful festivals.',
 'https://images.unsplash.com/photo-1595658658481-df7e8a3c8a0a?w=800');

SET @up = (SELECT state_id FROM state WHERE state_name = 'Uttar Pradesh' LIMIT 1);
SET @mh = (SELECT state_id FROM state WHERE state_name = 'Maharashtra' LIMIT 1);
SET @rj = (SELECT state_id FROM state WHERE state_name = 'Rajasthan' LIMIT 1);

INSERT INTO famous_places (state_id, place_name, description, image_url) VALUES
(@up, 'Taj Mahal', 'Iconic marble mausoleum in Agra, UNESCO World Heritage Site.',
 'https://images.unsplash.com/photo-1564507592333-c60657eea523?w=600'),
(@mh, 'Gateway of India', 'Historic arch overlooking the Arabian Sea in Mumbai.',
 'https://images.unsplash.com/photo-1570168007204-dfb528c6958f?w=600'),
(@rj, 'Amer Fort', 'Hill fort near Jaipur with mirror palace and courtyards.',
 'https://images.unsplash.com/photo-1595658658481-df7e8a3c8a0a?w=600');

INSERT INTO hidden_places (state_id, place_name, description, image_url) VALUES
(@up, 'Chitrakoot', 'Forest-clad pilgrimage town with tranquil ghats and legends of Ramayana.',
 NULL),
(@mh, 'Kaas Plateau', 'Seasonal flower valley (UNESCO) near Satara — best after monsoon.',
 NULL),
(@rj, 'Bundi', 'Blue city with stepwells and murals, less crowded than Jaipur.',
 NULL);

INSERT INTO famous_foods (state_id, food_name, description) VALUES
(@up, 'Tunday Kababi & Awadhi Biryani', 'Lucknow''s melt-in-mouth kebabs and layered rice dishes.'),
(@mh, 'Vada Pav & Misal Pav', 'Mumbai street staples — spicy potato fritter in bun; sprouted curry.'),
(@rj, 'Dal Baati Churma', 'Baked wheat balls with lentil, ghee, and sweet crumbled wheat.');
