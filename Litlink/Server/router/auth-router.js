const express = require("express");
const router = express.Router();
const controllers = require("../controllers/controller");
const signupSchema = require("../validators/validators");
const validate = require("../middlewares/validate-middleware");

router.route("/").get(controllers.home);
router
    .route("/register")
    .post(validate(signupSchema), controllers.register);
router.route("/login").post(controllers.login);

module.exports=router;