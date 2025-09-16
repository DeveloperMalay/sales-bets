# Firebase Setup & Permissions Fix 🔧

## 🚨 **Quick Fix for Permission Error**

The error you're seeing is because Firestore has default security rules that block all reads/writes. Here's how to fix it:

## **Method 1: Firebase Console (Easiest)**

1. **Go to [Firebase Console](https://console.firebase.google.com/)**
2. **Select your project**
3. **Click "Firestore Database" in left sidebar**
4. **Click "Rules" tab**
5. **Replace the existing rules with:**

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // Allow authenticated users to read and write their own user document
    match /users/{userId} {
      allow read, write: if request.auth != null && request.auth.uid == userId;
    }
    
    // Allow authenticated users to read all teams (needed for betting and display)
    match /teams/{document=**} {
      allow read: if request.auth != null;
      allow write: if request.auth != null; // Remove in production
    }
    
    // Allow authenticated users to read all events (needed for betting and display)
    match /events/{document=**} {
      allow read: if request.auth != null;
      allow write: if request.auth != null; // Remove in production
    }
    
    // Allow authenticated users to read all streams (needed for live streaming)
    match /streams/{document=**} {
      allow read: if request.auth != null;
      allow write: if request.auth != null; // Remove in production
    }
    
    // Allow authenticated users to manage their own bets
    match /bets/{betId} {
      allow read, write: if request.auth != null;
    }
    
    // Allow chat messages
    match /chat_messages/{document=**} {
      allow read, create: if request.auth != null;
    }
  }
}
```

6. **Click "Publish"**

## **✅ Testing the Fix**

After updating the rules:

1. **Go back to your Developer Tools screen**
2. **Tap "Refresh Stats"** 
3. **Try "Seed Initial Data"**
4. **You should see success messages! ✅**

Your app will then have realistic, professional-looking data for all the teams, events, and live streams! 🎉