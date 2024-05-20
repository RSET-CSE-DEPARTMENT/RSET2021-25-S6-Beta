import { StyleSheet, Text, View,Image,TouchableOpacity} from 'react-native'
import React from 'react'
import { LinearGradient } from 'expo-linear-gradient';
import { useNavigation } from '@react-navigation/native';

const InstTwo = () => {

    const navigation= useNavigation();

    const handleRegister=() =>{
        navigation.navigate("inst3")
    }


  return (
   <View style={styles.container}>
    <LinearGradient colors={['#FFB162', '#FE9F3F', '#FD962D']} style={styles.container}>
    <TouchableOpacity onPressIn= {handleRegister}>
        <View style={styles.textconatiner}>
            <Text style={styles.textt}>Select a Route!</Text>
        </View>
    </TouchableOpacity>
        <View style={styles.Imageconatiner}> 
            <Image
                source={require("../assets/bottom2.png")}
                style={styles.topImage}
            />
        </View>
        <View style={styles.ImageContainer2}>
            <Image source={require("../assets/pic2.png")}
            style={styles.topImage2}>

            </Image>
        </View>
        
        
    </LinearGradient>
   </View>
   
  )
}

export default InstTwo

const styles = StyleSheet.create({
    container:{
        flex:1,
    },
    textt:{
        fontSize: 30,
        color:"white",
        alignSelf:"center",
        fontWeight:"400",
        textAlign:"left",
    },
    textconatiner:{
        top:"55%",
        marginHorizontal: 8,
        //backgroundColor: "red",
        //textAlign:"right",
        width:"60%",
        height:"40%",
        paddingLeft:"7%",
    },
   
    topImage:{
        alignSelf:"center",
        top:"1900%",
    },
    ImageContainer2:{
        
    },
    topImage2:{
        height:300,
        width:300,
        marginHorizontal:"10%",
        bottom:"10%",
    },
})
