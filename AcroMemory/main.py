from flask import Flask, request, jsonify,render_template
from langchain_community.llms import CTransformers # Assuming you're using CTransformers
from langchain.chains import LLMChain
from langchain import PromptTemplate

app = Flask(__name__)

@app.route('/')
def welcome():
    return render_template('acromem.html')
# Load model and prompt template (consider storing them globally)
def load_llm(max_tokens, prompt_template):
    llm = CTransformers(
        model="llama-2-7b-chat.ggmlv3.q8_0.bin",  # Replace with your model name
        model_type="llama",
        max_new_tokens=max_tokens,
        temperature=0.7
    )
    llm_chain = LLMChain(llm=llm, prompt=PromptTemplate.from_template(prompt_template))
    return llm_chain

# Pre-load model and prompt template on application startup (optional)
llm_chain = None

@app.route("/")
def index():
    global llm_chain  # Access the global variable if pre-loaded
    if llm_chain is None:
        # Load model and prompt template if not already done
        max_tokens = 150
        prompt_template = "Write a random sentence that starts with the following letters: {first_letters}"
        llm_chain = load_llm(max_tokens, prompt_template)
    return "Acronym Generator is Ready!"  # Placeholder response

@app.route("/generate", methods=["POST"])
def generate():
    input_text = request.json.get("text")
    if not input_text:
        return jsonify({"error": "Missing input text"}), 400

    try:
        # Extract first letters
        first_letters = "".join([word[0] for word in input_text.split()])

        # Generate text using LLMChain
        result = llm_chain(first_letters)
        if not result:
            return jsonify({"error": "Sentence generation failed"}), 500

        return jsonify({"sentence": result["text"]})
    except Exception as e:
        return jsonify({"error": str(e)}), 500

if __name__ == "__main__":
    app.run(debug=True)
