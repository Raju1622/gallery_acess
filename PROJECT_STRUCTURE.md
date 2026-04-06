# DeshDarshan - Professional Project Structure

## Technology Stack
- **Front-End:** HTML, CSS, JavaScript, jQuery, Bootstrap
- **Back-End:** JSP, Servlet
- **Database:** MySQL

---

## Complete Folder Structure

```
gallery_acess/
│
├── database/                          # Database Scripts
│   ├── schema.sql                     # Database schema & initial data
│   └── bharatyatra_schema.sql         # BharatYatra schema (if needed)
│
├── src/main/
│   │
│   ├── java/com/deshdarshan/         # BACKEND - Java Code
│   │   │
│   │   ├── servlet/                   # Servlets (Controllers)
│   │   │   ├── user/                  # User Portal Servlets
│   │   │   │   ├── HomeServlet.java
│   │   │   │   ├── StateListServlet.java
│   │   │   │   ├── StateDetailServlet.java
│   │   │   │   └── SearchServlet.java
│   │   │   │
│   │   │   └── admin/                 # Admin Portal Servlets
│   │   │       ├── AdminLoginServlet.java
│   │   │       ├── AdminLogoutServlet.java
│   │   │       ├── AdminDashboardServlet.java
│   │   │       ├── AdminStatesServlet.java
│   │   │       ├── AdminPlacesServlet.java
│   │   │       └── AdminFoodsServlet.java
│   │   │
│   │   ├── dao/                       # Data Access Objects
│   │   │   ├── AdminDAO.java
│   │   │   ├── StateDAO.java
│   │   │   ├── FamousPlaceDAO.java
│   │   │   ├── HiddenPlaceDAO.java
│   │   │   └── FamousFoodDAO.java
│   │   │
│   │   ├── model/                     # Data Models (POJOs)
│   │   │   ├── AdminUser.java
│   │   │   ├── State.java
│   │   │   ├── FamousPlace.java
│   │   │   ├── HiddenPlace.java
│   │   │   └── FamousFood.java
│   │   │
│   │   ├── filter/                    # Filters
│   │   │   └── AdminAuthFilter.java   # Admin authentication filter
│   │   │
│   │   └── util/                      # Utility Classes
│   │       ├── DBUtil.java            # Database connection
│   │       └── PasswordUtil.java      # Password hashing
│   │
│   └── webapp/                        # FRONTEND - Web Resources
│       │
│       ├── WEB-INF/
│       │   │
│       │   ├── jsp/
│       │   │   │
│       │   │   ├── user/              # USER PORTAL - JSP Pages
│       │   │   │   ├── home.jsp       # Homepage
│       │   │   │   ├── states.jsp     # States listing
│       │   │   │   ├── state-detail.jsp
│       │   │   │   ├── search-results.jsp
│       │   │   │   └── includes/      # Reusable components
│       │   │   │       ├── header.jsp
│       │   │   │       ├── footer.jsp
│       │   │   │       └── navbar.jsp
│       │   │   │
│       │   │   └── admin/             # ADMIN PORTAL - JSP Pages
│       │   │       ├── login.jsp      # Admin login
│       │   │       ├── dashboard.jsp  # Admin dashboard
│       │   │       ├── states-list.jsp
│       │   │       ├── state-form.jsp
│       │   │       ├── places-manage.jsp
│       │   │       ├── place-form.jsp
│       │   │       ├── foods-manage.jsp
│       │   │       ├── food-form.jsp
│       │   │       └── includes/      # Admin reusable components
│       │   │           ├── admin-header.jsp
│       │   │           ├── admin-sidebar.jsp
│       │   │           └── admin-footer.jsp
│       │   │
│       │   ├── web.xml                # Servlet mappings
│       │   └── db.properties          # Database configuration
│       │
│       ├── css/                       # Stylesheets
│       │   ├── user/                  # User portal CSS
│       │   │   └── style.css
│       │   └── admin/                 # Admin portal CSS
│       │       └── admin-style.css
│       │
│       ├── js/                        # JavaScript Files
│       │   ├── user/                  # User portal JS
│       │   │   └── main.js
│       │   └── admin/                 # Admin portal JS
│       │       └── admin.js
│       │
│       ├── images/                    # Static Images
│       │   ├── user/
│       │   └── admin/
│       │
│       └── index.jsp                  # Entry point (redirects to home)
│
├── target/                            # Build output (auto-generated)
│
├── pom.xml                            # Maven configuration
├── PROJECT_STRUCTURE.md               # This file
├── BHARATYATRA_README.md              # Project documentation
└── SETUP_INSTRUCTIONS.md              # Setup guide
```

