import React from 'react';
import { View, Text, StyleSheet, Dimensions, Image, TouchableOpacity } from 'react-native';
import { useNavigation } from '@react-navigation/native';

const PlaceCard = ({navigation,key, name, imageUri }) => {
    const handlePress = () => {
        console.log(imageUri?.uri + "YOUR_API_KEY");
    };

    return (
        <TouchableOpacity onPress={handlePress} key={key}>
            <View style={{ height: 130, width: 130, marginLeft: 20, marginTop: 15, borderWidth: 0.5, borderColor: '#dddddd', borderRadius: 10 }}>
                <View style={{ flex: 2 }}>
                    <Image source={{uri: imageUri?.uri + "YOUR_API_KEY"}} style={{ flex: 1, resizeMode: 'cover', height: null, width: null }} />
                </View>
                <View style={{ flex: 1, paddingLeft: '5%', paddingTop: '5%' }}>
                    <Text>{name}</Text>
                </View>
            </View>
        </TouchableOpacity>
    );
};

export default PlaceCard;
