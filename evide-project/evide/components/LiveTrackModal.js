import React, { useCallback, useMemo, useRef } from "react";
import {
  View,
  Text,
  StyleSheet,
  Button,
  Dimensions,
  Image,
  Linking,
  TouchableOpacity,
  useWindowDimensions,
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
import * as Progress from "react-native-progress";
const windowHeight = Dimensions.get("window").height;
const windowWidth = Dimensions.get("window").width;
import HTML, { RenderHTML } from "react-native-render-html";
import StepCard from "./StepCard";
import TranslationComponent from "../services/nlpTransalationApi";
const LiveTrackModal = ({
  navigation,
  route,
  currentStep,
  showNavigate,
  checkStatus,
  navigate,
  updateStep,
}) => {
  const { width } = useWindowDimensions();

  const bottomSheetModalRef = useRef(null);
  const snapPoints = ["25%", "50%", "78%"];
  const step = route?.legs[0].steps[currentStep];

  bottomSheetModalRef.current?.present();
  function handlePresentModal() {
    bottomSheetModalRef.current?.present();
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
            style={{
              height: "100%",
              paddingTop: "0",
              position: "relative",
              backgroundColor: "#2675EC",
            }}
          >
            <View style={styles.locationContainer}>
              <View style={styles.sourceContainer}>
                <Text style={styles.locationText}>
                  {route?.legs[0].start_address.split(",")[0]}
                </Text>
              </View>
              <View style={styles.progressContainer}>
                <Progress.Bar
                  progress={currentStep / route.legs[0].steps.length}
                  width={null}
                  color="white"
                />
              </View>
              <View style={styles.destinationContainer}>
                <Text style={styles.locationText}>
                  {route?.legs[0].end_address.split(",")[0]}
                </Text>
              </View>
            </View>
            <ScrollView
              showsVerticalScrollIndicator={false}
              scrollEventThrottle={16}
              style={{}}
              contentContainerStyle={{ justifyContent: "flex-start" }}
            >
              {step && (
                <ScrollView contentContainerStyle={{}}>
                  {
                    <>
                      <Text style={styles.currentText}>Current Step </Text>
                      <StepCard step={step} />
                      {route?.legs[0].steps[currentStep + 1] && (
                        <>
                          <Text style={styles.nextText}>Next Step </Text>
                          <StepCard
                            step={route?.legs[0].steps[currentStep + 1]}
                          />
                        </>
                      )}
                      {/* <Text contentWidth={100}>
                        {step.html_instructions && `${step.html_instructions}`}
                      </Text>
                      {step.steps?.map((s, i) => (
                        <RenderHTML
                          key={`ss${i}`}
                          contentWidth={width}
                          source={{ html: s.html_instructions }}
                        />
                      ))}
                      {step.travel_mode == "TRANSIT" && (
                        <>
                          <Text>
                            {`${step.transit_details.line.vehicle.type}`}
                            {step.transit_details && (
                              <Image
                                style={{ width: 20, height: 20 }}
                                source={{
                                  uri: `https://${step.transit_details.line.vehicle.icon.substring(
                                    2
                                  )}`,
                                }}
                              />
                            )}
                            (Stops : {`${step.transit_details.num_stops}`})
                          </Text>
                          <Text>{`Name : ${step.transit_details.line.name}`}</Text>

                          <Text>
                            {`Departure Stop : ${step.transit_details.departure_stop.name} | ${step.transit_details.departure_time.text}`}
                          </Text>
                          <Text>
                            {`Arrival Stop : ${step.transit_details.arrival_stop.name} | ${step.transit_details.arrival_time.text}`}
                          </Text>
                        </>
                      )} */}
                    </>
                  }
                </ScrollView>
              )}
            </ScrollView>

            <TouchableOpacity style={styles.selectContainer}>
              <View style={styles.selectButton}>
                <Text style={styles.selectText}>End Trip</Text>
              </View>
            </TouchableOpacity>

            {showNavigate && (
              <TouchableOpacity
                style={styles.selectContainer}
                onPress={navigate}
              >
                <View style={styles.selectButton}>
                  <Text style={styles.selectText}>Navigate</Text>
                </View>
              </TouchableOpacity>
            )}
            {checkStatus && (
              <>
                <Text style={{ textAlign: "center" }}>Have you reached?</Text>
                <TouchableOpacity
                  style={styles.selectContainer}
                  onPress={updateStep}
                >
                  <View style={styles.selectButton}>
                    <Text style={styles.selectText}>Yes</Text>
                  </View>
                </TouchableOpacity>
              </>
            )}
          </View>
        </BottomSheetModal>
      </View>
    </View>
  );
};

export default LiveTrackModal;
const styles = StyleSheet.create({
  container: {
    alignItems: "center",
    justifyContent: "center",
  },
  currentText: {
    color: "white",
    fontWeight: "500",
    fontSize: 18,
    paddingLeft: "11%",
  },
  nextText: {
    color: "white",
    fontWeight: "500",
    fontSize: 18,
    paddingLeft: "11%",
    paddingTop: "5%",
  },
  modalButtonContainer: {
    top: windowHeight * 0.9, // Adjust the margin bottom to position the button lower
    backgroundColor: "#2675EC",
    borderRadius: 30,
    paddingHorizontal: 20,
    width: "100vw",
    elevation: 2,
    shadowColor: "black", // Shadow color
    shadowOffset: { width: 2, height: 2 }, // Shadow offset
    shadowOpacity: 0.8, // Shadow opacity
    shadowRadius: 3.84, // Shadow radius
    position: "absolute",
    alignSelf: "center",
  },
  modalButton: {
    border: "none",
    padding: 12,
    width: 300,
  },
  modalText: {
    alignSelf: "center",
    fontWeight: "700",
    color: "white",
    letterSpacing: 2,
  },
  BottomSheetContainer: {
    backgroundColor: "#2675EC",
    color: "#2675EC",
  },
  selectContainer: {
    marginBottom: 20, // Adjust the button position as needed
    alignItems: "center",
    alignSelf: "center",
    // Increase elevation for shadow effect
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
  indicatorContainer: {
    height: windowHeight,
    margin: 0,
    paddingLeft: 27,
    paddingTop: 0,
  },
  labelContainer: {
    paddingLeft: 10,
    height: windowHeight / 6,
    marginTop: 110,
    width: "100%",
  },
  labelText: {
    color: "white",
    fontSize: 15,
    fontWeight: "600",
    marginBottom: 10,
  },
  content: {
    color: "white",
    fontSize: 14,
    paddingBottom: 5,
  },
  locationContainer: {
    height: 100,
    paddingTop: 30,
    flexDirection: "row",
    alignContent: "center",
    marginHorizontal: 15,
  },
  location: {
    fontSize: 20,
    textAlign: "center",
  },
  sourceContainer: {
    flex: 0.3,
    justifyContent: "center",
  },
  progressContainer: {
    justifyContent: "center",
    flex: 0.4,
  },
  destinationContainer: {
    flex: 0.3,
    justifyContent: "center",
  },
  locationText: {
    color: "white",
    fontSize: 18,
    textAlign: "center",
    fontWeight: "500",
  },
});
