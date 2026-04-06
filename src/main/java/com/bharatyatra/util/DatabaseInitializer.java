package com.bharatyatra.util;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;
import java.sql.Connection;
import java.sql.Statement;

@WebListener
public class DatabaseInitializer implements ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        try (Connection conn = DBUtil.getConnection(sce.getServletContext())) {
            Statement stmt = conn.createStatement();

            // Create tables
            stmt.execute("CREATE TABLE IF NOT EXISTS admin_users (" +
                "admin_id INT AUTO_INCREMENT PRIMARY KEY, " +
                "username VARCHAR(50) NOT NULL UNIQUE, " +
                "password_hash VARCHAR(64) NOT NULL, " +
                "email VARCHAR(100))");

            stmt.execute("CREATE TABLE IF NOT EXISTS package_categories (" +
                "category_id INT AUTO_INCREMENT PRIMARY KEY, " +
                "category_name VARCHAR(100) NOT NULL UNIQUE, " +
                "description TEXT, " +
                "icon VARCHAR(50))");

            stmt.execute("CREATE TABLE IF NOT EXISTS holiday_packages (" +
                "package_id INT AUTO_INCREMENT PRIMARY KEY, " +
                "package_name VARCHAR(200) NOT NULL, " +
                "category_id INT, " +
                "destination VARCHAR(150) NOT NULL, " +
                "duration_days INT NOT NULL, " +
                "duration_nights INT NOT NULL, " +
                "price_per_person DECIMAL(10,2) NOT NULL, " +
                "description TEXT, " +
                "highlights TEXT, " +
                "inclusions TEXT, " +
                "exclusions TEXT, " +
                "image_url VARCHAR(500), " +
                "is_featured BOOLEAN DEFAULT FALSE, " +
                "rating DECIMAL(3,2) DEFAULT 0.00, " +
                "total_reviews INT DEFAULT 0, " +
                "available_from DATE, " +
                "available_to DATE, " +
                "status VARCHAR(20) DEFAULT 'active')");

            stmt.execute("CREATE TABLE IF NOT EXISTS customers (" +
                "customer_id INT AUTO_INCREMENT PRIMARY KEY, " +
                "full_name VARCHAR(150) NOT NULL, " +
                "email VARCHAR(100) NOT NULL UNIQUE, " +
                "phone VARCHAR(15), " +
                "address TEXT, " +
                "city VARCHAR(100), " +
                "state VARCHAR(100), " +
                "pincode VARCHAR(10))");

            stmt.execute("CREATE TABLE IF NOT EXISTS bookings (" +
                "booking_id INT AUTO_INCREMENT PRIMARY KEY, " +
                "booking_reference VARCHAR(20) UNIQUE NOT NULL, " +
                "customer_id INT NOT NULL, " +
                "package_id INT NOT NULL, " +
                "travel_date DATE NOT NULL, " +
                "num_adults INT NOT NULL DEFAULT 1, " +
                "num_children INT DEFAULT 0, " +
                "total_price DECIMAL(10,2) NOT NULL, " +
                "booking_status VARCHAR(20) DEFAULT 'pending', " +
                "payment_status VARCHAR(20) DEFAULT 'unpaid', " +
                "special_requests TEXT, " +
                "booking_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP)");

            // Insert sample data
            stmt.execute("INSERT INTO admin_users (username, password_hash, email) VALUES " +
                "('admin', '240be518fabd2724ddb6f04eeb1da5967448d7e831c08c8fa822809f74c720a9', 'admin@bharatyatra.com')");

            stmt.execute("INSERT INTO package_categories (category_name, description, icon) VALUES " +
                "('Hill Station', 'Escape to serene mountains', 'fa-mountain'), " +
                "('Beach & Islands', 'Relax on beautiful beaches', 'fa-umbrella-beach'), " +
                "('Heritage & Culture', 'Explore historical monuments', 'fa-landmark'), " +
                "('Wildlife Safari', 'Adventure in national parks', 'fa-paw'), " +
                "('Spiritual Tours', 'Visit sacred temples', 'fa-place-of-worship'), " +
                "('Adventure Sports', 'Trekking and adventure', 'fa-person-hiking')");

