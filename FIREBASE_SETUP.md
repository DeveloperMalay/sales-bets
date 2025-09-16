# 🔥 Firebase Setup Guide for Sales Bets App

## 📋 What You Need to Do on Firebase Website

### 1. Create a New Firebase Project

1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Click **"Create a project"**
3. Enter project name: `sales-bets` or any name you prefer
4. **Disable Google Analytics** (you can enable later if needed)
5. Click **"Create project"**

### 2. Set up Authentication

1. In Firebase Console, go to **"Authentication"** in the left sidebar
2. Click **"Get started"**
3. Go to **"Sign-in method"** tab
4. Enable **"Email/Password"**
   - Toggle the switch to enable
   - Click **"Save"**

### 3. Set up Firestore Database

1. Go to **"Firestore Database"** in the left sidebar
2. Click **"Create database"**
3. Choose **"Start in test mode"** (we'll update rules later)
4. Select a location close to your users (e.g., us-central1)
5. Click **"Done"**

### 4. Configure Your Apps

#### For iOS (if you plan to deploy to iOS):
1. Click the iOS icon in project overview
2. Enter iOS bundle ID: `com.example.salesBets`
3. Download `GoogleService-Info.plist`
4. Place it in `ios/Runner/` folder

#### For Android:
1. Click the Android icon in project overview
2. Enter Android package name: `com.example.sales_bets`
3. Download `google-services.json`
4. Place it in `android/app/` folder

#### For Web (if you plan to deploy to web):
1. Click the Web icon in project overview
2. Enter app nickname: `Sales Bets Web`
3. Copy the Firebase config object

### 5. Update Firebase Configuration

After setting up your apps, you'll get configuration values. Update the file:
`lib/firebase_options.dart`

Replace the placeholder values with your actual Firebase config:

```dart
// Replace these with your actual values from Firebase Console
static const FirebaseOptions android = FirebaseOptions(
  apiKey: 'YOUR_ACTUAL_ANDROID_API_KEY',
  appId: 'YOUR_ACTUAL_ANDROID_APP_ID',
  messagingSenderId: 'YOUR_ACTUAL_MESSAGING_SENDER_ID',
  projectId: 'YOUR_ACTUAL_PROJECT_ID',
  storageBucket: 'YOUR_ACTUAL_PROJECT_ID.appspot.com',
);
```

### 6. Set up Firestore Security Rules

1. Go to **"Firestore Database"** → **"Rules"** tab
2. Replace the default rules with the content from `firestore_rules.txt`
3. Click **"Publish"**

### 7. Add Sample Data (Optional)

1. Go to **"Firestore Database"** → **"Data"** tab
2. Create the following collections manually:
   - `teams`
   - `events` 
   - `streams`
   - `users`
   - `bets`

You can add sample documents using the data from `sample_data.json`

### 8. Set up Cloud Storage (for images)

1. Go to **"Storage"** in the left sidebar
2. Click **"Get started"**
3. Choose **"Start in test mode"**
4. Select the same location as your Firestore

### 9. Set up Cloud Messaging (for notifications)

1. Go to **"Cloud Messaging"** in the left sidebar
2. No additional setup needed - it's automatically configured

## 🚀 Testing Your Setup

After completing the Firebase setup:

1. Run the Flutter app:
   ```bash
   flutter run
   ```

2. Try creating a new account
3. Test signing in/out
4. Check if data appears in Firestore Console

## 🔧 Commands to Run After Firebase Setup

```bash
# Install Firebase CLI (if not already installed)
npm install -g firebase-tools

# Login to Firebase
firebase login

# Install FlutterFire CLI
dart pub global activate flutterfire_cli

# Auto-configure Firebase for Flutter (run this in project root)
flutterfire configure

# This will automatically update firebase_options.dart with correct values
```

## 📱 Platform-Specific Setup

### Android
- Ensure `android/app/google-services.json` is in place
- Update `android/app/build.gradle` to include:
  ```gradle
  apply plugin: 'com.google.gms.google-services'
  ```

### iOS  
- Ensure `ios/Runner/GoogleService-Info.plist` is in place
- In Xcode, add the file to the Runner target

## 🔒 Security Notes

- The Firestore rules I've provided are secure and follow best practices
- Users can only access their own data
- Only admins can modify teams/events (you'll need to manually set `isAdmin: true` for admin users)
- Betting is restricted to authenticated users only

## 🆘 Troubleshooting

- If you get Firebase initialization errors, make sure `firebase_options.dart` has the correct values
- For authentication issues, check that Email/Password is enabled in Firebase Console
- For Firestore permission errors, verify the security rules are published correctly

## 📊 Monitoring

Once your app is running, you can monitor:
- **Authentication**: See user signups/logins
- **Firestore**: Monitor database usage and queries
- **Analytics**: Track app usage (if enabled)
- **Crashlytics**: Monitor app crashes (can be added later)

Your Firebase backend is now ready! 🎉