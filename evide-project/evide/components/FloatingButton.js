import { StyleSheet, Text, View, Dimensions } from 'react-native'
import React from 'react'
import { TouchableOpacity } from 'react-native-gesture-handler'

const windowHeight = Dimensions.get('window').height;
const windowWidth = Dimensions.get('window').width;

const FloatingButton = ({name, onPress}) => {
  return (
    <View style={styles.modalButtonContainer}>
      <TouchableOpacity style={styles.modalButton} onPress={onPress}>
        <Text style={styles.modalText}>{name}</Text>
      </TouchableOpacity>
    </View>
  )
}

export default FloatingButton

const styles = StyleSheet.create({
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
    }
})