-- BharatYatra – Travel & Holiday Package Booking System
CREATE DATABASE IF NOT EXISTS bharatyatra CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE bharatyatra;

-- Admin users table
CREATE TABLE admin_users (
  admin_id INT AUTO_INCREMENT PRIMARY KEY,
  username VARCHAR(50) NOT NULL UNIQUE,
  password_hash VARCHAR(64) NOT NULL,
  email VARCHAR(100),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Categories for packages
CREATE TABLE package_categories (
  category_id INT AUTO_INCREMENT PRIMARY KEY,
  category_name VARCHAR(100) NOT NULL UNIQUE,
  description TEXT,
  icon VARCHAR(50)
);

-- Holiday packages
CREATE TABLE holiday_packages (
  package_id INT AUTO_INCREMENT PRIMARY KEY,
  package_name VARCHAR(200) NOT NULL,
  category_id INT,
  destination VARCHAR(150) NOT NULL,
  duration_days INT NOT NULL,
  duration_nights INT NOT NULL,
  price_per_person DECIMAL(10,2) NOT NULL,
  description TEXT,
  highlights TEXT,
  inclusions TEXT,
  exclusions TEXT,
  image_url VARCHAR(500),
  is_featured BOOLEAN DEFAULT FALSE,
  rating DECIMAL(3,2) DEFAULT 0.00,
  total_reviews INT DEFAULT 0,
  available_from DATE,
  available_to DATE,
  status ENUM('active', 'inactive') DEFAULT 'active',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (category_id) REFERENCES package_categories(category_id)
);

-- Package itinerary
CREATE TABLE package_itinerary (
  itinerary_id INT AUTO_INCREMENT PRIMARY KEY,
  package_id INT NOT NULL,
  day_number INT NOT NULL,
  title VARCHAR(200),
  description TEXT,
  activities TEXT,
  meals_included VARCHAR(100),
  FOREIGN KEY (package_id) REFERENCES holiday_packages(package_id) ON DELETE CASCADE
);

-- Hotels included in packages
CREATE TABLE package_hotels (
  hotel_id INT AUTO_INCREMENT PRIMARY KEY,
  package_id INT NOT NULL,
  hotel_name VARCHAR(200) NOT NULL,
  location VARCHAR(150),
  star_rating INT,
  check_in DATE,
  check_out DATE,
  FOREIGN KEY (package_id) REFERENCES holiday_packages(package_id) ON DELETE CASCADE
);

-- Customer/User table
CREATE TABLE customers (
  customer_id INT AUTO_INCREMENT PRIMARY KEY,
  full_name VARCHAR(150) NOT NULL,
  email VARCHAR(100) NOT NULL UNIQUE,
  phone VARCHAR(15),
  address TEXT,
  city VARCHAR(100),
  state VARCHAR(100),
  pincode VARCHAR(10),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Bookings table
CREATE TABLE bookings (
  booking_id INT AUTO_INCREMENT PRIMARY KEY,
  booking_reference VARCHAR(20) UNIQUE NOT NULL,
  customer_id INT NOT NULL,
  package_id INT NOT NULL,
  travel_date DATE NOT NULL,
  num_adults INT NOT NULL DEFAULT 1,
  num_children INT DEFAULT 0,
  total_price DECIMAL(10,2) NOT NULL,
  booking_status ENUM('pending', 'confirmed', 'cancelled', 'completed') DEFAULT 'pending',
  payment_status ENUM('unpaid', 'paid', 'refunded') DEFAULT 'unpaid',
  special_requests TEXT,
  booking_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
  FOREIGN KEY (package_id) REFERENCES holiday_packages(package_id)
);

-- Reviews and ratings
CREATE TABLE package_reviews (
  review_id INT AUTO_INCREMENT PRIMARY KEY,
  package_id INT NOT NULL,
  customer_id INT NOT NULL,
  rating INT NOT NULL CHECK (rating >= 1 AND rating <= 5),
  review_text TEXT,
  review_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (package_id) REFERENCES holiday_packages(package_id) ON DELETE CASCADE,
  FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- Insert default admin (admin/admin123)
INSERT INTO admin_users (username, password_hash, email) VALUES
('admin', '240be518fabd2724ddb6f04eeb1da5967448d7e831c08c8fa822809f74c720a9', 'admin@bharatyatra.com');

-- Insert package categories
INSERT INTO package_categories (category_name, description, icon) VALUES
('Hill Station', 'Escape to serene mountains and valleys', 'fa-mountain'),
('Beach & Islands', 'Relax on beautiful beaches and islands', 'fa-umbrella-beach'),
('Heritage & Culture', 'Explore historical monuments and cultural sites', 'fa-landmark'),
('Wildlife Safari', 'Adventure in national parks and sanctuaries', 'fa-paw'),
('Spiritual Tours', 'Visit sacred temples and pilgrimage sites', 'fa-place-of-worship'),
('Adventure Sports', 'Trekking, rafting, and adventure activities', 'fa-person-hiking');

-- Insert sample holiday packages
INSERT INTO holiday_packages (package_name, category_id, destination, duration_days, duration_nights, price_per_person, description, highlights, inclusions, exclusions, image_url, is_featured, rating, total_reviews) VALUES
('Shimla Manali Delight', 1, 'Himachal Pradesh', 6, 5, 15999.00,
 'Experience the charm of Himachal with visits to Shimla and Manali. Enjoy snow-capped mountains, apple orchards, and adventure activities.',
 'Mall Road Shimla, Solang Valley, Rohtang Pass (if accessible), Hadimba Temple, Vashisht Hot Springs',
 'Accommodation in 3-star hotels, Daily breakfast and dinner, All transfers by private vehicle, Sightseeing as per itinerary',
 'Lunch, Entry fees to monuments, Adventure activity costs, Personal expenses',
 'https://images.unsplash.com/photo-1626621341517-bbf3d9990a23?w=800', TRUE, 4.5, 127),

('Goa Beach Paradise', 2, 'Goa', 5, 4, 12999.00,
 'Relax on pristine beaches of Goa. Enjoy water sports, vibrant nightlife, and Portuguese heritage sites.',
 'Calangute Beach, Baga Beach, Aguada Fort, Old Goa Churches, Dudhsagar Waterfalls, Spice Plantation',
 'Beach resort accommodation, Breakfast daily, Airport transfers, North and South Goa sightseeing',
 'Lunch and dinner, Water sports charges, Personal expenses, Travel insurance',
 'https://images.unsplash.com/photo-1512343879784-a960bf40e7f2?w=800', TRUE, 4.7, 203),

('Rajasthan Royal Heritage', 3, 'Rajasthan', 8, 7, 24999.00,
 'Discover the royal heritage of Rajasthan visiting Jaipur, Udaipur, Jodhpur, and Jaisalmer.',
 'Amber Fort, City Palace Jaipur, Lake Pichola, Mehrangarh Fort, Sam Sand Dunes, Camel Safari',
 'Heritage hotel stays, All meals, AC vehicle transfers, Sightseeing with guide, Camel safari',
 'Monuments entry fees, Optional activities, Personal expenses',
 'https://images.unsplash.com/photo-1599661046289-e31897846e41?w=800', TRUE, 4.8, 156),

('Kerala Backwaters Bliss', 2, 'Kerala', 6, 5, 18999.00,
 'Experience Gods Own Country with houseboat stay, tea gardens, and Ayurvedic spa.',
 'Munnar tea gardens, Thekkady wildlife, Alleppey houseboat, Kovalam beach, Kathakali dance show',
 'Deluxe hotel accommodation, Houseboat stay with meals, All transfers, Ayurvedic massage session',
 'Lunch (except on houseboat), Entry tickets, Personal expenses',
 'https://images.unsplash.com/photo-1602216056096-3b40cc0c9944?w=800', TRUE, 4.6, 189),

('Uttarakhand Spiritual Journey', 5, 'Uttarakhand', 7, 6, 16999.00,
 'Visit the holy shrines of Haridwar, Rishikesh, and experience Ganga Aarti.',
 'Har Ki Pauri, Ganga Aarti, Laxman Jhula, Beatles Ashram, Yoga session, River Rafting in Rishikesh',
 'Hotel accommodation, All meals, Private vehicle, Yoga and meditation sessions',
 'River rafting charges, Temple donations, Personal expenses',
 'https://images.unsplash.com/photo-1548013146-72479768bada?w=800', FALSE, 4.4, 94),

('Ladakh Adventure Expedition', 6, 'Ladakh', 8, 7, 32999.00,
 'Experience the thrill of high-altitude adventure in Ladakh with Pangong Lake and Nubra Valley.',
 'Leh Palace, Pangong Lake, Nubra Valley, Khardung La Pass, Magnetic Hill, Monasteries',
 'Guesthouse stays, Breakfast and dinner, Oxygen cylinders, Inner line permits, All transfers',
 'Lunch, Entry fees, Adventure activities, Cold weather gear',
 'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=800', TRUE, 4.9, 241);

-- Insert sample itinerary for Shimla Manali package
INSERT INTO package_itinerary (package_id, day_number, title, description, activities, meals_included) VALUES
(1, 1, 'Arrival in Shimla', 'Arrive at Shimla. Check-in to hotel. Evening free for leisure at Mall Road.', 'Hotel check-in, Mall Road walk, Ridge visit', 'Dinner'),
(1, 2, 'Shimla Local Sightseeing', 'Visit Kufri, Jakhoo Temple, and enjoy toy train ride.', 'Kufri excursion, Jakhoo Temple, Toy train', 'Breakfast, Dinner'),
(1, 3, 'Shimla to Manali', 'Drive to Manali via Kullu Valley. Check-in to hotel.', 'Scenic drive, Kullu Valley views', 'Breakfast, Dinner'),
(1, 4, 'Manali Local Tour', 'Visit Hadimba Temple, Vashisht Hot Springs, and Old Manali.', 'Temple visit, Hot springs, Shopping', 'Breakfast, Dinner'),
(1, 5, 'Solang Valley Excursion', 'Full day excursion to Solang Valley for adventure activities.', 'Paragliding, Zorbing, Ropeway (optional)', 'Breakfast, Dinner'),
(1, 6, 'Departure from Manali', 'Check-out and departure. Trip ends with sweet memories.', 'Check-out, Departure', 'Breakfast');

-- Generate booking reference function
DELIMITER $$
CREATE TRIGGER generate_booking_ref BEFORE INSERT ON bookings
FOR EACH ROW
BEGIN
  SET NEW.booking_reference = CONCAT('BYT', YEAR(NOW()), LPAD(NEW.booking_id, 6, '0'));
END$$
DELIMITER ;
