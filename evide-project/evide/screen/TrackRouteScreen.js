import "react-native-gesture-handler";
import React, { useState, useEffect, useRef } from "react";
import {
  StyleSheet,
  View,
  Dimensions,
  TouchableOpacity,
  Linking,
} from "react-native";
import MapView, { Marker, PROVIDER_GOOGLE, Polyline } from "react-native-maps";
import polyline from "@mapbox/polyline";
import * as Location from "expo-location";
import FloatingContainer from "../components/FloatingContainer.js";
import RouteListModal from "../components/RouteListModal.js";
import { GestureHandlerRootView } from "react-native-gesture-handler";
import { BottomSheetModalProvider } from "@gorhom/bottom-sheet";
import GlobalApi from "../services/GlobalApi.js";
import { getDistance } from "geolib";

import LiveTrackModal from "../components/LiveTrackModal";
import TestModal from "../components/TestModal.js";
import axios from "axios";
import { GooglePlacesAutocomplete } from "react-native-google-places-autocomplete";

const windowHeight = Dimensions.get("window").height;

import { useRoute } from "@react-navigation/native";
import pushNotification from "../services/nativeNotifyApi.js";

// navigator.geolocation = require('@react-native-community/geolocation');
// navigator.geolocation = require('react-native-geolocation-service');

