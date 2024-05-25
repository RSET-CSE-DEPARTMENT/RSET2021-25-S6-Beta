import React, { useState, useEffect } from 'react';
import { View, Text, TouchableOpacity, TextInput, ScrollView, StyleSheet } from 'react-native';
import { AntDesign } from '@expo/vector-icons'; // Import AntDesign icon library

export default function HomeScreen({ navigation, route }) {
  const [notes, setNotes] = useState([]);
  const [searchQuery, setSearchQuery] = useState('');
  const [filteredNotes, setFilteredNotes] = useState([]);

  useEffect(() => {
    if (route.params && route.params.title && route.params.content) {
      // If new note is added, update the notes state
      setNotes([...notes, { title: route.params.title, content: route.params.content, timestamp: route.params.timestamp }]);
    }
  }, [route.params]);

  useEffect(() => {
    // Filter notes based on search query
    const filtered = notes.filter(note => {
      return (
        note.title.toLowerCase().includes(searchQuery.toLowerCase()) ||
        note.content.toLowerCase().includes(searchQuery.toLowerCase())
      );
    });
    setFilteredNotes(filtered);
  }, [searchQuery, notes]);

  const renderNotes = () => {
    return filteredNotes.map((note, index) => (
      <View key={index} style={styles.note}>
        <Text style={styles.noteTitle}>{note.title}</Text>
        <Text>{note.content}</Text>
        <Text style={styles.timestamp}>{note.timestamp}</Text>
      </View>
    ));
  };

  return (
    <View style={styles.container}>
      <TextInput
        style={styles.searchInput}
        placeholder="Search notes..."
        onChangeText={text => setSearchQuery(text)}
        value={searchQuery}
      />
      <ScrollView contentContainerStyle={styles.notesGrid}>
        {renderNotes()}
      </ScrollView>
      <TouchableOpacity
        style={styles.addButton}
        onPress={() => navigation.navigate('AddNote')}
      >
        <View style={styles.buttonContent}>
          <AntDesign name="plus" size={24} color="white" style={styles.plusIcon} />
          <Text style={styles.addText}>Add Note</Text>
        </View>
      </TouchableOpacity>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    padding: 20,
    backgroundColor: 'rgba(255, 240, 230, 0.5)', // White with a hint of peach
  },
  searchInput: {
    backgroundColor: 'rgba(0, 0, 0, 0.45)', // Black with 10% opacity
    borderWidth: 1,
    borderColor: '#ccc',
    borderRadius: 10,
    padding: 18,
    marginBottom: 10,
  },
  notesGrid: {
    flexDirection: 'row',
    flexWrap: 'wrap',
    justifyContent: 'space-between',
  },
  note: {
    backgroundColor: 'rgba(30, 144, 255, 0.3)', // Baby blue color with 70% opacity
    marginBottom: 20,
    borderWidth: 1,
    borderColor: '#ccc',
    padding: 20,
    borderRadius: 10,
    width: '48%', // Adjust as needed for spacing
  },
  noteTitle: {
    fontWeight: 'bold',
    marginBottom: 5,
  },
  timestamp: {
    fontStyle: 'italic',
    color: '#666',
    fontSize: 12,
  },
  addButton: {
    backgroundColor: 'rgba(0, 128, 0, 0.5)', // Green color with 50% opacity
    borderRadius: 35,
    padding: 19,
    alignSelf: 'center',
    marginBottom: 25,
  },
  buttonContent: {
    flexDirection: 'row',
    alignItems: 'center',
  },
  addText: {
    color: 'white',
    fontWeight: 'bold',
    fontSize: 18,
    marginLeft: 10,
  },
  plusIcon: {
    marginRight: 10,
  },
});