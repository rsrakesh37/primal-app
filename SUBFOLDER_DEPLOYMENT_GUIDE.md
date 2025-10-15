# 🚀 Primal Balance Backend - Subfolder Deployment Guide

## 📁 **Subfolder Installation (Preserves Landing Page)**

This guide helps you deploy the Primal Balance backend in a subfolder (`/app/`) without affecting your existing landing page.

---

## 🎯 **Deployment Structure**

```
public_html/
├── 🌐 index.html              # Your existing landing page (untouched)
├── 📂 app/                    # New subfolder for backend
│   ├── 🔧 index.php           # API entry point
│   ├── ⚙️ .htaccess           # Apache config (subfolder-ready)
│   ├── 📦 composer.json       # Dependencies
│   ├── 🔐 .env                # Environment config
│   ├── 📂 config/
│   │   ├── 🗄️ database.php    # Database connection
│   │   └── 📊 database.sql    # Database schema
│   └── 📂 controllers/
│       ├── 🔐 AuthController.php
│       ├── 👤 UserController.php
│       └── 💰 BalanceController.php
```

---

## 📤 **Step 1: Upload Files**

### **Method 1: Via cPanel File Manager**
1. **Login** to your cPanel
2. **Open** File Manager
3. **Navigate** to `public_html/`
4. **Create** new folder named `app`
5. **Upload** `primal_backend_deployment.zip` to `public_html/app/`
6. **Extract** the zip file inside the `app` folder
7. **Move** all extracted files to the root of `app/` folder

### **Method 2: Via FTP**
1. **Connect** to your server via FTP
2. **Navigate** to `public_html/`
3. **Create** directory `app/`
4. **Upload** all backend files to `public_html/app/`

---

## 🗄️ **Step 2: Database Setup**

### **Create Database:**
1. **cPanel** → MySQL Databases
2. **Create** database: `your_domain_primal`
3. **Create** user with full privileges
4. **Import** `config/database.sql`

### **Alternative: phpMyAdmin**
1. **Access** phpMyAdmin
2. **Create** new database
3. **Import** the `database.sql` file

---

## ⚙️ **Step 3: Environment Configuration**

### **Create .env file:**
```bash
# Copy the example file
cp .env.example .env
```

### **Edit .env with your details:**
```env
# Database Configuration
DB_HOST=localhost
DB_NAME=your_domain_primal
DB_USER=your_db_user
DB_PASS=your_db_password

# JWT Configuration
JWT_SECRET=your-super-secret-jwt-key-here
JWT_EXPIRY=3600

# API Configuration
API_VERSION=v1
API_BASE_URL=https://yourdomain.com/app/api

# Environment
ENVIRONMENT=production

# Security
CORS_ORIGIN=https://yourdomain.com
ALLOWED_ORIGINS=https://yourdomain.com,https://www.yourdomain.com

# File Upload (if needed)
UPLOAD_MAX_SIZE=5242880
UPLOAD_PATH=uploads/
```

---

## 🔧 **Step 4: Install Dependencies**

### **Via SSH (if available):**
```bash
cd public_html/app
composer install --no-dev --optimize-autoloader
```

### **Via cPanel Terminal (if available):**
```bash
cd public_html/app
php composer.phar install --no-dev
```

### **Manual Upload (if no SSH/Terminal):**
- Dependencies are already included in the deployment package

---

## ✅ **Step 5: Test Your API**

### **API Base URL:**
```
https://yourdomain.com/app/api/
```

### **Test Endpoints:**

#### **1. Health Check:**
```bash
GET https://yourdomain.com/app/api/health
```
**Expected Response:**
```json
{
    "status": "success",
    "message": "API is running",
    "version": "1.0.0"
}
```

#### **2. User Registration:**
```bash
POST https://yourdomain.com/app/api/auth/register
Content-Type: application/json

{
    "username": "testuser",
    "email": "test@example.com",
    "password": "password123"
}
```

#### **3. User Login:**
```bash
POST https://yourdomain.com/app/api/auth/login
Content-Type: application/json

{
    "email": "test@example.com",
    "password": "password123"
}
```

---

## 📱 **Step 6: Update Mobile App**

### **Update API URL in Flutter App:**
In your Flutter app, update the base URL to:
```dart
const String API_BASE_URL = 'https://yourdomain.com/app/api';
```

---

## 🔒 **Security Checklist**

- [ ] ✅ `.env` file is not publicly accessible
- [ ] ✅ Database credentials are secure
- [ ] ✅ JWT secret is strong and unique
- [ ] ✅ CORS origins are properly configured
- [ ] ✅ HTTPS is enabled
- [ ] ✅ File permissions are correct (644 for files, 755 for directories)

---

## 🐛 **Troubleshooting**

### **Common Issues:**

#### **1. 404 Error on API calls:**
- Check if `.htaccess` is uploaded
- Verify mod_rewrite is enabled
- Ensure RewriteBase is set to `/app/`

#### **2. Database Connection Error:**
- Verify database credentials in `.env`
- Check if database exists
- Ensure database user has proper privileges

#### **3. CORS Errors:**
- Update `CORS_ORIGIN` in `.env`
- Check `ALLOWED_ORIGINS` configuration

#### **4. 500 Internal Server Error:**
- Check server error logs
- Verify PHP version (7.4+ required)
- Ensure all required PHP extensions are installed

---

## 📞 **Support**

### **Server Requirements:**
- **PHP:** 7.4 or higher
- **MySQL:** 5.7 or higher
- **Apache:** with mod_rewrite enabled
- **Extensions:** PDO, PDO_MySQL, JSON, OpenSSL

### **File Permissions:**
```bash
find public_html/app -type f -exec chmod 644 {} \;
find public_html/app -type d -exec chmod 755 {} \;
chmod 600 public_html/app/.env
```

---

## 🎉 **Final URLs**

- **Landing Page:** `https://yourdomain.com/` (unchanged)
- **API Base:** `https://yourdomain.com/app/api/`
- **Health Check:** `https://yourdomain.com/app/api/health`

Your existing landing page remains completely untouched! 🎯