const TrackRouteScreen = ({ navigation }) => {
  const r = useRoute();
  const { routeValue } = r.params;

  const API_KEY = "YOUR_API_KEY";

  const mapRef = useRef();
  const originRef = useRef();
  const destinationRef = useRef();

  const [route, setRoute] = useState();
  const [location, setLocation] = useState({});
  const [markers, setMarkers] = useState([]);
  const [currentStep, setCurrentStep] = useState(0);

  const [checkStatus, setCheckStatus] = useState(false);
  const [showNavigate, setShowNavigate] = useState(false);

  const userLocaton = async () => {
    let { status } = await Location.requestForegroundPermissionsAsync();
    if (status !== "granted") {
      setErrorMsg("Permission for location access denied");
      return;
    }
    let locationResponse = await Location.getCurrentPositionAsync({
      enableHighAccuracy: true,
    });

    setLocation(locationResponse);

    await mapRef.current?.animateToRegion({
      latitude: location?.coords.latitude,
      longitude: location?.coords.longitude,
      latitudeDelta: 0.009,
      longitudeDelta: 0.009,
    });
  };

  const initializeTracking = async () => {
    if (route?.legs[0]?.steps) {
      const newMarkers = route.legs[0].steps.map((parentStep) => ({
        latitude: parentStep.end_location.lat,
        longitude: parentStep.end_location.lng,
        instruction: parentStep.html_instructions,
        completed: false,
      }));

      setMarkers((oldMarkers) => [...oldMarkers, ...newMarkers]);
    }

    if (route?.legs[0].steps[currentStep].travel_mode == "WALKING")
      setShowNavigate(true);
    console.log(route?.legs[0].steps[currentStep].travel_mode);
  };

  useEffect(() => {
    userLocaton();
    setRoute(routeValue);
    console.log(routeValue);
    originRef.current.setAddressText(routeValue.legs[0].start_address);
    destinationRef.current.setAddressText(routeValue.legs[0].end_address);

    initializeTracking();
  }, []);

  const checkStep = (coordinate) => {
    if (route?.legs[0].steps[currentStep]) {
      const distanceEndCurrent = getDistance(
        {
          latitude: coordinate.nativeEvent.coordinate.latitude,
          longitude: coordinate.nativeEvent.coordinate.longitude,
        },
        {
          latitude: route?.legs[0].steps[currentStep]?.end_location.lat,
          longitude: route?.legs[0].steps[currentStep]?.end_location.lng,
        }
      );

      if (distanceEndCurrent < 50) {
        console.log("Check step completion");
        pushNotification('Kuruvilla', 'Evide', 'Have you reached?')
        setCheckStatus(true);
      }
    }
  };

  const navigate = () => {
    console.log(route?.legs[0].steps[currentStep].travel_mode);

    if (route?.legs[0].steps[currentStep].travel_mode == "WALKING") {
      setShowNavigate(true);
      const destinationLatitude =
        route?.legs[0].steps[currentStep].end_location.lat;
      const destinationLongitude =
        route?.legs[0].steps[currentStep].end_location.lng;
      const travelMode = "walking";
      const url = `https://www.google.com/maps/dir/?api=1&destination=${destinationLatitude},${destinationLongitude}&travelmode=${travelMode}`;

      Linking.openURL(url).catch((err) =>
        console.error("An error occurred", err)
      );
    } else {
      setShowNavigate(false);
      console.log("Transit Mode");
    }

    console.log(showNavigate);
  };

  const updateStep = () => {
    if (currentStep + 1 == route.legs[0].steps.length)
      navigation.navigate("Complete Route", { routeValue: route });
    setCurrentStep((old) => old + 1);
    setCheckStatus(false);
  };

  return (
    <GestureHandlerRootView style={{ flex: 1 }}>
      <BottomSheetModalProvider>
        <View style={styles.container}>
          <FloatingContainer navigation={navigation}>
            <GooglePlacesAutocomplete
              placeholder="Enter Origin"
              placeholderTextColor="black"
              ref={originRef}
              styles={{
                textInputContainer: {
                  width: "90%",
                  marginLeft: "10%",
                  marginTop: "3%",
                  // paddingLeft:10,
                },
                textInput: styles.locationInput,
                listView: { position: "absolute", top: 50, zIndex: 2 },
              }}
              onPress={(data, details = null) => {
                setOrigin(data);
              }}
              query={{
                key: API_KEY,
                language: "en",
              }}
              currentLocation
            />
            <GooglePlacesAutocomplete
              ref={destinationRef}
              styles={{
                textInputContainer: {
                  width: "90%",
                  marginLeft: "10%",
                  height: "10%",
                },
                textInput: styles.locationInput,
                listView: { position: "absolute", top: 50, zIndex: 2 },
              }}
              placeholderTextColor="black"
              placeholder="Enter Destination"
              onPress={(data, details = null) => {
                setDestination(data.description);
              }}
              query={{
                key: API_KEY,
                language: "en",
              }}
            />
          </FloatingContainer>
          <MapView
            style={styles.map}
            ref={mapRef}
            // provider={PROVIDER_GOOGLE}
            showsUserLocation
            showsMyLocationButton
            onUserLocationChange={checkStep}
          >
            {route && (
              <Polyline
                coordinates={polyline
                  .decode(route.overview_polyline.points)
                  .map((coord) => {
                    return { latitude: coord[0], longitude: coord[1] };
                  })}
                strokeColor={"#FFC75B"} // fallback for when `strokeColors` is not supported by the map-provider
                strokeWidth={6}
              />
            )}
          </MapView>

          <LiveTrackModal
            navigation={navigation}
            route={routeValue}
            currentStep={currentStep}
            showNavigate={showNavigate}
            checkStatus={checkStatus}
            navigate={navigate}
            updateStep={updateStep}
          />
        </View>
      </BottomSheetModalProvider>
    </GestureHandlerRootView>
  );
};

const CONTAINER_PADDING = 10;

const styles = StyleSheet.create({
  container: {
    flex: 1,
    flexDirection: "column",
    justifyContent: "flex-start",
    alignItems: "center",
  },
  map: {
    flex: 1,
    ...StyleSheet.absoluteFillObject,
    width: "100%",
    marginBottom: 0, // Remove or set to 0
    zIndex: -1,
  },
  goButtonContainer: {
    position: "fixed",
    bottom: windowHeight * 0.06, // Adjust the button position as needed
    alignSelf: "center",
    elevation: 1, // Ensure the button appears on top
  },
  goButton: {
    backgroundColor: "#FFC75B",
    borderRadius: 20, // Adjust border radius as needed
    paddingHorizontal: "20%",
    paddingVertical: "5%",
    alignItems: "center",
  },
  goButtonText: {
    fontSize: 16,
    fontWeight: "bold",
  },
  locationInput: {
    color: "black",
    height: 42,
    backgroundColor: "#FFFFFF",
    borderRadius: 25,
    borderWidth: 1,
    borderColor: "#2675EC",
    fontWeight: "600",
  },
});

export default TrackRouteScreen;
