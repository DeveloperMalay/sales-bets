# 🔐 Firebase Security Setup Guide

## ⚠️ IMPORTANT: Environment Variables Required

This project now uses **environment variables** to secure Firebase credentials. The Firebase keys are **NOT** hardcoded in the source code.

## 🚀 Quick Setup

### 1. Create Environment File

Copy the example environment file:
```bash
cp .env.example .env
```

### 2. Fill in Your Firebase Credentials

Open `.env` file and replace the placeholder values with your actual Firebase credentials:

```bash
# Firebase Configuration - DO NOT COMMIT TO VERSION CONTROL
# Web
FIREBASE_WEB_API_KEY=your_actual_web_api_key_here
FIREBASE_WEB_APP_ID=your_actual_web_app_id_here
FIREBASE_WEB_MEASUREMENT_ID=your_actual_measurement_id_here

# Android
FIREBASE_ANDROID_API_KEY=your_actual_android_api_key_here
FIREBASE_ANDROID_APP_ID=your_actual_android_app_id_here

# Common
FIREBASE_PROJECT_ID=your_actual_project_id_here
FIREBASE_MESSAGING_SENDER_ID=your_actual_messaging_sender_id_here
FIREBASE_STORAGE_BUCKET=your_project_id.firebasestorage.app
FIREBASE_AUTH_DOMAIN=your_project_id.firebaseapp.com
```

### 3. Get Your Firebase Credentials

#### From Firebase Console:
1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Select your project: `sales-bets-79e8a`
3. Go to **Project Settings** (gear icon)
4. Scroll down to **Your apps** section
5. Click on your Web/Android app
6. Copy the configuration values to your `.env` file

#### From google-services.json (Android):
```json
{
  "project_info": {
    "project_id": "sales-bets-79e8a",        // FIREBASE_PROJECT_ID
    "project_number": "591223589431"         // FIREBASE_MESSAGING_SENDER_ID
  },
  "client": [{
    "client_info": {
      "mobilesdk_app_id": "1:591223589431:android:xxx", // FIREBASE_ANDROID_APP_ID
    },
    "api_key": [{
      "current_key": "AIzaSyBxxx"           // FIREBASE_ANDROID_API_KEY
    }]
  }]
}
```

## 🛡️ Security Features

### ✅ What's Secure Now:
- **No hardcoded API keys** in source code
- **Environment variables** for all Firebase credentials
- **.env file excluded** from version control
- **Separate configs** for different platforms (Web, Android, iOS)

### ✅ Files Protected:
- `.env` - Your actual credentials (gitignored)
- `android/app/google-services.json` - Android config (gitignored)
- `ios/Runner/GoogleService-Info.plist` - iOS config (gitignored)

### ✅ What's Committed:
- `.env.example` - Template with placeholder values
- `firebase_options.dart` - Secure implementation using environment variables

## 🔧 Development Setup

```bash
# 1. Clone the repository
git clone <your-repo-url>
cd sales_bets

# 2. Install dependencies
flutter pub get

# 3. Create your .env file (see steps above)
cp .env.example .env

# 4. Add your Firebase credentials to .env file
# (edit .env with your actual values)

# 5. Run the app
flutter run
```

## 🚨 Production Deployment

### For different environments, create separate .env files:
- `.env` - Development
- `.env.staging` - Staging environment  
- `.env.production` - Production environment

### CI/CD Setup:
Set environment variables in your CI/CD platform:
- GitHub Actions: Repository secrets
- Firebase Hosting: Environment variables
- Other platforms: Platform-specific environment variable settings

## 🔍 Troubleshooting

### Error: "No Firebase option found"
- ✅ Check that `.env` file exists
- ✅ Verify all required variables are set in `.env`
- ✅ Restart your app after changing `.env`

### Error: "Firebase initialization failed"
- ✅ Verify your Firebase credentials are correct
- ✅ Check that your Firebase project is active
- ✅ Ensure your app is registered in Firebase Console

## 📝 Environment Variables Reference

| Variable | Description | Example |
|----------|-------------|---------|
| `FIREBASE_WEB_API_KEY` | Web app API key | `AIzaSyC...` |
| `FIREBASE_WEB_APP_ID` | Web app ID | `1:123:web:abc` |
| `FIREBASE_ANDROID_API_KEY` | Android API key | `AIzaSyB...` |
| `FIREBASE_ANDROID_APP_ID` | Android app ID | `1:123:android:def` |
| `FIREBASE_PROJECT_ID` | Project ID | `my-project-id` |
| `FIREBASE_MESSAGING_SENDER_ID` | Messaging sender ID | `123456789` |
| `FIREBASE_STORAGE_BUCKET` | Storage bucket | `project.appspot.com` |
| `FIREBASE_AUTH_DOMAIN` | Auth domain | `project.firebaseapp.com` |
| `FIREBASE_WEB_MEASUREMENT_ID` | Analytics measurement ID | `G-XXXXXXXXX` |

## ⛔ Important Notes

- **Never commit .env files** to version control
- **Use different credentials** for different environments
- **Rotate API keys** regularly for security
- **Restrict API key usage** in Firebase Console for production

Your Firebase credentials are now secure! 🔐✨