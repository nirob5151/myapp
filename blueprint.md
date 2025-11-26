
# Project Overview

Krishi Bazaar is a Flutter application that allows farmers to rent agricultural equipment. The app connects equipment owners with farmers who need to rent equipment for their farming activities. The app provides a platform for browsing, booking, and managing equipment rentals.

# Features Implemented

*   **Farmer Dashboard:** A dashboard that displays the different categories of equipment available for rent.
*   **Category Listing:** A screen that lists all the equipment available in a specific category.
*   **Equipment Detail:** A screen that shows the details of a specific piece of equipment, including its price, availability, and location.
*   **Booking:** A screen that allows farmers to book a piece of equipment for a specific period.
*   **Profile:** A screen that displays the user's profile information and provides access to their booking history.
*   **Booking History:** A screen that shows a list of all the equipment that the user has booked.
*   **Centralized Routing:** A centralized routing system that handles all the navigation in the app.
*   **Not Found Screen:** A screen that is displayed when a user tries to navigate to a route that does not exist.
*   **Theme Provider:** A theme provider that manages the application's theme.
*   **Light and Dark Themes:** The application now supports both light and dark themes.
*   **Theme Toggle:** A feature that allows users to switch between light and dark modes, and also to set the theme to follow the system settings.
*   **Modern UI:** The application has been updated with a more modern and visually appealing design, including a bottom navigation bar, horizontally scrolling category cards, and improved styling for the equipment listing and detail screens.
*   **Date and Time Pickers:** The booking screen now includes date and time pickers to allow users to select the start and end dates and times for their bookings.

# Plan for Current Changes

*   **Create a centralized routing system:** Create a `routes.dart` file to centralize all the routing logic in the app. This will make the navigation more organized and easier to manage.
*   **Update the navigation logic:** Update the navigation logic in all the relevant files to use the new centralized routing system. This will make the navigation more consistent and easier to maintain.
*   **Create a Not Found screen:** Create a screen that is displayed when a user tries to navigate to a route that does not exist. This will improve the user experience by providing a clear message instead of a generic error.
*   **Make equipment cards tappable:** Make the equipment cards on the `CategoryListingScreen` tappable so that tapping on a card will navigate the user to the `EquipmentDetailScreen` for that specific piece of equipment.
*   **Add a theme provider:** Create a `ThemeProvider` to manage the application's theme. This will allow for easy switching between light and dark modes.
*   **Implement light and dark themes:** Define light and dark themes for the application using the `google_fonts` package and `ColorScheme.fromSeed`.
*   **Add a theme toggle:** Add a theme toggle button to the `ProfileScreen` to allow users to switch between light and dark modes.
*   **Modernize the UI:** Update the UI of the `FarmerDashboard`, `CategoryListingScreen`, and `EquipmentDetailScreen` to have a more modern and visually appealing design.
*   **Add a bottom navigation bar:** Add a bottom navigation bar to the `FarmerDashboard` to provide easy access to the main sections of the app.
*   **Add date and time pickers:** Add date and time pickers to the `BookingScreen` to allow users to select the start and end dates and times for their bookings.
