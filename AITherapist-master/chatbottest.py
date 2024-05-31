import pickle
from gradientai import Gradient
import random
import requests
from PIL import Image
from io import BytesIO
import pandas as pd
from flask import Flask, request, jsonify
from flask_cors import CORS

def load_model_adapter_id(file_path):
    with open(file_path, 'rb') as f:
        model_adapter_id = pickle.load(f)
    return model_adapter_id

def retrieve_model_adapter(access_token, workspace_id, model_adapter_id):
    with Gradient(access_token=access_token, workspace_id=workspace_id) as gradient:
        model_adapter = gradient.get_model_adapter(model_adapter_id=model_adapter_id)
    return model_adapter

def get_rec(user_input):
    return recommendation_response(user_input.lower())

def recommendation_response(emotion):
    print("Emotion detected:", emotion)
    emotion=emotion.strip()
    df = pd.read_csv('quote_dataset.csv')
    emotion_label_mapping = {
        'joy': ['Optimism','Gratitude', 'Laughter', 'Happiness', 'Joy'],
        'sadness': ['Resilience', 'Overcoming', 'Grit', 'Patience', 'Rising Above', 'Responsibility',
                    'Courage', 'Perseverance', 'Appreciation', 'Making a Difference', 'Rising Above'],
        'fear': ['Courage', 'Bravery', 'Overcoming', 'Rising Above', 'Determination', 'Rising Above'],
        'surprise': ['Discovery', 'Wonder', 'Imagine'],
        'disgust': ['Integrity', 'Soul'],
        'anger': ['Forgiveness', 'Courage', 'Determination', 'Purpose', 'Right Choices']
    }
    labels = [label.upper() for label in emotion_label_mapping.get(emotion, [])]
    print("Labels:", labels)
    filtered_df = df[df['Category'].isin(labels)]
    if not filtered_df.empty:
        random_entry = random.choice(filtered_df.index)
        quote = filtered_df.loc[random_entry, 'Quote']
        image_url = filtered_df.loc[random_entry, 'Image-link']
        try:
            response = requests.get(image_url)
            image = Image.open(BytesIO(response.content))
            #image.show()
            #print(quote)
            return quote
        except Exception as e:
            return "Sorry, I didn't understand you."
        return f"Here's something to uplift you:\n\n{quote}"
    else:
        return "No quotes found for the provided emotion."


def detecor(user_input):
    model_adapter_id = "1dbe795b-cce1-4ed9-9b2f-9738d30842db_model_adapter"

    access_token = "7Ve3RqWYuLjpfljfe2JM4Z3UCpCArTtW"
    workspace_id = "30132923-499e-46f9-81e5-dbd582d00a96_workspace"

    model_adapter = retrieve_model_adapter(access_token, workspace_id, model_adapter_id)


    # Now you can use the model adapter to generate predictions or perform other tasks
    #print("Hello! How are you feeling today?")
    #user_input = input("You: ")

    # Sample query for emotion detection
    sample_query = f"### Instruction:{user_input.lower()} \n\n### Response:"
    completion = model_adapter.complete(query=sample_query, max_generated_token_count=100).generated_output
    #print(f"detected emotion: {completion}")
    emotion=completion.split('\n')[0]
    #print(emotion)
    return get_rec(emotion)
app = Flask(__name__)
CORS(app)
@app.route('/get_response', methods=['POST', 'OPTIONS'])
def get_response():
    if request.method == 'OPTIONS':
        response = jsonify({'message': 'OPTIONS request handled'})
        response.headers.add('Access-Control-Allow-Origin', '*')
        response.headers.add('Access-Control-Allow-Headers', 'Content-Type')
        response.headers.add('Access-Control-Allow-Methods', 'POST')
        return response

    user_input = request.json.get('user_input')
    if user_input is None:
        return jsonify({'error': 'No user input provided'}), 400

    response = detecor(user_input.lower())
    #print(response)
    quote=response
    return jsonify({'response': response,'quote':quote })

if __name__ == "__main__":
    app.run(debug=True)
