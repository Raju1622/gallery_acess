# DeshDarshan - Explore the Culture, Cuisine & Heritage of India

## 🎉 Website Successfully Running!

**URL:** http://localhost:8080/deshdarshan/

---

## ✅ What's Already Done:

- ✅ Complete Java Backend (Servlets, DAOs, Models)
- ✅ JSP Frontend Pages (Home, States, Admin Panel)
- ✅ Database Schema Created
- ✅ Responsive Design (Bootstrap + Custom CSS)
- ✅ Maven Build Configuration
- ✅ Tomcat Server Running

---

## 📋 Complete Features:

### **User Features:**
1. **Home Page** - Welcome page with featured states
2. **State Listing** - Browse all Indian states
3. **State Details** - View details of each state including:
   - Capital, Population, Language, Area, Climate
   - Famous Tourist Places
   - Hidden/Underrated Places
   - Famous Foods
4. **Search** - Search states by name

### **Admin Panel:**
- **URL:** http://localhost:8080/deshdarshan/admin/login
- **Username:** admin
- **Password:** admin123

**Admin Features:**
- Dashboard with statistics
- Manage States (Add, Edit, Delete)
- Manage Famous Places (Add, Edit, Delete)
- Manage Hidden Places (Add, Edit, Delete)
- Manage Famous Foods (Add, Edit, Delete)
- Secure login with SHA-256 password hashing

---

## ⚠️ Database Setup Required

**Database is NOT YET SET UP!** The website will show database errors until you complete this step.

### Step 1: Access MySQL

```bash
mysql -u root -p
```

### Step 2: Run the Schema

```sql
source database/schema.sql
```

Or manually copy-paste the SQL from `database/schema.sql` into MySQL Workbench/phpMyAdmin.

### What the Schema Includes:
- **Database:** `deshdarshan`
- **Tables:**
  - `admin_users` (Admin login)
  - `state` (State information)
  - `famous_places` (Tourist destinations)
  - `hidden_places` (Hidden gems)
  - `famous_foods` (State cuisines)
- **Sample Data:** 3 states (UP, Maharashtra, Rajasthan) with places and foods
- **Default Admin:** username: `admin`, password: `admin123`

---

## 🚀 How to Use:

### Start the Server:
```bash
mvn cargo:run
```

### Stop the Server:
Press `Ctrl+C` in the terminal

### Rebuild and Run:
```bash
mvn clean package && mvn cargo:run
```

---

## 📁 Project Structure:

```
gallery_acess/
├── database/
│   └── schema.sql                  # MySQL database schema
├── src/main/
│   ├── java/com/deshdarshan/
│   │   ├── dao/                    # Database Access Objects
│   │   ├── model/                  # Data models
│   │   ├── servlet/                # Servlets (Controllers)
│   │   └── util/                   # Utilities
│   └── webapp/
│       ├── WEB-INF/
│       │   ├── jsp/                # JSP pages
│       │   ├── db.properties       # Database config
│       │   └── web.xml             # Web config
│       └── css/
│           └── style.css           # Custom styles
├── pom.xml                         # Maven config
└── SETUP_INSTRUCTIONS.md          # This file
```

---

## 🛠️ Technology Stack:

**Frontend:**
- HTML5, CSS3
- Bootstrap 5.3
- JavaScript, jQuery

**Backend:**
- Java 11
- JSP & Servlet
- JSTL

**Database:**
- MySQL 8.x
- JDBC

**Server:**
- Apache Tomcat 9.x (Embedded via Cargo Maven Plugin)

**Build Tool:**
- Apache Maven

---

## 📝 Adding More States:

1. Login to Admin Panel
2. Go to "Manage States"
3. Click "Add New State"
4. Fill in the details
5. Add places and foods for that state

---

## 🎯 Project Synopsis Match:

This project matches the PDF synopsis requirements:

✅ **Title:** DeshDarshan – Explore the Culture, Cuisine & Heritage of India
✅ **Tech Stack:** HTML, CSS, Bootstrap, JavaScript, JSP, MySQL
✅ **Modules:** Home, States, Famous Places, Hidden Places, Foods, Admin Panel
✅ **Database:** State, Famous_Places, Hidden_Places, Famous_Foods tables
✅ **Features:** Search, CRUD operations, Responsive design

---

## 📞 Support:

For any issues:
1. Check if MySQL is running
2. Verify database is created and populated
3. Check `db.properties` has correct MySQL password
4. Ensure port 8080 is not in use by other applications

---

**🎓 Developed By:** Ganeshu Keshari (12524407034)
**🏫 College:** Mahadev P.G. College, Bariyasanpur, Varanasi
**📚 Course:** BCA (Session 2025-2026, Semester 6th)
