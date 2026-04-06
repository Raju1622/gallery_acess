-- =======================================================
-- TOUR & TRAVELS WEBSITE - Complete Database Schema
-- Technology Stack: HTML, CSS, JS, jQuery, Bootstrap, JSP, Servlet, MySQL
-- =======================================================

CREATE DATABASE IF NOT EXISTS tour_travels CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE tour_travels;

-- =====================================================
-- ADMIN USERS TABLE
-- =====================================================
CREATE TABLE admin_users (
  admin_id INT AUTO_INCREMENT PRIMARY KEY,
  username VARCHAR(50) NOT NULL UNIQUE,
  password_hash VARCHAR(64) NOT NULL,
  full_name VARCHAR(100) NOT NULL,
  email VARCHAR(100),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

-- =====================================================
-- PACKAGE CATEGORIES TABLE
-- =====================================================
CREATE TABLE package_categories (
  category_id INT AUTO_INCREMENT PRIMARY KEY,
  category_name VARCHAR(100) NOT NULL UNIQUE,
  description TEXT,
  icon VARCHAR(50)
) ENGINE=InnoDB;

-- =====================================================
-- TOUR PACKAGES TABLE
-- =====================================================
CREATE TABLE tour_packages (
  package_id INT AUTO_INCREMENT PRIMARY KEY,
  category_id INT NOT NULL,
  package_name VARCHAR(200) NOT NULL,
  destination VARCHAR(200) NOT NULL,
  duration_days INT NOT NULL,
  duration_nights INT NOT NULL,
  price DECIMAL(10,2) NOT NULL,
  description TEXT,
  highlights TEXT,
  inclusions TEXT,
  exclusions TEXT,
  image_url VARCHAR(500),
  rating DECIMAL(3,2) DEFAULT 0.00,
  total_reviews INT DEFAULT 0,
  is_featured BOOLEAN DEFAULT FALSE,
  is_active BOOLEAN DEFAULT TRUE,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_package_category FOREIGN KEY (category_id) REFERENCES package_categories(category_id)
) ENGINE=InnoDB;

-- =====================================================
-- PACKAGE ITINERARY TABLE
-- =====================================================
CREATE TABLE package_itinerary (
  itinerary_id INT AUTO_INCREMENT PRIMARY KEY,
  package_id INT NOT NULL,
  day_number INT NOT NULL,
  title VARCHAR(200) NOT NULL,
  description TEXT,
  activities TEXT,
  meals_included VARCHAR(100),
  CONSTRAINT fk_itinerary_package FOREIGN KEY (package_id) REFERENCES tour_packages(package_id) ON DELETE CASCADE
) ENGINE=InnoDB;

-- =====================================================
-- PACKAGE HOTELS TABLE
-- =====================================================
CREATE TABLE package_hotels (
  hotel_id INT AUTO_INCREMENT PRIMARY KEY,
  package_id INT NOT NULL,
  hotel_name VARCHAR(200) NOT NULL,
  location VARCHAR(200),
  star_rating INT,
  amenities TEXT,
  CONSTRAINT fk_hotel_package FOREIGN KEY (package_id) REFERENCES tour_packages(package_id) ON DELETE CASCADE
) ENGINE=InnoDB;

-- =====================================================
-- CUSTOMERS TABLE
-- =====================================================
CREATE TABLE customers (
  customer_id INT AUTO_INCREMENT PRIMARY KEY,
  full_name VARCHAR(100) NOT NULL,
  email VARCHAR(100) NOT NULL UNIQUE,
  phone VARCHAR(20) NOT NULL,
  address TEXT,
  city VARCHAR(100),
  state VARCHAR(100),
  country VARCHAR(100) DEFAULT 'India',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

-- =====================================================
-- BOOKINGS TABLE
-- =====================================================
CREATE TABLE bookings (
  booking_id INT AUTO_INCREMENT PRIMARY KEY,
  package_id INT NOT NULL,
  customer_id INT NOT NULL,
  booking_date DATE NOT NULL,
  travel_date DATE NOT NULL,
  num_adults INT NOT NULL DEFAULT 1,
  num_children INT DEFAULT 0,
  total_amount DECIMAL(10,2) NOT NULL,
  payment_status ENUM('pending', 'paid', 'cancelled') DEFAULT 'pending',
  booking_status ENUM('confirmed', 'pending', 'cancelled', 'completed') DEFAULT 'pending',
  special_requests TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_booking_package FOREIGN KEY (package_id) REFERENCES tour_packages(package_id),
  CONSTRAINT fk_booking_customer FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
) ENGINE=InnoDB;

-- =====================================================
-- PACKAGE REVIEWS TABLE
-- =====================================================
CREATE TABLE package_reviews (
  review_id INT AUTO_INCREMENT PRIMARY KEY,
  package_id INT NOT NULL,
  customer_id INT NOT NULL,
  rating INT NOT NULL CHECK (rating BETWEEN 1 AND 5),
  review_text TEXT,
  review_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  is_approved BOOLEAN DEFAULT FALSE,
  CONSTRAINT fk_review_package FOREIGN KEY (package_id) REFERENCES tour_packages(package_id) ON DELETE CASCADE,
  CONSTRAINT fk_review_customer FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
) ENGINE=InnoDB;

-- =====================================================
-- DESTINATIONS TABLE
-- =====================================================
CREATE TABLE destinations (
  destination_id INT AUTO_INCREMENT PRIMARY KEY,
  destination_name VARCHAR(200) NOT NULL UNIQUE,
  country VARCHAR(100) NOT NULL,
  description TEXT,
  image_url VARCHAR(500),
  is_popular BOOLEAN DEFAULT FALSE
) ENGINE=InnoDB;

-- =====================================================
-- INSERT DEFAULT DATA
-- =====================================================

-- Admin User (username: admin, password: admin123)
INSERT INTO admin_users (username, password_hash, full_name, email) VALUES
('admin', '240be518fabd2724ddb6f04eeb1da5967448d7e831c08c8fa822809f74c720a9', 'Admin User', 'admin@tourtravels.com');

-- Package Categories
INSERT INTO package_categories (category_name, description, icon) VALUES
('Hill Station', 'Explore serene mountain destinations', 'fa-mountain'),
('Beach', 'Relaxing coastal getaways', 'fa-umbrella-beach'),
('Heritage', 'Historical and cultural tours', 'fa-landmark'),
('Adventure', 'Thrilling adventure packages', 'fa-hiking'),
('Wildlife', 'Wildlife safari and nature tours', 'fa-paw'),
('Spiritual', 'Pilgrimage and spiritual journeys', 'fa-om');

-- Popular Destinations
INSERT INTO destinations (destination_name, country, description, image_url, is_popular) VALUES
('Shimla', 'India', 'Capital of Himachal Pradesh, known for colonial architecture', 'https://images.unsplash.com/photo-1602216056096-3b40cc0c9944?w=800', TRUE),
('Goa', 'India', 'Beautiful beaches and Portuguese heritage', 'https://images.unsplash.com/photo-1512343879784-a960bf40e7f2?w=800', TRUE),
('Jaipur', 'India', 'The Pink City with magnificent forts and palaces', 'https://images.unsplash.com/photo-1477587458883-47145ed94245?w=800', TRUE),
('Kerala', 'India', 'Gods Own Country with backwaters and tea gardens', 'https://images.unsplash.com/photo-1602216056096-3b40cc0c9944?w=800', TRUE),
('Ladakh', 'India', 'Land of high passes and stunning landscapes', 'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=800', TRUE),
('Varanasi', 'India', 'Ancient spiritual capital on the Ganges', 'https://images.unsplash.com/photo-1561361513-2d000a50f0dc?w=800', TRUE);

-- Tour Packages
SET @hill_station = (SELECT category_id FROM package_categories WHERE category_name = 'Hill Station');
SET @beach = (SELECT category_id FROM package_categories WHERE category_name = 'Beach');
SET @heritage = (SELECT category_id FROM package_categories WHERE category_name = 'Heritage');
SET @adventure = (SELECT category_id FROM package_categories WHERE category_name = 'Adventure');
SET @wildlife = (SELECT category_id FROM package_categories WHERE category_name = 'Wildlife');
SET @spiritual = (SELECT category_id FROM package_categories WHERE category_name = 'Spiritual');

INSERT INTO tour_packages (category_id, package_name, destination, duration_days, duration_nights, price, description, highlights, inclusions, exclusions, image_url, rating, total_reviews, is_featured, is_active) VALUES

-- Package 1: Shimla Manali
(@hill_station, 'Shimla Manali Delight', 'Shimla & Manali, Himachal Pradesh', 6, 5, 15999.00,
'Experience the best of Himachal with this package covering Shimla and Manali. Enjoy scenic mountain views, adventure activities, and colonial charm.',
'Visit Mall Road Shimla, Solang Valley, Rohtang Pass, Hadimba Temple, Adventure activities',
'5 Nights accommodation, Daily breakfast & dinner, All transfers by AC vehicle, Sightseeing as per itinerary, All tolls and parking',
'Lunch, Adventure activity charges, Personal expenses, Travel insurance',
'https://images.unsplash.com/photo-1602216056096-3b40cc0c9944?w=800', 4.5, 120, TRUE, TRUE),

-- Package 2: Goa Beach
(@beach, 'Goa Beach Paradise', 'Goa', 5, 4, 12999.00,
'Relax on pristine beaches, explore Portuguese heritage, and enjoy the vibrant nightlife of Goa.',
'Beach hopping, Water sports, Fort Aguada, Basilica of Bom Jesus, Cruise party',
'4 Nights beach resort stay, Daily breakfast, Airport transfers, Sightseeing tour, Cruise party',
'Lunch & dinner, Water sports, Entry fees, Personal expenses',
'https://images.unsplash.com/photo-1512343879784-a960bf40e7f2?w=800', 4.7, 200, TRUE, TRUE),

-- Package 3: Rajasthan Heritage
(@heritage, 'Rajasthan Royal Heritage', 'Jaipur, Udaipur, Jodhpur', 8, 7, 25999.00,
'Discover the royal grandeur of Rajasthan with visits to magnificent forts, palaces, and desert landscapes.',
'Amber Fort, City Palace, Mehrangarh Fort, Lake Pichola boat ride, Camel safari',
'7 Nights hotel stay, Daily breakfast & dinner, AC vehicle, All sightseeing, Camel safari',
'Lunch, Entry fees to monuments, Camera charges, Tips',
'https://images.unsplash.com/photo-1477587458883-47145ed94245?w=800', 4.8, 150, TRUE, TRUE),

-- Package 4: Kerala Backwaters
(@beach, 'Kerala Backwaters Bliss', 'Kerala', 6, 5, 18999.00,
'Experience the tranquility of Kerala backwaters, tea plantations, and beautiful beaches.',
'Houseboat stay, Munnar tea gardens, Alleppey backwaters, Kovalam beach, Kathakali dance',
'5 Nights accommodation (1 night houseboat), Daily meals, All transfers, Sightseeing, Cultural show',
'Personal expenses, Optional activities, Tips, Travel insurance',
'https://images.unsplash.com/photo-1602216056096-3b40cc0c9944?w=800', 4.6, 180, TRUE, TRUE),

-- Package 5: Ladakh Adventure
(@adventure, 'Ladakh Adventure Expedition', 'Ladakh', 7, 6, 28999.00,
'Embark on an adventurous journey to the land of high passes with stunning landscapes and monasteries.',
'Pangong Lake, Nubra Valley, Khardung La Pass, Magnetic Hill, Monasteries',
'6 Nights hotel/camp stay, Daily breakfast & dinner, Bike/vehicle, Permits, Oxygen cylinders',
'Lunch, Fuel costs (if bike), Personal gear, Medical expenses',
'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=800', 4.9, 95, TRUE, TRUE),

-- Package 6: Varanasi Spiritual
(@spiritual, 'Uttarakhand Spiritual Journey', 'Haridwar, Rishikesh, Varanasi', 6, 5, 14999.00,
'Seek spiritual bliss with this package covering the holy cities of Haridwar, Rishikesh, and Varanasi.',
'Ganga Aarti, Yoga sessions, Temple visits, River rafting, Ghats exploration',
'5 Nights hotel stay, Daily breakfast & dinner, All transfers, Temple visits, Yoga sessions',
'Lunch, Rafting charges, Donations, Personal expenses',
'https://images.unsplash.com/photo-1561361513-2d000a50f0dc?w=800', 4.4, 110, FALSE, TRUE);

-- Sample Itinerary for Shimla Manali Package
SET @shimla_manali = (SELECT package_id FROM tour_packages WHERE package_name = 'Shimla Manali Delight' LIMIT 1);

INSERT INTO package_itinerary (package_id, day_number, title, description, activities, meals_included) VALUES
(@shimla_manali, 1, 'Arrival in Shimla', 'Arrive in Shimla and check-in to hotel. Evening free to explore Mall Road.', 'Mall Road walk, Shopping', 'Dinner'),
(@shimla_manali, 2, 'Shimla Sightseeing', 'Visit Jakhu Temple, Christ Church, Scandal Point, and Ridge.', 'Temple visit, Heritage walk, Photography', 'Breakfast, Dinner'),
(@shimla_manali, 3, 'Shimla to Manali', 'Drive to Manali via Kullu Valley. Check-in and relax.', 'Scenic drive, Kullu Valley views', 'Breakfast, Dinner'),
(@shimla_manali, 4, 'Manali Local Sightseeing', 'Visit Hadimba Temple, Vashisht Temple, Tibetan Monastery, Mall Road.', 'Temple tours, Shopping, Cafe hopping', 'Breakfast, Dinner'),
(@shimla_manali, 5, 'Solang Valley Excursion', 'Full day at Solang Valley for adventure activities and snow fun.', 'Paragliding, Zorbing, Cable car (at own cost)', 'Breakfast, Dinner'),
(@shimla_manali, 6, 'Departure', 'Check-out and departure with sweet memories.', 'Shopping, Transfer to airport', 'Breakfast');

-- Sample Hotels for Shimla Manali Package
INSERT INTO package_hotels (package_id, hotel_name, location, star_rating, amenities) VALUES
(@shimla_manali, 'Hotel Willow Banks', 'Shimla', 3, 'Free WiFi, Restaurant, Room Service, Parking'),
(@shimla_manali, 'Manali Heights', 'Manali', 3, 'Mountain View, Restaurant, Bonfire, Parking');

-- Sample Customer Data
INSERT INTO customers (full_name, email, phone, address, city, state) VALUES
('Raj Kumar', 'raj.kumar@email.com', '9876543210', '123 MG Road', 'Delhi', 'Delhi'),
('Priya Sharma', 'priya.sharma@email.com', '9876543211', '456 Park Street', 'Mumbai', 'Maharashtra'),
('Amit Patel', 'amit.patel@email.com', '9876543212', '789 FC Road', 'Pune', 'Maharashtra');

-- Sample Bookings
INSERT INTO bookings (package_id, customer_id, booking_date, travel_date, num_adults, num_children, total_amount, payment_status, booking_status) VALUES
(@shimla_manali, 1, '2025-04-01', '2025-05-15', 2, 1, 31998.00, 'paid', 'confirmed'),
(@shimla_manali, 2, '2025-04-05', '2025-06-20', 2, 0, 31998.00, 'pending', 'pending');

-- Sample Reviews
INSERT INTO package_reviews (package_id, customer_id, rating, review_text, is_approved) VALUES
(@shimla_manali, 1, 5, 'Amazing trip! The hotels were great and the itinerary was well planned. Highly recommended!', TRUE),
(@shimla_manali, 2, 4, 'Good package, enjoyed the scenic beauty. Could have more adventure activities.', TRUE);

-- =======================================================
-- CREATE INDEXES FOR BETTER PERFORMANCE
-- =======================================================

CREATE INDEX idx_packages_category ON tour_packages(category_id);
CREATE INDEX idx_packages_featured ON tour_packages(is_featured);
CREATE INDEX idx_packages_active ON tour_packages(is_active);
CREATE INDEX idx_bookings_customer ON bookings(customer_id);
CREATE INDEX idx_bookings_package ON bookings(package_id);
CREATE INDEX idx_bookings_status ON bookings(booking_status);
CREATE INDEX idx_reviews_package ON package_reviews(package_id);

-- =======================================================
-- END OF SCHEMA
-- =======================================================
