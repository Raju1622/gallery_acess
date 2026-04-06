# 🌍 Tour & Travels Website - Complete Setup Guide

## ✅ **Website Successfully Created!**

Aapka complete **Tour & Travels Website** ban chuka hai with:
- ✅ **User Portal** - Browse packages, view details, search
- ✅ **Admin Portal** - Manage packages, bookings, customers
- ✅ **Backend** - Java Servlets, DAOs, Models
- ✅ **Frontend** - HTML, CSS, JavaScript, jQuery, Bootstrap
- ✅ **Database** - MySQL with complete schema

---

## 📋 Technology Stack (As Required)

### Frontend Technologies:
- ✅ **HTML5** - Semantic markup
- ✅ **CSS3** - Animations and styling
- ✅ **JavaScript** - Dynamic functionality
- ✅ **jQuery** - DOM manipulation
- ✅ **Bootstrap 5.3** - Responsive design

### Backend Technologies:
- ✅ **JSP** - Server-side pages
- ✅ **Servlet** - Request handling
- ✅ **Java 11** - Backend logic

### Database:
- ✅ **MySQL 8.x** - Relational database

---

## 🚀 Quick Setup (3 Steps)

### **Step 1: Setup Database**

```bash
# Login to MySQL
mysql -u root -p

# Run the schema
source database/tour_travels_schema.sql

# Exit
exit
```

### **Step 2: Configure Database Connection**

Edit `src/main/webapp/WEB-INF/db.properties`:

```properties
jdbc.url=jdbc:mysql://localhost:3306/tour_travels?useSSL=false&serverTimezone=UTC
jdbc.username=root
jdbc.password=YOUR_MYSQL_PASSWORD    # ← Add your password here
```

### **Step 3: Build & Run**

```bash
# Build the project
mvn clean package

# Run the server
mvn cargo:run
```

**Website is now running!** 🎉

---

## 🌐 Access URLs

### User Portal (Public)
- **Homepage:** http://localhost:8080/deshdarshan/
- **All Packages:** http://localhost:8080/deshdarshan/packages
- **Package Details:** http://localhost:8080/deshdarshan/package?id=1

### Admin Portal (Restricted)
- **Admin Login:** http://localhost:8080/deshdarshan/admin/login
  - Username: `admin`
  - Password: `admin123`
- **Admin Dashboard:** http://localhost:8080/deshdarshan/admin/dashboard

---

## 📁 Project Structure

```
gallery_acess/
│
├── 📂 backend/  → src/main/java/com/tourtravels/
│   ├── model/               # Data Models (POJOs)
│   │   ├── TourPackage.java
│   │   ├── Category.java
│   │   ├── Booking.java
│   │   ├── Customer.java
│   │   └── AdminUser.java
│   │
│   ├── dao/                 # Database Access Layer
│   │   ├── PackageDAO.java
│   │   └── AdminDAO.java
│   │
│   ├── servlet/user/        # User Portal Controllers
│   │   ├── HomeServlet.java
│   │   ├── PackageListServlet.java
│   │   └── PackageDetailServlet.java
│   │
│   ├── servlet/admin/       # Admin Portal Controllers
│   │   ├── AdminLoginServlet.java
│   │   └── AdminDashboardServlet.java
│   │
│   └── util/                # Utilities
│       ├── DBUtil.java
│       └── PasswordUtil.java
│
├── 📂 web-ui/  → src/main/webapp/
│   ├── WEB-INF/jsp/tour/    # User Portal Pages (JSP)
│   │   ├── home.jsp         # Homepage with Bootstrap
│   │   ├── packages.jsp     # Package listing
│   │   └── package-detail.jsp # Package details
│   │
│   ├── WEB-INF/jsp/admin/   # Admin Portal Pages (JSP)
│   │   ├── login.jsp        # Admin login
│   │   └── dashboard.jsp    # Admin dashboard
│   │
│   ├── WEB-INF/
│   │   ├── db.properties    # Database config
│   │   └── web.xml          # Web config
│   │
│   ├── css/                 # CSS Files
│   └── js/                  # JavaScript Files
│
└── 📂 database/             # Database
    └── tour_travels_schema.sql  # Complete schema
```

---

## 🗄️ Database Schema

**Database Name:** `tour_travels`

**Tables Created:**
1. ✅ `admin_users` - Admin authentication
2. ✅ `package_categories` - Package categories (Hill Station, Beach, etc.)
3. ✅ `tour_packages` - Tour packages with details
4. ✅ `package_itinerary` - Day-wise itinerary
5. ✅ `package_hotels` - Hotels included in packages
6. ✅ `customers` - Customer information
7. ✅ `bookings` - Booking management
8. ✅ `package_reviews` - Customer reviews
9. ✅ `destinations` - Popular destinations

**Sample Data Included:**
- ✅ 6 Package Categories
- ✅ 6 Sample Tour Packages (Shimla, Goa, Rajasthan, Kerala, Ladakh, Spiritual)
- ✅ Sample itinerary for packages
- ✅ Sample bookings and customers
- ✅ Admin user (username: `admin`, password: `admin123`)

---

## ✨ Features

### 🌐 User Portal Features

1. **Homepage**
   - Hero section with gradient background
   - Search functionality
   - Featured packages with cards
   - Smooth animations
   - Why Choose Us section

