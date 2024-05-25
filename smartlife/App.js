// App.js (main entry point)
import React from 'react';
import { NavigationContainer } from '@react-navigation/native';
import { createStackNavigator } from '@react-navigation/stack';
import 'react-native-gesture-handler';
import ProfileScreen from './screens/ProfileScreen';
import TasksListScreen from './screens/TasksListScreen';
import AddTaskScreen from './screens/AddTaskScreen';
import EditTaskScreen from './screens/EditTaskScreen';
import DocPicScreen from './screens/DocPicScreen';
import GetStarted from './screens/GetStarted';
import Splash from './screens/Splash';
import NotesHomeScreen from './screens/NotesHomeScreen';
import AddNoteScreen from './screens/AddNoteScreen';
import CalendarScreen from './screens/CalendarScreen';
import HomeScreen from './screens/HomeScreen';
import SignUpScreen from './screens/SignUpScreen';
import Timer from './screens/Timer';
import AlarmList from './screens/AlarmList';
import Alarm from './screens/Alarm'
import { StyleSheet } from 'react-native';
import { UsernameContext } from './screens/HomeScreen';


const Stack = createStackNavigator();

const App = () => {
  
  return (
    <NavigationContainer>
      <UsernameContext.Provider value={username}>
      <Stack.Navigator initialRouteName="Splash">
        <Stack.Screen name="Profile" component={ProfileScreen} />
        <Stack.Screen name="TasksList" component={TasksListScreen} />
        <Stack.Screen name="DocScan" component={DocPicScreen} />
        <Stack.Screen name="AddTask" component={AddTaskScreen} />
        <Stack.Screen name="EditTask" component={EditTaskScreen} />
        <Stack.Screen name="GetStarted" component={GetStarted} />
        <Stack.Screen name="Splash" component={Splash} />
        <Stack.Screen name="NotesHome" component={NotesHomeScreen} />
        <Stack.Screen name="Calendar" component={CalendarScreen} />
        <Stack.Screen name="AddNote" component={AddNoteScreen} />
        <Stack.Screen name="Home" component={HomeScreen} />
        <Stack.Screen name="SignUp" component={SignUpScreen} />
        <Stack.Screen name="Timer" component={Timer} />
        <Stack.Screen name="Alarmlist" component={AlarmList} />
        <Stack.Screen name="Alarm" component={Alarm} />
        
        
      </Stack.Navigator>
      </UsernameContext.Provider>
    </NavigationContainer>
  );
}

export default App;


const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#fff',
    alignItems: 'center',
    justifyContent: 'center',
  },
});