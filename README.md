# Primal Balance - Yoga Training App with Subscription System

A comprehensive yoga training platform built with Flutter (frontend) and PHP (backend), featuring video library, subscription management, admin panel, and multi-platform support.

## 🌟 Live Demo
- **Web App**: [Coming Soon - Deploy to Netlify/Vercel]
- **Backend API**: https://primal-balance.co.uk/app/api/
- **Mobile Apps**: Download from GitHub Actions builds

## ✨ Features

### Core Functionality
- 🧘 **Yoga Video Library**: Extensive collection of yoga training videos
- 📚 **Course Management**: Structured yoga courses and sessions
- 💳 **Subscription System**: Premium and free trial memberships
- 👥 **User Management**: Secure registration and profile management
- 📱 **Multi-Platform**: Native Android, iOS, and responsive web app

### Subscription Features
- 🆓 **Free Trial**: 7-day trial with limited video access
- 💎 **Premium Subscription**: Full access to all videos and features
- ⏰ **Auto-Renewal**: Seamless subscription management
- 🔒 **Content Protection**: Video access based on subscription status

### Admin Features
- 📹 **Video Upload**: Admin panel for uploading yoga videos
- 📊 **User Analytics**: Track user engagement and subscriptions
- 🎯 **Content Management**: Organize videos by difficulty, duration, style
- 💰 **Revenue Tracking**: Monitor subscription revenue and metrics

### Technical Features
- 🚀 **RESTful API**: Clean PHP backend with proper routing
- 🗄️ **MySQL Database**: Structured data storage with user and content management
- 🎨 **Modern UI**: Clean, intuitive Flutter interface optimized for yoga content
- 📱 **Responsive Design**: Works seamlessly across all devices
- 🔄 **State Management**: Efficient app state handling with Provider

## 🏗️ Architecture

### Frontend (Flutter)
- **Framework**: Flutter 3.x with Dart
- **State Management**: Provider pattern
- **Navigation**: Named routes with authentication guards
- **Storage**: Secure storage for tokens and user preferences
- **Video Player**: Integrated video streaming capabilities
- **Subscription UI**: Payment integration and subscription management

### Backend (PHP)
- **Framework**: Custom PHP with clean architecture
- **Database**: MySQL with optimized queries
- **Authentication**: JWT tokens with refresh mechanism
- **File Upload**: Secure video upload system
- **API Design**: RESTful endpoints with proper HTTP status codes
- **Subscription Logic**: Trial periods, renewals, and access control

### Database Schema
```sql
-- Users table with subscription tracking
users (id, username, email, password_hash, subscription_type, trial_end_date, created_at)

-- Videos table for yoga content
videos (id, title, description, file_path, duration, difficulty_level, category, premium_only, created_at)

-- Subscriptions table for payment tracking
subscriptions (id, user_id, plan_type, start_date, end_date, status, payment_method)

-- User progress tracking
user_progress (id, user_id, video_id, watched_duration, completed, last_watched)
```

### Project Structure
```
primal_mobile/
├── lib/
│   ├── models/          # Data models (User, Balance)
│   ├── providers/       # State management (Auth, Balance)
│   ├── screens/         # UI screens (Login, Dashboard)
│   └── services/        # API integration
├── android/             # Android configuration
├── ios/                 # iOS configuration
└── web/                 # Web configuration
```

```
primal_backend/
├── api/
│   └── index.php        # Main API router
├── config/
│   └── database.php     # Database configuration
└── controllers/         # API controllers
```

## 🛠️ Technology Stack

### Frontend
- **Flutter 3.24+** - Cross-platform framework
- **Provider** - State management
- **HTTP** - API communication
- **Flutter Secure Storage** - Secure token storage
- **JSON Annotation** - Model serialization

### Backend
- **PHP 8.0+** - Server-side language
- **MySQL** - Database
- **JWT** - Authentication tokens
- **CORS** - Cross-origin support

## 🚀 Quick Start

