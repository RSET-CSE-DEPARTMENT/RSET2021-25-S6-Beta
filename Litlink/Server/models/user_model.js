const mongoose = require('mongoose');
const bcrypt = require("bcrypt");
const jwt = require("jsonwebtoken");
//schema definition for the collection
const userSchema = new mongoose.Schema({

    username: {
        type: String,
        require: true,
        unique: true,
    },

    password: {
        type: String,
        require: true,
    },

    emailid: {
        type: String,
        require: true,
    },

    phone:{
        type: String,
        require: true
    }

});

userSchema.pre("save", async function(){
    const user = this;
    console.log("Actual Data ", this);

    if(!user.isModified("password")){   //Checks if the password has been modified
        return next();  //if yes then move to next middleware
    }

    try {
        const saltRound = await bcrypt.genSalt(10); //10 Rounds of hashing
        const hashPassword = await bcrypt.hash(user.password, saltRound);

        user.password = hashPassword;
    } catch (error) {
        return next(error);
    }
}
);

userSchema.methods.generateToken = async function(){
    try {
        return jwt.sign(
            {
                userId: this._id.toString(),
                email: this.emailid,
            },

            process.env.TOKEN_SECKEY, //Digital Signature

            {
                expiresIn: "7d", //Time after which the token expires
            }
        );
    } catch (error) {
        console.error(error);
    }
}

userSchema.methods.comparePassword = async function(password){
    try {
        
        return bcrypt.compare(password, this.password);

    } catch (error) {
        console.error(error);
    }
}

const User = new mongoose.model('User',userSchema);
module.exports = User;