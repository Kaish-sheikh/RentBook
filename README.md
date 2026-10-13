# RentBook 🏢📱

> Modern Mobile Rental Marketplace & Property Portfolio Management System

RentBook is a rental management and portfolio platform built with high-density tenant management, automatic compounding rent escalation, direct UPI QR payments, WhatsApp automated tenant reminders, and customizable property storefront photography.

---

## ✨ Key Features

- **RentBook Rent Portfolio**: Real-time overview of leased commercial shops and residential units with compounding rent yield analytics and lease health indicators.
- **Storefront & Shop Photo Customization**:
  - Live device camera and gallery upload with smart canvas compression.
  - Curated 8-preset commercial catalog (Retail Storefront, Modern Commercial, Tech Studio, Salon, Food & Dining, etc.).
  - Custom image URL support with real-time live preview.
- **Automated WhatsApp Payment Reminders**:
  - One-tap WhatsApp payment notifications with customized lease amounts.
  - Dynamic UPI payment links and embedded scan-and-pay QR codes.
- **Rent Roll & Payment Tracking**:
  - Track on-time, pending, and overdue rents across cycles.
  - Automatic 5% compounded annual escalation calculations.
- **Android Native Mobile App**:
  - Powered by Capacitor for native Android experience.
  - Pre-built debug APK included for immediate installation (`RentBook.apk`).

---

## 🚀 Getting Started

### Web / Local Preview
Run any local static HTTP server:
```bash
# Python
python -m http.server 8089

# Node.js
npx serve .
```
Open [http://localhost:8089](http://localhost:8089) in your browser.

### Android Native Build
Requirements: Android SDK / Android Studio, Node.js.

```bash
# Install dependencies
npm install

# Sync web assets to Android
npx cap copy

# Build debug APK
cd android
./gradlew assembleDebug
```
The compiled APK will be located at `android/app/build/outputs/apk/debug/app-debug.apk` or in the root directory as `RentBook.apk`.

### Direct APK Installation
You can directly install the pre-compiled APK on an Android device:
```bash
adb install -r RentBook.apk
```

---

## 🎨 Design System
- **Warm Ivory Background**: `#F6F4EF`
- **Forest Green Brand & Actions**: `#153C35`
- **Midnight Navy Cards & Text**: `#202B36`
- **Restrained Amber Accents**: `#E5B96D`
- **Status Badges**: Emerald Green (Active / Paid Up), Amber (Pending Dues)

---

## 📄 License
MIT License. Created by Kaish Sheikh.
