# 🚀 GitHub Repository Setup

## Quick Setup Instructions

### 1. Create GitHub Repository
1. Go to [github.com](https://github.com)
2. Click "New repository"
3. Name: `primal-balance` (or your preferred name)
4. Description: "Complete financial management app with Flutter and PHP"
5. Set to **Public** (for GitHub Actions to work)
6. **Don't** initialize with README (we already have one)
7. Click "Create repository"

### 2. Connect Local Repository
```bash
# Add your GitHub repository as remote origin
git remote add origin https://github.com/YOURUSERNAME/primal-balance.git

# Push to GitHub
git push -u origin main
```

### 3. Verify GitHub Actions
After pushing, check:
1. Go to your repository on GitHub
2. Click "Actions" tab
3. You should see "Android APK Build" workflow running
4. Wait for it to complete (about 5-10 minutes)

### 4. Download Mobile Apps
Once GitHub Actions completes:
1. Go to "Actions" tab
2. Click on the completed workflow run
3. Scroll down to "Artifacts" section
4. Download "android-apk" artifact
5. Extract and install the APK on Android device

### 5. Build iOS App (Optional)
For iOS app:
1. Go to "Actions" tab
2. Click "iOS IPA Build" workflow
3. Click "Run workflow" button
4. Wait for completion
5. Download "ios-ipa" artifact

## 🎯 What Happens After Push

### Automatic Android Build
- Triggers on every push to `main` branch
- Builds release APK
- Uploads as downloadable artifact
- Takes about 5-10 minutes

### Manual iOS Build
- Requires manual trigger
- Builds IPA file
- Requires Apple Developer account for distribution
- Takes about 10-15 minutes

## 📱 Testing Your Apps

### Web App
```bash
cd primal_mobile
flutter build web --release
# Deploy build/web folder to Netlify/Vercel
```

### Android APK
1. Download from GitHub Actions artifacts
2. Enable "Unknown sources" on Android device
3. Install APK file
4. Test registration and login

### iOS IPA
1. Download from GitHub Actions artifacts
2. Requires Apple Developer account
3. Install via TestFlight or direct installation
4. Test on iOS device

## 🔧 Repository Structure
```
primal-balance/
├── .github/workflows/     # GitHub Actions
├── primal_backend/        # PHP backend
├── primal_mobile/         # Flutter app
├── README.md             # Project documentation
└── deployment guides/    # Deployment instructions
```

## ✅ Success Checklist
- [ ] Repository created on GitHub
- [ ] Code pushed successfully
- [ ] Android APK builds automatically
- [ ] APK downloads and installs
- [ ] App connects to production API
- [ ] Registration and login work
- [ ] Dashboard displays balance

## 🆘 Troubleshooting

### GitHub Actions Fails
- Check workflow logs in Actions tab
- Ensure repository is public
- Verify all files are committed

### APK Won't Install
- Enable "Unknown sources" in Android settings
- Check APK is not corrupted
- Try different Android device

### API Connection Issues
- Verify API is live: `https://primal-balance.co.uk/app/api/health`
- Check network connectivity
- Ensure CORS headers are configured

## 🎉 Next Steps
1. **Push to GitHub** → Automatic Android build
2. **Deploy web app** → Netlify/Vercel
3. **Test everything** → End-to-end testing
4. **Share with users** → Your app is live!

---

**Your complete financial app is ready for the world! 🌟**