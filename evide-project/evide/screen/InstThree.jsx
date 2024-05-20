import { StyleSheet, Text, View,Image,TouchableOpacity} from 'react-native'
import React from 'react'
import { LinearGradient } from 'expo-linear-gradient';
import { useNavigation } from '@react-navigation/native';

const InstThree = () => {

    const navigation= useNavigation();

    const handleRegister=() =>{
        navigation.navigate("login")
    }


  return (
   <View style={styles.container}>
    <LinearGradient colors={['#298E6F', '#1C6A52', '#165843','#104534']} style={styles.container}>
   
        <View style={styles.textconatiner}>
            <Text style={styles.textt}>Start  Your   Journey Now</Text>
        </View>
   
        <TouchableOpacity onPressIn= {handleRegister}>
        <View style={styles.button}>
            <Text style={styles.buttext}>Get started!</Text>
        </View>
        </TouchableOpacity>
        
        
    </LinearGradient>
   </View>
   
  )
}

export default InstThree

const styles = StyleSheet.create({
    container:{
        flex:1,
    },
    textt:{
        fontSize: 70,
        color:"white",
        alignSelf:"center",
        fontWeight:"400",
        textAlign:"left",
    },
    textconatiner:{
        top:"25%",
        marginHorizontal: 30,
        //backgroundColor: "red",
        //textAlign:"right",
        width:"80%",
        height:"50%",
        paddingLeft:"4%",
        fontFamily:"inter",
    },
   
    topImage:{
        alignSelf:"center",
        top:"1500%",
    },
    buttext:{
        color:"green",
        fontSize: 15,
        textAlign:'center',
        //fontWeight:"80",
      },
      button:{
        alignSelf:"center",
        borderRadius:20,
        paddingVertical:12,
        paddingHorizontal:2,
        backgroundColor:'white',
        width:300,
        top:"600%",
      },
})
