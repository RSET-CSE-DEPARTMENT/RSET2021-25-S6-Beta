import React, { useCallback, useMemo, useRef } from 'react';
import { View, Text, StyleSheet, Button, Dimensions, Image,TouchableOpacity} from 'react-native';
import { GestureHandlerRootView, ScrollView } from 'react-native-gesture-handler';
import { BottomSheetModal, BottomSheetModalProvider } from '@gorhom/bottom-sheet';
import LocationCard from './LocationCard';
import { useTranslation } from 'react-i18next';
const windowHeight = Dimensions.get('window').height;
const windowWidth = Dimensions.get('window').width;

const TestModal = ({navigation}) => {
  
  
  const bottomSheetModalRef = useRef(null);
  const snapPoints = ['25%', '50%', '78%'];
  bottomSheetModalRef.current?.present();
  function handlePresentModal() {
    bottomSheetModalRef.current?.present();
  }
  // const { t } = useTranslation();
  const handleContentPanning = useCallback((event, gestureState, fromIndex, toIndex) => {
    // Prevent the modal from going below 25%
    if (toIndex < 0) {
      return false;
    }
    return true;
  }, []);
    
  return (
        <View style={styles.container}>
          <View style={styles.modalButtonContainer}>
          <TouchableOpacity style={styles.modalButton} onPress={handlePresentModal}>
            <Text style={styles.modalText}>Explore</Text>
          </TouchableOpacity>
          </View>
          <View style = {styles.BottomSheetContainer}>
          <BottomSheetModal
            ref={bottomSheetModalRef}
            index={2}
            snapPoints={snapPoints}
            enableContentPanning={handleContentPanning} // Apply the custom content panning handler
          >
            <View style={{ height:'100%', marginTop: '1%' ,position:'relative'}}>
              <View style={styles.tripDetails}>
                <Text style={styles.stopsText}> 2h 2min</Text>
                <Text style={styles.st}>|</Text>
                <Text style={styles.stopsText}> 11Km</Text>
                <Text style={styles.st}>|</Text>
                <Text style={styles.stopsText}> 50Rs</Text>
              </View>
              <ScrollView
                showsVerticalScrollIndicator={false}
                scrollEventThrottle={16}
                style = {{}}
                contentContainerStyle={{justifyContent:'flex-start'}}
              >
                {/* <View style={styles.routeTextContainer}>
                    <Text style={styles.routeText}>Recommended</Text>
                </View> */}
                <View style={styles.line}></View>
                <LocationCard startButtonColor="#FFC75B" startButtonTextColor="black" />
                <LocationCard startButtonColor="#0074CB" startButtonTextColor="white" />
                <LocationCard startButtonColor="#0074CB" startButtonTextColor="white" />
                <LocationCard startButtonColor="#0074CB" startButtonTextColor="white" />
                <LocationCard startButtonColor="#0074CB" startButtonTextColor="white" />
                
              </ScrollView>
              <TouchableOpacity style={styles.selectContainer} >
                <View style={styles.selectButton}>
                   <Text style={styles.selectText}>Start Journey</Text>
                </View>
              </TouchableOpacity>
            </View>
    
          </BottomSheetModal>
          </View>
        </View>

  );
}

export default TestModal;
const styles = StyleSheet.create({
  container: {
    alignItems: 'center',
    justifyContent: 'center',
  },
  modalButtonContainer: {
    top: windowHeight * 0.9, // Adjust the margin bottom to position the button lower
    backgroundColor: "#2675EC",
    borderRadius: 30,
    paddingHorizontal: 20,
    width: "100vw",
    elevation:2,
    shadowColor: 'black', // Shadow color
    shadowOffset: { width: 2, height: 2 }, // Shadow offset
    shadowOpacity: 0.8, // Shadow opacity
    shadowRadius: 3.84, // Shadow radius
    position:'absolute',
    alignSelf:'center',
  },
  modalButton: {
      border: "none",
      padding:12,
      width: 300,
  },
  modalText:{
    alignSelf:'center',
    fontWeight:'700',
    color:'white',
    letterSpacing:2,
  },
  exploreContainer: {
    flex:1,
    paddingTop:20,
    paddingHorizontal:35,
  },
  textLabel: {
    marginLeft: 20,
  },
  routeTextContainer:{
    marginLeft:'6%',
    marginTop:'2%',
  },
  routeText:{
    fontWeight:'600',
    fontSize:13,
  },
  filterText:{
    fontSize:15,
    fontWeight:'600',
    marginLeft:'10%',
    marginTop:'3%',
  },
  BottomSheetContainer:{

  },
  selectContainer:{
    position: 'absolute',
    bottom: windowHeight * 0.06, // Adjust the button position as needed
    alignItems: 'center',
    alignSelf:'center',
    elevation: 2, // Increase elevation for shadow effect
    shadowColor: 'black', // Shadow color
    shadowOffset: { width: 0, height: 2 }, // Shadow offset
    shadowOpacity: 0.7, // Shadow opacity
    shadowRadius: 3.84, // Shadow radius
  },
  selectButton:{
    backgroundColor: '#15C679',
    borderRadius: 20, // Adjust border radius as needed
    paddingHorizontal: '25%',
    paddingVertical: '5%',
  },
  selectText:{
    fontWeight:'600',
    color:'white',
  },
  line:{
    position:'absolute',
    height:'100%',
    width:4,
    left:'11%',
    top:98,
    borderRadius:10,
    backgroundColor:'#F8BC62',
    zIndex:1,
  },
  tripDetails:{
    backgroundColor:'#FAF9F6',
    height:80,
    borderRadius:10,
    flexDirection:'row',
    justifyContent:'space-between',
    paddingHorizontal:40,
    alignItems:'center',
  },
  stopsText:{
    fontSize:20,
    fontWeight:'600',
  }
});
