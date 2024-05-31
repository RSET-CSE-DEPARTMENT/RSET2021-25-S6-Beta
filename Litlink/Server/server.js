require("dotenv").config(); // to use dotenv and the env file created
const express = require("express"); //to use express
const app =  express(); //assigning express path
const router = require("./router/auth-router.js"); //importing routers
const connectDb = require("./utils/db.js"); //calling the database connection util file


const { PythonShell } = require('python-shell');

function loadModel() {
    const options = {
        mode: 'text',
        pythonOptions: ['-u'], // unbuffered output
        scriptPath: 'C:/mini/Server/python_script', // directory containing your Python script
        args: ['C:/mini/Server/ml_model/recommendation_system.pkl'] // path to your .pkl file
    };

    return new Promise((resolve, reject) => {
        PythonShell.run('load_model.py', options, function (err, result) {
            if (err) {
                console.error('Error loading model:', err);
                reject(err);
            } else {
                console.log('Model loaded successfully');
                resolve(result);
            }
        });
    });
}

// Example usage
loadModel()
    .then(model => {
        // Now you can use the model for making recommendations or other tasks
    })
    .catch(error => {
        console.error('Failed to load model:', error);
    });


app.use(express.json()); //allowing the transfer of JSON files, it is a middle ware.
app.use("/api/auth", router); //To use the router created


const PORT = 5000;


//Connect to the port only when the connection to the database is successfull
connectDb().then(() => {
    app.listen(PORT, () =>{
        console.log(`server is running at port : ${PORT}`);
    });
});