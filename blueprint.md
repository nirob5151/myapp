
# Project Blueprint: Farmer's Market App

## Overview

This application is a mobile marketplace designed to connect farmers with equipment renters. Farmers can browse and search for agricultural equipment, view featured ads, and manage their own farm-related activities. The app supports both light and dark themes and is built with a focus on a clean, modern, and user-friendly design.

---

## Implemented Features & Design

*   **Architecture:**
    *   Provider for State Management (`ThemeProvider`).
    *   GoRouter for declarative navigation.
    *   Layered architecture (separating UI, services, and models).
    *   Firebase integration (Auth, Firestore).

*   **Authentication:**
    *   Email/Password and Google Sign-In.
    *   Auth state persistence with a splash screen for loading.
    *   Auth service to handle user session logic.
    *   Role-based redirection (Farmer/Renter) after login.

*   **UI & Design:**
    *   Material 3 Design with `ColorScheme.fromSeed`.
    *   Custom typography using `google_fonts` (Poppins).
    *   Theming system with support for Light/Dark mode toggle.
    *   A bottom navigation bar for main app sections.

*   **Farmer Dashboard:**
    *   SliverAppBar with an integrated search bar.
    *   A grid-based "Categories" section with descriptive icons.
    *   A grid-based "Featured Ads" section to showcase rental equipment.

---

## Current Task: Refactor "Featured Ads" to use Firestore

**Objective:** The current "Featured Ads" are hardcoded into the UI, which is inflexible. The images are also failing to load due to a combination of hot-reload issues and a poor data source. This plan will refactor the feature to load data dynamically and correctly from Cloud Firestore.

**Plan:**

1.  **Create a Firestore Service:**
    *   Develop a new service class at `lib/features/farmer/services/ad_service.dart`.
    *   This service will contain a method `getFeaturedAds()` that fetches documents from the `featuredAds` collection in Firestore.
    *   Define an `Ad` model class to structure the data retrieved from Firestore (name, price, status, image URL).

2.  **Refactor the UI (FarmerDashboardScreen):**
    *   Replace the hardcoded `featuredAds` list.
    *   Implement a `FutureBuilder` widget that calls the `ad_service.getFeaturedAds()` method.
    *   The builder will display a loading indicator while fetching data.
    *   Once the data is loaded, it will render the two-column grid of "Featured Ads" using the data from Firestore.
    *   Proper error handling will be included for the `FutureBuilder`.

3.  **Populate Firestore Database:**
    *   Create and execute a one-time script or function to populate the `featuredAds` collection with initial documents. Each document will contain fields for `name`, `price`, `status`, and a valid, publicly accessible `imageUrl`.

4.  **Ensure Full App Restart:**
    *   After the code changes are complete, trigger a full "cold" restart of the application (`flutter run`) to ensure the previously added `INTERNET` permission in `AndroidManifest.xml` is correctly loaded by the Android system. This will resolve the image loading failures.
