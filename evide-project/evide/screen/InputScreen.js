import React, { useState, useEffect, useRef, useCallback } from "react";
import { StyleSheet, View, Dimensions } from "react-native";
import MapView, { Marker, Polyline, PROVIDER_GOOGLE } from "react-native-maps";
import * as Location from "expo-location";
import { GestureHandlerRootView } from "react-native-gesture-handler";
import { BottomSheetModalProvider } from "@gorhom/bottom-sheet";
import polyline from "@mapbox/polyline";
import axios from "axios";
import { GooglePlacesAutocomplete } from "react-native-google-places-autocomplete";
import FloatingContainer from "../components/FloatingContainer.js";
import ExploreModal from "../components/ExploreModal.js";
import RouteListModal from "../components/RouteListModal.js";

import metroStations from "../services/staticData.js";

const windowHeight = Dimensions.get("window").height;

const InputScreen = ({ navigation }) => {
  const API_KEY = "YOUR_API_KEY";

  const mapRef = useRef();
  const originRef = useRef();
  const destinationRef = useRef();

  const [origin, setOrigin] = useState("");
  const [destination, setDestination] = useState("");
  const [location, setLocation] = useState();
  const [showType, setShowType] = useState("explore");

  const [routes, setRoutes] = useState([]);
  const [markers, setMarkers] = useState([]);
  const [shortestTimeBus, setShortestTimeBus] = useState();
  const [shortestDistanceBus, setShortestDistanceBus] = useState();
  const [lowestFareBus, setLowestFareBus] = useState();

  const [selectedSortCriteria, setSelectedSortCriteria] = useState(null);

  // Function to calculate distance between two coordinates (in meters)
  const calculateDistance = (coord1, coord2) => {
    const R = 6371e3; // Earth radius in meters
    const φ1 = (coord1.lat * Math.PI) / 180;
    const φ2 = (coord2.lat * Math.PI) / 180;
    const Δφ = ((coord2.lat - coord1.lat) * Math.PI) / 180;
    const Δλ = ((coord2.lng - coord1.lng) * Math.PI) / 180;

    const a =
      Math.sin(Δφ / 2) * Math.sin(Δφ / 2) +
      Math.cos(φ1) * Math.cos(φ2) * Math.sin(Δλ / 2) * Math.sin(Δλ / 2);
    const c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));

    return R * c;
  };

  const fetchUserLocation = async () => {
    let { status } = await Location.requestForegroundPermissionsAsync();
    if (status !== "granted") {
      console.log("Permission for location access denied");
      return;
    }
    console.log("Fetching Location");
    let locationResponse = await Location.getLastKnownPositionAsync({
      enableHighAccuracy: true,
    });
    setLocation(locationResponse);

    console.log("Getting Origin Address");
    const response = await axios.get(
      `https://maps.googleapis.com/maps/api/geocode/json?latlng=${locationResponse.coords.latitude},${locationResponse.coords.longitude}&key=${API_KEY}`
    );
    console.log(response.data);
    // originRef.current?.setAddressText(
    //   response.data.results[0]?.formatted_address
    // );
    // setOrigin(response.data.results[0]?.formatted_address);
  };

  const findNearestMetroStation = (coordinates) => {
    let minDistance = Number.MAX_VALUE;
    let nearestStation = null;
    console.log(metroStations);
    metroStations.forEach((station) => {
      const distance = calculateDistance(coordinates, station);
      if (distance < minDistance) {
        minDistance = distance;
        nearestStation = station;
      }
    });

    return nearestStation;
  };

  function generateRandomShade(hexColor) {
    // Parse the hex color string into RGB components
    var red = parseInt(hexColor.substring(0, 2), 16);
    var green = parseInt(hexColor.substring(2, 4), 16);
    var blue = parseInt(hexColor.substring(4, 6), 16);

    // Generate random offsets for each RGB component
    var offsetRed = Math.floor(Math.random() * 51) - 25; // Random number between -25 and 25
    var offsetGreen = Math.floor(Math.random() * 51) - 25;
    var offsetBlue = Math.floor(Math.random() * 51) - 25;

    // Apply the offsets to the RGB components
    red = Math.min(255, Math.max(0, red + offsetRed));
    green = Math.min(255, Math.max(0, green + offsetGreen));
    blue = Math.min(255, Math.max(0, blue + offsetBlue));

    // Convert the RGB components back to hex
    var newHexColor =
      "#" +
      ((1 << 24) + (red << 16) + (green << 8) + blue).toString(16).slice(1);

    return newHexColor;
  }

  const getroutes = async () => {
    try {
      const originResponse = await axios.get(
        "https://maps.googleapis.com/maps/api/geocode/json",
        {
          params: {
            address: origin,
            key: "YOUR_API_KEY",
          },
        }
      );
      const originCoordinates =
        originResponse.data.results[0].geometry.location;

      const destinationResponse = await axios.get(
        "https://maps.googleapis.com/maps/api/geocode/json",
        {
          params: {
            address: destination,
            key: "YOUR_API_KEY",
          },
        }
      );
      const destinationCoordinates =
        destinationResponse.data.results[0]?.geometry.location;

      const nearestMetroToOrigin = findNearestMetroStation(originCoordinates);
      const nearestMetroToDestination = findNearestMetroStation(
        destinationCoordinates
      );

      console.log(originCoordinates, destinationCoordinates);

      const response = await axios.get(
        `https://maps.googleapis.com/maps/api/directions/json?origin=${origin}&destination=${destination}&mode=transit&key=${API_KEY}&alternatives=true`
      );
      // setDirections(response.data);
      console.log(
        `https://maps.googleapis.com/maps/api/directions/json?origin=${origin}&destination=${destination}&mode=transit&key=${API_KEY}&alternatives=true`
      );
      console.log("Routes : ", response.data.routes);

      setRoutes(response.data.routes);
      // console.log(
      //   "Polyline : ",
      //   response.data.routes[0].overview_polyline.points
      // );

      setMarkers(() => [
        {
          latitude: response.data.routes[0]?.legs[0].start_location.lat,
          longitude: response.data.routes[0]?.legs[0].start_location.lng,
        },
        {
          latitude: response.data.routes[0]?.legs[0].end_location.lat,
          longitude: response.data.routes[0]?.legs[0].end_location.lng,
        },
      ]);
      mapRef.current?.fitToElements();
      console.log("Markers : ", markers);

      const originToMetroResponse = await axios.get(
        `https://maps.googleapis.com/maps/api/directions/json?origin=${origin}&destination=${nearestMetroToOrigin.lat},${nearestMetroToOrigin.lng}&key=${API_KEY}&mode=transit&alternatives=true`
      );
      const metroToDestinationResponse = await axios.get(
        `https://maps.googleapis.com/maps/api/directions/json?origin=${nearestMetroToDestination.lat},${nearestMetroToDestination.lng}&destination=${destination}&key=${API_KEY}&mode=transit&alternatives=true`
      );

      const routeDetails = response.data.routes;
      console.log(routeDetails[0]);
      const stations = {
        Aluva: {
          distance_from_previous_station: "0",
        },
        Pulinchodu: {
          distance_from_previous_station: "1.729",
        },
        Companypady: {
          distance_from_previous_station: "0.969",
        },
        Ambattukavu: {
          distance_from_previous_station: "0.984",
        },
        Muttom: {
          distance_from_previous_station: "0.937",
        },
        Kalamassery: {
          distance_from_previous_station: "2.052",
        },
        "Cochin University": {
          distance_from_previous_station: "1.379",
        },
        Pathadipalam: {
          distance_from_previous_station: "1.247",
        },
        Edapally: {
          distance_from_previous_station: "1.393",
        },
        "Changampuzha Park": {
          distance_from_previous_station: "1.300",
        },
        Palarivatom: {
          distance_from_previous_station: "1.008",
        },
        "J. L. N. Stadium": {
          distance_from_previous_station: "1.121",
        },
        Kaloor: {
          distance_from_previous_station: "1.033",
        },
        "Town Hall": {
          distance_from_previous_station: "0.473",
        },
        "M. G. Road": {
          distance_from_previous_station: "1.203",
        },
        "Maharaja's College": {
          distance_from_previous_station: "1.173",
        },
        "Ernakulam South": {
          distance_from_previous_station: "0.856",
        },
        Kadavanthra: {
          distance_from_previous_station: "1.185",
        },
        Elamkulam: {
          distance_from_previous_station: "1.155",
        },
        Vyttila: {
          distance_from_previous_station: "1.439",
        },
        Thaikoodam: {
          distance_from_previous_station: "1.024",
        },
        Pettah: {
          distance_from_previous_station: "1.183",
        },
      };
      const metroStations = [
        { name: "Aluva", lat: 10.1099872, lng: 76.3495149 },
        { name: "Pulinchodu", lat: 10.0951, lng: 76.3466 },
        { name: "Companypady", lat: 10.0873, lng: 76.3428 },
        { name: "Ambattukavu", lat: 10.0792806, lng: 76.3388894 },
        { name: "Muttom", lat: 10.0727011, lng: 76.33375 },
        { name: "Kalamassery", lat: 10.0630188, lng: 76.3279715 },
        { name: "CUSAT", lat: 10.0468491, lng: 76.3182738 },
        { name: "Pathadipalam", lat: 10.0361, lng: 76.3144 },
        { name: "Edapally", lat: 10.025263, lng: 76.3083641 },
        { name: "Changampuzha Park", lat: 10.0152041, lng: 76.3023872 },
        { name: "Palarivattom", lat: 10.0063373, lng: 76.3048456 },
        { name: "JLN Stadium", lat: 10.0003003, lng: 76.2991852 },
        { name: "Kaloor", lat: 9.9943, lng: 76.2914 },
        { name: "Town Hall", lat: 9.9914, lng: 76.2884 },
        { name: "MG Road", lat: 9.983496, lng: 76.282263 },
        { name: "Maharaja’s College", lat: 9.9732357, lng: 76.2850733 },
        { name: "Ernakulam South", lat: 9.9685, lng: 76.2893 },
        { name: "Kadavanthra", lat: 9.966593, lng: 76.298074 },
        { name: "Elamkulam", lat: 9.9672125, lng: 76.3086071 },
        { name: "Vyttila", lat: 9.9673739, lng: 76.3204215 },
        { name: "Thaikoodam", lat: 9.960079, lng: 76.323483 },
        { name: "Pettah", lat: 9.9525568, lng: 76.3300456 },
        { name: "Vadakkekotta", lat: 9.952771, lng: 76.339277 },
        { name: "SN Junction", lat: 9.954662, lng: 76.345919 },
        { name: "Thrippunithura", lat: 9.9504507, lng: 76.3517069 },
      ];
      function calculateDistanceBetweenStations(station1, station2) {
        let distance = 0;
        let foundStation1 = false;
        let foundStation2 = false;
        let reverseTravel = false;

        // Iterate over each station and accumulate the distances until reaching station1 and station2
        for (const station in stations) {
          if (!foundStation1 && station === station1) {
            foundStation1 = true;
          } else if (!foundStation1 && station === station2) {
            reverseTravel = true;
            foundStation1 = true;
          } else if (foundStation1 && !foundStation2) {
            if (!reverseTravel) {
              distance += stations[station].distance_from_previous_station;
            }
            if (station === station2) {
              foundStation2 = true;
            }
          }
        }

        return foundStation2 ? distance : "Stations are not connected";
      }

      const distanceBetweenStations = calculateDistanceBetweenStations(
        nearestMetroToOrigin.name,
        nearestMetroToDestination.name
      );

      const findCoordsStation = (stationName) => {
        const station = metroStations.find(
          (station) => station.name === stationName
        );
        if (station) {
          return { latitude: station.lat, longitude: station.lng };
        }
      };

      const createCombinedRoutes = (
        originToMetroResponseData,
        metroToDestinationResponseData
      ) => {
        const busAndMetroRoute = [];

        originToMetroResponseData.forEach((originRoute) => {
          metroToDestinationResponseData.forEach((destinationRoute) => {
            const combinedRoute = {
              originToMetroLeg: originRoute,
              metroLeg: {
                departure_stop: {
                  name: nearestMetroToOrigin.name,
                  latitude: nearestMetroToOrigin.lat,
                  longitude: nearestMetroToOrigin.lng,
                },
                arrival_stop: {
                  name: nearestMetroToDestination.name,
                  latitude: nearestMetroToDestination.lat,
                  longitude: nearestMetroToDestination.lng,
                },
                fare: {
                  currency: "INR",
                  text: "₹30.00",
                  value: 30,
                },
                legs: [
                  {
                    steps: [
                      {
                        distance: {
                          text: `${distanceBetweenStations} km`,
                          value: distanceBetweenStations,
                        },
                        duration: {
                          text: "30 mins",
                          value: 1800,
                        },
                        end_location: {
                          latitude: nearestMetroToOrigin.lat,
                          longitude: nearestMetroToOrigin.lng,
                        },
                        html_instructions: `Get on metro to ${nearestMetroToDestination}`,
                        start_location: {
                          latitude: nearestMetroToOrigin.lat,
                          longitude: nearestMetroToOrigin.lng,
                        },
                        transit_details: {
                          arrival_stop: {
                            name: nearestMetroToDestination.name,
                            latitude: nearestMetroToDestination.lat,
                            longitude: nearestMetroToDestination.lng,
                          },
                          departure_stop: {
                            name: nearestMetroToOrigin.name,
                            latitude: nearestMetroToOrigin.lat,
                            longitude: nearestMetroToOrigin.lng,
                          },
                          headsign: "Kochi Metro",
                          line: {
                            agencies: [
                              {
                                name: "Kochi Metro",
                                url: "https://www.keralartc.com/main.html",
                              },
                            ],
                            name: "Kochi Metro",
                            vehicle: {
                              icon: "//maps.gstatic.com/mapfiles/transit/iw2/6/bus2.png",
                              name: "Bus",
                              type: "BUS",
                            },
                          },
                          num_stops: 37,
                        },
                        travel_mode: "TRANSIT",
                      },
                    ],
                  },
                ],
                duration: {
                  text: "30 mins",
                  value: 1800,
                },
                distance: {
                  value: distanceBetweenStations,
                },

                summary: "Metro Transport",
                warnings: ["Metro transport - Use caution"],
                waypoint_order: [],
              },
              metroToDestinationLeg: destinationRoute,
            };

            busAndMetroRoute.push(combinedRoute);
          });
        });

        return busAndMetroRoute;
      };

      const busAndMetroRoute = createCombinedRoutes(
        originToMetroResponse.data.routes,
        metroToDestinationResponse.data.routes
      );
      console.log(busAndMetroRoute);
      console.log("1st part");
      console.log(busAndMetroRoute[0].originToMetroLeg.legs);
      console.log("2nd part");
      console.log(busAndMetroRoute[0].metroLeg);
      console.log("3rd part");
      console.log(busAndMetroRoute[0].metroToDestinationLeg.legs);

      function calculateTotalFareDistanceTimeandCoordinates(busAndMetroRoute) {
        const convertSeconds = (seconds) => {
          const hours = Math.floor(seconds / 3600);
          const minutes = Math.floor((seconds % 3600) / 60);

          if (hours > 0) {
            return `${hours} hour${hours > 1 ? "s" : ""} ${minutes} minute${
              minutes > 1 ? "s" : ""
            }`;
          } else {
            return `${minutes} minute${minutes > 1 ? "s" : ""}`;
          }
        };

        busAndMetroRoute.forEach((route) => {
          const fare1 = route.originToMetroLeg.fare
            ? route.originToMetroLeg.fare.value
            : 0;
          const fare2 = route.metroLeg.fare ? route.metroLeg.fare.value : 0;
          const fare3 = route.metroToDestinationLeg.fare
            ? route.metroToDestinationLeg.fare.value
            : 0;
          const totalFare = fare1 + fare2 + fare3;

          // Add total fare to the existing route object
          route.totalFare = totalFare;

          const time1 = route.originToMetroLeg.legs[0].duration
            ? route.originToMetroLeg.legs[0].duration.value
            : 0;
          const time2 = route.metroLeg.duration
            ? route.metroLeg.duration.value
            : 0;
          const time3 = route.metroToDestinationLeg.legs[0].duration
            ? route.metroToDestinationLeg.legs[0].duration.value
            : 0;

          const totalTime = time1 + time2 + time3;
          const totalTimeInWords = convertSeconds(totalTime);

          // Add total fare to the existing route object
          route.totalTime = [totalTime, totalTimeInWords];

          const dist1 = route.originToMetroLeg.legs[0].distance
            ? route.originToMetroLeg.legs[0].distance.value
            : 0;
          // const dist2 = route.metroLeg.duration ? route.metroLeg.duration.value : 0;
          const dist3 = route.metroToDestinationLeg.legs[0].distance
            ? route.metroToDestinationLeg.legs[0].distance.value
            : 0;
          const totalDistance = dist1 + dist3;
          const totalDistanceInKm = totalDistance / 1000;

          // Add total fare to the existing route object
          route.totalDistance = [totalDistance, totalDistanceInKm];

          const finalPolylineCoords = [];
          const coords = polyline
            .decode(route.originToMetroLeg.overview_polyline?.points)
            .forEach((coord) => {
              finalPolylineCoords.push([coord[0], coord[1]]);
            });

          const metroCoordsStart = [
            route.metroLeg.startStation.latitude,
            route.metroLeg.startStation.longitude,
          ];
          const metroCoordsEnd = [
            route.metroLeg.endStation.latitude,
            route.metroLeg.endStation.longitude,
          ];
          finalPolylineCoords.push(metroCoordsStart);
          finalPolylineCoords.push(metroCoordsEnd);
          const coords1 = polyline
            .decode(route.metroToDestinationLeg.overview_polyline?.points)
            .forEach((coord) => {
              finalPolylineCoords.push([coord[0], coord[1]]);
            });
          const finalEncodedPoints = polyline.encode(finalPolylineCoords);
          route.finalpolyline = finalEncodedPoints;
        });

        return busAndMetroRoute;
      }
      const finalBusandMetroRoutes =
        calculateTotalFareDistanceTimeandCoordinates(busAndMetroRoute);
      console.log(finalBusandMetroRoutes);

      const formattedMetroRoutes = finalBusandMetroRoutes.map((route) => {
        console.log(route.finalpolyline);
        return {
          fare: {
            currency: "INR",
            text: `₹${route.totalFare}.00`,
            value: route.totalFare,
          },
          legs: [
            {
              distance: {
                text: `${route.totalDistance[1]}km`,
                value: route.totalDistance[0],
              },
              duration: {
                text: route.totalTime[1],
                value: route.totalTime[0],
              },
              end_address: destination,
              end_location: {
                lat: destinationCoordinates.lat,
                lng: destinationCoordinates.lng,
              },
              start_address: origin,
              start_location: {
                lat: originCoordinates.lat,
                lng: originCoordinates.lng,
              },
              steps: [
                ...route.originToMetroLeg.legs[0].steps,
                route.metroLeg,
                ...route.metroToDestinationLeg.legs[0].steps,
              ],
            },
          ],
          overview_polyline: {
            points: route.finalpolyline,
          },
        };
      });

      console.log(formattedMetroRoutes);

      setRoutes((old) => [...old, ...formattedMetroRoutes]);
    } catch (error) {
      console.error("Error fetching coordinates: ", error);
    }
  };

  const sortRoutes = (criteria) => {
    let sortedRoutes = [...routes.routeDetails];

    switch (criteria) {
      case "time":
        sortedRoutes.sort((a, b) => {
          return a?.legs[0].duration?.value - b?.legs[0].duration?.value;
        });
        break;
      case "distance":
        sortedRoutes.sort((a, b) => {
          return a?.legs[0].distance?.value - b?.legs[0].distance?.value;
        });
        break;
      case "fare":
        sortedRoutes.sort((a, b) => {
          return a?.fare?.value - b?.fare?.value;
        });
        break;
      default:
        return;
    }

    setRoutes((prevState) => ({
      ...prevState,
      routeDetails: sortedRoutes,
    }));
    setSelectedSortCriteria(criteria);
  };

  useEffect(() => {
    if (location) {
      console.log("Animating Map: ", location.coords);
      mapRef.current?.animateToRegion({
        latitude: location.coords.latitude,
        longitude: location.coords.longitude,
        latitudeDelta: 0.009,
        longitudeDelta: 0.009,
      });
    }
  }, [location]);

  useEffect(() => {
    console.log("Metro Stations : ", metroStations);

    const initialize = async () => {
      await fetchUserLocation();
    };

    initialize();
  }, []);

  useEffect(() => {
    console.log(destination);
    if (destination) {
      setShowType("routes");
      console.log("Fetching Routes");
      getroutes();
    }
  }, [destination]);

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
                },
                textInput: styles.locationInput,
                listView: { position: "absolute", top: 50, zIndex: 2 },
              }}
              onPress={(data, details = null) => {
                setOrigin(data.description);
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
            showsUserLocation
            showsMyLocationButton
          >
            {markers.map((marker, index) => (
              <Marker key={`m${index}`} coordinate={marker} />
            ))}
            {routes &&
              routes?.map((route) => {
                if (route?.overview_polyline?.points) {
                  const coords = polyline
                    .decode(route.overview_polyline?.points)
                    .map((coord) => {
                      return { latitude: coord[0], longitude: coord[1] };
                    });

                  // Example usage:
                  var baseColor = "2675EC";
                  var randomShade = generateRandomShade(baseColor);

                  return (
                    <Polyline
                      coordinates={coords}
                      strokeColor={randomShade} // fallback for when `strokeColors` is not supported by the map-provider
                      strokeWidth={7}
                    />
                  );
                } else {
                  console.log("Invalid Route : ", route);
                }
              })}
          </MapView>
          {showType == "explore" && (
            <ExploreModal navigation={navigation} location={location} />
          )}
          {showType == "routes" && (
            <RouteListModal navigation={navigation} routes={routes} />
          )}
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
    position: "absolute",
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

export default InputScreen;
