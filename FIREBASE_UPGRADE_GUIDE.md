# Firebase Storage - Upgrade Guide (Hindi)

## ⚠️ Important Update (September 2024)

**Firebase ने policy change किया है:**
- ❌ **Spark (Free) Plan:** नए Storage buckets नहीं बना सकते
- ✅ **Blaze Plan:** Storage use करने के लिए जरूरी है
- 💰 **Good News:** Blaze plan में भी **FREE TIER** है!

---

## 💡 Blaze Plan में Free Tier क्या है?

### Free Quota (हर महीने):
- **Storage:** 5 GB free
- **Downloads:** 1 GB/day free
- **Uploads:** 20,000 operations/day free
- **Deletes:** 20,000 operations/day free

### कब Pay करना पड़ेगा?
- जब आप free quota से ज्यादा use करेंगे
- Example: अगर 6 GB storage use करेंगे, तो 1 GB का charge होगा

---

## 🚀 Step-by-Step: Blaze Plan पर Upgrade करें

### **STEP 1: Firebase Console में जाएँ**

1. https://console.firebase.google.com/ खोलें
2. Project `gallery-d786d` select करें
3. Login करें

---

### **STEP 2: Billing Section खोलें**

**Option A: Left Sidebar से:**
- Left sidebar में **"⚙️ Project settings"** (gear icon) click करें
- **"Usage and billing"** tab click करें

**Option B: Direct Link:**
```
https://console.firebase.google.com/project/gallery-d786d/settings/usage
```

---

### **STEP 3: Blaze Plan Select करें**

1. **"Upgrade project"** या **"Modify plan"** button दिखेगा
2. Click करें
3. **"Blaze Plan"** select करें
4. **"Continue"** click करें

---

### **STEP 4: Billing Account Setup करें**

1. **"Link billing account"** या **"Create billing account"** click करें
2. Google Cloud Console खुलेगा
3. **Payment method add करें:**
   - Credit/Debit card
   - या Bank account
4. **Billing account create करें**
5. **Firebase project को link करें**

**Important:**
- Card add करना जरूरी है (security के लिए)
- लेकिन free tier में कोई charge नहीं होगा
- Budget alerts set कर सकते हैं

---

### **STEP 5: Storage Enable करें**

1. Firebase Console में वापस जाएँ
2. **Storage** section में जाएँ
3. **"Get started"** या **"Create bucket"** button click करें
4. Default settings accept करें:
   - Location: `us-central` (या nearest)
   - Storage class: `Standard`
5. **"Create"** click करें

---

### **STEP 6: Storage Rules Set करें**

1. Storage → **Rules** tab पर जाएँ
2. नीचे दी गई rules paste करें:

```javascript
rules_version = '2';

service firebase.storage {
  match /b/{bucket}/o {
    // Allow authenticated users to read/write their own photos
    match /users/{userId}/photos/{fileName} {
      allow read, write: if request.auth != null && request.auth.uid == userId;
    }
    
    // Deny all other access
    match /{allPaths=**} {
      allow read, write: if false;
    }
  }
}
```

3. **"Publish"** click करें

---

## 💰 Cost Estimation (आपके Project के लिए)

### Typical Usage:
- **Photos:** ~2-5 MB per photo
- **100 photos:** ~200-500 MB
- **1000 photos:** ~2-5 GB

### Free Tier में Fit होगा?
- ✅ **500-1000 photos:** Free tier में fit होगा (5 GB)
- ⚠️ **2000+ photos:** Free tier से ज्यादा हो सकता है

### Budget Alert Set करें:
1. Firebase Console → Usage and billing
2. **"Set budget alert"** click करें
3. Amount set करें (example: $5/month)
4. Email alerts enable करें

---

## ✅ Verification (कैसे Check करें)

### 1. Plan Check करें:
- Firebase Console → Project settings → Usage and billing
- **"Blaze (pay as you go)"** दिखना चाहिए

### 2. Storage Check करें:
- Storage → Files tab
- Bucket create हो गया होना चाहिए

### 3. Rules Check करें:
- Storage → Rules tab
- Rules publish हो गई होंगी

---

## 🆘 Common Issues & Solutions

### **Issue 1: "Billing account not found"**
**Solution:**
- Google Cloud Console में billing account create करें
- Firebase project को link करें

### **Issue 2: "Payment method required"**
**Solution:**
- Credit/debit card add करें
- यह security के लिए है, free tier में charge नहीं होगा

### **Issue 3: "Storage bucket creation failed"**
**Solution:**
- Billing account properly linked है? Check करें
- Project permissions check करें

---

## 📊 Free Tier Limits (Summary)

| Feature | Free Tier |
|---------|-----------|
| Storage | 5 GB |
| Downloads | 1 GB/day |
| Uploads | 20,000/day |
| Deletes | 20,000/day |

**Note:** Free tier limits cross करने पर charges apply होंगे

---

## 🔗 Quick Links

- **Billing Setup:**
  https://console.firebase.google.com/project/gallery-d786d/settings/usage

- **Storage Setup:**
  https://console.firebase.google.com/project/gallery-d786d/storage

- **Google Cloud Billing:**
  https://console.cloud.google.com/billing

---

## ⚠️ Important Notes

1. **Card Add करना Safe है:**
   - Free tier में कोई charge नहीं होगा
   - Budget alerts set कर सकते हैं
   - Usage monitor कर सकते हैं

2. **Free Tier Sufficient है:**
   - Small to medium apps के लिए
   - 1000-2000 photos तक comfortably fit होगा

3. **Pay-as-you-go:**
   - जितना use करेंगे, उतना pay करेंगे
   - Free tier के बाद charges start होंगे

---

## 📝 Summary

1. ✅ **Blaze Plan** पर upgrade करें (free tier के साथ)
2. 💳 **Billing account** setup करें (card add करें)
3. 📦 **Storage bucket** create करें
4. 🔒 **Rules** set करें
5. ✅ **Done!** Images upload होने लगेंगी

**Total Cost:** $0 (free tier में रहने तक) 💰
