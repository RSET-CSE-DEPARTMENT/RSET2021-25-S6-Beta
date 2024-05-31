import pickle

# Define or import recommend_book function/class
# from your_module import recommend_book  # Make sure to replace 'your_module' with the actual module name

# Load the model
with open('C:/mini/Server/ml_model/recommendation_system.pkl', 'rb') as f:
    model = pickle.load(f)

print('Model loaded successfully')
