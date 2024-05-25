import React, { useState, useEffect } from 'react';
import { View, Text, FlatList, TouchableOpacity, StyleSheet } from 'react-native';
import AsyncStorage from '@react-native-async-storage/async-storage';
import * as Notifications from 'expo-notifications';

const AlarmList = ({ navigation }) => {
  const [alarms, setAlarms] = useState([]);

  useEffect(() => {
    // Load alarms from AsyncStorage when component mounts or navigates back
    const unsubscribe = navigation.addListener('focus', () => {
      loadAlarms();
    });

    return unsubscribe;
  }, [navigation]);

  const loadAlarms = async () => {
    try {
      const keys = await AsyncStorage.getAllKeys();
      const alarmKeys = keys.filter(key => key.startsWith('alarm_'));
      const alarmItems = await AsyncStorage.multiGet(alarmKeys);
      const alarmsData = alarmItems.map(item => JSON.parse(item[1]));
      setAlarms(alarmsData);
      scheduleNotifications(alarmsData);
    } catch (error) {
      console.error('Error loading alarms:', error);
    }
  };

  const scheduleNotifications = (alarmsData) => {
    alarmsData.forEach(alarm => {
      const alarmTime = new Date(alarm.time);
      const currentTime = new Date();
      if (alarmTime > currentTime) {
        const notificationBody = `Time to ${alarm.label || 'wake up!'}`;
        Notifications.scheduleNotificationAsync({
          content: {
            title: 'Alarm Notification',
            body: notificationBody,
            sound: 'default',
          },
          trigger: {
            date: alarmTime,
          },
        });
      }
    });
  };

  const renderAlarmItem = ({ item }) => (
    <TouchableOpacity style={styles.alarmItem} onPress={() => handleEditAlarm(item.id)}>
      <Text>{item.time}</Text>
      <Text>{item.repeatDays.join(', ')}</Text>
      <TouchableOpacity onPress={() => handleDeleteAlarm(item.id)}>
        <Text style={styles.deleteButton}>Delete</Text>
      </TouchableOpacity>
    </TouchableOpacity>
  );

  const handleDeleteAlarm = async (alarmId) => {
    try {
      await AsyncStorage.removeItem(`alarm_${alarmId}`);
      await Notifications.cancelAllScheduledNotificationsAsync();
      loadAlarms();
    } catch (error) {
      console.error('Error deleting alarm:', error);
    }
  };

  const handleNavigateToCreateAlarm = () => {
    navigation.navigate('Alarm');
  };

  return (
    <View style={styles.container}>
      <FlatList
        data={alarms}
        renderItem={renderAlarmItem}
        keyExtractor={(item) => item.id.toString()}
        ListEmptyComponent={<Text>No alarms found</Text>}
      />
      <TouchableOpacity style={styles.addButton} onPress={handleNavigateToCreateAlarm}>
        <Text style={styles.addButtonText}>Add Alarm</Text>
      </TouchableOpacity>
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#fff',
  },
  alarmItem: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    padding: 16,
    borderBottomWidth: 1,
    borderBottomColor: '#ccc',
  },
  deleteButton: {
    color: 'red',
  },
  addButton: {
    backgroundColor: 'red',
    paddingVertical: 10,
    paddingHorizontal: 20,
    borderRadius: 50,
    marginBottom: 20,
    alignSelf: 'center',
  },
  addButtonText: {
    color: 'white',
    fontSize: 18,
    fontWeight: 'bold',
  },
});

export default AlarmList;
