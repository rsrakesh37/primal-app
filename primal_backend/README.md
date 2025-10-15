# Primal Balance Backend API

A PHP REST API backend for the Primal Balance mobile application.

## Features

- User authentication (register/login) with JWT tokens
- User profile management
- Balance tracking with income/expense records
- Transaction history with pagination and filtering
- MySQL database integration
- CORS support for mobile app integration

## Requirements

- PHP 7.4 or higher
- MySQL 5.7 or higher
- Apache web server (with mod_rewrite enabled)
- Composer (optional, for dependency management)

## Installation

1. **Database Setup**
   ```bash
   mysql -u root -p < config/database.sql
   ```

2. **Environment Configuration**
   Set the following environment variables or update `config/database.php`:
   - `DB_HOST` (default: localhost)
   - `DB_NAME` (default: primal_balance)
   - `DB_USER` (default: root)
   - `DB_PASS` (default: empty)

3. **Web Server Setup**
   - Copy files to your web server document root
   - Ensure Apache mod_rewrite is enabled
   - The `.htaccess` file handles URL routing

4. **Test the API**
   ```bash
   curl http://your-domain/api/health
   ```

## API Endpoints

### Authentication
- `POST /api/auth/register` - Register new user
- `POST /api/auth/login` - User login

### User Management
- `GET /api/user/profile` - Get user profile (requires auth)
- `PUT /api/user/profile` - Update user profile (requires auth)

### Balance Management
- `GET /api/balance` - Get current balance and recent transactions (requires auth)
- `POST /api/balance` - Add new income/expense record (requires auth)
- `GET /api/balance/history` - Get transaction history with pagination (requires auth)

### System
- `GET /api/health` - Health check endpoint

## Request/Response Examples

### Register User
```bash
curl -X POST http://your-domain/api/auth/register \
  -H "Content-Type: application/json" \
  -d '{
    "email": "user@example.com",
    "password": "password123",
    "first_name": "John",
    "last_name": "Doe"
  }'
```

### Login
```bash
curl -X POST http://your-domain/api/auth/login \
  -H "Content-Type: application/json" \
  -d '{
    "email": "user@example.com",
    "password": "password123"
  }'
```

### Add Transaction
```bash
curl -X POST http://your-domain/api/balance \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer YOUR_JWT_TOKEN" \
  -d '{
    "amount": 100.50,
    "type": "income",
    "description": "Freelance work",
    "category": "work"
  }'
```

### Get Balance
```bash
curl -X GET http://your-domain/api/balance \
  -H "Authorization: Bearer YOUR_JWT_TOKEN"
```

## Security Features

- Password hashing with PHP's `password_hash()`
- JWT token authentication
- Input validation and sanitization
- SQL injection prevention with prepared statements
- CORS headers for cross-origin requests
- Security headers in .htaccess

## Database Schema

### Users Table
- `id` - Primary key
- `email` - Unique user email
- `password_hash` - Hashed password
- `first_name`, `last_name` - User names
- `phone` - Phone number
- `created_at`, `updated_at` - Timestamps

### Balance Records Table
- `id` - Primary key
- `user_id` - Foreign key to users
- `amount` - Transaction amount
- `description` - Transaction description
- `type` - 'income' or 'expense'
- `category` - Transaction category
- `created_at` - Timestamp

## Development

### Local Development Server
```bash
php -S localhost:8000
```

### Testing
The API includes a demo user:
- Email: `demo@primal-balance.co.uk`
- Password: `password` (hash: `$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi`)

## Deployment

1. Upload files to your web hosting provider
2. Create MySQL database and import schema
3. Update database configuration
4. Ensure proper file permissions
5. Test API endpoints

## License

MIT License