import React, { useState, useEffect } from 'react';
import { View, Button, Text, Modal, Image, Alert,PermissionsAndroid,StyleSheet } from 'react-native';
import * as ImageManipulator from 'expo-image-manipulator';
import * as ImagePicker from 'expo-image-picker'; // Import Expo Image Picker
import * as FileSystem from 'expo-file-system';
import { useNavigation } from '@react-navigation/native';

const DocumentScannerScreen = () => {
  const navigation = useNavigation();
  const [hasPermission, setHasPermission] = useState(null);
  const [cameraRef, setCameraRef] = useState(null);
  const [imageUri, setImageUri] = useState(null);
  const [filteredImage, setFilteredImage] = useState(null);
  const [croppedImage, setCroppedImage] = useState(null);
  const [modalVisible, setModalVisible] = useState(false);
  const [facing, setFacing] = useState('back');

  const styles = StyleSheet.create({
    container: {
      flex: 1,
      justifyContent: 'center',
    },
    camera: {
      flex: 1,
    },
    buttonContainer: {
      flex: 1,
      flexDirection: 'row',
      backgroundColor: 'transparent',
      margin: 64,
    },
    button: {
      flex: 1,
      alignSelf: 'flex-end',
      alignItems: 'center',
    },
    text: {
      fontSize: 24,
      fontWeight: 'bold',
      color: 'white',
    },
  });
  useEffect(() => {
    
    (async () => {
      const granted = await PermissionsAndroid.request(
        PermissionsAndroid.PERMISSIONS.CAMERA,{
          title: 'Smart Life Planner Camera Permission',
          message:
            'Smart Life Planner needs access to your Camera ',
          buttonNeutral: 'Ask Me Later',
          buttonNegative: 'Cancel',
          buttonPositive: 'OK',
        },)
      const mediaLibraryStatus = await ImagePicker.requestMediaLibraryPermissionsAsync();
      if (granted !== PermissionsAndroid.RESULTS.GRANTED || mediaLibraryStatus.status !== PermissionsAndroid.RESULTS.GRANTED) {
        Alert.alert('Permission Denied', 'Camera or media library permission not granted');
      } else {
        setHasPermission(true);
      }
    })();
  }, []);
  function toggleCameraFacing() {
    setFacing(current => (current === 'back' ? 'front' : 'back'));
  }
  const takePicture = async () => {
    const result = await ImagePicker.launchCameraAsync({
      mediaTypes: ImagePicker.MediaTypeOptions.Images,
      allowsEditing: false,
      quality: 1,
    });
    console.log(result)
    if (!result.cancelled) {
      setImageUri(result.assets[0].uri);
      setModalVisible(true);
    }
  };

  const chooseImage = async () => {
    const result = await ImagePicker.launchImageLibraryAsync({
      mediaTypes: ImagePicker.MediaTypeOptions.Images,
      allowsEditing: false,
      quality: 1,
    });

    if (!result.cancelled) {
      setImageUri(result.assets[0].uri);
      setModalVisible(true);
    }
  };

  const applyFilter = async (filterType) => {
    if (imageUri) {
      const manipResult = await ImageManipulator.manipulateAsync(
        imageUri,
        [{ [filterType]: true }],
        { compress: 1, format: 'png' }
      );
      setFilteredImage(manipResult.uri);
    }
  };

  const handleCrop = async () => {
    if (filteredImage || imageUri) {
      const uriToCrop = filteredImage || imageUri;
      const result = await ImageManipulator.manipulateAsync(
        uriToCrop,
        [{ crop: { originX: 0, originY: 0, width: 500, height: 500 } }],
        { compress: 1, format: 'png' }
      );
      setCroppedImage(result.uri);

      const dir = FileSystem.documentDirectory + 'croppedImages/';
      const filename = 'cropped_image.png';
      await FileSystem.makeDirectoryAsync(dir, { intermediates: true });
      await FileSystem.moveAsync({ from: result.uri, to: dir + filename });
    }
  };

  return (
    <View style={{ flex: 1 }}>
      {hasPermission === null ? (
        <View />
      ) : hasPermission === false ? (
        <Text>No access to camera</Text>
      ) : (
        <View style={{ flex: 1 }}>
         <Button title="Take Picture" onPress={takePicture} color="#000" />
          <Button title="Choose Image" onPress={chooseImage} color="#000" />
          
          <Modal
            animationType="slide"
            transparent={false}
            visible={modalVisible}
            onRequestClose={() => setModalVisible(false)}
          >
            <View style={{ flex: 1, justifyContent: 'center', alignItems: 'center' }}>
              <Image source={{ uri: imageUri }} style={{ width: '80%', height: '80%' }} />
              <Button title="Close" onPress={() => setModalVisible(false)} color="#000" />
              <Button title="Apply Grayscale" onPress={() => applyFilter('grayscale')} color="#000" />
              <Button title="Apply Sepia" onPress={() => applyFilter('sepia')} color="#000" />
              <Button title="Crop Image" onPress={handleCrop} color="#000" />
            </View>
          </Modal>
          {filteredImage && <Image source={{ uri: filteredImage }} style={{ width: '80%', height: '80%' }} />}
          {croppedImage && <Image source={{ uri: croppedImage }} style={{ width: '80%', height: '80%' }} />}
        </View>
      )}
    </View>
  );
};

export default DocumentScannerScreen;

