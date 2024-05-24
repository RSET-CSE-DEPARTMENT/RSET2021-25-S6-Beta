import React, { useState } from 'react';
import { View, TextInput, Button, Text, StyleSheet, Image, Alert } from 'react-native';
import AsyncStorage from '@react-native-async-storage/async-storage';

const SignUpScreen = ({ navigation }) => {
  const [username, setUsername] = useState('');
  const [password, setPassword] = useState('');
  const [email, setEmail] = useState('');

  const handleSignUp = async () => {
    // Store user data in AsyncStorage
    try {
      await AsyncStorage.setItem('userData', JSON.stringify({ username, password, email }));
      navigation.navigate('Profile');
    } catch (error) {
      console.error('Error saving user data:', error);
    }
  };

  return (
    <View style={styles.container}>
      {/* GIF Image */}
      <Image
        source={require('./login.gif')} // Adjust the path of your GIF file
        style={styles.gif}
      />

      {/* Input fields */}
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
      <TextInput
        style={styles.input}
        placeholder="Email"
        value={email}
        onChangeText={setEmail}
      />
      
      {/* Sign Up button */}
      <View style={styles.signupContainer}>
        <Button
          title="Sign Up"
          onPress={handleSignUp}
          style={[styles.button, { width: '100%' }]}
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
    backgroundColor: 'rgba(173, 216, 230, 0.5)', // Light transparent blue
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
    marginTop: 20,
    alignItems: 'left',
  },
  gif: {
    width: 200, // Adjust the width of the GIF image
    height: 200, // Adjust the height of the GIF image
    marginBottom: 20, // Add margin to separate it from the input boxes
  },
});

export default SignUpScreen;
