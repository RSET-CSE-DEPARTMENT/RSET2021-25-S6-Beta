import React, { useState } from 'react';
import { View, Text, TextInput, Button, StyleSheet, Switch } from 'react-native';
import DateTimePicker from '@react-native-community/datetimepicker';
import { Picker } from '@react-native-picker/picker';

const EditTaskScreen = ({ route, navigation }) => {
  const { taskId, taskDetails } = route.params;

  const [taskName, setTaskName] = useState(taskDetails.name || 'Task Name');
  const [priority, setPriority] = useState(taskDetails.priority || 'High');
  const [dueDate, setDueDate] = useState(taskDetails.dueDate ? new Date(taskDetails.dueDate) : new Date());
  const [dueTime, setDueTime] = useState(taskDetails.dueTime ? new Date(taskDetails.dueTime) : new Date());
  const [reminder, setReminder] = useState(taskDetails.reminder !== undefined ? taskDetails.reminder : true);
  const [reminderTiming, setReminderTiming] = useState('1day');
  const [showDatePicker, setShowDatePicker] = useState(false); // New state for showing/hiding date picker

  const handleSaveChanges = () => {
    // Calculate reminder time based on selected reminder timing
    let reminderTime;
    if (reminderTiming === '1day') {
      reminderTime = new Date(dueDate.getTime() - 24 * 60 * 60 * 1000);
    } else if (reminderTiming === '5min') {
      reminderTime = new Date(dueDate.getTime() + dueTime.getTime() - 5 * 60 * 1000);
    }

    console.log('Reminder set:', reminderTime);
    console.log('Task updated:', { taskId, taskName, priority, dueDate, dueTime, reminder });
    navigation.goBack();
  };

  const toggleDatePicker = () => {
    setShowDatePicker(!showDatePicker);
  };

  return (
    <View style={styles.container}>
      <Text style={styles.heading}>Edit Task</Text>
      <TextInput
        style={styles.input}
        value={taskName}
        onChangeText={setTaskName}
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
      <TextInput
        style={styles.input}
        value={dueTime.toLocaleTimeString()}
        placeholder="Due Time"
        onChangeText={(text) => setDueTime(new Date(text))}
      />

      <Button title="Select Due Date" onPress={toggleDatePicker} />
      {showDatePicker && (
        <DateTimePicker
          value={dueDate}
          mode="date"
          display="default"
          onChange={(event, selectedDate) => {
            setShowDatePicker(false);
            setDueDate(selectedDate || dueDate);
          }}
        />
      )}

      <View style={styles.row}>
        <Text>Set Reminder:</Text>
        <Switch
          value={reminder}
          onValueChange={(value) => setReminder(value)}
        />
      </View>

      <Picker
        selectedValue={reminderTiming}
        style={styles.input}
        onValueChange={(itemValue) => setReminderTiming(itemValue)}
      >
        <Picker.Item label="1 Day Before" value="1day" />
        <Picker.Item label="5 Minutes Before" value="5min" />
      </Picker>

      <Button title="Save Changes" onPress={handleSaveChanges} />
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    padding: 20,
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
  row: {
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'space-between',
    marginBottom: 20,
  },
});

export default EditTaskScreen;