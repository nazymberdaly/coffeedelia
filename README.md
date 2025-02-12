# coffeedelia

This app displays coffee images fetched from a free API and allows users to save their favorites for offline viewing. It's built for iOS and Android using Flutter.

## User Requirements

As a user, I should be able to:

* Open the app and load a new coffee image from the network.
* Load a new coffee image if the current one is not my favorite.
* Save the current coffee image locally if I really like it, so I can access my favorite coffee images at any time, even if I don’t have internet access.
* Ensure any loading/error states are handled correctly.

## Technical Requirements

* The application pulls coffee images from the free API: [https://coffee.alexflipnote.dev](https://coffee.alexflipnote.dev)
* The application runs on iOS and Android.

## Getting Started

To run this application, please follow these steps:

1. **Clone the repository:**
   ```bash
   git clone https://github.com/nazymberdaly/coffeedelia.git

2. Install dependencies:
Bash

flutter pub get

(Ensure you have Flutter installed. If not, follow the instructions at https://flutter.dev/docs/get-started/install)

3. Run the app:

    iOS:
    Bash

flutter run

(You may need to have Xcode installed and configured for iOS development.)

Android:
Bash

        flutter run

        (You may need to have Android Studio and the Android SDK installed and configured for Android development.)
        
Troubleshooting:

    If you encounter any issues during the installation or running process, please refer to the Flutter documentation or create an issue in the repository.

Architecture

This section will describe the app's architecture, including state management, data flow, and any design patterns used.

    State Management: BLoC.
    Networking: http package.
    Local Storage: sqflite.
    Image Caching: cached_network_image.
