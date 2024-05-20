import React from "react";
import { View, Text, StyleSheet, TouchableOpacity, Image } from "react-native";
import { NavigationContainer } from "@react-navigation/native";
import { createNativeStackNavigator } from "@react-navigation/native-stack";
import { useNavigation } from "@react-navigation/native";

const RouteCard = ({ startButtonColor, startButtonTextColor, route }) => {
  const navigation = useNavigation();

  return (
    <View style={styles.container}>
      <View style={{ flex: 0.65 }}>
        <View
          style={{
            flexDirection: "row",
            justifyContent: "space-between",
            marginHorizontal: "6%",
            marginTop: "5%",
            marginBottom: "5%",
          }}
        >
          {route.legs[0].steps.map((step) => {
            if (step.travel_mode == "WALKING")
              return (
                <Image
                  source={require("../assets/walk.png")}
                  style={styles.icon}
                />
              );
            else if (step.travel_mode == "TRANSIT")
              return (
                <Image
                  source={require("../assets/bus.png")}
                  style={styles.icon}
                />
              );
          })}
        </View>
        <View>
          <Text style={styles.routeText}>
            {route.legs[0].departure_time?.text} -{" "}
            {route.legs[0].arrival_time?.text} | Cost: {route.fare?.text}
          </Text>
          <Text style={[styles.routeText, { fontWeight: "bold" }]}>
            Distance : {route.legs[0].distance?.text}
          </Text>
        </View>
      </View>
      <View
        style={{
          flex: 0.35,
          justifyContent: "center",
          alignItems: "center",
          borderLeftColor: "#dddddd",
          borderLeftWidth: 1.2,
        }}
      >
        <Text style={styles.routeTime}>{route.legs[0].duration?.text.replaceAll("hour","h").replaceAll("mins","min")}</Text>
        <View style={styles.startButtonContainer}>
          <TouchableOpacity
            onPress={() => {
              navigation.navigate("View Route", { routeValue: route });
            }}
            style={[styles.startButton, { backgroundColor: startButtonColor }]}
          >
            <Text
              style={[styles.startButtonText, { color: startButtonTextColor }]}
            >
              View
            </Text>
          </TouchableOpacity>
        </View>
      </View>
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    height: 110,
    width: "90%",
    marginLeft: "5%",
    marginTop: 15,
    borderWidth: 1.2,
    borderColor: "black",
    borderRadius: 25,
    backgroundColor: "white",
    flexDirection: "row",
  },
  startButtonContainer: {
    marginTop: 10
  },
  startButton: {
    paddingVertical: "5%",
    paddingHorizontal: "17%",
    borderRadius: 30,
    alignItems: "center",
    justifyContent: "center",
  },
  startButtonText: {},
  routeIcons: {
    flexDirection: "row",
    paddingLeft: "0%",
    paddingTop: "12%",
    marginBottom: "0%",
  },
  routeTime: {
    fontSize: 22,
  },
  routeText: {
    fontSize: 10,
    marginTop: "2%",
    marginLeft: "5%",
  },
  icon: {
    height: 22,
    width: 22,
    resizeMode: "contain",
  },
});

export default RouteCard;
