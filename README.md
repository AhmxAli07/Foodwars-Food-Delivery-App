<div align="center">

# 🍔 FoodWars

**A Flutter food-ordering app powered by Firebase**

Browse restaurants, order food, chat with others, and manage your profile — all in one app.

[![Flutter](https://img.shields.io/badge/Flutter-3.x-02569B?logo=flutter)](https://flutter.dev)
[![Firebase](https://img.shields.io/badge/Firebase-Firestore%20%7C%20Auth%20%7C%20Storage-FFCA28?logo=firebase)](https://firebase.google.com)
[![Platform](https://img.shields.io/badge/Platform-Android-3DDC84?logo=android)](https://developer.android.com)

</div>

---

## 📱 Preview

> _Screenshots coming soon. Download the APK below to try the app directly._

| Home | Restaurant Menu | Profile | Chat |
|------|-----------------|---------|------|
| _screenshot_ | _screenshot_ | _screenshot_ | _screenshot_ |

---

## 📥 Download APK

> An Android APK is available in the [**GitHub Releases**](../../releases) section.
> No build tools needed — install directly on any Android device.

[![Download APK](https://img.shields.io/badge/⬇️%20Download%20APK-v1.0.0-brightgreen?style=for-the-badge)](../../releases/latest)

> **Note:** The APK requires an internet connection. Allow installation from unknown sources in your Android settings before installing.

---

## ✨ Features

### 🔐 Authentication
- **Email / Password** sign-up and sign-in with form validation
- **Google Sign-In** via OAuth
- **Facebook Login** via OAuth
- **Password reset** via email link
- Automatic session persistence (returning users are routed directly to home)

### 🏠 Home & Discovery
- Animated splash screen with app logo
- Home screen with a **carousel slider** and restaurant cards
- Browse **4 restaurant categories**: Good Food, Vegan Resto, Healthy Food, Smart Resto
- **Search** food items across all menus using Firestore queries

### 🍽️ Menus & Ordering
- Each restaurant has a full-screen detail page with live Firestore data
- **16 individual menu item pages** (Boiled Fries, Herbal Tea, Pizza, Ice Cream, Avocado, and more)
- **Add to Cart** — stored in Firestore with duplicate prevention
- **Add to Favourites** — dedicated per-user favourites list

### 🛒 Cart
- Real-time cart view via Firestore StreamBuilder
- **Swipe to remove** items (dismissible list)
- Cart badge count in the bottom navigation bar

### 👤 Profile
- Profile **cover photo** (user's uploaded image as background)
- Display username and email
- **Edit username** with an inline update dialog
- View and manage your **Favourites** list
- **Logout** button

### 📸 Profile Photo
- Upload from the **gallery** or **camera**
- Images stored in **Firebase Storage**, URL saved to Firestore

### 💬 Real-Time Chat
- Search for any registered user by **email** or **username**
- One-to-one **chat rooms** backed by Firestore
- Messages ordered by **server timestamp**
- **Online / Offline** status indicator updated via app lifecycle observer

### 🌙 Dark / Light Theme
- Toggle between dark and light mode from the home screen
- Theme **persisted across sessions** using SharedPreferences

---

## 🛠️ Tech Stack

| Category | Technology |
|---|---|
| Framework | Flutter (SDK >=3.1.2) |
| Language | Dart |
| Authentication | Firebase Authentication |
| Database | Cloud Firestore |
| File Storage | Firebase Storage |
| State Management | Provider (ChangeNotifier) |
| Local Persistence | SharedPreferences |
| Social Auth | Google Sign-In, Flutter Facebook Auth |
| Image Handling | image_picker, cached_network_image |
| Navigation | Named routes |
| UI Components | google_nav_bar, badges, carousel_slider |
| Notifications | fluttertoast, animated_snack_bar |

---

## 🔥 Firebase Functionality

| Firebase Service | Usage |
|---|---|
| **Firebase Auth** | Email/password, Google, and Facebook authentication |
| **Cloud Firestore** | User profiles, menu data, cart, favourites, chat messages, online status |
| **Firebase Storage** | Profile photo upload and retrieval |

### Firestore Collections

```
user/
  {uid}/
    username, email, uid, status, url
    cart/         — shopping cart items
    Favourite/    — favourite menu items

chatroom/
  {roomId}/
    chats/        — messages with serverTimestamp

GoodMenu/         — menu items for Good Food restaurant
Search/           — indexed items for cross-menu search
```

---

## 📁 Project Structure

```
lib/
├── main.dart                 # App entry, Firebase init, route table
├── firebase_options.dart     # FlutterFire-generated Firebase config
│
├── Screens/
│   ├── view/
│   │   ├── home.dart         # Home tab
│   │   ├── cart.dart         # Cart tab
│   │   ├── profile.dart      # Profile tab
│   │   └── CHAT.dart         # Chat tab
│   ├── Bottombar.dart        # Bottom navigation shell (4 tabs)
│   ├── ChatRoom.dart         # One-to-one chat room
│   ├── Search.dart           # Global food search
│   ├── notification.dart     # Notifications (placeholder)
│   └── splash.dart           # Auth-aware splash screen
│
├── auth/
│   ├── login.dart            # Email/Password + Google/Facebook login
│   ├── register.dart         # Account registration
│   ├── forget.dart           # Password reset
│   ├── upload.dart           # Post-registration photo upload
│   └── profileSEE.dart       # Profile photo preview
│
├── Services/
│   ├── Good.dart / healthy.dart / smart.dart / vegan.dart
│   ├── Goodmenu/             # 4 item detail pages
│   ├── HealthMenu/           # 4 item detail pages
│   ├── SmartMenu/            # 4 item detail pages
│   └── VeganMenu/            # 4 item detail pages
│
├── Theme/
│   ├── theme.dart            # ThemeProvider (ChangeNotifier + SharedPreferences)
│   ├── color.dart            # Light/dark color schemes
│   └── style.dart
│
├── widgets/                  # 30+ reusable UI components
│   └── components/           # Google/Facebook auth helpers, image handler
│
└── utils/                    # Image pick + upload utilities
```

---

## 🚀 Installation

### Prerequisites

- [Flutter SDK](https://flutter.dev/docs/get-started/install) **>=3.1.2**
- Android Studio or VS Code with Flutter extension
- A Firebase project (see [Firebase Setup](#-firebase-setup))

### Clone & Run

```bash
# 1. Clone the repository
git clone https://github.com/Ahmad-Ali-Pakistan/foodwars.git
cd foodwars

# 2. Install dependencies
flutter pub get

# 3. Complete Firebase setup (see below)

# 4. Run the app
flutter run
```

---

## 🔧 Firebase Setup

This project requires your own Firebase project to run from source.

### 1. Create a Firebase Project

1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Create a new project
3. Enable:
   - **Authentication** → Email/Password, Google, Facebook
   - **Cloud Firestore**
   - **Firebase Storage**

### 2. Configure Flutter

Install the FlutterFire CLI:

```bash
dart pub global activate flutterfire_cli
```

Run in the project root:

```bash
flutterfire configure
```

This generates `lib/firebase_options.dart` — replace the existing file with your generated one.

### 3. Seed Firestore Data

**Collection:** `GoodMenu` (repeat for HealthMenu, SmartMenu, VeganMenu collections)

```json
{
  "name": "Boiled Fries",
  "image": "https://your-image-url.com/fries.jpg",
  "price": "12"
}
```

**Collection:** `Search`

```json
{
  "name": "Boiled Fries",
  "image": "https://your-image-url.com/fries.jpg",
  "price": "12",
  "array": ["boiled", "fries", "potato"]
}
```

### 4. Firestore Security Rules

```
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /user/{userId}/{document=**} {
      allow read, write: if request.auth != null && request.auth.uid == userId;
    }
    match /chatroom/{roomId}/{document=**} {
      allow read, write: if request.auth != null;
    }
    match /{menuCollection}/{doc} {
      allow read: if request.auth != null;
    }
  }
}
```

---

## ⚠️ Known Limitations

- **Email validation** accepts `@gmail.com` addresses only.
- **Notifications screen** is a placeholder — no push notifications are implemented.
- **Menu data must be seeded manually** in Firestore — there is no in-app admin panel.
- **Some layouts use fixed heights** that may not scale well on all screen sizes or tablets.
- The app requires an **active internet connection** (no offline mode).

---

## 📦 Building the APK

```bash
flutter build apk --release
# Output: build/app/outputs/flutter-apk/app-release.apk
```

The pre-built APK in [GitHub Releases](../../releases) is signed with a debug key for demo purposes.

---

## 👤 Author

**Ahmad Ali**

---

<div align="center">
Made with ❤️ using Flutter & Firebase
</div>
