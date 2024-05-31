const mongoose = require("mongoose"); //mongoose import

// const URI = "mongodb://127.0.0.1:27017/admin" //URL for from mongosh shell for example
const URI = 'mongodb+srv://yaswanth_jk:jk_litlink932@cluster0.pn3wavp.mongodb.net/'; //.env call to get the sensitive information from the .env file
//connection from the database is secured

// const connectDb = async() => {
//     try {
//         await mongoose.connect(URI);
//         console.log("Database connection succesfull !!");
//     } catch (error) {
//         console.error("Database connection failed.", error);
//         process.exit(0);
//     }
// };

async function connectDb() {
    try {
        await mongoose.connect(URI);
        console.log('Connected to MongoDB');
    } catch (error) {
        console.error('MongoDB connection error:', error);
    }
}

module.exports = connectDb;