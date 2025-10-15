# Primal Balance App - Deployment Instructions

## Overview
This guide covers the complete deployment process for the Primal Balance app across all platforms.

## Current Status
✅ **Flutter Web App**: Built successfully (`build/web` folder ready)
❌ **Android APK**: Requires Android SDK installation
❌ **iOS App**: Requires macOS environment
⏳ **Backend**: Ready for deployment
⏳ **Production Configuration**: Needs API endpoint updates

## 1. Backend Deployment (PHP)

### Option A: Shared Hosting (Recommended for beginners)
1. **Upload files** to your hosting provider:
   - Upload all files from `primal_backend/` to your web root
   - Ensure `.htaccess` files are uploaded

2. **Database Setup**:
   - Create a MySQL database
   - Import `config/database.sql` or use the appropriate hosting SQL file
   - Update database credentials in your hosting control panel

3. **Configuration**:
   - Copy `.env.example` to `.env`
   - Update database credentials and API settings
   - Test endpoints using `test_endpoints.php`

### Option B: VPS/Cloud Hosting
1. **Server Requirements**:
   - PHP 7.4+ with MySQL support
   - Apache/Nginx with mod_rewrite
   - SSL certificate (Let's Encrypt recommended)

2. **Deployment Steps**:
   - Clone/upload repository to server
   - Configure virtual host
   - Set up database and import schema
   - Configure environment variables

## 2. Web App Deployment

### Option A: Netlify (Recommended)
1. **Prepare build**:
   ```bash
   cd primal_mobile
   flutter build web --release
   ```

2. **Deploy to Netlify**:
   - Go to [netlify.com](https://netlify.com)
   - Drag and drop the `build/web` folder
   - Configure custom domain (optional)

### Option B: Vercel
1. **Install Vercel CLI**:
   ```bash
   npm i -g vercel
   ```

2. **Deploy**:
   ```bash
   cd primal_mobile/build/web
   vercel --prod
   ```

### Option C: Firebase Hosting
1. **Install Firebase CLI**:
   ```bash
   npm install -g firebase-tools
   ```

2. **Initialize and deploy**:
   ```bash
   firebase login
   firebase init hosting
   firebase deploy
   ```

## 3. Mobile App Builds

### Android APK
**Prerequisites**: Install Android Studio and Android SDK

1. **Install Android Studio**:
   - Download from [developer.android.com/studio](https://developer.android.com/studio)
   - Install Android SDK through Android Studio
   - Accept license agreements

2. **Build APK**:
   ```bash
   cd primal_mobile
   flutter build apk --release
   ```

3. **Output**: APK will be in `build/app/outputs/flutter-apk/app-release.apk`

### iOS App (macOS required)
1. **Prerequisites**:
   - macOS with Xcode installed
   - iOS development certificates
   - Apple Developer account

2. **Build**:
   ```bash
   cd primal_mobile
   flutter build ios --release
   ```

## 4. Production Configuration

### Update API Endpoints
1. **Edit API Service**:
   ```dart
   // lib/services/api_service.dart
   static const String baseUrl = 'https://your-domain.com/api';
   ```

2. **Rebuild apps** after API endpoint changes

### Environment-specific Builds
Consider creating different build flavors for development, staging, and production.

## 5. Testing Checklist

### Backend Testing
- [ ] Health check endpoint responds
- [ ] User registration works
- [ ] User login returns valid token
- [ ] Balance endpoints return data
- [ ] CORS headers configured for web app

### Frontend Testing
- [ ] Web app loads without errors
- [ ] Registration flow works end-to-end
- [ ] Login flow works end-to-end
- [ ] Dashboard displays data correctly
- [ ] Logout functionality works
- [ ] Mobile responsiveness

### Mobile App Testing
- [ ] APK installs on Android device
- [ ] All features work on mobile
- [ ] Network requests succeed
- [ ] Secure storage works
- [ ] App handles offline scenarios

## 6. App Store Deployment

### Google Play Store
1. **Prepare**:
   - Create Google Play Developer account ($25 fee)
   - Generate signed APK with upload key
   - Prepare store listing (screenshots, descriptions)

2. **Upload**:
   - Use Google Play Console
   - Upload APK to internal testing first
   - Submit for review

### Apple App Store
1. **Prepare**:
   - Apple Developer account ($99/year)
   - App Store Connect access
   - iOS build with distribution certificate

2. **Upload**:
   - Use Xcode or Application Loader
   - Submit for App Store review

## 7. Monitoring and Maintenance

### Backend Monitoring
- Set up error logging
- Monitor API response times
- Regular database backups
- Security updates

### App Updates
- Use Flutter's hot reload for development
- Test updates thoroughly before deployment
- Consider staged rollouts for mobile apps

## Quick Start Commands

```bash
# Build web app
cd primal_mobile
flutter build web --release

# Build Android APK (requires Android SDK)
flutter build apk --release

# Test backend locally
cd primal_backend
php -S localhost:8000

# Deploy to Netlify (drag and drop build/web folder)
# Deploy to Vercel
cd primal_mobile/build/web && vercel --prod
```

## Support

For deployment issues:
1. Check Flutter doctor: `flutter doctor`
2. Verify backend endpoints with test files
3. Check browser console for web app errors
4. Review server logs for backend issues

## Security Notes

- Never commit API keys or passwords
- Use HTTPS for all production deployments
- Implement rate limiting on API endpoints
- Regular security updates for dependencies
- Use secure storage for sensitive data