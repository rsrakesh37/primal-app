# Shared Hosting Setup Guide

## 🚀 Quick Setup for Shared Hosting

Since you're using shared hosting, here's how to resolve the MySQL connection issue:

### Step 1: Check PHP Extensions
1. Upload `phpinfo.php` to your hosting
2. Visit `yourdomain.com/phpinfo.php` in browser
3. Look for MySQL extensions (PDO, MySQLi)

### Step 2: Test Database Connection
1. Upload all backend files to your hosting
2. Visit `yourdomain.com/test_mysqli.php` to test MySQLi connection
3. If PDO is available, use `yourdomain.com/test_connection.php`

### Step 3: Common Shared Hosting Solutions

#### Option A: Use MySQLi (Most Common)
If PDO MySQL is not available but MySQLi is:
1. Replace `require_once 'config/database.php';` with `require_once 'config/database_mysqli.php';` in your controllers
2. Update your controllers to use MySQLi syntax instead of PDO

#### Option B: Contact Hosting Provider
Ask your hosting provider to:
- Enable `pdo_mysql` extension
- Or confirm which MySQL extensions are available

#### Option C: Use Alternative Database Class
I've created `database_mysqli.php` as a backup that works with MySQLi

### Step 4: Database Import
For shared hosting database import:
1. Use cPanel phpMyAdmin or hosting control panel
2. Import your `database.sql` file
3. Ensure database user has proper permissions

### Step 5: File Permissions
Set these permissions on shared hosting:
- Folders: 755
- PHP files: 644
- .htaccess: 644

### Step 6: Update Controllers (if using MySQLi)
If you need to use MySQLi instead of PDO, update your controllers:

```php
// Instead of PDO prepare/execute
$stmt = $db->prepare("SELECT * FROM users WHERE id = ?");
$stmt->execute([$id]);

// Use MySQLi
$stmt = $db->prepare("SELECT * FROM users WHERE id = ?");
$stmt->bind_param("i", $id);
$stmt->execute();
$result = $stmt->get_result();
```

## 🔧 Troubleshooting

### Common Issues:
1. **"could not find driver"** - MySQL extension not enabled
2. **"Access denied"** - Wrong database credentials
3. **"Unknown database"** - Database doesn't exist
4. **"Connection refused"** - Wrong host or MySQL not running

### Solutions:
1. Check `phpinfo.php` for available extensions
2. Verify database credentials in hosting control panel
3. Use `localhost` as host (most common for shared hosting)
4. Contact hosting support if needed

## 📁 File Structure for Upload
```
public_html/
├── api/
│   ├── .htaccess
│   └── index.php
├── config/
│   ├── database.php
│   ├── database_mysqli.php (backup)
│   └── database.sql
├── controllers/
│   ├── AuthController.php
│   ├── BalanceController.php
│   └── UserController.php
├── .htaccess
├── index.php
├── phpinfo.php (for testing)
├── test_connection.php (PDO test)
└── test_mysqli.php (MySQLi test)
```

## 🎯 Next Steps
1. Upload files to your shared hosting
2. Run `phpinfo.php` to check extensions
3. Run appropriate test file
4. Import database via hosting control panel
5. Test API endpoints

Your database is already configured with the correct credentials:
- Database: `rectubmx_primal_app`
- Username: `rectubmx_primal_user`
- Password: `Inferno@8087`