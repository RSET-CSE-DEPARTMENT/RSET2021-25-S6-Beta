import React from 'react';
import { StyleSheet, Text, View, Image, TouchableOpacity } from 'react-native';
import { useNavigation } from '@react-navigation/native'; // Import useNavigation

export default function GetStarted() {
  const navigation = useNavigation(); // Initialize navigation

  const handleGetStarted = () => {
    navigation.navigate('Home'); // Navigate to ProfileScreen when button is pressed
  };

  return (
    <View style={styles.container}>
      <Image 
        source={require('../assets/logo.png')} 
        style={styles.image}
      />
      <Text style={styles.title}>Your Smartlife Planner</Text>
      <Text style={styles.subtitle}>Let's go!</Text>
      <TouchableOpacity style={styles.button} onPress={handleGetStarted}>
        <Text style={styles.buttonText}>Get started →</Text>
      </TouchableOpacity>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: 'rgba(137, 207, 240, 0.7)', // More transparent blue color
    alignItems: 'center',
    justifyContent: 'center',
    paddingLeft: 20, // Move content to the left
    paddingBottom: 50, // Move content down
  },
  image: {
    width: 439,
    height: 450,
    marginTop:67,
    marginBottom: 1,
    marginRight:30,
  },
  title: {
    fontSize: 25,
    fontWeight: 'bold',
    marginTop:3,
    marginBottom: 18,
    textAlign: 'left', // Align text to the left
    marginLeft: 20, // Add left margin for further adjustment
  },
  subtitle: {
    fontSize: 15,
    color: '#333',
    marginBottom: 15,
    textAlign: 'left', // Align text to the left
    marginLeft: 2, // Add left margin for further adjustment
  },
  button: {
    backgroundColor: '#000', // Black color for the button
    padding: 12,
    borderRadius: 700,
  },
  buttonText: {
    color: '#fff',
    fontSize: 23,
  },
});
