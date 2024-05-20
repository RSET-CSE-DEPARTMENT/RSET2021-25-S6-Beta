import React, { useState, useEffect } from 'react';
import { View, Text, TouchableOpacity } from 'react-native';
import axios from 'axios';

const TranslationComponent = ({ text }) => {
  const [translatedText, setTranslatedText] = useState('');
  const [isTranslated, setIsTranslated] = useState(false);

  useEffect(() => {
    const translateText = async () => {
      const options = {
        method: 'GET',
        url: 'https://nlp-translation.p.rapidapi.com/v1/translate',
        params: {
          text: text,
          to: 'ml',
          from: 'en'
        },
        headers: {
          'X-RapidAPI-Key': '65bacb379dmsh4ba2d20954903acp14fca1jsn1a8d8c231af8',
          'X-RapidAPI-Host': 'nlp-translation.p.rapidapi.com'
        }
      };

      try {
        const response = await axios.request(options);
        const translatedText = response.data.translated_text.ml;
        setTranslatedText(translatedText);
      } catch (error) {
        console.error(error);
      }
    };

    translateText();
  }, [text]);

  const toggleTranslation = () => {
    setIsTranslated(!isTranslated);
  };

  return (
    <TouchableOpacity onPress={toggleTranslation}>
      <View>
        <Text>{isTranslated ? translatedText : text}</Text>
      </View>
    </TouchableOpacity>
  );
};

export default TranslationComponent;
