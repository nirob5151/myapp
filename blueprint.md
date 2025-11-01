# EasyFarm - Smart Equipment Rentals Blueprint

## App Concept

EasyFarm is a mobile platform that connects farmers with agricultural equipment owners for renting or leasing farm machinery such as tractors, harvesters, irrigation pumps, and more. It helps small and medium-scale farmers access modern tools without large upfront costs, while owners earn by renting out their idle equipment.

## Key Features

### For Farmers (Renters):
*   Browse and search for equipment by location, price, and availability.
*   View detailed equipment information (specifications, photos, rental rates, owner profiles).
*   Book equipment for specific dates.
*   Contact equipment owners through in-app messaging or calls.
*   Track active and past rentals.
*   Leave reviews and ratings for equipment and owners.

### For Owners:
*   Create a profile to list agricultural equipment.
*   Post equipment with details, photos, rental prices, and availability calendar.
*   Manage equipment listings (edit, pause, or delete).
*   Receive and manage booking requests (accept or reject).
*   Track rental history and earnings.
*   Communicate with potential renters.

### Common Features:
*   User Authentication: Secure login and signup for both Farmers and Owners.
*   Profile Management: Users can manage their personal information and settings.
*   Notifications: Real-time alerts for booking requests, confirmations, and payment updates.

## Unique Selling Points (USP)

*   **Localized Experience:** Support for both English and Bangla to cater to the local user base.
*   **Location-Based Discovery:** Smart suggestions for equipment based on the user's location using Google Maps API.
*   **Secure & Integrated System:** Built-in payment tracking and a rental calendar for seamless management.
*   **Community & Sustainability:** Promotes a shared economy model, encouraging efficient resource utilization in farming.

## Tech Stack

*   **Frontend:** Flutter
*   **Backend & Database:** Firebase (Authentication, Firestore, Storage)
*   **Notifications:** Firebase Cloud Messaging (FCM)
*   **Maps & Location:** Google Maps Platform

## Current Implementation Plan

*   **Phase 1: Core Structure Refactoring**
    *   **Action:** Remove the previous "farm and crop management" feature.
    *   **Details:** This involves deleting the `farm_management` directory, including its models, services, and UI pages. The routing and dependency injection will be updated accordingly.
*   **Phase 2: Implement Equipment Marketplace**
    *   **Action:** Create the foundation for browsing and listing equipment.
    *   **Details:** A new `Equipment` model and `EquipmentService` will be created. The home page will be redesigned to display a list of available equipment from Firestore.
*   **Phase 3: User Roles & Listings**
    *   **Action:** Introduce the concept of "Owner" and "Farmer" roles.
    *   **Details:** Update the authentication and user profile system to handle different user types. Owners will get the functionality to list and manage their equipment.
