import React from 'react';
import 'react-native-gesture-handler';
import { NavigationContainer } from '@react-navigation/native';
import { createDrawerNavigator } from '@react-navigation/drawer';
import registerNNPushToken from 'native-notify';
import { registerIndieID, unregisterIndieDevice } from 'native-notify';

import InputScreen from './screen/InputScreen';
import ViewRouteScreen from './screen/ViewRouteScreen';
import TrackRouteScreen from './screen/TrackRouteScreen';
import RouteListScreen from './screen/RouteListScreen';
import CompleteRouteScreen from './screen/CompleteRouteScreen';
import TestScreen from './screen/TestScreen';
import ProfileScreen from './screen/ProfileScreen';

import InstOne from './screen/InstOne';
import InstTwo from './screen/InstTwo';
import InstThree from './screen/InstThree';
import OpenScreen from './screen/OpenScreen';
import Open0Screen from './screen/Open0Screen';

import LoginScreen from './screen/LoginScreen';

const Drawer = createDrawerNavigator();

const DrawerNavigator = () => {
  // const { t } = useTranslation();
  return (
    <Drawer.Navigator
      drawerStyle={{ backgroundColor: '#FFC75B' }}
      screenOptions={{
        headerShown: false,
      }}
    >
    <Drawer.Screen name="open0" component={Open0Screen} />
    <Drawer.Screen name="open" component={OpenScreen} />
    <Drawer.Screen name="inst1" component={InstOne} />
    <Drawer.Screen name="inst2" component={InstTwo} />
    <Drawer.Screen name="inst3" component={InstThree} />
    <Drawer.Screen name="login" component={LoginScreen} />

      <Drawer.Screen name="Input Screen" component={InputScreen} />
      <Drawer.Screen name="Route List" component={RouteListScreen} />
      <Drawer.Screen name="View Route" component={ViewRouteScreen} />
      <Drawer.Screen name="Track Route" component={TrackRouteScreen} />
      <Drawer.Screen name="Complete Route" component={CompleteRouteScreen} />
      <Drawer.Screen name="Test Screen" component={TestScreen} />
    </Drawer.Navigator>
  );
};

export default function App(){
  registerNNPushToken(21277, 'zKYr5HfxtSvzogaxyd2h3F');
  registerIndieID('Kuruvilla', 21277, 'zKYr5HfxtSvzogaxyd2h3F');
  return (
    // <LanguageProvider>
      <NavigationContainer>
        <DrawerNavigator />
      </NavigationContainer>
    // </LanguageProvider>
  );
};
