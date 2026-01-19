# Payment Demo

A Flutter application with Google Sign-In functionality.

## Features

- Google Sign-In authentication
- Modern and clean UI
- Firebase integration

## Setup Instructions

### 1. Install Dependencies

```bash
flutter pub get
```

### 2. Firebase Setup

1. Create a Firebase project at [Firebase Console](https://console.firebase.google.com/)
2. Add Android and iOS apps to your Firebase project
3. Download configuration files:
   - `google-services.json` for Android (place in `android/app/`)
   - `GoogleService-Info.plist` for iOS (place in `ios/Runner/`)

### 3. Google Sign-In Configuration

#### For Android:
1. Add SHA-1 fingerprint to Firebase Console
   ```bash
   keytool -list -v -keystore ~/.android/debug.keystore -alias androiddebugkey -storepass android -keypass android
   ```
2. Add the SHA-1 to your Firebase project settings

#### For iOS:
1. Configure the OAuth client ID in Firebase Console
2. Add URL scheme in `ios/Runner/Info.plist`

### 4. Firebase Storage Rules Setup (IMPORTANT - Free Plan में Images दिखने के लिए)

Firebase Storage में images दिखने के लिए Storage Rules deploy करना जरूरी है:

#### Option 1: Firebase CLI से (Recommended)

1. Firebase CLI install करें:
   ```bash
   npm install -g firebase-tools
   ```

2. Firebase में login करें:
   ```bash
   firebase login
   ```

3. Storage rules deploy करें:
   ```bash
   firebase deploy --only storage
   ```

#### Option 2: Firebase Console से (Manual)

1. [Firebase Console](https://console.firebase.google.com/) खोलें
2. अपना project select करें (`gallery-d786d`)
3. **Storage** → **Rules** tab पर जाएँ
4. नीचे दिए गए rules paste करें:
   ```javascript
   rules_version = '2';
   service firebase.storage {
     match /b/{bucket}/o {
       match /users/{userId}/photos/{fileName} {
         allow read, write: if request.auth != null && request.auth.uid == userId;
       }
       match /{allPaths=**} {
         allow read, write: if false;
       }
     }
   }
   ```
5. **Publish** button click करें

**Note:** Rules deploy करने के बाद ही images Firebase Storage में दिखेंगी!

### 5. Run the App

```bash
flutter run
```

## Project Structure

```
lib/
  ├── main.dart                 # App entry point
  ├── screens/
  │   └── login_screen.dart    # Login screen UI
  └── services/
      └── google_sign_in_service.dart  # Google Sign-In service
```

## Dependencies

- `google_sign_in`: ^6.2.1
- `firebase_auth`: ^4.15.0
- `firebase_core`: ^2.24.2
