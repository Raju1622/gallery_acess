# Firebase Storage Rules Guide (Hindi)

## 📍 Rules कहाँ हैं?

### 1. **आपके Computer पर (Local)**
```
gallery_acess/
  ├── storage.rules          ← यहाँ rules file है
  ├── firebase.json          ← यह rules file को point करता है
  └── .firebaserc            ← Project ID configuration
```

### 2. **Firebase Console में (Online)**
- URL: https://console.firebase.google.com/
- Path: **Storage** → **Rules** tab
- Project: `gallery-d786d`

---

## 🔍 Firebase Console में Rules कैसे देखें?

### Step-by-Step:

1. **Firebase Console खोलें**
   - https://console.firebase.google.com/ पर जाएँ
   - Login करें

2. **Project Select करें**
   - Project: `gallery-d786d` select करें

3. **Storage Section में जाएँ**
   - Left sidebar में **"Storage"** click करें
   - या direct: https://console.firebase.google.com/project/gallery-d786d/storage

4. **Rules Tab पर जाएँ**
   - Top में **"Rules"** tab click करें
   - यहाँ आपकी current rules दिखेंगी

---

## 📝 Current Rules क्या करती हैं?

### Rules Explanation:

```javascript
rules_version = '2';

service firebase.storage {
  match /b/{bucket}/o {
    // ✅ यह rule: users/{userId}/photos/ में images allow करती है
    match /users/{userId}/photos/{fileName} {
      // केवल authenticated user अपनी images access कर सकता है
      allow read, write: if request.auth != null && request.auth.uid == userId;
    }
    
    // ❌ बाकी सभी paths block हैं
    match /{allPaths=**} {
      allow read, write: if false;
    }
  }
}
```

### Rules का मतलब:

✅ **Allow (Line 6-8):**
- Path: `users/{userId}/photos/{fileName}`
- Condition: User login होना चाहिए और userId match होना चाहिए
- Permission: Read और Write दोनों

❌ **Deny (Line 12-14):**
- बाकी सभी paths block हैं
- Security के लिए

---

## 🚀 Rules कैसे Deploy करें?

### Method 1: Firebase Console से (सबसे आसान)

1. Firebase Console → Storage → Rules tab
2. Editor में `storage.rules` file का content paste करें
3. **"Publish"** button click करें
4. Done! ✅

### Method 2: Firebase CLI से

```bash
# Terminal में project folder में जाएँ
cd /Users/dinanathmaurya/Documents/GitHub/gallery_acess

# Firebase CLI install (अगर नहीं है)
npm install -g firebase-tools

# Login करें
firebase login

# Rules deploy करें
firebase deploy --only storage
```

---

## 📂 Files Structure

```
gallery_acess/
├── storage.rules          ← Rules definition (यहाँ edit करें)
├── firebase.json          ← Firebase config (rules file को point करता है)
├── .firebaserc            ← Project ID (gallery-d786d)
└── lib/
    └── services/
        └── firebase_storage_service.dart  ← Code में rules use होती हैं
```

---

## ⚠️ Important Notes

1. **Rules Deploy जरूरी है**
   - Local file में rules होने से कुछ नहीं होगा
   - Firebase Console में deploy करना होगा

2. **Rules Change के बाद**
   - हमेशा "Publish" करें
   - कुछ seconds में apply हो जाएंगी

3. **Free Plan में भी काम करती हैं**
   - Rules deploy करने के बाद images दिखेंगी
   - Free plan में भी कोई problem नहीं

---

## 🔗 Quick Links

- **Firebase Console**: https://console.firebase.google.com/
- **Your Project Storage**: https://console.firebase.google.com/project/gallery-d786d/storage
- **Storage Rules**: https://console.firebase.google.com/project/gallery-d786d/storage/rules

---

## 📸 Images कहाँ Store होती हैं?

**Path Structure:**
```
users/
  └── {userId}/              ← User का Firebase UID
      └── photos/            ← सभी photos यहाँ
          ├── photo_1234567890_0.jpg
          ├── photo_1234567891_1.jpg
          └── photo_1234567892_2.jpg
```

**Firebase Console में देखने के लिए:**
1. Storage → Files tab
2. `users` folder खोलें
3. अपने `userId` folder में जाएँ
4. `photos` folder में सभी images दिखेंगी
