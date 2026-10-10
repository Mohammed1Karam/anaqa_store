<h1 align="center">🛍️ Anaqa Store (أناقة)</h1>

<p align="center">
  <img src="https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white" />
  <img src="https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white" />
  <img src="https://img.shields.io/badge/GetX-8A2BE2?style=for-the-badge" />
  <img src="https://img.shields.io/badge/REST%20API-005571?style=for-the-badge" />
  <img src="https://img.shields.io/badge/Google%20Maps-4285F4?style=for-the-badge&logo=googlemaps&logoColor=white" />
</p>

<p align="center">
A fashion e-commerce app in Flutter, with a full shopping journey from onboarding to checkout and order tracking, in Arabic and English.
</p>

## ✨ Features

- 👋 **Onboarding** screens on first launch.
- 🔐 **Authentication**: sign up, login, OTP verification, forgot and reset password, with Gulf country codes.
- 🏠 **Home & categories** with carousels and cached images.
- 👗 **Product details** with a picture gallery and a size chart.
- ❤️ **Wishlist**, 🛒 **cart** and **checkout**.
- 🔎 **Sort and filter** products.
- 📦 **Orders**: order list, order details and order tracking.
- 📍 **Addresses**: add and save delivery addresses with Google Maps.
- 👤 **Profile** settings and notifications.
- 🌍 **Arabic & English** (RTL support) and share to other apps.

## 🧱 Project Structure

```
lib/
├── api/              API settings and requests
├── getx_controller/  user, profile and country controllers
├── models/           user, gulf country
├── preferences/      local storage with get_storage
├── screen/           auth, home, product, profile, launch screens
├── utils/            colors, helpers
├── utils_lan/        Arabic and English translations
└── widget/           buttons, text fields, loaders
```

## 🛠️ Tech Stack

- **Flutter & Dart**
- **GetX** for state management, routing and translations
- **get_storage** for local storage
- **flutter_screenutil** for responsive layouts
- **google_maps_flutter**, **carousel_slider**, **cached_network_image**, **pinput**, **flutter_svg**, **share_plus**

## 🚀 Getting Started

```bash
git clone https://github.com/Mohammed1Karam/anaqa_store.git
cd anaqa_store
flutter pub get
flutter run
```

## 👨‍💻 Author

**Mohammed Karam**, Flutter Developer · [GitHub](https://github.com/Mohammed1Karam)
