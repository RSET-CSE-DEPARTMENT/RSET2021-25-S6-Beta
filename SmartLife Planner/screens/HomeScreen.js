import React, { createContext, useState } from 'react';
import { View, TextInput, Button, Text, StyleSheet, Image, Alert } from 'react-native';
import AsyncStorage from '@react-native-async-storage/async-storage';

export const UsernameContext = createContext()

const HomeScreen = ({ navigation }) => {
  const [username, setUsername] = useState('');
  const [password, setPassword] = useState('');

  const handleLogin = async () => {
    try {
      // Retrieve user data from AsyncStorage
      const userData = await AsyncStorage.getItem('userData');
      if (userData) {
        const { username: storedUsername, password: storedPassword } = JSON.parse(userData);
        // Check if entered username and password match with stored data
        if (username === storedUsername && password === storedPassword) {
          // Navigate to Profile screen if credentials match
          navigation.navigate('Profile');
        } else {
          // Display error message if credentials don't match
          Alert.alert('Error', 'Wrong username or password');
        }
      } else {
        // Display error message if no user data found
        Alert.alert('Error', 'User not found');
      }
    } catch (error) {
      console.error('Error fetching user data:', error);
    }
  };

  const handleSignUp = () => {
    navigation.navigate('SignUp');
  };

  return (
    <View style={styles.container}>
      <Image
        source={require('./login.gif')}
        style={styles.gif}
      />
      <TextInput
        style={styles.input}
        placeholder="Username"
        value={username}
        onChangeText={setUsername}
      />
      <TextInput
        style={styles.input}
        placeholder="Password"
        secureTextEntry
        value={password}
        onChangeText={setPassword}
      />
      <Button
        title="Login"
        onPress={handleLogin}
        style={[styles.button, { width: '100%' }]}
        color="black"
      />
      <View style={styles.signupContainer}>
        <Text style={styles.signupText}>Don't have an account? Create one!</Text>
        <Button
          title="Sign Up"
          onPress={handleSignUp}
          style={[styles.button, styles.signupButton]} // Adjusted styles for the button
          color="black"
        />
      </View>
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: 'rgba(173, 216, 230, 0.5)',
  },
  input: {
    width: '80%',
    marginBottom: 15,
    padding: 10,
    borderWidth: 1,
    borderColor: 'skyblue',
    borderRadius: 5,
    backgroundColor: 'skyblue',
  },
  signupContainer: {
    marginTop: 30,
    alignItems: 'center',
  },
  signupText: {
    marginBottom: 15,
  },
  signupButton: {
    width: '100%',
    
  },
  gif: {
    width: 250,
    height: 200,
    marginBottom: 50,
  },
});

export default HomeScreen;
