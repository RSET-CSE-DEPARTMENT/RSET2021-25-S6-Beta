import React, { useState, useEffect } from 'react';
import { View, Text, TouchableOpacity, StyleSheet, TextInput, Alert } from 'react-native';
import DateTimePickerModal from '@react-native-community/datetimepicker';
import AsyncStorage from '@react-native-async-storage/async-storage';
import * as Notifications from 'expo-notifications'; // Corrected import statement

const Alarm = ({ navigation }) => {
  const [selectedTime, setSelectedTime] = useState(null);
  const [repeatDays, setRepeatDays] = useState({
    Sunday: false,
    Monday: false,
    Tuesday: false,
    Wednesday: false,
    Thursday: false,
    Friday: false,
    Saturday: false,
  });
  const [showTimePicker, setShowTimePicker] = useState(false);
  const [label, setLabel] = useState('');

  useEffect(() => {
    // Request notification permissions when the component mounts
    Notifications.requestPermissionsAsync().then(({ status }) => {
      if (status !== 'granted') {
        console.warn('Notification permissions not granted.');
      }
    });

    // Set notification handler
    Notifications.setNotificationHandler({
      handleNotification: async () => ({
        shouldShowAlert: true,
        shouldPlaySound: true,
        shouldSetBadge: false,
      }),
    });

    // Listener for notification response
    const responseListener = Notifications.addNotificationResponseReceivedListener(response => {
      console.log(`Notification opened: ${response.notification.request.content.body}`);
    });

    return () => {
      responseListener.remove();
    };
  }, []);

  const handleTimeChange = (event, selectedDate) => {
    const currentDate = selectedDate || selectedTime;
    setShowTimePicker(false);
    if (currentDate) {
      setSelectedTime(currentDate);
    }
  };

  const scheduleNotification = async (alarm) => {
    const { time, repeatDays } = alarm;
    const notificationTitle = 'Alarm Notification';
    const notificationBody = `Time to ${alarm.label || 'wake up!'}`; // Corrected string interpolation
  
    // Schedule notifications based on repeat days and time
    repeatDays.forEach(day => {
      const notificationTime = new Date();
      const dayIndex = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'].indexOf(day);
      notificationTime.setDate(notificationTime.getDate() + ((dayIndex + 7 - notificationTime.getDay()) % 7));
      notificationTime.setHours(parseInt(time.split(':')[0], 10));
      notificationTime.setMinutes(parseInt(time.split(':')[1], 10));
      Notifications.scheduleNotificationAsync({
        content: {
          title: notificationTitle,
          body: notificationBody,
          sound: 'default',
          alert: true, // Add this line to make the notification pop up as an alert
        },
        trigger: {
          date: notificationTime,
          repeats: true,
        },
      });
    });
  };

  const handleSave = async () => {
    // Handle saving the alarm data to AsyncStorage
    const newAlarm = {
      id: Date.now(), // Generate a unique ID for the alarm
      time: selectedTime ? selectedTime.toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' }) : '',
      repeatDays: Object.keys(repeatDays).filter(day => repeatDays[day]),
      label,
    };
    try {
      // Save new alarm to AsyncStorage or your data storage
      await AsyncStorage.setItem(`alarm_${newAlarm.id}`, JSON.stringify(newAlarm));
      console.log('New Alarm:', newAlarm);

      // Schedule notification for the alarm time
      scheduleNotification(newAlarm);

      // Navigate to the Alarm List screen
      navigation.navigate('Alarmlist', { refresh: true }); // Corrected navigation name
    } catch (error) {
      console.error('Error saving alarm:', error);
      Alert.alert('Error', 'Failed to save alarm. Please try again.');
    }
  };

  return (
    <View style={styles.container}>
      <Text style={styles.title}>Create Alarm</Text>
      <TouchableOpacity style={styles.timePickerButton} onPress={() => setShowTimePicker(true)}>
        <Text style={styles.timePickerButtonText}>{selectedTime ? selectedTime.toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' }) : 'Select Time'}</Text>
      </TouchableOpacity>
      {showTimePicker && (
        <DateTimePickerModal
          value={selectedTime || new Date()}
          mode="time"
          is24Hour={false}
          display="spinner"
          onChange={handleTimeChange}
        />
      )}
      <View style={styles.repeatDaysContainer}>
        <Text style={styles.repeatDaysLabel}>Repeat Days:</Text>
        {Object.keys(repeatDays).map(day => (
          <TouchableOpacity
            key={day}
            style={[styles.repeatDayButton, repeatDays[day] && styles.repeatDayButtonSelected]}
            onPress={() => setRepeatDays(prevState => ({ ...prevState, [day]: !prevState[day] }))}
          >
            <Text style={styles.repeatDayText}>{day.substring(0, 3)}</Text>
          </TouchableOpacity>
        ))}
      </View>
      <TextInput
        style={styles.input}
        placeholder="Label"
        value={label}
        onChangeText={setLabel}
      />
      <TouchableOpacity style={styles.button} onPress={handleSave}>
        <Text style={styles.buttonText}>Save Alarm</Text>
      </TouchableOpacity>
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#fff',
  },
  title: {
    fontSize: 24,
    marginBottom: 20,
  },
  timePickerButton: {
    backgroundColor: '#007bff',
    paddingVertical: 10,
    paddingHorizontal: 20,
    borderRadius: 5,
    marginBottom: 20,
  },
  timePickerButtonText: {
    color: '#fff',
    fontSize: 18,
  },
  repeatDaysContainer: {
    flexDirection: 'row',
    alignItems: 'center',
    marginBottom: 20,
  },
  repeatDaysLabel: {
    marginRight: 10,
  },
  repeatDayButton: {
    backgroundColor: '#007bff',
    padding: 10,
    borderRadius: 5,
    marginRight: 10,
  },
  repeatDayButtonSelected: {
    backgroundColor: '#0056b3',
  },
  repeatDayText: {
    color: '#fff',
    fontSize: 16,
  },
  input: {
    width: '80%',
    height: 40,
    borderColor: '#ccc',
    borderWidth: 1,
    borderRadius: 5,
    marginBottom: 20,
    paddingHorizontal: 10,
  },
  button: {
    backgroundColor: '#007bff',
    paddingVertical: 10,
    paddingHorizontal: 20,
    borderRadius: 5,
  },
  buttonText: {
    color: '#fff',
    fontSize: 18,
  },
});

export default Alarm;
