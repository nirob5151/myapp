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
    *   Users can sign up and log in with their email and password.
    *   Users can choose between two roles: "Farmer" and "Owner".
    *   The user's name and role are stored in Firestore.
    *   The sign-up screen now uses `ChoiceChip` widgets for a modern and accessible role selection.
*   **Equipment:**
    *   A list of equipment is displayed on the home page.
    *   Users with the "Owner" role can add new equipment with a name, description, price, and image.
    *   Equipment data is stored in Firestore, and images are stored in Firebase Storage.
    *   Users can view the details of each piece of equipment on a dedicated screen.
    *   The equipment detail screen fetches and displays real data from Firestore, including the owner's name.
*   **UI:**
    *   The app has a basic theme with a primary color.
    *   The home page displays a list of equipment in a card format.
    *   The "add equipment" page provides a form for owners to add new equipment.
*   **Code Quality:**
    *   All analyzer warnings and deprecation issues have been resolved.
    *   The codebase is clean and follows best practices.

## Next Steps:

*   **Booking:**
    *   Allow farmers to book equipment for specific dates.
    *   Implement a booking system to manage equipment availability.
*   **User Profiles:**
    *   Create a profile page for users to view and edit their information.
    *   Display the user's rental history.
