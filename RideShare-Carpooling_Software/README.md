## Abstract

**RideShare** is a user-friendly mobile app built using Flutter for Android, designed to connect individuals who want to share rides. RideShare facilitates carpooling by enabling users to both offer and search for rides through an intuitive interface. Users can either offer rides by specifying their starting point, destination, and available space, or search for existing rides matching their needs. This dual functionality allows users to either contribute by offering spare seats or find convenient, cost-effective rides. Built for simplicity, RideShare leverages OpenStreetMap API and OpenRouteService API alongside Firebase for seamless navigation and secure data management. By encouraging carpooling, RideShare aims to reduce traffic congestion, lower transportation costs for users, and contribute to a more environmentally friendly and connected community.

## Features

- Offer rides by specifying start point, destination, and available space
- Search for existing rides that match your needs
- Seamless navigation using OpenStreetMap API and OpenRouteService API
- Secure data management with Firebase integration

## Installation

### Prerequisites

- [Flutter SDK](https://flutter.dev/docs/get-started/install)
- [Firebase Account](https://firebase.google.com/)

### Flutter Installation

Follow the official Flutter installation guide: [Flutter Installation](https://flutter.dev/docs/get-started/install)

### Setting Up an Emulator

#### Android Emulator

1. **Install Android Studio**:
   Download and install [Android Studio](https://developer.android.com/studio).

2. **Set Up Android Emulator**:
   - Open Android Studio.
   - Go to `AVD Manager` by navigating to `Tools` > `AVD Manager`.
   - Click on `Create Virtual Device`.
   - Select a device definition and click `Next`.
   - Choose a system image and click `Next`.
   - Adjust the AVD properties as needed and click `Finish`.

3. **Start the Emulator** :
   - Open `AVD Manager`.
   - Click the play button next to your virtual device to start the emulator.

### Firebase Setup

1. Go to the [Firebase Console](https://console.firebase.google.com/).
2. Create a new project or use an existing project.
3. Add an Android and/or iOS app to your Firebase project.
4. Follow the setup instructions to download `google-services.json` (for Android).
5. Place these configuration files in the appropriate directories of your Flutter project:
   - `android/app/google-services.json`

For detailed setup instructions, refer to the official documentation:
- [Firebase for Flutter](https://firebase.flutter.dev/docs/overview)

### Steps

```sh
# Clone the repository
git clone https://github.com/John-kurian-03/RideShare-Carpooling_Software.git

# Navigate to the project directory
cd RideShare-Carpooling_Software

# Install dependencies
flutter pub get

# Run the project
flutter run
