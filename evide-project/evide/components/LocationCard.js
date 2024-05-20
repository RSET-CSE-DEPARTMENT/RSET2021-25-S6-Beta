import React from "react";
import { View, Text, StyleSheet, TouchableOpacity, Image } from "react-native";
import { NavigationContainer } from "@react-navigation/native";
import { createNativeStackNavigator } from "@react-navigation/native-stack";
import { useNavigation } from "@react-navigation/native";

const LocationCard = ({ step }) => {
  return (
    <View style={styles.container}>
      {/* <View style={styles.line}>

      </View> */}
      <View style={styles.circleContainer}>
        <View style={styles.circle}></View>
      </View>
      <View style={styles.infoContainer}>
        <View style={styles.headerContainer}>
          {step.travel_mode == "WALKING" ? (
            <Image source={require(`../assets/walk.png`)} style={styles.icon} />
          ) : (
            <Image source={require(`../assets/bus.png`)} style={styles.icon} />
          )}
          <Text style={styles.headerText}>
            {step.html_instructions && `${step.html_instructions}`}
          </Text>
        </View>
        <View style={styles.stopsContainer}>
          <Text style={styles.stopsText}> {step.duration.text}</Text>
          <Text style={styles.st}>|</Text>
          <Text style={styles.stopsText}> {step.distance.text}</Text>
          {step.fare && (
            <>
              <Text style={styles.st}>|</Text>
              <Text style={styles.stopsText}> {step.fare.text}</Text>
            </>
          )}
        </View>
        {step.travel_mode == "TRANSIT" && (
          <View style={styles.busContainer}>
            <View style={styles.busStop}>
              <Text style={styles.busStopText}>
                {step.transit_details.line.name}
              </Text>
            </View>
            {/* <View style={styles.busStopMal}>
              <Text style={styles.busStopText}>
                {step.transit_details.line.name}
              </Text>
            </View> */}
          </View>
        )}
      </View>
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    height: 150,
    // minHeight: 10,
    width: "90%",
    marginLeft: "5%",
    marginTop: 15,
    // marginHorizontal: 5,
    // borderWidth: 1.2,
    // borderColor: 'black',
    backgroundColor: "white",
    flexDirection: "row",
  },
  circleContainer: {
    height: "100%",
    flex: 0.15,
    alignItems: "center",
    justifyContent: "center",
  },
  infoContainer: {
    backgroundColor: "#FAF9F6",
    // height:200,
    width: "100%",
    flex: 0.85,
    borderRadius: 20,
  },
  headerContainer: {
    flexDirection: "row",
    paddingTop: 10,
    paddingBottom: 8,
    paddingLeft: 10,
  },
  headerText: {
    fontSize: 16,
    fontWeight: "600",
  },
  stopsContainer: {
    flexDirection: "row",
    justifyContent: "space-between",
    paddingHorizontal: 30,
  },
  circle: {
    height: 21,
    width: 21,
    backgroundColor: "#F8BC62",
    borderRadius: 10.5,
  },
  line: {
    position: "absolute",
    backgroundColor: "blue",
    height: 500,
  },
  icon: {
    height: 25,
    width: 25,
    resizeMode: "contain",
  },
  stopsText: {
    fontWeight: "350",
    fontSize: 16,
  },
  stopsBorder: {
    borderRightColor: "black",
    borderRightWidth: 2,
    paddingRight: 10,
  },
  busContainer: {
    marginTop: 1,
    backgroundColor: "#2675EC",
    height: 70,
    borderRadius: 20,
  },
  busStopMal: {
    flexDirection: "row",
    justifyContent: "space-between",
    paddingTop: 5,
    marginHorizontal: 25,
    paddingTop: 8,
  },
  busStop: {
    flexDirection: "row",
    justifyContent: "space-between",
    paddingTop: 5,
    borderBottomWidth: 1,
    borderBottomColor: "white",
    marginHorizontal: 25,
    paddingBottom: 5,
  },
  busStopText: {
    color: "white",
    fontSize: 12,
  },
  busName: {
    color: "white",
    alignSelf: "center",
    fontSize: 17,
    paddingTop: 10,
  },
  iconUnion: {
    height: 20,
    width: 20,
    resizeMode: "contain",
  },
});

export default LocationCard;
