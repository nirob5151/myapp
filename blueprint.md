# Project Blueprint

## App Name: EasyFarm — Smart Equipment Rentals

## App Concept:
EasyFarm is a mobile platform that connects farmers with agricultural equipment owners for renting or leasing farm machinery such as tractors, harvesters, irrigation pumps, and more.
It helps small and medium-scale farmers access modern tools without large upfront costs, while owners earn by renting out their idle equipment.

## Key Features:

### For Farmers:

*   Browse equipment (tractors, harvesters, pumps, etc.) by location, price, and availability
*   View equipment details (specs, photos, rent rate, owner info)
*   Book equipment and contact owners (call/message)
*   Track active and past rentals

### For Owners:

*   Post equipment with photos, description, price, and availability
*   Manage listings (edit, pause, delete)
*   Accept or reject booking requests
*   Track payments and rental history

### Common Features:

*   Login/Signup (Farmer or Owner)
*   Profile and settings management
*   Reviews and ratings system
*   Notifications for booking updates and payments

## Unique Selling Points (USP):

*   Localized support (Bangla + English)
*   Location-based equipment suggestions
*   Built-in payment tracking and rental calendar
*   Promotes shared resource usage (eco-friendly farming)

## Tech Stack Suggestion:

*   **Frontend:** Flutter
*   **Backend:** Firebase
*   **Database:** Firestore
*   **Map Integration:** Google Maps API
*   **Notifications:** Firebase Cloud Messaging (FCM)

## Current Implementation:

*   **Authentication:**
    *   The login and sign-up process has been completely redesigned to match the provided UI.
    *   Users can sign up and log in with their email and password.
    *   The login screen presents role selection cards ("Farmer" or "Owner") that navigate to the sign-up screen with the role pre-selected.
    *   The user's name and role are stored in Firestore upon sign-up.
*   **Equipment:**
    *   A list of equipment is displayed on the home page.
    *   Users with the "Owner" role can add new equipment with a name, description, price, and image.
    *   Equipment data is stored in Firestore, and images are stored in Firebase Storage.
    *   Users can view the details of each piece of equipment on a dedicated screen.
    *   The equipment detail screen fetches and displays real data from Firestore, including the owner's name.
*   **UI:**
    *   The login and sign-up screens have been rebuilt for a modern, visually appealing look and feel, consistent with the new design.
    *   The new design features a light green background (`#F5F9F5`), custom-styled text fields, and prominent green buttons (`#3B873E`).
    *   Role selection on the login page is now presented as large, tappable cards with icons.
    *   Role selection on the sign-up page uses styled `ChoiceChip` widgets for a seamless user experience.
    *   The home page displays a list of equipment in a card format.
*   **Code Quality:**
    *   File structure for authentication has been reorganized for better clarity (`pages` and `screens`).
    *   Routing has been updated to support the new authentication flow.
    *   All analyzer warnings and deprecation issues have been resolved.
    *   The codebase is clean and follows best practices.

## Next Steps:

*   **Implement Google Sign-In:** The "Continue w/Google" button is currently a placeholder.
*   **Booking:**
    *   Allow farmers to book equipment for specific dates.
    *   Implement a booking system to manage equipment availability.
*   **User Profiles:**
    *   Create a profile page for users to view and edit their information.
    *   Display the user's rental history.
