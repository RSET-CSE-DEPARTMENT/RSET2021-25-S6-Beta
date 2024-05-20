import React, { useCallback, useEffect, useMemo, useRef } from "react";
import {
  View,
  Text,
  StyleSheet,
  Button,
  Dimensions,
  Image,
  TouchableOpacity,
} from "react-native";
import {
  GestureHandlerRootView,
  ScrollView,
} from "react-native-gesture-handler";
import {
  BottomSheetModal,
  BottomSheetModalProvider,
} from "@gorhom/bottom-sheet";
import RouteCard from "./RouteCard.js";
import { useTranslation } from "react-i18next";

const windowHeight = Dimensions.get("window").height;
const windowWidth = Dimensions.get("window").width;

import BottomModalContainer from "./BottomModalContainer.js";

const RouteListModal = ({ navigation, routes }) => {
  const bottomSheetModalRef = useRef(null);
  const snapPoints = ["25%", "50%", "78%"];
  bottomSheetModalRef.current?.present();

  return (
    <View style={styles.container}>
      {/* <View style={styles.modalButtonContainer}>
            <Button title='Explore' onPress={handlePresentModal} />
          </View> */}
      <View style={styles.BottomSheetContainer}>
        <BottomModalContainer>
          <View
            style={{ height: "100%", marginTop: "1%", position: "relative" }}
          >
            <ScrollView
              showsVerticalScrollIndicator={false}
              scrollEventThrottle={16}
              style={{}}
              contentContainerStyle={{ justifyContent: "flex-start" }}
            >
              <View style={styles.routeTextContainer}>
                <Text style={styles.routeText}>Recommended Route</Text>
              </View>
              {routes?.map((route) => (
                <RouteCard
                  route={route}
                  startButtonColor="#FFC75B"
                  startButtonTextColor="black"
                />
              ))}

              {/* <View style={styles.routeTextContainer}>
                <Text style={styles.routeText}>More Routes</Text>
              </View>
              <RouteCard
                startButtonColor="#0074CB"
                startButtonTextColor="white"
              />
              <RouteCard
                startButtonColor="#0074CB"
                startButtonTextColor="white"
              />
              <RouteCard
                startButtonColor="#0074CB"
                startButtonTextColor="white"
              />
              <RouteCard
                startButtonColor="#0074CB"
                startButtonTextColor="white"
              />
              <RouteCard
                startButtonColor="#0074CB"
                startButtonTextColor="white"
              />
              <RouteCard
                startButtonColor="#0074CB"
                startButtonTextColor="white"
              /> */}
            </ScrollView>
          </View>
        </BottomModalContainer>
      </View>
    </View>
  );
};

export default RouteListModal;
const styles = StyleSheet.create({
  container: {
    alignItems: "center",
    justifyContent: "center",
  },
  modalButtonContainer: {
    top: windowHeight * 0.6, // Adjust the margin bottom to position the button lower
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
  routeTextContainer: {
    marginLeft: "6%",
    marginTop: "2%",
  },
  routeText: {
    fontWeight: "600",
    fontSize: 13,
  },
  filterText: {
    fontSize: 15,
    fontWeight: "600",
    marginLeft: "10%",
    marginTop: "3%",
  },
  BottomSheetContainer: {},
});
