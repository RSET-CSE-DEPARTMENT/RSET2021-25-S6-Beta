import React, { useCallback, useMemo, useRef } from 'react';
import { View, Text, StyleSheet, Button, Dimensions, Image,TouchableOpacity} from 'react-native';
import { GestureHandlerRootView, ScrollView } from 'react-native-gesture-handler';
import { BottomSheetModal, BottomSheetModalProvider } from '@gorhom/bottom-sheet';
import StepIndicator from 'react-native-step-indicator';
import { useTranslation } from 'react-i18next';
import * as Progress from 'react-native-progress';
import TranslationComponent from '../services/nlpTransalationApi';
const windowHeight = Dimensions.get('window').height;
const windowWidth = Dimensions.get('window').width;

const labels = ["Your Location","Delivery Address","Order Summary","Payment Method","Track"];
const customStyles = {
  stepIndicatorSize: 25,
  currentStepIndicatorSize:30,
  separatorStrokeWidth: 10,
  currentStepStrokeWidth: 15,
  stepStrokeCurrentColor: '#F8BC62', //First node
  stepStrokeWidth: 3,
  stepStrokeFinishedColor: '#fe7013',  //Finished node
  stepStrokeUnFinishedColor: '#F8BC62',
  separatorFinishedColor: '#fe7013',
  separatorUnFinishedColor: '#F8BC62',
  stepIndicatorFinishedColor: '#fe7013',
  stepIndicatorUnFinishedColor: '#ffffff',
  stepIndicatorCurrentColor: '#ffffff',
  stepIndicatorLabelFontSize: 15,
  currentStepIndicatorLabelFontSize: 15,
  stepIndicatorLabelCurrentColor: '#fe7013',
  stepIndicatorLabelFinishedColor: '#ffffff',
  stepIndicatorLabelUnFinishedColor: '#aaaaaa',
  labelColor: '#999999',
  labelSize: 15,
  currentStepLabelColor: '#fe7013',
  labelAlign:'left',
  labelColor:'black',
}

const TripCompleteModal = ({navigation, route}) => {
  const bottomSheetModalRef = useRef(null);
  const snapPoints = ['25%', '50%', '60%'];
  bottomSheetModalRef.current?.present();
  function handlePresentModal() {
    bottomSheetModalRef.current?.present();
  }
  const { t } = useTranslation();
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
            <View style={{ height:'100%',paddingTop:'0' ,position:'relative', backgroundColor:'#2675EC'}}>
              <View style = {styles.locationContainer}>
                <View style = {styles.sourceContainer} >
                  <Text style = {styles.locationText} > {route?.legs[0].start_address.split(",")[0]}</Text>
                </View>
                <View style = {styles.progressContainer} >
                  <Progress.Bar progress={1} width={null} color='white' /> 
                </View>
                <View style = {styles.destinationContainer} >
                  <Text style = {styles.locationText}> {route?.legs[0].end_address.split(",")[0]}</Text>
                </View>
              </View>
              {/* <ScrollView
                showsVerticalScrollIndicator={false}
                scrollEventThrottle={16}
                style = {{}}
                contentContainerStyle={{justifyContent:'flex-start'}}
              > */}
                <View style = {styles.indicatorContainer}>
                  <View style={styles.endTextContainer}>
                    <Text style={styles.endText}> Trip Completed!</Text>
                  </View>
                  <View style={styles.detailTextContainer}>
                    <Text style={styles.detailText}> Cost: {route?.fare.text}</Text>
                    <Text style={styles.detailText}> {route?.legs[0].duration.text}</Text>
                  </View>

                    <TouchableOpacity style={styles.selectContainer} >
                      <View style={styles.selectButton}>
                        <Text style={styles.selectText}>Close Trip</Text>
                      </View>
                    </TouchableOpacity>
                  <View style={styles.circle1}>
                  </View>
                  <View style={styles.circle2}>
                  </View>
                </View>
            </View>
              
          </BottomSheetModal>
          </View>
        </View>

  );
}

export default TripCompleteModal;
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
  BottomSheetContainer:{
    backgroundColor:'#2675EC',
    color:'#2675EC',
  },
  selectContainer:{
    // marginBottom:20, // Adjust the button position as needed
    position:'absolute',
    top:'35%',
    alignItems: 'center',
    alignSelf:'center',
    width:'100%',
  // Increase elevation for shadow effect
    shadowColor: 'black', // Shadow color
    shadowOffset: { width: 0, height: 2 }, // Shadow offset
    shadowOpacity: 0.7, // Shadow opacity
    shadowRadius: 3.84, // Shadow radius

  },
  selectButton:{
    backgroundColor: '#15C679',
    borderRadius: 30, // Adjust border radius as needed
    paddingHorizontal: '25%',
    paddingVertical: '5%',
  },
  selectText:{
    fontWeight:'600',
    color:'white',
  },
  indicatorContainer:{
    height:windowHeight,
    margin:0,
    paddingLeft:27,
    paddingTop:0,
  },
  locationContainer:{
    height:100,
    paddingTop:30,
    flexDirection:'row',
    alignContent:'center',
    marginHorizontal:15,
  },
  location:{
    fontSize:20,
    textAlign:'center',
  },
  sourceContainer:{
    flex:0.3,
    justifyContent:'center',
  },
  progressContainer:{
    justifyContent:'center',
    flex:0.4,
  },
  destinationContainer:{
    flex:0.3,
    justifyContent:'center',
  },
  locationText:{
    color:'white',
    fontSize:18,
    textAlign:'center',
    fontWeight:'500',
  },
  endTextContainer:{
    alignItems:'center',
  },
  endText:{
    color:'white',
    fontSize:55,
    textAlign:'left',
    fontWeight:'600',
    paddingTop:20,
    paddingRight:10,
    letterSpacing:1,
    fontFamily:'Inter',
  },
  detailTextContainer:{
    flexDirection:'row',
    justifyContent:"space-around",
    marginTop:'10%',
    paddingRight:'5%',
  },
  detailText:{
    color:'white',
    fontFamily:'Inter',
    fontSize:22,
    fontWeight:'600',
  },
  circle1:{
    color:'white',
    backgroundColor:'white',
    height:20,
    width:20,
    borderRadius:10,
    position:'absolute',
    left:'30%',
    bottom:'103%',
  },
  circle2:{
    color:'white',
    backgroundColor:'white',
    height:20,
    width:20,
    borderRadius:10,
    position:'absolute',
    bottom:'103%',
    left:'70%',
  }
});


