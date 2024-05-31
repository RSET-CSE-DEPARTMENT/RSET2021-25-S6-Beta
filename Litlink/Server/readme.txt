get :- to read data
post :- Insert data

Architecture used :- MVC {Model,View,Controller }

server.js :- Main server file
auth-router.js :- Routing handler
auth-controller :- Controller file {Contains all the Logic}
console.log(req.body) :- gives access to the information in the body.

packages installed :- bcrypt, dotenv, express, mongoose, nodemon, jsonwebtoken, zod

next() :- Call back fuction that is used to pass control to the next middleware function in the chain.

next(error) :- Pass error to the error handling middle ware.

Tutorial Code for Password Encryption in the controller file
    const saltRound=10; //Salt
    const hash_password = await bcrypt.hash(password, saltRound); //Hashing the Password
    const userCreated = await User.create({
            username,
            password: hash_password, //Assigning it to the password
            emailid,
            phone
    });

JWT is used for Authorization(Permisions) and Authentication(identify)

zod :- to create a middleware which checks that the valued entered by the user matches the defined schema



Atlas server password :- jk_litlink932