---

## URL Structure

### User Portal URLs
- `http://localhost:8080/deshdarshan/` - Homepage
- `http://localhost:8080/deshdarshan/states` - Browse states
- `http://localhost:8080/deshdarshan/state?id=1` - State details
- `http://localhost:8080/deshdarshan/search?q=keyword` - Search

### Admin Portal URLs
- `http://localhost:8080/deshdarshan/admin/login` - Admin login
- `http://localhost:8080/deshdarshan/admin/dashboard` - Dashboard
- `http://localhost:8080/deshdarshan/admin/states` - Manage states
- `http://localhost:8080/deshdarshan/admin/places` - Manage places
- `http://localhost:8080/deshdarshan/admin/foods` - Manage foods

---

## Architecture Overview

### 1. USER PORTAL (Frontend for Users)
**Location:** `src/main/webapp/WEB-INF/jsp/user/`

**Technologies:** HTML, CSS, JavaScript, jQuery, Bootstrap

**Pages:**
- Home page with featured content
- States listing with search
- State detail pages
- Responsive design

### 2. ADMIN PORTAL (Management Interface)
**Location:** `src/main/webapp/WEB-INF/jsp/admin/`

**Technologies:** HTML, CSS, JavaScript, jQuery, Bootstrap

**Features:**
- Secure login system
- Dashboard with statistics
- CRUD operations for all entities
- Admin-only access (protected by filter)

### 3. BACKEND (Business Logic)
**Location:** `src/main/java/com/deshdarshan/`

**Technologies:** Java, JSP, Servlet

**Components:**
- **Servlets:** Handle HTTP requests (Controllers)
- **DAOs:** Database operations (Data Access)
- **Models:** Java classes for data (POJOs)
- **Filters:** Authentication & security
- **Utils:** Helper classes (DB, Password)

### 4. DATABASE
**Location:** `database/schema.sql`

**Technology:** MySQL

**Tables:**
- `admin_users` - Admin authentication
- `state` - State information
- `famous_places` - Tourist destinations
- `hidden_places` - Hidden gems
- `famous_foods` - State cuisines

---

## Benefits of This Structure

✅ **Clear Separation:** User portal, Admin portal, Backend clearly separated
✅ **Organized:** Easy to find files and maintain code
✅ **Scalable:** Easy to add new features
✅ **Standard:** Follows Java web application best practices
✅ **Secure:** Admin portal protected by authentication filter
✅ **Maintainable:** Logical grouping of related files

---

## Next Steps

1. **Setup Database:** Run `database/schema.sql`
2. **Configure:** Update `WEB-INF/db.properties` with MySQL credentials
3. **Build:** `mvn clean package`
4. **Run:** `mvn cargo:run`
5. **Access:** http://localhost:8080/deshdarshan/

---

## Development Guidelines

### Adding New User Feature:
1. Create servlet in `servlet/user/`
2. Create JSP in `WEB-INF/jsp/user/`
3. Add CSS in `css/user/`
4. Add JavaScript in `js/user/`

### Adding New Admin Feature:
1. Create servlet in `servlet/admin/`
2. Create JSP in `WEB-INF/jsp/admin/`
3. Add authentication check
4. Update admin navigation

### Adding New Database Entity:
1. Create model class in `model/`
2. Create DAO in `dao/`
3. Create servlet(s) for operations
4. Create JSP pages for UI
5. Add database table

---

**Project:** DeshDarshan - Explore Culture, Cuisine & Heritage of India
**Developer:** Ganeshu Keshari
**Technology Stack:** HTML, CSS, JavaScript, jQuery, Bootstrap, JSP, Servlet, MySQL
