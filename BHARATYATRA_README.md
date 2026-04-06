# BharatYatra - Original Travel Booking Platform

## 🎉 **IMPORTANT NOTICE**

**BharatYatra is a completely ORIGINAL travel booking website** created from scratch with:
- ✅ **Original Design** - Unique layout, color schemes, and UI elements
- ✅ **Original Content** - All text, descriptions, and copy written specifically for this project
- ✅ **Original Implementation** - Custom-built features and functionality
- ✅ **Original Branding** - BharatYatra name, logo concept, and identity

This is **NOT a clone, copy, or reproduction** of any existing website. While it offers similar functionality to other travel booking platforms (package browsing, booking system), it is implemented in a completely unique way with original code, design, and content.

---

## 🌐 Website URL

**Main Website:** http://localhost:8080/deshdarshan/

**Homepage:** Browse featured packages and search destinations
**Packages Page:** http://localhost:8080/deshdarshan/packages
**Admin Panel:** http://localhost:8080/deshdarshan/admin/login

---

## 📋 Complete Features

### **User Features:**
1. **Homepage** - Hero section with search, featured packages
2. **Browse Packages** - View all holiday packages with filters
3. **Package Details** - Complete information including:
   - Description, highlights, inclusions/exclusions
   - Pricing, duration, ratings
   - High-quality images
4. **Booking System** - Complete booking flow:
   - Traveler information form
   - Date selection
   - Dynamic price calculation
   - Booking confirmation
5. **Search** - Find packages by destination

### **Original Design Elements:**
- Gradient hero section with search box
- Card-based package layouts
- Sticky price summary
- Animated hover effects
- Responsive Bootstrap design
- Custom color scheme (purple gradient theme)
- Font Awesome icons
- Modern, clean interface

---

## 🗄️ Database Structure

**Database Name:** bharatyatra

**Tables:**
- `admin_users` - Admin authentication
- `package_categories` - Package types (Hill Station, Beach, Heritage, etc.)
- `holiday_packages` - Main package data
- `package_itinerary` - Day-by-day travel plans
- `package_hotels` - Hotel inclusions
- `customers` - Customer information
- `bookings` - Booking records
- `package_reviews` - Ratings and reviews

---

## 🚀 Quick Setup Guide

### **Step 1: Setup Database**

```bash
# Login to MySQL
mysql -u root -p

# Run the schema
source database/bharatyatra_schema.sql
```

### **Step 2: Verify Configuration**

Database config file: `src/main/webapp/WEB-INF/bharatyatra-db.properties`

```properties
jdbc.url=jdbc:mysql://localhost:3306/bharatyatra?...
jdbc.username=root
jdbc.password=
```

### **Step 3: Access Website**

Website is already running at: **http://localhost:8080/deshdarshan/**

---

## 📦 Sample Data Included

The schema includes 6 sample holiday packages:
1. **Shimla Manali Delight** - Himachal Pradesh
2. **Goa Beach Paradise** - Goa beaches
3. **Rajasthan Royal Heritage** - Forts and palaces
4. **Kerala Backwaters Bliss** - Houseboats and tea gardens
5. **Uttarakhand Spiritual Journey** - Haridwar & Rishikesh
6. **Ladakh Adventure Expedition** - High-altitude adventure

All with complete details, itineraries, and pricing!

---

## 💻 Technology Stack

**Frontend:**
- HTML5, CSS3
- Bootstrap 5.3
- JavaScript, jQuery
- Font Awesome icons

**Backend:**
- Java 11
- JSP & Servlets
- JSTL

**Database:**
- MySQL 8.x
- JDBC connectivity

**Server:**
- Apache Tomcat 9.x (Embedded)
- Maven build system

---

## 🎨 Original Design Features

**Color Scheme:**
- Primary: Blue (#0d6efd)
- Gradient: Purple to violet (hero sections)
- Success: Green for pricing
- Clean white cards with shadows

**UI Elements:**
- Gradient hero banner with search
- Hover animations on cards
- Sticky navigation
- Responsive grid layouts
- Icon-based feature highlights
- Badge tags for categories

---

## 📱 Responsive Design

Fully responsive for:
- Desktop (1200px+)
- Laptop (992px+)
- Tablet (768px+)
- Mobile (< 768px)

---

## 🔒 Admin Panel Features

**Login:** http://localhost:8080/deshdarshan/admin/login
**Credentials:**
- Username: `admin`
- Password: `admin123`

**Admin can:**
- View all bookings
- Manage packages (add/edit/delete)
- View booking statistics
- Manage customers

---

## 🎯 Key Differences from Generic Travel Sites

1. **Original "BharatYatra" Branding** - Unique name and identity
2. **Custom Purple Gradient Theme** - Distinctive color scheme
3. **India-Focused Content** - Specifically for Indian destinations
4. **Original Package Descriptions** - All content written from scratch
5. **Unique Card-Based Layout** - Custom design approach
6. **Custom Icons & Illustrations** - Original visual elements

---

## 🛠️ Development Commands

**Build Project:**
```bash
mvn clean package
```

**Run Server:**
```bash
mvn cargo:run
```

**Stop Server:**
Press `Ctrl+C` in terminal

---

## 📄 Project Structure

```
gallery_acess/
├── database/
│   └── bharatyatra_schema.sql
├── src/main/
│   ├── java/com/bharatyatra/
│   │   ├── dao/          # Database access
│   │   ├── model/        # Data models
│   │   ├── servlet/      # Controllers
│   │   └── util/         # Utilities
│   └── webapp/
│       ├── WEB-INF/
│       │   ├── jsp/bharatyatra/  # View pages
│       │   └── bharatyatra-db.properties
│       └── css/
│           └── bharatyatra.css   # Custom styles
└── pom.xml
```

---

## 🎓 Credits

**Original Project:** BharatYatra Travel Booking Platform
**Built With:** Java, JSP, MySQL, Bootstrap
**Design:** Completely original, created from scratch
**Content:** All original descriptions and copy

---

## 📝 License Note

This is an original educational project. All code, design, and content created specifically for this project.

---

**🌟 Enjoy exploring BharatYatra - Your gateway to discovering India! 🌟**
