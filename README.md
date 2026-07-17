# AUREA - Luxury Jewelry & Accessories E-commerce 💎

AUREA is a high-end, responsive Flutter e-commerce application designed for a premium shopping experience. It features an elegant UI, real-time API integration, and full support for multiple languages and themes.

---

## 🚀 Key Features

### 🛍️ Shopping Experience
*   **Dynamic Home Screen**: Features luxury offer carousels, categorized explore sections, and a responsive product grid.
*   **Detailed Product Pages**: Interactive image carousels, expandable dual-language descriptions, technical specifications, and customer reviews.
*   **Smart Cart System**: Real-time "Add to Cart" and "Buy Now" functionality with stock availability protection and order summary.
*   **Related Products**: Intelligent cross-selling suggestions based on the current product view.

### 🔐 Authentication & Security
*   **Full Auth Flow**: Secure Login, Signup, and Email Verification.
*   **Secure Password Reset**: Multi-step recovery process using OTP (One-Time Password) and secure new password creation.
*   **Token Management**: Persistent authentication state using encrypted local storage.
*   **Form Validation**: Robust input validation for all user entries.

### 🛠️ Admin Dashboard
*   **Inventory Control**: Dedicated panel for admins to manage the store's inventory.
*   **Product Operations**: Seamlessly add new products (with gallery image picking), search through inventory, and perform deletions with confirmation.

### 🎨 Premium UI/UX
*   **Fully Responsive**: Adapts seamlessly to Mobile, Tablet, and Web screens using `LayoutBuilder` and `ScreenUtil`.
*   **Dual Theme Support**: Elegant Light and Dark modes with persistent user preference using `Provider`.
*   **Localization**: Complete support for **Arabic (RTL)** and **English (LTR)** using `Intl`.
*   **Interactive Animations**: Custom "Sparkle" favorite buttons, smooth transitions, and glassmorphism effects.

---

## 🛠️ Technical Stack

### Core
*   **Framework**: [Flutter](https://flutter.dev/) (Dart)
*   **Architecture**: Clean Architecture / Feature-driven Modular Structure.
*   **State Management**: [Flutter BloC / Cubit](https://pub.dev/packages/flutter_bloc) for efficient state handling.

### Networking & Storage
*   **Networking**: [Dio](https://pub.dev/packages/dio) with custom Interceptors for Auth/Logging.
*   **Service Locator**: [Get_it](https://pub.dev/packages/get_it) for dependency injection.
*   **Local Storage**: [SharedPreferences](https://pub.dev/packages/shared_preferences) for app settings and caching.

### UI & Utilities
*   **Responsive UI**: [Flutter ScreenUtil](https://pub.dev/packages/flutter_screenutil) & [MediaQuery].
*   **Localization**: [Intl](https://pub.dev/packages/intl) with ARB files for easy translation.
*   **Image Handling**: [Image Picker](https://pub.dev/packages/image_picker) & [Cached Network Image](https://pub.dev/packages/cached_network_image).
*   **Animation**: Custom Painters for sparkle and design effects.

---

## 📸 Project Structure

```text
lib/
├── core/               # Theme, Routes, Network, Utilities, Validators
├── features/           # Modular feature-based structure
│   ├── auth/           # Authentication logic, OTP & UI
│   ├── home/           # Dashboard, Offers & Explore sections
│   ├── products/       # Details, Listing, Reviews & Related rail
│   ├── cart/           # Shopping Bag logic, POST items & Summary
│   ├── admin_product/  # Inventory Management & Search
│   ├── splash/         # Animated entrance screen
│   └── onboarding/     # Product introduction carousel
├── generated/          # Localization generated files
└── main.dart           # Entry point & App configuration
```

---

## 📦 Getting Started

1.  **Clone the repository:**
    ```bash
    git clone https://github.com/your-username/aurea_app.git
    ```
2.  **Install dependencies:**
    ```bash
    flutter pub get
    ```
3.  **Generate Localization:**
    ```bash
    flutter pub run intl_utils:generate
    ```
4.  **Run the app:**
    ```bash
    flutter run
    ```

---

## 🤝 Contributors
*   **Team 4** - NTI Final Project

---
*Developed with ❤️ by the AUREA Team*
