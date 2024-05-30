import 'package:finance_app/common/extension/space_extension.dart';
import 'package:finance_app/common/theme/style/text_style.dart';
import 'package:finance_app/common/widget/common_button.dart';
import 'package:finance_app/view/onboard/controller/onboard_controller.dart';
import 'package:finance_app/view/onboard/pages/sign_up_page.dart';
import 'package:finance_app/view/onboard/widgets/onboard_text_field.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatelessWidget {
  static const String route = "/loginPageRoute";

  final _controller = OnBoardController();

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(scrolledUnderElevation: 0),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
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
                "WELCOME BACK",
                style: boldTextStyle.copyWith(fontSize: 30, color: Colors.blue),
              ),
              Text(
                "Please Login To Your Account",
                style: lightTextStyle.copyWith(
                  color: Colors.grey,
                  fontStyle: FontStyle.italic,
                ),
              ),
              20.ph,
              OnBoardTextField(
                controller: _controller.email,
                keyboardType: TextInputType.emailAddress,
                hintText: "Email",
                validator: _controller.emailValidator,
              ),
              20.ph,
              OnBoardTextField(
                controller: _controller.password,
                hintText: "Password",
                obscureText: true,
                validator: _controller.loginPasswordValidator,
              ),
              50.ph,
              CommonButton(
                onPressed: () {
                  _controller.login();
                },
                text: "Login",
              ),
              50.ph,
              GestureDetector(
                onTap: () {
                  context.push(SignUpPage.route);
                },
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "Don't Have An Account? ",
                        style: lightTextStyle.copyWith(
                          color: Colors.grey,
                        ),
                      ),
                      TextSpan(
                        text: "Sign Up Here",
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
