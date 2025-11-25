# Agri-Rental App Blueprint

## App Overview

Agri-Rental is a mobile application that connects farmers who need agricultural equipment with owners who have equipment available for rent. The app facilitates the entire rental process, from browsing and booking to communication and payment.

## Features

### Implemented

*   **Farmer Dashboard:** A home screen for farmers to browse equipment categories and featured ads.
*   **Theme Toggle:** Light and dark mode support.
*   **User Authentication:** Secure login with Google Sign-In.
*   **Real-time Chat:** In-app messaging between farmers and owners using Firebase.

### Planned

*   **Equipment Listings:** Detailed pages for each piece of equipment.
*   **Booking System:** A complete system for requesting, accepting, and managing rentals.
*   **Payment Integration:** Secure payment processing for rentals.
*   **Notifications:** Real-time alerts for booking requests and updates.
*   **User Profiles:** Profiles for farmers and owners with their rental history and ratings.
*   **Map Integration:** Displaying equipment and rental locations on a map.

## Farmer User Story

1.  **Browse and Discover:**
    *   The farmer opens the app and sees a dashboard with equipment categories (e.g., Tractors, Harvesters, Pumps) and featured ads.
    *   The farmer can search for specific equipment.

2.  **View Equipment Listings:**
    *   The farmer taps on a category to see a list of available equipment in that category.
    *   Each item in the list displays the equipment name, image, price, availability, and location.

3.  **Explore Equipment Details:**
    *   The farmer taps on an equipment card to view a detailed page with:
        *   An image slider with multiple pictures of the equipment.
        *   Detailed pricing (per hour, day, week).
        *   An availability calendar.
        *   Technical specifications (e.g., power, model, fuel type).
        *   Owner information (name, contact details).
        *   The equipment's location on a map.
        *   A detailed description and terms and conditions.

4.  **Book Equipment:**
    *   The farmer can request a booking by selecting the desired date, time, duration, and rental location.
    *   The farmer can also chat with the owner or call them directly from the app.

5.  **Manage Bookings:**
    *   The farmer receives a notification when the owner accepts or rejects the booking request.
    *   The farmer can track the status of their bookings (e.g., pending, confirmed, completed).
    *   The farmer can view their rental history.

## Owner User Story

1.  **List Equipment:**
    *   The owner can create a new equipment listing by providing all the necessary details, including images, pricing, and specifications.

2.  **Manage Listings:**
    *   The owner can view, edit, or delete their equipment listings.
    *   The owner can set the availability of their equipment on a calendar.

3.  **Handle Booking Requests:**
    *   The owner receives a notification when a farmer requests to book their equipment.
    *   The owner can review the request and either accept or reject it.

4.  **Communicate with Farmers:**
    *   The owner can chat with farmers in real-time to answer questions and coordinate rentals.

5.  **Track Earnings:**
    *   The owner can track their earnings from rentals.

## Technical Details

*   **Frontend:** Flutter
*   **Backend:** Firebase (Firestore, Authentication, Storage, Cloud Firestore)
*   **State Management:** Provider
*   **Routing:** GoRouter
*   **Authentication:** Google Sign-In
*   **Chat:** Cloud Firestore