### Prerequisites
- Flutter SDK (3.x or higher)
- PHP 8.0+ with MySQL
- Git for version control

### 1. Clone Repository
```bash
git clone https://github.com/rsrakesh37/primal-app.git
cd primal-app
```

### 2. Backend Setup
```bash
cd primal_backend
# Configure database connection in config/database.php
# Import database schema from config/database.sql
# Set up your web server to point to the backend directory
```

### 3. Mobile App Setup
```bash
cd primal_mobile
flutter pub get
flutter run
```

### 4. Configuration
- Update API endpoints in `lib/services/api_service.dart`
- Configure video storage paths in backend
- Set up payment gateway for subscriptions
- Configure admin credentials for video uploads

## 📱 Deployment Methods

### Automated Deployment (Recommended)
1. **Push to GitHub**: Triggers automatic builds
2. **Download Apps**: Get APK/IPA from GitHub Actions
3. **Deploy Backend**: Upload to your hosting provider

### Manual Deployment
```bash
# Build Android APK
flutter build apk --release

# Build iOS (requires macOS)
flutter build ios --release

# Build Web App
flutter build web --release
```

## 📦 Deployment

### Automated Builds (Recommended)
- **Android APK**: Builds automatically on push to `main`
- **iOS IPA**: Manual trigger via GitHub Actions
- **Web App**: Build locally and deploy to hosting

### Manual Builds
- **Android**: Requires Android SDK
- **iOS**: Requires Xcode and macOS
- **Web**: `flutter build web --release`

## 🔧 Configuration

### API Endpoints
```dart
// lib/services/api_service.dart
static const String baseUrl = 'https://primal-balance.co.uk/app/api';
```

### Database Schema
```sql
-- Users table
CREATE TABLE users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    email VARCHAR(255) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Balances table
CREATE TABLE balances (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    amount DECIMAL(10,2) DEFAULT 1000.00,
    currency VARCHAR(3) DEFAULT 'USD',
    FOREIGN KEY (user_id) REFERENCES users(id)
);
```

## 🧪 Testing

### API Testing
```bash
# Health check
curl https://primal-balance.co.uk/app/api/health

# Register user
curl -X POST https://primal-balance.co.uk/app/api/register \
  -H "Content-Type: application/json" \
  -d '{"email":"test@example.com","password":"password123"}'
```

### Mobile Testing
```bash
cd primal_mobile
flutter test
flutter drive --target=test_driver/app.dart
```

## 📱 App Store Deployment

### Google Play Store
1. Generate signed APK with upload key
2. Create store listing with screenshots
3. Upload APK for review

### Apple App Store
1. Apple Developer account required ($99/year)
2. Configure iOS certificates
3. Build with distribution profile
4. Submit via App Store Connect

## 🔒 Security Features

- **Password Hashing**: Secure bcrypt hashing
- **JWT Tokens**: Stateless authentication
- **CORS Protection**: Configured headers
- **Input Validation**: Server-side validation
- **Secure Storage**: Encrypted local storage

## 📊 API Documentation

### Authentication
- `POST /register` - User registration
- `POST /login` - User login

### Balance Management
- `GET /balance` - Get user balance (requires auth)
- `POST /balance` - Update balance (requires auth)

### System
- `GET /health` - API health check

## 🤝 Contributing

1. Fork the repository
2. Create feature branch (`git checkout -b feature/amazing-feature`)
3. Commit changes (`git commit -m 'Add amazing feature'`)
4. Push to branch (`git push origin feature/amazing-feature`)
5. Open Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🆘 Support

- **Documentation**: Check the `docs/` folder
- **Issues**: Create GitHub issue
- **API Status**: `https://primal-balance.co.uk/app/api/health`

## 🎯 Roadmap

- [ ] Transaction categories
- [ ] Expense tracking
- [ ] Budget planning
- [ ] Financial reports
- [ ] Multi-currency support
- [ ] Bank integration

---

**Built with ❤️ using Flutter and PHP**

🌟 **Star this repo if you found it helpful!** 🌟