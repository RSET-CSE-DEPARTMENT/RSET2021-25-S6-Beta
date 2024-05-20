# Evide - Multi Modal Transport App

## Overview

Evide is a Multi Modal Transport App developed using React Native and the Google Maps API. The app is designed to help users in Kochi plan and optimize their journeys using various public transport options including metro, water metro, and buses. Evide provides real-time information, detailed itineraries, and enhances user safety and convenience during their journeys.

## Features

### Route Planning and Optimization
- **Description**: Allows users to plan journeys using various public transport options, optimizing for travel time, eco-friendliness, or scenic routes.
- **Functional Requirements**:
  - Enter origin and destination addresses.
  - Auto-complete addresses using location services.
  - Validate entered addresses.
  - Select preferred travel modes (All, metro, water metro, bus).
  - Filter routes based on travel modes.
  - Select route optimization preference (Fastest, Eco-friendly, Scenic).
  - Display route options on a map with estimated travel times.

### Real-Time Information
- **Description**: Provides real-time information about the user's journey progress, upcoming stops, and estimated arrival times.
- **Functional Requirements**:
  - Track user’s location during the journey.
  - Integrate with real-time public transport data feeds.
  - Display current location on a map.
  - Highlight upcoming stops.
  - Display estimated arrival times for upcoming stops.

### User Itinerary and Tracking
- **Description**: Provides a detailed itinerary including transport legs, transfers, travel times, and fares.
- **Functional Requirements**:
  - Generate a comprehensive itinerary for the chosen route.
  - Display total fare cost.
  - Allow users to review their itinerary during the journey.

### User Safety and Convenience
- **Description**: Enhance user safety and convenience with features like live location sharing, POIs information, and in-app Malayalam translation.
- **Functional Requirements**:
  - Integrate with Malayalam-English translation API.
  - Offer on-screen translation of Malayalam text.
  - Allow sharing of live location and route with emergency contacts.
  - Display information on POIs along the route.

## Getting Started

### Prerequisites
- Node.js
- npm or yarn
- React Native CLI
- Google Maps API Key

### Installation
1. **Clone the Repository**:
   ```sh
   git clone https://github.com/yourusername/evide.git
   cd evide
   ```

2. **Install Dependencies**:
   ```sh
   npm install
   # or
   yarn install
   ```

3. **Get Google API Credentials**:
   - Go to the [Google Cloud Console](https://console.cloud.google.com/).
   - Create a new project or select an existing one.
   - Navigate to the **APIs & Services** > **Credentials**.
   - Click on **Create credentials** > **API key**.
   - Copy the generated API key.

4. **Configure Google API Key**:
   - Create a `.env` file in the root of the project.
   - Add your Google API key:
     ```sh
     GOOGLE_MAPS_API_KEY=your_api_key_here
     ```

5. **Link Environment Variables**:
   Ensure your environment variables are linked in your `app.json` or `app.config.js`:
   ```json
   "expo": {
     "extra": {
       "googleMapsApiKey": process.env.GOOGLE_MAPS_API_KEY
     }
   }
   ```

6. **Start the Project**:
   ```sh
   npm start
   # or
   yarn start
   ```

## Running the App
- For iOS:
  ```sh
  npm run ios
  # or
  yarn ios
  ```
- For Android:
  ```sh
  npm run android
  # or
  yarn android
  ```

## Additional Resources
- [React Native Documentation](https://reactnative.dev/docs/getting-started)
- [Google Maps API Documentation](https://developers.google.com/maps/documentation)

---

Thank you for using Evide! We hope this app helps make your travel in Kochi easier and more efficient.