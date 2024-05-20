import React, {
  useCallback,
  useEffect,
  useMemo,
  useRef,
  useState,
} from "react";
import {
  View,
  Text,
  StyleSheet,
  Button,
  Dimensions,
  Image,
} from "react-native";
import {
  GestureHandlerRootView,
  ScrollView,
} from "react-native-gesture-handler";
import { useTranslation } from "react-i18next";

import PlaceCard from "./PlaceCard.js";
import BottomModalContainer from "./BottomModalContainer.js";
import FloatingButton from "./FloatingButton.js";

const windowHeight = Dimensions.get("window").height;
const windowWidth = Dimensions.get("window").width;

import GlobalApi from "../services/GlobalApi.js";

const ExploreModal = ({ navigation, location }) => {
  const [poiList, setPoiList] = useState([]);
  const [foodList, setFoodList] = useState([]);
  const [cafeList, setCafeList] = useState([]);

  useEffect(() => {
    const fetchPlaces = async () => {
      const poiResponse = await GlobalApi.nearByPlace(
        location.coords.latitude,
        location.coords.longitude,
        "point_of_interest"
      );

      console.log("Places : ", poiResponse.data.results);

      setPoiList(poiResponse.data.results);

      console.log(poiList);

      const foodResponse = await GlobalApi.nearByPlace(
        location.coords.latitude,
        location.coords.longitude,
        "restaurant"
      );

      console.log("Food : ", foodResponse.data.results);

      setFoodList(foodResponse.data.results);

      const cafeResponse = await GlobalApi.nearByPlace(
        location.coords.latitude,
        location.coords.longitude,
        "cafe"
      );

      console.log("Cafe : ", cafeResponse.data.results);

      setCafeList(cafeResponse.data.results);
    };

    fetchPlaces();
  }, []);

  return (
    <View style={styles.container}>
      <View style={styles.BottomSheetContainer}>
        <BottomModalContainer>
          <View style={{ height: "90%", marginTop: 20 }}>
            <View style={styles.welcomeTextContainer}>
              <Text style={styles.welcomeText}>Hi Gayathri</Text>
              <Text style={styles.welcomeText}>
                Where would you like to go?
              </Text>
            </View>
            <View style={styles.filterTextContainer}>
              <Text style={styles.filterText}>Points of Interest</Text>
            </View>
            <ScrollView
              horizontal={true}
              showsHorizontalScrollIndicator={false}
              scrollEventThrottle={16}
            >
              {poiList.map((place) => (
                <PlaceCard
                  key={place.id}
                  name={place.name}
                  imageUri={
                    place.photos && place.photos.length > 0
                      ? {
                          uri:
                            "https://maps.googleapis.com/maps/api/place/photo" +
                            "?maxwidth=400" +
                            "&photo_reference=" +
                            place.photos[0].photo_reference +
                            "&key=",
                        }
                      : null
                  }
                />
              ))}
            </ScrollView>

            <View style={styles.filterTextContainer}>
              <Text style={styles.filterText}>Food</Text>
            </View>
            <ScrollView
              horizontal={true}
              showsHorizontalScrollIndicator={false}
              scrollEventThrottle={16}
            >
              {foodList.map((place) => (
                <PlaceCard
                  key={place.id}
                  name={place.name}
                  imageUri={
                    place.photos && place.photos.length > 0
                      ? {
                          uri:
                            "https://maps.googleapis.com/maps/api/place/photo" +
                            "?maxwidth=400" +
                            "&photo_reference=" +
                            place.photos[0].photo_reference +
                            "&key=",
                        }
                      : null
                  }
                />
              ))}
            </ScrollView>

            <View style={styles.filterTextContainer}>
              <Text style={styles.filterText}>Cafe</Text>
            </View>
            <ScrollView
              horizontal={true}
              showsHorizontalScrollIndicator={false}
              scrollEventThrottle={16}
            >
              {cafeList.map((place) => (
                <PlaceCard
                  key={place.id}
                  name={place.name}
                  imageUri={
                    place.photos && place.photos.length > 0
                      ? {
                          uri:
                            "https://maps.googleapis.com/maps/api/place/photo" +
                            "?maxwidth=400" +
                            "&photo_reference=" +
                            place.photos[0].photo_reference +
                            "&key=",
                        }
                      : null
                  }
                />
              ))}
            </ScrollView>
          </View>
        </BottomModalContainer>
      </View>
    </View>
  );
};

export default ExploreModal;

const styles = StyleSheet.create({
  container: {
    alignItems: "center",
    justifyContent: "center",
  },
  modalButtonContainer: {
    top: windowHeight * 0.8, // Adjust the margin bottom to position the button lower
    backgroundColor: "white",
    borderRadius: 30,
    borderColor: "black",
    borderWidth: 1,
    paddingHorizontal: 20,
  },
  exploreContainer: {
    flex: 1,
    paddingTop: 20,
    paddingHorizontal: 35,
  },
  textLabel: {
    marginLeft: 20,
  },
  welcomeTextContainer: {
    marginLeft: "10%",
    marginTop: "2%",
  },
  welcomeText: {
    fontWeight: "600",
    fontSize: 20,
  },
  filterText: {
    fontSize: 15,
    fontWeight: "600",
    marginLeft: "10%",
    marginTop: "3%",
  },
  BottomSheetContainer: {},
});
