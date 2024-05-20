import React, { useCallback, useMemo, useRef } from "react";
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
import StepIndicator from "react-native-step-indicator";
import { useTranslation } from "react-i18next";
import axios from "axios";
import pushNotification from "../services/nativeNotifyApi";
const windowHeight = Dimensions.get("window").height;
const windowWidth = Dimensions.get("window").width;
import FontAwesome from "@expo/vector-icons/FontAwesome";
import HTML from "react-native-render-html";
import LocationCard from "./LocationCard";

const RouteModal = ({ navigation, route }) => {
  const bottomSheetModalRef = useRef(null);
  const snapPoints = ["25%", "50%", "78%"];
  bottomSheetModalRef.current?.present();
  function handlePresentModal() {
    bottomSheetModalRef.current?.present();
    // pushNotification('Kuruvilla','You Pressed a Button','This is a Notification');
  }
  // const { t } = useTranslation();
  const handleContentPanning = useCallback(
    (event, gestureState, fromIndex, toIndex) => {
      // Prevent the modal from going below 25%
      if (toIndex < 0) {
        return false;
      }
      return true;
    },
    []
  );

  return (
    <View style={styles.container}>
      <View style={styles.modalButtonContainer}>
        <TouchableOpacity
          style={styles.modalButton}
          onPress={handlePresentModal}
        >
          <Text style={styles.modalText}>Explore</Text>
        </TouchableOpacity>
      </View>
      <View style={styles.BottomSheetContainer}>
        <BottomSheetModal
          ref={bottomSheetModalRef}
          index={2}
          snapPoints={snapPoints}
          enableContentPanning={handleContentPanning} // Apply the custom content panning handler
          >
          <View
            style={{ height: "100%", marginTop: "1%", position: "relative",paddingBottom:'20%' }}
            >
            <View style={styles.tripDetails}>
              <Text style= {styles.stopsText}>{route?.legs[0].distance?.text}</Text>
              <Text style={styles.st}>|</Text>
              <Text style= {styles.stopsText}>{route?.legs[0].duration?.text}</Text>
              <Text style={styles.st}>|</Text>
              <Text style= {styles.stopsText}>{route?.fare?.text}</Text>
                  
                {/* <Text style={styles.stopsText}> 11Km</Text>
                <Text style={styles.st}>|</Text>
                <Text style={styles.stopsText}> 50Rs</Text> */}
              </View>
            
            {route && (
              <ScrollView
                showsVerticalScrollIndicator={false}
                scrollEventThrottle={16}
                style={{}}
                contentContainerStyle={{ justifyContent: "flex-start" }}
              >
                <View style={styles.line}></View>
                <ScrollView>
                  {route.legs[0].steps.map((step, index) => (
                    <LocationCard step={step} />
                    // <>
                    //   <Text key={`s${index}`}>
                    //     {index}.{" "}
                    //     {step.html_instructions && `${step.html_instructions}`}
                    //   </Text>
                    //   {step.travel_mode == "WALKING" &&
                    //     step.steps.map((s) => (
                    //       <View style={{ flexDirection: "column" }}>
                    //         <Text>-</Text>
                    //         <HTML source={{ html: s.html_instructions }} />
                    //       </View>
                    //     ))}
                    //   {step.travel_mode == "TRANSIT" && (
                    //     <>
                    //       <Text>
                    //         {`${step.transit_details.line.vehicle.type}`}{" "}
                    //         {step.transit_details && (
                    //           <Image
                    //             style={{ width: 20, height: 20 }}
                    //             source={{
                    //               uri: `https://${step.transit_details.line.vehicle.icon.substring(
                    //                 2
                    //               )}`,
                    //             }}
                    //           />
                    //         )}{" "}
                    //         (Stops : {`${step.transit_details.num_stops}`})
                    //       </Text>
                    //       <Text>{`Name : ${step.transit_details.line.name}`}</Text>

                    //       <Text>
                    //         {`Departure Stop : ${step.transit_details.departure_stop.name} | ${step.transit_details.departure_time.text}`}
                    //       </Text>
                    //       <Text>
                    //         {`Arrival Stop : ${step.transit_details.arrival_stop.name} | ${step.transit_details.arrival_time.text}`}
                    //       </Text>
                    //     </>
                    // )}
                    // </>
                  ))}
                </ScrollView>
              </ScrollView>
            )}
            <TouchableOpacity
              style={styles.selectContainer}
              onPress={() => {
                navigation.navigate("Track Route", { routeValue: route });
              }}
            >
              <View style={styles.selectButton}>
                <Text style={styles.selectText}>Start Journey</Text>
              </View>
            </TouchableOpacity>
          </View>
        </BottomSheetModal>
      </View>
    </View>
  );
};

export default RouteModal;
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
  selectContainer: {
    position: "absolute",
    bottom: windowHeight * 0.06, // Adjust the button position as needed
    alignItems: "center",
    alignSelf: "center",
    elevation: 2, // Increase elevation for shadow effect
    shadowColor: "black", // Shadow color
    shadowOffset: { width: 0, height: 2 }, // Shadow offset
    shadowOpacity: 0.7, // Shadow opacity
    shadowRadius: 3.84, // Shadow radius
  },
  selectButton: {
    backgroundColor: "#15C679",
    borderRadius: 20, // Adjust border radius as needed
    paddingHorizontal: "25%",
    paddingVertical: "5%",
  },
  selectText: {
    fontWeight: "600",
    color: "white",
  },
  line: {
    position: "absolute",
    height: "100%",
    width: 4,
    left: "11%",
    top: 98,
    borderRadius: 10,
    backgroundColor: "#F8BC62",
    zIndex: 1,
  },
  tripDetails:{
    backgroundColor:'#FAF9F6',
    height:80,
    borderRadius:10,
    flexDirection:'row',
    justifyContent:'space-between',
    paddingHorizontal:40,
    alignItems:'center',
  },
  stopsText:{
    fontSize:20,
    fontWeight:'600',
  }
});
