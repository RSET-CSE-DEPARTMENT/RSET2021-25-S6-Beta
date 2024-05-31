import React, { useEffect } from 'react';
import { View, Image, StyleSheet } from 'react-native';
import { useNavigation } from '@react-navigation/native';

const SplashScreen = () => {
  const navigation = useNavigation();

  // Navigate to GetStarted screen after a delay
  useEffect(() => {
    const timer = setTimeout(() => {
      navigation.navigate('GetStarted');
    }, 2000); // 2000 milliseconds delay

    return () => clearTimeout(timer);
  }, [navigation]);

  return (
    <View style={styles.container}>
      <Image 
        source={require('../assets/splash_logo.png')} 
        style={styles.image}
      />
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#fff',
    alignItems: 'center',
    justifyContent: 'center',
  },
  image: {
    marginBottom:100,
    marginLeft:50,
    width: 185,
    height: 100,
  },
});

export default SplashScreen;

