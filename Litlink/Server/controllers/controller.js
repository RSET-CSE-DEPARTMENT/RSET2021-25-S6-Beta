const User = require("../models/user_model");
const bcrypt = require("bcrypt");
const jwt = require("jsonwebtoken");

const home = async (req, res) => {
    try {
        res.status(200).send("Welcome to our home page using controller");
    } catch (error) {
        console.log(error);
    }
};

const register = async (req, res) => {
    try {
        console.log(req.body);
        const{username, password, emailid, phone} = req.body; //body for the POST
        const userExist = await User.findOne({emailid: emailid}); //Checking email duplicacy

        if(userExist){
            return res.status(400).json({msg: "Email Already Exists!!"}); //If the email exists then exit
            //status(400) :- Bad Request
            //status(200) :- OK
            //status(201) :- Created
            //status(500) :- Internal Server Error
            //status(401) :- Unauthorized Request
        }

        //Else the collection is created
        const userCreated = await User.create({username, password, emailid, phone});

        res.status(201).json({
            msg:"Registration Successfull",
            token:await userCreated.generateToken(), //Generates token for the Registration data
            userId: userCreated._id.toString(),
        });   //Reflected as a JSON message

    } catch (error) {
        res.status(500).json({msg: "Internal Server Error"});
    }

};

const login = async(req, res) => {
    try {
        const {emailid, password} = req.body;
        const userExist = await User.findOne({ emailid });

        if(!userExist){
            return res.status(400).json({message:"  Invalid Credentials"});
        }

        // const user = await bcrypt.compare(password, userExist.password);
        const user = await userExist.comparePassword(password);
        

        if(user){
            res.status(201).json({
                msg:"Login Successfull",
                token:await userExist.generateToken(), //Generates token for the Login data
                userId: userExist._id.toString(),
            });
        }
        else{
            res.status(401).json({message: "Invalid email or password"})
        }

    } catch (error) {
        res.status(500).json("Internal Server Error !!");
    }
}

module.exports = {home , register, login};