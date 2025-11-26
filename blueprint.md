# Project Blueprint

## Overview

This document outlines the structure and features of the Farm Equipment Rental application. The app allows users to browse, rent, and list farm equipment.

## Style and Design

The application uses a modern, clean design with a green color scheme to reflect the agricultural theme. It utilizes Material Design components for a consistent and intuitive user experience.

- **Primary Color:** Dark Green (`#2C7D32`)
- **Secondary Color:** Light Green (`#F5F9F5`)
- **Typography:** The app uses the default Roboto font.

## Features Implemented

### 1. Authentication

- Users can create an account and log in.
- Authentication is handled by a dedicated `AuthService`.
- User data is stored in Firestore and managed by a `UserService`.

### 2. Home Page

- The home page displays a dashboard with quick actions, categories, and featured equipment.
- It includes a header with a search bar.
- The `_seedDatabase` function allows for populating the database with dummy data.

### 3. Marketplace

- The marketplace page displays all available equipment in a grid view.
- It includes a search bar to filter equipment by name.

### 4. Equipment Details

- The equipment details page shows detailed information about a selected piece of equipment.
- It includes an image carousel, equipment details, and a "Rent Now" button.

### 5. Profile

- The profile page displays the user's information.
- The edit profile page allows users to update their name and location.

### 6. Add Equipment

- Users can add their own equipment to the marketplace.
- The add equipment form includes fields for name, description, price, category, and images.

## Current Task: Refactor and Fix Equipment Model

### Plan

1.  **Fix `lib/features/equipment/models/equipment.dart`:**
    *   Add the `rentalPrice`, `location`, and `availability` fields to the `Equipment` model.
    *   Update the `copyWith`, `fromSnap`, and `toJson` methods to include the new fields.

2.  **Fix `lib/features/equipment/pages/add_equipment_page.dart`:**
    *   Update the `_AddEquipmentPageState` to use the new fields in the `Equipment` model.
    *   Add form fields for `rentalPrice`, `location`, and `availability`.

3.  **Fix `lib/features/equipment/pages/equipment_detail_page.dart`:**
    *   Update the UI to display the new `rentalPrice`, `location`, and `availability` fields.

4.  **Fix `lib/features/farmer/widgets/equipment_card.dart`:**
    *   Update the `EquipmentCard` to display the new `rentalPrice` and `availability` fields.

5.  **Fix `lib/features/home/pages/home_page.dart`:**
    *   Update the `_seedDatabase` method to use the new fields in the `Equipment` model.

6.  **Fix `lib/features/equipment/data/dummy_equipment.dart`:**
    *   Update the dummy data to include the new `rentalPrice`, `location`, and `availability` fields.

7.  **Fix `lib/features/marketplace/pages/marketplace_page.dart`:**
    *   Update the UI to display the new `rentalPrice` field.

8.  **Fix `lib/features/profile/pages/edit_profile_page.dart`:**
    *   Fix the `copyWith` method not being available on the `UserModel`.
    *   Fix the `initialValue` property of the `DropdownButtonFormField`s.
