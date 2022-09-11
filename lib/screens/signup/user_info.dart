import 'package:flutter/material.dart';
import 'package:omnihealth/screens/signup/personal_information.dart';

import '../../constants/constants.dart';
import '../../utils/input_field.dart';

class UserInfoScreen extends StatelessWidget {
  UserInfoScreen({Key? key}) : super(key: key);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
                InputField(inputController: TextEditingController(), headingText: 'First Name', obscureText: false, isPasswordField: false, labelText: '',),
                const SizedBox(height: 20.0),
                InputField(inputController: TextEditingController(), headingText: 'Last Name', obscureText: false, isPasswordField: false, labelText: '',),
                const SizedBox(height: 20.0),
                InputField(inputController: TextEditingController(), headingText: 'Email', obscureText: false, isPasswordField: false, labelText: '',),
                const SizedBox(height: 20.0),
                InputField(inputController: TextEditingController(), headingText: 'Password', obscureText: false, isPasswordField: false, labelText: '',),
                const SizedBox(height: 20.0),
                InputField(inputController: TextEditingController(), headingText: 'Confirm Password', obscureText: false, isPasswordField: false, labelText: '',),
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

                        }
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
