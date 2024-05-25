import React, { useState, useEffect, useContext } from 'react';
import { View, Text, FlatList, TouchableOpacity, StyleSheet, Modal } from 'react-native';
import { useNavigation } from '@react-navigation/native';
import { Swipeable } from 'react-native-gesture-handler';
import AsyncStorage from '@react-native-async-storage/async-storage';
import { Checkbox } from 'react-native-paper';
import { PieChart } from 'react-native-chart-kit';
import { UsernameContext } from './HomeScreen';


const TasksListScreen = () => {
  const navigation = useNavigation();
  const [tasks, setTasks] = useState([]);
  const [markedTasks, setMarkedTasks] = useState([]);
  const [showModal, setShowModal] = useState(false);
  const username = useContext(UsernameContext); // Access username from context

  useEffect(() => {
    const fetchTasks = async () => {
      try {
        const storedTasks = await AsyncStorage.getItem('tasks');
        if (storedTasks !== null) {
          const parsedTasks = JSON.parse(storedTasks);
          const userTasks = parsedTasks.filter(task => task.username === username); // Filter tasks by username
          setTasks(userTasks);
          const marked = userTasks.filter(task => task.done);
          setMarkedTasks(marked);
        }
      } catch (error) {
        console.error('Error fetching tasks:', error);
      }
    };

    fetchTasks();
  }, [username]); // Add username as a dependency

  // Add a task with username
  const addTask = async (task) => {
    try {
      const updatedTasks = [...tasks, { ...task, username: username }];
      setTasks(updatedTasks);
      await AsyncStorage.setItem('tasks', JSON.stringify(updatedTasks));
    } catch (error) {
      console.error('Error adding task:', error);
    }
  };

  const handleEditTask = (task) => {
    navigation.navigate("EditTask", { taskId: task.id, taskDetails: task });
  };

  const deleteTask = async (taskId) => {
    try {
      const updatedTasks = tasks.filter(task => task.id !== taskId);
      setTasks(updatedTasks);
      await AsyncStorage.setItem('tasks', JSON.stringify(updatedTasks));
    } catch (error) {
      console.error('Error deleting task:', error);
    }
  };

  const toggleTaskStatus = async (taskId) => {
    try {
      const updatedTasks = tasks.map(task => {
        if (task.id === taskId) {
          return { ...task, done: !task.done };
        } else {
          return task;
        }
      });
      setTasks(updatedTasks);
      await AsyncStorage.setItem('tasks', JSON.stringify(updatedTasks));
      const marked = updatedTasks.filter(task => task.done);
      setMarkedTasks(marked);
    } catch (error) {
      console.error('Error toggling task status:', error);
    }
  };

  const openModal = () => {
    setShowModal(true);
  };

  const closeModal = () => {
    setShowModal(false);
  };

  const chartData = [
    {
      name: 'Undone',
      percentage: (markedTasks.length / tasks.length) * 100,
      color: 'rgba(30, 144, 255, 0.5)',
      legendFontColor: '#7F7F7F',
      legendFontSize: 15,
    },
    {
      name: 'Undone',
      percentage: 100 - ((markedTasks.length / tasks.length) * 100),
      color: '#F00',
      legendFontColor: '#7F7F7F',
      legendFontSize: 15,
    },
  ];

  const chartConfig = {
    backgroundGradientFrom: '#FFFFFF',
    backgroundGradientTo: '#FFFFFF',
    color: (opacity = 1) => `rgba(0, 0, 0, ${opacity})`,
  };

  const renderItem = ({ item, index }) => (
    <Swipeable
      renderRightActions={() => (
        <TouchableOpacity
          style={styles.deleteButton}
          onPress={() => deleteTask(item.id)}
        >
          <Text style={styles.deleteButtonText}>Delete</Text>
        </TouchableOpacity>
      )}
    >
      <TouchableOpacity
        style={[
          styles.taskItem,
          { backgroundColor: index % 2 === 0 ? 'rgba(65, 105, 225, 0.5)' : 'rgba(138, 43, 226, 0.5)' }
        ]}
        onPress={() => handleEditTask(item)}
      >
        <Checkbox.Android
          status={item.done ? 'checked' : 'unchecked'}
          onPress={() => toggleTaskStatus(item.id)}
          color="blue"
        />
        <View style={styles.taskDetails}>
          <Text style={styles.taskName}>{item.name}</Text>
          <Text style={styles.taskDetail}>Priority: {item.priority}</Text>
          <Text style={styles.taskDetail}>Due: {item.dueDate} at {item.dueTime}</Text>
          {item.reminder && <Text style={styles.taskDetail}>Reminder: On</Text>}
        </View>
      </TouchableOpacity>
    </Swipeable>
  );

  return (
    <View style={styles.container}>
      <Text style={styles.heading}>Tasks List</Text>
      <TouchableOpacity style={styles.productivityButton} onPress={openModal}>
        <Text style={styles.productivityButtonText}>Productivity Analysis</Text>
      </TouchableOpacity>
      <FlatList
        data={tasks}
        renderItem={renderItem}
        keyExtractor={item => item.id.toString()}
        contentContainerStyle={styles.taskList}
      />
      <Modal visible={showModal} transparent animationType="fade">
        <View style={styles.modalContainer}>
          <View style={styles.modalContent}>
            <Text style={styles.modalHeading}>Productivity Analysis</Text>
            <PieChart
              data={chartData}
              width={300}
              height={200}
              chartConfig={chartConfig}
              accessor="percentage"
              backgroundColor="transparent"
              paddingLeft="15"
            />
            <TouchableOpacity onPress={closeModal}>
              <Text style={styles.closeButton}>Close</Text>
            </TouchableOpacity>
          </View>
        </View>
      </Modal>
      <TouchableOpacity style={styles.addButton} onPress={() => navigation.navigate("AddTask", { addTask })}>
        <Text style={styles.addButtonIcon}>+</Text>
        <Text style={styles.addButtonText}>Add Tasks</Text>
      </TouchableOpacity>
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    padding: 20,
    backgroundColor: '#f8f8f8',
  },
  heading: {
    fontSize: 28,
    fontWeight: 'bold',
    marginBottom: 20,
    color: '#333',
    textAlign: 'center',
  },
  taskList: {
    flexGrow: 1,
  },
  taskItem: {
    flexDirection: 'row',
    alignItems: 'center',
    padding: 20,
    marginBottom: 20,
    borderRadius: 20,
    elevation: 5,
    shadowColor: '#000',
    shadowOffset: {
      width: 0,
      height: 2,
    },
    shadowOpacity: 0.25,
    shadowRadius: 3.84,
    backgroundColor: '#fff',
  },
  taskDetails: {
    marginLeft: 10,
    flex: 1,
  },
  taskName: {
    fontSize: 20,
    fontWeight: 'bold',
    color: '#333',
  },
  taskDetail: {
    fontSize: 16,
    color: '#555',
  },
  deleteButton: {
    backgroundColor: 'red',
    justifyContent: 'center',
    alignItems: 'center',
    width: 80,
    borderRadius: 10,
    marginVertical: 10,
  },
  deleteButtonText: {
    color: 'white',
    fontSize: 16,
    fontWeight: 'bold',
  },
  addButton: {
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'center',
    paddingVertical: 15,
    paddingHorizontal: 30,
    backgroundColor: 'rgba(30, 144, 255, 0.5)',
    borderRadius: 30,
    marginBottom: 20,
    elevation: 5,
    shadowColor: '#000',
    shadowOffset: {
      width: 0,
      height: 2,
    },
    shadowOpacity: 0.25,
    shadowRadius: 3.84,
  },
  addButtonIcon: {
    fontSize: 24,
    color: '#fff',
    marginRight: 10,
  },
  addButtonText: {
    fontSize: 18,
    fontWeight: 'bold',
    color: '#fff',
  },
  productivityButton: {
    alignItems: 'center',
    justifyContent: 'center',
    paddingVertical: 15,
    backgroundColor: 'rgba(46, 139, 87, 0.5)',
    borderRadius: 30,
    marginBottom: 20,
    elevation: 5,
    shadowColor: '#000',
    shadowOffset: {
      width: 0,
      height: 2,
    },
    shadowOpacity: 0.25,
    shadowRadius: 3.84,
  },
  productivityButtonText: {
    fontSize: 18,
    fontWeight: 'bold',
    color: '#fff',
  },
  modalContainer: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: 'rgba(0, 0, 0, 0.5)',
  },
  modalContent: {
    backgroundColor: '#fff',
    padding: 20,
    borderRadius: 10,
    elevation: 5,
  },
  modalHeading: {
    fontSize: 20,
    fontWeight: 'bold',
    marginBottom: 10,
    textAlign: 'center',
  },
  closeButton: {
    fontSize: 16,
    textAlign: 'center',
    color: 'blue',
    marginTop: 10,
  },
});

export default TasksListScreen;
