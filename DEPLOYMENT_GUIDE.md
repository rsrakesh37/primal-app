# 🚀 Primal Balance Deployment Guide

## 📱 Android APK Build Status

**✅ APK Build Triggered!**

### Get Your APK:
1. Go to: `https://github.com/rsrakesh37/primal-app/actions`
2. Click on the latest "Android APK Build" workflow run
3. Wait for completion (~5-10 minutes)
4. Download APK from "Artifacts" section
5. Install on Android device for testing

---

## 🔧 Backend Server Deployment

### Files to Upload to Your Web Server:

```
primal_backend/
├── index.php              # Main API entry point
├── .htaccess              # Apache configuration
├── composer.json          # PHP dependencies
├── .env                   # Environment config (create from .env.example)
├── config/
│   ├── database.php       # Database connection
│   └── database.sql       # Database schema & sample data
└── controllers/
    ├── AuthController.php # User authentication
    ├── UserController.php # User management
    └── BalanceController.php # Balance tracking
```

### 📋 Server Requirements:
- **PHP 7.4+** with extensions: PDO, PDO_MySQL, JSON, OpenSSL
- **MySQL 5.7+** or **MariaDB 10.2+**
- **Apache** with mod_rewrite enabled
- **HTTPS** SSL certificate (recommended)

### 🛠️ Installation Steps:

#### 1. Upload Files
Upload all files from `primal_backend/` to your web server's public directory

#### 2. Database Setup
```sql
-- Create database
CREATE DATABASE primal_balance;

-- Import schema and sample data
mysql -u username -p primal_balance < config/database.sql
```

#### 3. Environment Configuration
```bash
# Copy and edit environment file
cp .env.example .env
```

Edit `.env` with your actual values:
```env
DB_HOST=localhost
DB_NAME=primal_balance
DB_USER=your_actual_db_username
DB_PASS=your_actual_db_password
JWT_SECRET=generate_a_strong_random_key_here
```

#### 4. Install Dependencies (if Composer available)
```bash
composer install --no-dev --optimize-autoloader
```

#### 5. Set Permissions
```bash
chmod 644 *.php
chmod 644 .htaccess
chmod 600 .env
```

### 🔗 API Endpoints

Your API will be available at: `https://yourdomain.com/api/`

**Test endpoint:** `GET https://yourdomain.com/api/health`
Should return: `{"status": "OK", "message": "API is running"}`

### 📱 Configure Mobile App

Update your Flutter app's API base URL to point to your server:
```dart
// In your Flutter app
const String API_BASE_URL = 'https://yourdomain.com/api';
```

---

## 🧪 Testing Checklist

### Backend Testing:
- [ ] Health check: `GET /api/health`
- [ ] User registration: `POST /api/auth/register`
- [ ] User login: `POST /api/auth/login`
- [ ] Protected endpoints with JWT token

### APK Testing:
- [ ] Install APK on Android device
- [ ] Test user registration
- [ ] Test user login
- [ ] Test balance management features
- [ ] Test API connectivity

---

## 🔒 Security Notes

1. **Change JWT Secret** - Generate a strong random key
2. **Use HTTPS** - Never use HTTP in production
3. **Database Security** - Use strong passwords and limited privileges
4. **File Permissions** - Ensure `.env` is not publicly accessible
5. **Regular Updates** - Keep PHP and MySQL updated

---

## 🆘 Troubleshooting

### Common Issues:

**500 Internal Server Error:**
- Check PHP error logs
- Verify database connection
- Ensure all required PHP extensions are installed

**CORS Issues:**
- Update `CORS_ORIGIN` in `.env`
- Check `.htaccess` CORS headers

**Database Connection Failed:**
- Verify database credentials in `.env`
- Ensure MySQL service is running
- Check database user permissions

### Support:
- Check server error logs: `/var/log/apache2/error.log`
- PHP error logs: Check your hosting control panel
- Test API endpoints with tools like Postman or curl

---

## 📞 Next Steps

1. **Deploy Backend** - Upload files and configure database
2. **Test APK** - Download from GitHub Actions and install
3. **Configure Domain** - Point your domain to the server
4. **SSL Certificate** - Enable HTTPS for security
5. **iOS Build** - Set up Apple Developer account when ready