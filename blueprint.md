# Farmer App Blueprint

## Overview

This application is a marketplace for renting and listing agricultural equipment. It allows users to browse and search for equipment, view details, and contact owners. The app is built with Flutter and uses Firebase for backend services.

## Style, Design, and Features

### Implemented (as of this version):

*   **Authentication:**
    *   User authentication with Firebase.
    *   The user's full name is now saved during the signup process and displayed on the profile page.
*   **Equipment Listings:**
    *   Display a list of available equipment.
    *   Search and filter equipment by category, country, and division.
    *   View detailed information for each piece of equipment.
    *   Add new equipment listings with images.
*   **Owner (Lender) Section:**
    *   A dedicated page for owners to view and manage their equipment listings.
    *   The page fetches and displays only the equipment belonging to the currently logged-in user.
    *   The UI displays a list of the owner's equipment, including the name, price, and availability status.
*   **Profile Page:**
    *   A redesigned, visually appealing UI with a card-based layout.
    *   A prominent header displaying the user's profile picture, name, and email.
    *   The profile page now correctly displays user information immediately after signup by receiving the `User` object directly as a navigation parameter, eliminating the previous race condition.
    *   It then uses the user's `uid` to listen to a stream from Firestore for any subsequent updates.
    *   Menu items for "Edit Profile," "Rental History," and "Settings" (functionality to be implemented).
    *   A "Logout" button with a distinct color to signify a destructive action.
*   **Database:**
    *   Firestore is used to store equipment data.
    *   Firebase Storage is used to store equipment images.
*   **Navigation:**
    *   GoRouter is used for declarative routing.
    *   The router has been updated to pass the `User` object to the profile page upon registration.
    *   A bottom navigation bar provides easy access to different sections of the app.
    *   A back button has been added to the "Add Equipment" page.
*   **UI/UX:**
    *   The app uses the Material Design library.
    *   A custom theme is applied for a consistent look and feel.
    *   The UI is designed to be responsive and work on different screen sizes.

### Current Task: Implement Owner Section

**Plan and Steps:**

1.  **Create Service Method:** Added a `getEquipmentByOwner` method to `EquipmentService` to fetch equipment by the owner's ID.
2.  **Create Owner Page:** Created a new `OwnerListingsPage` to display the owner's equipment.
3.  **Integrate Page:** Replaced the "My Farm" navigation with a link to the new `OwnerListingsPage`.