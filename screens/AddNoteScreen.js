import React, { useState } from 'react';
import { View, TextInput, TouchableOpacity, Text, StyleSheet } from 'react-native';

export default function AddNoteScreen({ navigation }) {
  const [noteTitle, setNoteTitle] = useState('');
  const [noteContent, setNoteContent] = useState('');

  const saveNote = () => {
    const currentTime = new Date().toLocaleString();
    navigation.navigate('NotesHome', { title: noteTitle, content: noteContent, timestamp: currentTime });
  };

  return (
    <View style={styles.container}>
      <View style={styles.notebook}>
        <TextInput
          style={styles.titleInput}
          placeholder="Enter note title"
          onChangeText={text => setNoteTitle(text)}
          value={noteTitle}
        />
        <TextInput
          style={styles.contentInput}
          placeholder="Enter note content"
          onChangeText={text => setNoteContent(text)}
          value={noteContent}
          multiline
        />
      </View>
      <TouchableOpacity
        style={styles.buttonContainer}
        onPress={saveNote}
      >
        <Text style={styles.buttonText}>Save Note</Text>
      </TouchableOpacity>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    padding: 25,
    justifyContent: 'center',
    alignItems: 'center',
  },
  notebook: {
    borderWidth: 2,
    borderColor: '#ccc',
    borderRadius: 10,
    padding: 10,
    width: '100%',
    marginBottom: 20,
  },
  titleInput: {
    borderBottomWidth: 1,
    borderBottomColor: '#ccc',
    marginBottom: 10,
    padding: 10,
  },
  contentInput: {
    height: 200,
    textAlignVertical: 'top',
    padding: 10,
  },
  buttonContainer: {
    backgroundColor: 'rgba(0, 128, 0, 0.4)', // Green color with 50% opacity
    borderRadius: 27,
    paddingVertical: 18,
    paddingHorizontal: 30,
  },
  buttonText: {
    color: 'white', // Black color for button text
    fontWeight: 'bold',
  },
});
