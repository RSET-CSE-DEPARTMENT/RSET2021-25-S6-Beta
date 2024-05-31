import 'package:finance_app/common/extension/space_extension.dart';
import 'package:finance_app/common/theme/style/text_style.dart';
import 'package:finance_app/common/widget/common_button.dart';
import 'package:finance_app/view/onboard/controller/onboard_controller.dart';
import 'package:finance_app/view/onboard/widgets/onboard_text_field.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SignUpPage extends StatelessWidget {
  static const String route = "/signUpPageRoute";

  final _controller = OnBoardController();

  SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(scrolledUnderElevation: 0),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: _controller.formKey,
          child: Column(
            children: [
              Image.asset(
                "assets/logo.png",
                height: 200,
                width: 200,
                fit: BoxFit.cover,
              ),
              20.ph,
              Text(
                "SIGN UP",
                style: boldTextStyle.copyWith(fontSize: 30, color: Colors.blue),
              ),
              Text(
                "Create a free account here",
                style: lightTextStyle.copyWith(
                  color: Colors.grey,
                  fontStyle: FontStyle.italic,
                ),
              ),
              20.ph,
              OnBoardTextField(
                controller: _controller.name,
                textCapitalization: TextCapitalization.words,
                hintText: "Enter Your Name",
                validator: _controller.nameValidator,
              ),
              20.ph,
              OnBoardTextField(
                controller: _controller.email,
                keyboardType: TextInputType.emailAddress,
                hintText: "Enter Your Email",
                validator: _controller.emailValidator,
              ),
              20.ph,
              OnBoardTextField(
                controller: _controller.password,
                hintText: "Enter Your Password",
                obscureText: true,
                validator: _controller.signUpPasswordValidator,
              ),
              20.ph,
              OnBoardTextField(
                controller: _controller.confirmPassword,
                hintText: "Confirm Your Password",
                obscureText: true,
                validator: _controller.confirmPasswordValidator,
              ),
              50.ph,
              CommonButton(
                onPressed: () {
                  _controller.signUp();
                },
                text: "Sign Up",
              ),
              50.ph,
              GestureDetector(
                onTap: () {
                  context.pop();
                },
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "Already Have An Account? ",
                        style: lightTextStyle.copyWith(
                          color: Colors.grey,
                        ),
                      ),
                      TextSpan(
                        text: "Sign In Here",
                        style: semiBoldTextStyle.copyWith(
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              50.ph,
            ],
          ),
        ),
      ),
    );
  }
}
