# Agri-Rental App Blueprint

## Overview

Agri-Rental is a mobile application designed to connect farmers who need to rent agricultural equipment with equipment owners. The app provides a platform for owners to list their equipment and for farmers to browse and rent available items.

## Current Plan: Farmer Experience Overhaul

This phase focuses on building a comprehensive and intuitive experience for farmers, from discovering equipment to managing bookings.

### 1. Farmer Dashboard

*   **Goal:** Replace the current simple list of equipment with a user-friendly dashboard that organizes equipment by category.
*   **Implementation:**
    *   The Farmer's home page will display a grid of equipment categories (e.g., "Tractors", "Harvesters", "Plows").
    *   Create a `Category` model and a `CategoryService` to fetch categories from Firestore.

### 2. Equipment Discovery

*   **Goal:** Allow farmers to easily find the equipment they need.
*   **Flow:** Category -> Equipment List -> Equipment Details.
*   **Implementation:**
    *   **Equipment List:** Tapping a category will navigate to a page showing all equipment in that category.
    *   **Equipment Details Page:** A rich view with:
        *   Image gallery/carousel.
        *   Rental price (per hour/day).
        *   Availability calendar.
        *   Technical specifications.
        *   Owner information (name, profile link).
        *   Detailed description and terms of use.

### 3. Booking System

*   **Goal:** Implement a full booking workflow.
*   **Implementation:**
    *   **Booking Request:** Farmers can request to book equipment by selecting dates, times, duration, and a delivery location.
    *   **Booking Model:** Create a `Booking` model with a defined lifecycle.
    *   **Booking Lifecycle:** The status of a booking will be tracked in Firestore: `Pending`, `Accepted`, `Rejected`, `Ongoing`, `Completed`.
    *   **Communication:**
        *   **Chat:** Farmers can chat with the equipment owner for inquiries.
        *   **Call:** A button to initiate a phone call with the owner.

### 4. Farmer Profile

*   **Goal:** Provide farmers with a dedicated space to manage their information and bookings.
*   **Implementation:**
    *   A profile page where farmers can:
        *   Edit their personal information.
        *   View their complete booking history (past and upcoming).
        *   Select their preferred language for the app.

## Implemented Features

*   **Authentication:** User roles (`Farmer`, `Owner`), sign-up, and login.
*   **UI/UX:** Custom theme, dark/light mode toggle, modern design.
*   **Owner Role:** A basic interface to view and add equipment.
*   **Project Structure:** A scalable feature-first project structure.
*   **Bug Fix:** Resolved a crash on the farmer's home page related to missing rental prices.

## Future Plans

*   Advanced search and filtering.
*   User ratings and reviews.
*   Payment integration.
*   Geolocation and notifications.