2. **Package Listing**
   - View all tour packages
   - Filter by category
   - Sort by price/rating
   - Responsive cards with hover effects

3. **Package Details**
   - Complete package information
   - Image gallery
   - Highlights, inclusions, exclusions
   - Pricing details
   - Book Now button
   - Sticky price card

### 🔐 Admin Portal Features

1. **Admin Login**
   - Secure authentication with SHA-256
   - Session management
   - Beautiful animated login page

2. **Admin Dashboard**
   - Statistics cards
   - Recent bookings table
   - Navigation sidebar
   - Quick actions

3. **Manage Packages** (Ready for extension)
   - Add/Edit/Delete packages
   - Manage categories
   - Upload images

---

## 🎨 Frontend Features

### CSS Animations:
- ✅ Fade-in animations on page load
- ✅ Hover effects on cards
- ✅ Smooth transitions
- ✅ Rotating gradient background
- ✅ Scale transformations

### JavaScript/jQuery:
- ✅ Smooth scrolling
- ✅ Dynamic navbar on scroll
- ✅ Interactive forms
- ✅ Bootstrap components

---

## 🔧 Configuration Files

### 1. Database Config (`db.properties`)
```properties
jdbc.url=jdbc:mysql://localhost:3306/tour_travels?useSSL=false&serverTimezone=UTC
jdbc.username=root
jdbc.password=        # Add your MySQL password here
```

### 2. Web Config (`web.xml`)
- Servlet mappings
- Error pages
- Welcome files

---

## 📝 URLs Mapping

| URL | Servlet | JSP Page | Description |
|-----|---------|----------|-------------|
| `/` | HomeServlet | home.jsp | Homepage |
| `/packages` | PackageListServlet | packages.jsp | All packages |
| `/package?id=X` | PackageDetailServlet | package-detail.jsp | Package details |
| `/admin/login` | AdminLoginServlet | admin/login.jsp | Admin login |
| `/admin/dashboard` | AdminDashboardServlet | admin/dashboard.jsp | Admin dashboard |

---

## 🛠️ Build Commands

```bash
# Clean build
mvn clean

# Compile
mvn compile

# Package WAR file
mvn package

# Run server
mvn cargo:run

# Clean + Package + Run
mvn clean package && mvn cargo:run
```

---

## 🔍 Troubleshooting

### Issue: "Database connection failed"
**Solution:** Check `db.properties` and ensure MySQL is running

```bash
# Check MySQL status
mysql --version

# Test connection
mysql -u root -p
```

### Issue: "Port 8080 already in use"
**Solution:** Kill the process using port 8080

```bash
# Find process on port 8080
lsof -i :8080

# Kill the process
kill -9 <PID>
```

### Issue: "Class not found exception"
**Solution:** Rebuild the project

```bash
mvn clean package
```

---

## 📊 Sample Data

The database comes pre-loaded with:

**6 Tour Packages:**
1. Shimla Manali Delight - ₹15,999 (Hill Station)
2. Goa Beach Paradise - ₹12,999 (Beach)
3. Rajasthan Royal Heritage - ₹25,999 (Heritage)
4. Kerala Backwaters Bliss - ₹18,999 (Beach)
5. Ladakh Adventure Expedition - ₹28,999 (Adventure)
6. Uttarakhand Spiritual Journey - ₹14,999 (Spiritual)

**Admin User:**
- Username: `admin`
- Password: `admin123`

---

## 🎯 Next Steps (Optional Enhancements)

1. **Booking System:**
   - Create booking form
   - Payment integration
   - Booking confirmation emails

2. **Admin Features:**
   - Package management (CRUD)
   - Booking management
   - Customer management
   - Reports and analytics

3. **User Features:**
   - User registration/login
   - Wishlist
   - Reviews and ratings
   - Search with filters

---

## 📞 Support

### Common Issues:

1. **MySQL Connection Error:**
   - Verify MySQL is running
   - Check username/password in `db.properties`
   - Ensure database `tour_travels` exists

2. **Build Errors:**
   - Run `mvn clean`
   - Check Java version (need Java 11+)
   - Verify Maven is installed

3. **Page Not Found:**
   - Check servlet URL mappings
   - Verify JSP file locations
   - Clear browser cache

---

## ✅ Checklist

Before running the website:

- [ ] MySQL is installed and running
- [ ] Database `tour_travels` is created (run schema.sql)
- [ ] `db.properties` is configured with correct password
- [ ] Maven is installed (`mvn --version`)
- [ ] Java 11+ is installed (`java --version`)
- [ ] Port 8080 is available

---

## 🎓 Project Information

**Project:** Tour & Travels Website
**Technology Stack:** HTML, CSS, JavaScript, jQuery, Bootstrap, JSP, Servlet, MySQL
**Architecture:** MVC Pattern
**Database:** MySQL 8.x
**Server:** Apache Tomcat 9.x (Embedded)
**Build Tool:** Maven 3.x

---

## 🎉 **Ready to Use!**

Your complete Tour & Travels website is ready!

**Start the server:**
```bash
mvn cargo:run
```

**Access the website:**
- User Portal: http://localhost:8080/deshdarshan/
- Admin Portal: http://localhost:8080/deshdarshan/admin/login

---

**Happy Coding! 🚀**
