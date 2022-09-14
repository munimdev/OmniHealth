import 'package:flutter/material.dart';
import 'package:omnihealth/screens/signup/personal_information.dart';

import '../../constants/constants.dart';
import '../../utils/input_field.dart';

class UserInfoScreen extends StatelessWidget {
  UserInfoScreen({Key? key}) : super(key: key);

  final TextEditingController _firstName = TextEditingController();
  final TextEditingController _lastName = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _firstName.dispose();
    _lastName.dispose();
    _email.dispose();
    _password.dispose();
    _confirmPassword.dispose();
  }

  String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }
    return null;
  }

  //validate user name
  String? nameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a name';
    }
    return null;
  }

  //validate if user entered a valid email
  String? emailValidator(String? value) {

    if (
    RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$'
    ).hasMatch(value!)) {
      return null;
    }
    return "Please enter a valid email address";
  }

  //validate confirm password
  String? confirmPasswordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }
    if (value != _password.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.grey[50],
        foregroundColor: Colors.black,
        elevation: 0,
        leading: scaffoldBackButton,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 0.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              omniHealthHeading,
              const Text(
                "Create your account!",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  fontFamily: defaultFontFamily,
                  decoration: TextDecoration.none,
                  color: inputFieldHeadingColor,
                ),
              ),
              Row(
                children: [
                  const Text(
                    "Already have an account?",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      fontFamily: defaultFontFamily,
                      decoration: TextDecoration.none,
                      color: inputFieldHeadingColor,
                    ),
                  ),
                  TextButton(
                    onPressed: () { },
                    child: const Text(
                      "Sign in!",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        fontFamily: defaultFontFamily,
                        decoration: TextDecoration.none,
                        color: inputFieldHeadingColor,
                      ),
                    ),
                  ),
                  ],
                ),
                InputField(inputController: _firstName, headingText: 'First Name', obscureText: false, isPasswordField: false, labelText: '', validator: nameValidator, capitalizeFirstLetter: true),
                const SizedBox(height: 20.0),
                InputField(inputController: _lastName, headingText: 'Last Name', obscureText: false, isPasswordField: false, labelText: '', validator: nameValidator, capitalizeFirstLetter: true),
                const SizedBox(height: 20.0),
                InputField(inputController: _email, headingText: 'Email', obscureText: false, isPasswordField: false, labelText: '', validator: emailValidator,),
                const SizedBox(height: 20.0),
                InputField(inputController: _password, headingText: 'Password', obscureText: false, isPasswordField: false, labelText: '', validator: passwordValidator,),
                const SizedBox(height: 20.0),
                InputField(inputController: _confirmPassword, headingText: 'Confirm Password', obscureText: false, isPasswordField: false, labelText: '', validator: confirmPasswordValidator,),
                const SizedBox(height: 35.0),
                Material(
                  elevation: 5.0,
                  borderRadius: BorderRadius.circular(50.0),
                  color: Theme.of(context).primaryColor,
                  child: SizedBox(
                    height: 50.0,
                    child: MaterialButton(
                      minWidth: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      onPressed: () async {
                        FocusScope.of(context).unfocus();
                        if (_formKey.currentState!.validate()) {
                          await Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder: (context, animation, secondaryAnimation) => PersonalInformation(),
                                transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                  const begin = Offset(1.0, 0.0);
                                  const end = Offset.zero;
                                  const curve = Curves.ease;

                                  var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

                                  return SlideTransition(
                                    position: animation.drive(tween),
                                    child: child,
                                  );
                                },
                              )
                          );
                        }

                      },
                      child: Text(
                        "Next",
                        style: TextStyle(color: Theme.of(context).primaryColorLight, fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

