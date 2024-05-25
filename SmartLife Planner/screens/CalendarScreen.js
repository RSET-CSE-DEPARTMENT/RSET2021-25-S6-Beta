import React, { useState, useEffect } from 'react';
import { View, Text, TouchableOpacity, TextInput, ScrollView, Alert, Platform, StyleSheet } from 'react-native';
import { Calendar } from 'react-native-calendars';
import DateTimePicker from '@react-native-community/datetimepicker';
import AsyncStorage from '@react-native-async-storage/async-storage';

const CalendarScreen = () => {
  const [selectedDate, setSelectedDate] = useState('');
  const [events, setEvents] = useState({});
  const [eventText, setEventText] = useState('');
  const [eventTime, setEventTime] = useState('');
  const [editedEvent, setEditedEvent] = useState(null);
  const [showTimePicker, setShowTimePicker] = useState(false);
  const [chosenTime, setChosenTime] = useState(new Date());

  // Load events from AsyncStorage on component mount
  useEffect(() => {
    loadEvents();
  }, []);

  const loadEvents = async () => {
    try {
      const eventsData = await AsyncStorage.getItem('events');
      if (eventsData !== null) {
        setEvents(JSON.parse(eventsData));
      }
    } catch (error) {
      console.error('Error loading events from AsyncStorage:', error);
    }
  };

  const saveEvents = async (updatedEvents) => {
    try {
      await AsyncStorage.setItem('events', JSON.stringify(updatedEvents));
    } catch (error) {
      console.error('Error saving events to AsyncStorage:', error);
    }
  };

  const handleDateSelect = (date) => {
    setSelectedDate(date.dateString);
    setEventText('');
    setEventTime('');
    setShowTimePicker(false);
    setEditedEvent(null);
  };

  const handleTimeChange = (event, selectedTime) => {
    const currentTime = selectedTime || chosenTime;
    setShowTimePicker(Platform.OS === 'ios');
    setChosenTime(currentTime);
    setEventTime(currentTime.toLocaleTimeString());
  };

  const addEvent = () => {
    if (selectedDate && eventText.trim() !== '') {
      const newEvent = { event: eventText, time: eventTime };
      const updatedEvents = {
        ...events,
        [selectedDate]: newEvent,
      };
      setEvents(updatedEvents);
      saveEvents(updatedEvents); // Save to AsyncStorage
      setSelectedDate('');
      setEventText('');
      setEventTime('');
      Alert.alert('Event Added', 'Your event has been successfully added.');
    } else {
      Alert.alert('Error', 'Please select a date and fill in all fields.');
    }
  };

  const deleteEvent = () => {
    if (selectedDate && events[selectedDate]) {
      Alert.alert(
        'Delete Event',
        'Are you sure you want to delete this event?',
        [
          {
            text: 'Cancel',
            style: 'cancel',
          },
          {
            text: 'Delete',
            onPress: () => {
              const updatedEvents = { ...events };
              delete updatedEvents[selectedDate];
              setEvents(updatedEvents);
              saveEvents(updatedEvents); // Save updated events to AsyncStorage
              setSelectedDate('');
              setEventText('');
              setEventTime('');
              Alert.alert('Event Deleted', 'Your event has been successfully deleted.');
            },
            style: 'destructive',
          },
        ],
        { cancelable: false }
      );
    } else {
      Alert.alert('Error', 'Please select a valid event to delete.');
    }
  };


  return (
    <ScrollView contentContainerStyle={styles.container}>
      <Calendar
        onDayPress={handleDateSelect}
        markedDates={{
          [selectedDate]: { selected: true, selectedColor: 'blue' },
          ...events,
        }}
      />
      <Text style={styles.header}>Add/Edit Event</Text>
      <TextInput
        style={styles.input}
        placeholder="Event"
        value={eventText}
        onChangeText={(text) => setEventText(text)}
      />
      <TouchableOpacity style={[styles.button, styles.blueButton]} onPress={() => setShowTimePicker(true)}>
        <Text style={styles.buttonText}>🕒 Set Time</Text>
      </TouchableOpacity>
      <TouchableOpacity style={[styles.button, styles.greenButton]} onPress={addEvent}>
        <Text style={styles.buttonText}>✓ Add Event</Text>
      </TouchableOpacity>
      <TouchableOpacity style={[styles.button, styles.blueButton]} onPress={deleteEvent}>
        <Text style={styles.buttonText}>🗑 Delete Event</Text>
      </TouchableOpacity>

      <Text style={styles.header}>Events</Text>
      {Object.keys(events).map((date) => {
        const selectedEvent = events[date] || {};
        return (
          <TouchableOpacity
            key={date}
            onPress={() => {
              setSelectedDate(date);
              setEventText(selectedEvent.event || '');
              setEventTime(selectedEvent.time || '');
              setEditedEvent(selectedEvent);
            }}
          >
            <View style={styles.eventItem}>
              <Text style={styles.eventText}>Events for {date}: {selectedEvent.event || ''}</Text>
            </View>
          </TouchableOpacity>
        );
      })}

      {showTimePicker && (
        <DateTimePicker
          testID="dateTimePicker"
          value={chosenTime}
          mode="time"
          is24Hour={true}
          display="default"
          onChange={handleTimeChange}
        />
      )}
    </ScrollView>
  );
};

const styles = StyleSheet.create({
  container: {
    padding: 20,
    backgroundColor: '#f5f5f5', // Light gray background
  },
  header: {
    fontSize: 18,
    fontWeight: 'bold',
    marginTop: 20,
    marginBottom: 10,
  },
  input: {
    borderWidth: 1,
    borderColor: 'lightgray',
    padding: 10,
    marginBottom: 10,
    borderRadius: 5,
  },
  button: {
    padding: 10,
    alignItems: 'center',
    marginBottom: 10,
    borderRadius: 5,
  },
  buttonText: {
    color: '#fff',
    fontWeight: 'bold',
  },
  blueButton: {
    backgroundColor: 'rgba(30, 144, 255, 0.3)', // Lighter and less transparent blue shade
  },
  greenButton: {
    backgroundColor: 'rgba(0, 128, 0, 0.5)', // Lighter and more transparent green shade
  },
  eventItem: {
    padding: 10,
    borderBottomWidth: 1,
    borderBottomColor: 'lightgray',
  },
  eventText: {
    fontSize: 16,
    marginLeft: 8,
  },
});

export default CalendarScreen;