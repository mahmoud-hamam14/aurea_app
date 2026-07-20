# AUREA - Luxury Jewelry & Accessories E-commerce 💎

AUREA is a high-end, fully responsive Flutter e-commerce application designed for a premium shopping experience. It features an elegant UI, real-time API integration, full localization support, and an advanced administrative dashboard.

---

## 🚀 Key Features

### 🛍️ Premium Shopping Experience
*   **Dynamic Home Screen**: Features luxury offer carousels, categorized explore sections, and a responsive product grid that adapts to any screen size.
*   **Detailed Product Pages**: Interactive multi-image carousels, expandable dual-language descriptions, technical specifications, and customer reviews.
*   **Smart Cart System**: Real-time "Add to Cart" and "Buy Now" functionality with automatic price calculations, quantity management, and stock protection.
*   **Related Products**: Intelligent cross-selling suggestions based on the current product view.
*   **Payment Simulation**: Secure checkout mockup with animated processing and success feedback.

### 🔐 Advanced Authentication
*   **Full Auth Flow**: Secure Login, Signup, and Email Verification processes.
*   **Password Recovery**: Multi-step recovery using OTP (One-Time Password) and secure password reset.
*   **Persistent Auth**: Session management using secure token storage and automated API interceptors.

### 🛠️ Admin Dashboard (Inventory Management)
*   **Full CRUD Operations**: Admins can add new products with gallery image integration, search the entire inventory, and delete items with safety confirmations.
*   **Dynamic Sync**: Immediate UI updates across the app when products are added or removed via the shared state management.

### 🎨 State-of-the-Art UI/UX
*   **Full Responsiveness**: Adaptive layouts for **Mobile, Tablet, and Web** using `LayoutBuilder`, `MediaQuery`, and `ScreenUtil`.
*   **Scaleable Typography**: Text and UI elements scale perfectly across devices using `.sp`, `.h`, and `.r` units.
*   **Dual Theme Support**: Persisted Light and Dark modes with an elegant, jewelry-inspired color palette.
*   **Full Localization**: Complete **Arabic (RTL)** and **English (LTR)** support with persistent user language preference.
*   **Interactive Animations**: Custom "Sparkle" favorite buttons, smooth transitions, and glassmorphism effects.

---

## 🛠️ Technical Stack

### Architecture & State Management
*   **Framework**: [Flutter](https://flutter.dev/) (Dart)
*   **State Management**: [Flutter BloC / Cubit](https://pub.dev/packages/flutter_bloc) for modular and predictable state.
*   **Navigation**: Centralized **`onGenerateRoute`** architecture for clean and scaleable routing.

### Networking & Data
*   **API Client**: [Dio](https://pub.dev/packages/dio) with custom Interceptors for automated header management and logging.
*   **Data Modeling**: Advanced JSON mapping with null-safety and support for dynamic API field names (e.g., dual-language fields).

### Storage & Media
*   **Local Storage**: [SharedPreferences](https://pub.dev/packages/shared_preferences) for theme, locale, and token persistence.
*   **Image Handling**: [Image Picker](https://pub.dev/packages/image_picker) for admin uploads and [Cached Network Image](https://pub.dev/packages/cached_network_image) for optimized loading.

---

## 📸 Project Structure

```text
lib/
├── core/               # Centralized routing, theme extensions, network logic & validators
├── features/           # Feature-first modular architecture
│   ├── auth/           # Login, Signup, OTP & Password recovery
│   ├── home/           # Responsive dashboard, Offers & Category explore
│   ├── products/       # Details, Specifications, Reviews & Related products
│   ├── cart/           # Shopping bag, Quantity logic & Payment simulation
│   ├── admin_product/  # Full inventory management & Search
│   ├── splash/         # Animated entrance
│   └── onboarding/     # Product introduction flow
├── generated/          # Auto-generated localization assets
└── main.dart           # Global initialization & ScreenUtil setup
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

*   **Mahmoud Hamam**
*   **Momen Mohamed**
*   **Huda Yasser**
*   **Hagar Tamer**
*   **Ahmed Radwan**
*   **Mahmoud Magdy**

*Team 4 - NTI Final Project*

---
*Developed with ❤️ by the AUREA Team*
