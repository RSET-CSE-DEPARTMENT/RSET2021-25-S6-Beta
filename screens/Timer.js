import React, { useState, useEffect } from 'react';
import { View, Text, TouchableOpacity, StyleSheet, useWindowDimensions, Animated } from 'react-native';

const formatTime = (time) => {
  const hours = Math.floor(time / 3600);
  const minutes = Math.floor((time % 3600) / 60);
  const seconds = time % 60;

  return (
    hours.toString().padStart(2, '0') +
    ':' +
    minutes.toString().padStart(2, '0') +
    ':' +
    seconds.toString().padStart(2, '0')
  );
};

const Timer = ({ navigation }) => {
  const [time, setTime] = useState(0);
  const [isRunning, setIsRunning] = useState(false);
  const { width } = useWindowDimensions();
  const pulseValue = new Animated.Value(1);

  const startTimer = () => {
    setIsRunning(true);
  };

  const stopTimer = () => {
    setIsRunning(false);
  };

  const resetTimer = () => {
    setIsRunning(false);
    setTime(0);
    pulseValue.setValue(1);
  };

  useEffect(() => {
    if (isRunning) {
      const timer = setInterval(() => {
        setTime((prevTime) => prevTime + 1);
      }, 1000);

      return () => clearInterval(timer);
    }
  }, [isRunning]);

  useEffect(() => {
    if (isRunning) {
      Animated.loop(
        Animated.sequence([
          Animated.timing(pulseValue, {
            toValue: 1.2,
            duration: 100,
            useNativeDriver: true,
          }),
          Animated.timing(pulseValue, {
            toValue: 1,
            duration: 300,
            useNativeDriver: true,
          }),
          Animated.delay(1000),
        ]),
      ).start();
    }
  }, [isRunning, pulseValue]);

  return (
    <View style={styles.container}>
      <View style={styles.heartbeatContainer}>
        <Animated.View
          style={[
            styles.heartbeat,
            {
              transform: [{ scale: pulseValue }],
            },
          ]}
        />
      </View>
      <View style={styles.timerContainer}>
        <Text style={styles.timeText}>{formatTime(time)}</Text>
        <View style={styles.buttonRow}>
          <TouchableOpacity style={styles.buttonStart} onPress={startTimer}>
            <Text style={styles.buttonText}>Start</Text>
          </TouchableOpacity>
          <TouchableOpacity style={styles.buttonStop} onPress={stopTimer}>
            <Text style={styles.buttonText}>Stop</Text>
          </TouchableOpacity>
        </View>
        <View style={styles.buttonRow}>
          <TouchableOpacity style={styles.buttonReset} onPress={resetTimer}>
            <Text style={styles.buttonText}>Reset</Text>
          </TouchableOpacity>
        </View>
      </View>
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#000', // Change background color to black
  },
  heartbeatContainer: {
    alignItems: 'center',
    marginBottom: 30,
  },
  heartbeat: {
    width: 100,
    height: 100,
    backgroundColor: '#FF5733',
    borderRadius: 50,
  },
  timerContainer: {
    alignItems: 'center',
  },
  timeText: {
    fontSize: 48,
    marginVertical: 20,
    color: '#fff', // Change text color to white
  },
  buttonRow: {
    flexDirection: 'row',
    justifyContent: 'center',
    alignItems: 'center',
    marginVertical: 10,
  },
  buttonStart: {
    marginHorizontal: 10,
    padding: 10,
    backgroundColor: '#89cff0', // Baby blue color
    borderRadius: 5,
  },
  buttonStop: {
    marginHorizontal: 10,
    padding: 10,
    backgroundColor: '#89cff0', // Baby blue color
    borderRadius: 5,
  },
  buttonReset: {
    marginHorizontal: 10,
    padding: 10,
    backgroundColor: '#89cff0', // Baby blue color
    borderRadius: 5,
  },
  buttonText: {
    fontSize: 20,
    color: '#fff',
  },
});

export default Timer;
