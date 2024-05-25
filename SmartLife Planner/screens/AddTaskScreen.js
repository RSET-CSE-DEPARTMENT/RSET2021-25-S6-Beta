import React, { useState, useContext } from 'react';
import { View, Text, TextInput, TouchableOpacity, StyleSheet, Switch } from 'react-native';
import { Ionicons } from '@expo/vector-icons';
import DateTimePicker from '@react-native-community/datetimepicker';

import AsyncStorage from '@react-native-async-storage/async-storage';

import { Picker } from '@react-native-picker/picker';
import { useNavigation } from '@react-navigation/native';
import { UsernameContext } from './HomeScreen';


const AddTaskScreen = () => {
  const navigation = useNavigation();
  const [taskName, setTaskName] = useState('');
  const [priority, setPriority] = useState('');
  const [dueDate, setDueDate] = useState(new Date());
  const [dueTime, setDueTime] = useState(new Date());
  const [reminder, setReminder] = useState(false);
  const [showDatePicker, setShowDatePicker] = useState(false);
  const [showTimePicker, setShowTimePicker] = useState(false);
  const username =  useContext(UsernameContext);


  const generateRandomColor = () => {
    const colors = ['#FF5733', '#33FF57', '#5733FF']; // Add more light colors if needed
    const randomIndex = Math.floor(Math.random() * colors.length);
    return colors[randomIndex];
  };

  const handleAddTask = async () => {
    // Prepare task object
    const color = generateRandomColor(); // Generate random color
    const task = {
      username:username,
      id: Math.random().toString(),
      name: taskName,
      priority,
      dueDate: dueDate.toISOString().split('T')[0], // Format dueDate as YYYY-MM-DD
      dueTime: dueTime.toLocaleTimeString(), // Format dueTime as HH:MM:SS
      reminder,
      color, // Assign random color
    };

    // Update tasks list in AsyncStorage
    const existingTasks = await AsyncStorage.getItem('tasks');
    let updatedTasks = [];
    if (existingTasks !== null) {
      updatedTasks = JSON.parse(existingTasks);
    }
    updatedTasks.push(task);
    await AsyncStorage.setItem('tasks', JSON.stringify(updatedTasks));

    // Reset form fields
    setTaskName('');
    setPriority('');
    setDueDate(new Date());
    setDueTime(new Date());
    setReminder(false);

    // Navigate back to TaskListScreen
    navigation.navigate('TasksList');
  };

  const showDatePickerModal = () => {
    setShowDatePicker(true);
  };

  const handleDatePickerChange = (event, selectedDate) => {
    setShowDatePicker(false);
    if (selectedDate) {
      setDueDate(selectedDate);
    }
  };

  const showTimePickerModal = () => {
    setShowTimePicker(true);
  };

  const handleTimePickerChange = (event, selectedTime) => {
    setShowTimePicker(false);
    if (selectedTime) {
      setDueTime(selectedTime);
    }
  };

  return (
    <View style={styles.container}>
      <Text style={styles.heading}>Add Task</Text>
      <TextInput
        style={[styles.input, styles.taskInput]}
        placeholder="Task Name"
        value={taskName}
        onChangeText={setTaskName}
        multiline={true}
        numberOfLines={4} // Increased height
      />
      <Picker
        selectedValue={priority}
        style={styles.input}
        onValueChange={(itemValue) => setPriority(itemValue)}
        
      >
        <Picker.Item label="High" value="High" />
        <Picker.Item label="Medium" value="Medium" />
        <Picker.Item label="Low" value="Low" />
      </Picker>
      {/* Due Date picker */}
      <TouchableOpacity style={styles.datePickerContainer} onPress={showDatePickerModal}>
        <Ionicons name="calendar-outline" size={24} color="#555" />
        <Text style={styles.datePickerText}>Select Due Date</Text>
      </TouchableOpacity>
      {showDatePicker && (
        <DateTimePicker
          value={dueDate}
          mode="date"
          display="default"
          onChange={handleDatePickerChange}
        />
      )}
      {/* Due Time picker */}
      <TouchableOpacity style={styles.datePickerContainer} onPress={showTimePickerModal}>
        <Ionicons name="time-outline" size={24} color="#555" />
        <Text style={styles.datePickerText}>Select Due Time</Text>
      </TouchableOpacity>
      {showTimePicker && (
        <DateTimePicker
          value={dueTime}
          mode="time"
          display="default"
          onChange={handleTimePickerChange}
        />
      )}
      {/* Reminder switch */}
      <View style={styles.checkboxContainer}>
        <Text>Reminder</Text>
        <Switch value={reminder} onValueChange={setReminder} />
      </View>
      {/* Add Task button */}
      <TouchableOpacity style={styles.addButton} onPress={handleAddTask}>
        <Ionicons name="add-circle-outline" size={24} color="#fff" />
        <Text style={styles.addButtonText}>Add Task</Text>
      </TouchableOpacity>
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    padding: 20,
    backgroundColor: '#fff',
  },
  heading: {
    fontSize: 20,
    fontWeight: 'bold',
    marginBottom: 20,
  },
  input: {
    borderWidth: 1,
    borderColor: '#ccc',
    borderRadius: 5,
    padding: 10,
    marginBottom: 20,
  },
  taskInput: {
    backgroundColor: 'rgba(138, 43, 226, 0.2)', // Lighter and more transparent purple shade
    height: 120, // Increased height
    borderRadius: 10, // Rounded corners
  },
  datePickerContainer: {
    flexDirection: 'row',
    alignItems: 'center',
    marginBottom: 20,
  },
  datePickerText: {
    marginLeft: 10,
  },
  addButton: {
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'center',
    backgroundColor: 'rgba(0, 128, 0, 0.5)', // Lighter and more transparent green shade
    paddingVertical: 15,
    borderRadius: 10, // Rounded corners
    alignSelf: 'center', // Center the button
    width: '50%', // Decreased width
  },
  addButtonText: {
    fontSize: 18,
    fontWeight: 'bold',
    color: '#fff',
    marginLeft: 10,
  },
  checkboxContainer: {
    flexDirection: 'row',
    alignItems: 'center',
    marginBottom: 20,
  },
});

export default AddTaskScreen;