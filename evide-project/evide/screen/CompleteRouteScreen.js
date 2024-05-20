import "react-native-gesture-handler";
import React, { useState, useEffect, useRef } from "react";
import { StyleSheet, View, Dimensions } from "react-native";
import MapView, { Marker, PROVIDER_GOOGLE } from "react-native-maps";
import * as Location from "expo-location";
import FloatingContainer from "../components/FloatingContainer.js";
import RouteListModal from "../components/RouteListModal.js";
import { GestureHandlerRootView } from "react-native-gesture-handler";
import { BottomSheetModalProvider } from "@gorhom/bottom-sheet";
import GlobalApi from "../services/GlobalApi.js";

import TripCompleteModal from "../components/TripCompleteModal.js";

import axios from "axios";
import { GooglePlacesAutocomplete } from "react-native-google-places-autocomplete";

const windowHeight = Dimensions.get("window").height;

import { useRoute } from "@react-navigation/native";

// navigator.geolocation = require('@react-native-community/geolocation');
// navigator.geolocation = require('react-native-geolocation-service');

const CompleteRouteScreen = ({ navigation }) => {
  const r = useRoute();
  const { routeValue } = r.params;
  const API_KEY = "YOUR_API_KEY";

  const mapRef = useRef();
  const originRef = useRef();
  const destinationRef = useRef();

  const [location, setLocation] = useState({});
  const [route, setRoute] = useState();

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

    const response = await axios.get(
      `https://maps.googleapis.com/maps/api/geocode/json?latlng=${locationResponse.coords.latitude},${locationResponse.coords.longitude}&key=${API_KEY}`
    );
    console.log(response.data);

    // await originRef.current.setAddressText(
    //   response.data.results[0]?.formatted_address
    // );
    // // await destinationRef.current.focus();
    // setOrigin(response.data.results[0]?.formatted_address);
  };

  useEffect(() => {
    userLocaton();
    setRoute(routeValue)
    originRef.current.setAddressText(routeValue.legs[0].start_address);
    destinationRef.current.setAddressText(routeValue.legs[0].end_address);
  }, []);

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
          ></MapView>

          <TripCompleteModal navigation={navigation} route={route} />
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

export default CompleteRouteScreen;
