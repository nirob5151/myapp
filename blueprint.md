# EasyFarm Blueprint

## Overview

EasyFarm is a mobile platform that connects farmers with agricultural equipment owners for renting or leasing farm machinery. This blueprint outlines the current and planned features of the application.

## Implemented Features

### Version 1.0

*   **User Authentication:** Users can sign up and log in using email/password, phone number, and Google Sign-In.
*   **Firebase Integration:** The application is connected to a Firebase project.
*   **Navigation:** The application uses `go_router` for navigation.
*   **Basic Structure:** A feature-based project structure is in place.

## Current Plan: Farm Management Module

1.  **Farm Model:** Define the `Farm` data model with fields like `name`, `location`, `ownerId`, etc.
2.  **Farm Service:** Create a `FarmService` to handle all Firestore operations related to farms (add, retrieve, update, delete).
3.  **Farm Management UI:**
    *   Create a `FarmManagementPage` to display a list of the user's farms.
    *   Implement a stream-based approach using `StreamBuilder` to show real-time updates from Firestore.
    *   Add a floating action button to navigate to the `AddFarmPage`.
4.  **Add Farm UI:**
    *   Create an `AddFarmPage` with a form to input new farm details (name, location).
    *   Connect the form to the `FarmService` to add new farms to Firestore.

