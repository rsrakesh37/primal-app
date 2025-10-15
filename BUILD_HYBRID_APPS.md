# Build Hybrid Apps (Android APK + iOS IPA)

## 🎯 Overview
Your project is already configured for **hybrid app development** using GitHub Actions! No need to install Android SDK or macOS locally.

## 🚀 Quick Build Process

### Step 1: Push to GitHub
```bash
# Make sure your code is on GitHub
git add .
git commit -m "Ready for hybrid build"
git push origin main
```

### Step 2: Trigger Builds

#### Option A: Automatic Builds
- **Android APK**: Builds automatically on every push to `main` branch
- **iOS IPA**: Manual trigger only (to save resources)

#### Option B: Manual Builds
1. Go to your GitHub repository
2. Click **Actions** tab
3. Select the workflow you want:
   - "Android APK Build" for Android
   - "iOS IPA Build" for iOS
4. Click **Run workflow**

### Step 3: Download Built Apps
1. After build completes, go to **Actions** tab
2. Click on the completed workflow run
3. Download artifacts:
   - `primal_mobile-apk` (Android app)
   - `primal_mobile-ipa` (iOS app)

## 📱 What You Get

### Android APK
- **File**: `app-release.apk`
- **Install**: Direct install on Android devices
- **Distribution**: Share via file, upload to Google Play Store

### iOS IPA
- **File**: `Runner.ipa`
- **Install**: Requires iOS developer account for distribution
- **Distribution**: TestFlight, App Store, or enterprise distribution

## 🔧 Local Development Alternative

If you prefer local builds:

### For Android (Windows/Linux/Mac):
```bash
# Install Android Studio (includes Android SDK)
# Download from: https://developer.android.com/studio

# After installation:
flutter doctor  # Check if Android toolchain is detected
flutter build apk --release
```

### For iOS (macOS only):
```bash
# Install Xcode from Mac App Store
# Install CocoaPods: sudo gem install cocoapods

flutter build ios --release
```

## 🌐 Cross-Platform Benefits

### GitHub Actions Advantages:
✅ **No local setup required**
✅ **Consistent build environment**
✅ **Automated on code changes**
✅ **Both platforms from any OS**
✅ **Free for public repositories**

### Local Build Advantages:
✅ **Faster iteration during development**
✅ **No internet dependency**
✅ **Full control over build process**

## 🎯 Recommended Workflow

1. **Development**: Use `flutter run` for testing
2. **Testing**: Use GitHub Actions for release builds
3. **Distribution**: Download artifacts from GitHub Actions

## 📋 Prerequisites for iOS Build

The iOS workflow requires these GitHub Secrets:
- `APP_STORE_CONNECT_API_KEY_ID`
- `APP_STORE_CONNECT_API_ISSUER_ID`
- `APP_STORE_CONNECT_API_KEY_CONTENT`
- `IOS_EXPORT_METHOD`

**Note**: iOS builds require Apple Developer account ($99/year)

## 🚀 Next Steps

1. **Push your code** to GitHub
2. **Trigger Android build** (automatic or manual)
3. **Set up iOS secrets** if you have Apple Developer account
4. **Download and test** both apps
5. **Deploy to app stores** when ready

## 💡 Pro Tips

- **Android**: Can be built and tested immediately
- **iOS**: Requires Apple Developer setup for device testing
- **Web**: Already built locally in `build/web` folder
- **Testing**: Use Android APK for immediate testing on any Android device