            stmt.execute("INSERT INTO holiday_packages (package_name, category_id, destination, duration_days, duration_nights, " +
                "price_per_person, description, highlights, inclusions, exclusions, image_url, is_featured, rating, total_reviews) VALUES " +
                "('Shimla Manali Delight', 1, 'Himachal Pradesh', 6, 5, 15999.00, " +
                "'Experience the charm of Himachal with visits to Shimla and Manali. Enjoy snow-capped mountains, apple orchards, and adventure activities.', " +
                "'Mall Road Shimla, Solang Valley, Rohtang Pass, Hadimba Temple, Vashisht Hot Springs', " +
                "'Accommodation in 3-star hotels, Daily breakfast and dinner, All transfers by private vehicle, Sightseeing as per itinerary', " +
                "'Lunch, Entry fees to monuments, Adventure activity costs, Personal expenses', " +
                "'https://images.unsplash.com/photo-1626621341517-bbf3d9990a23?w=800', TRUE, 4.5, 127), " +

                "('Goa Beach Paradise', 2, 'Goa', 5, 4, 12999.00, " +
                "'Relax on pristine beaches of Goa. Enjoy water sports, vibrant nightlife, and Portuguese heritage sites.', " +
                "'Calangute Beach, Baga Beach, Aguada Fort, Old Goa Churches, Dudhsagar Waterfalls, Spice Plantation', " +
                "'Beach resort accommodation, Breakfast daily, Airport transfers, North and South Goa sightseeing', " +
                "'Lunch and dinner, Water sports charges, Personal expenses, Travel insurance', " +
                "'https://images.unsplash.com/photo-1512343879784-a960bf40e7f2?w=800', TRUE, 4.7, 203), " +

                "('Rajasthan Royal Heritage', 3, 'Rajasthan', 8, 7, 24999.00, " +
                "'Discover the royal heritage of Rajasthan visiting Jaipur, Udaipur, Jodhpur, and Jaisalmer.', " +
                "'Amber Fort, City Palace Jaipur, Lake Pichola, Mehrangarh Fort, Sam Sand Dunes, Camel Safari', " +
                "'Heritage hotel stays, All meals, AC vehicle transfers, Sightseeing with guide, Camel safari', " +
                "'Monuments entry fees, Optional activities, Personal expenses', " +
                "'https://images.unsplash.com/photo-1599661046289-e31897846e41?w=800', TRUE, 4.8, 156), " +

                "('Kerala Backwaters Bliss', 2, 'Kerala', 6, 5, 18999.00, " +
                "'Experience Gods Own Country with houseboat stay, tea gardens, and Ayurvedic spa.', " +
                "'Munnar tea gardens, Thekkady wildlife, Alleppey houseboat, Kovalam beach, Kathakali dance', " +
                "'Deluxe hotel accommodation, Houseboat stay with meals, All transfers, Ayurvedic massage', " +
                "'Lunch except on houseboat, Entry tickets, Personal expenses', " +
                "'https://images.unsplash.com/photo-1602216056096-3b40cc0c9944?w=800', TRUE, 4.6, 189), " +

                "('Ladakh Adventure', 6, 'Ladakh', 8, 7, 32999.00, " +
                "'Experience high-altitude adventure in Ladakh with Pangong Lake and Nubra Valley.', " +
                "'Leh Palace, Pangong Lake, Nubra Valley, Khardung La Pass, Magnetic Hill, Monasteries', " +
                "'Guesthouse stays, Breakfast and dinner, Oxygen cylinders, Inner line permits, All transfers', " +
                "'Lunch, Entry fees, Adventure activities, Cold weather gear', " +
                "'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=800', TRUE, 4.9, 241), " +

                "('Uttarakhand Spiritual', 5, 'Uttarakhand', 7, 6, 16999.00, " +
                "'Visit holy shrines of Haridwar, Rishikesh, and experience Ganga Aarti.', " +
                "'Har Ki Pauri, Ganga Aarti, Laxman Jhula, Beatles Ashram, Yoga session, River Rafting', " +
                "'Hotel accommodation, All meals, Private vehicle, Yoga and meditation sessions', " +
                "'River rafting charges, Temple donations, Personal expenses', " +
                "'https://images.unsplash.com/photo-1548013146-72479768bada?w=800', FALSE, 4.4, 94)");

            System.out.println("✅ Database initialized successfully with H2!");

        } catch (Exception e) {
            System.err.println("❌ Database initialization failed: " + e.getMessage());
            e.printStackTrace();
        }
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        // Cleanup if needed
    }
}
