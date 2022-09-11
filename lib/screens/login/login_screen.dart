import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../utils/login_info.dart';
import '../../loginuser.dart';
import '../../auth.dart';
import '../../constants/constants.dart';
import '../../utils/input_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  bool _obscureText = true;
  final _email = TextEditingController();
  final _password = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {

    final emailField = InputField(inputController: TextEditingController(), headingText: 'Email', obscureText: false, isPasswordField: false, labelText: '',);

    final testPassword = InputField(inputController: TextEditingController(), headingText: 'Password', obscureText: true, isPasswordField: true, labelText: '',);

    final loginEmailPasswordButon =
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
              dynamic result = await _auth.signInEmailPassword(
                  LoginUser(email: _email.text, password: _password.text));
              if (result.uid == null) {
                //null means unsuccessfull authentication
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        content: Text(result.code),
                      );
                    });
              }
              else {
                String? emailAddress;

                _auth.getCurrentUserEmail().then(
                    (value) => emailAddress = value
                );

                print(emailAddress);
                Navigator.pushNamed(
                    context,
                    '/home',
                    arguments: LoginInfo(email: emailAddress)
                );
              }
            }
          },
          child: Text(
            "Sign in",
            style: TextStyle(color: Theme.of(context).primaryColorLight, fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.grey[50],
        foregroundColor: Colors.black,
        elevation: 0,
        leading: scaffoldBackButton,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          omniHealthHeading,
            const Text(
              "Login to your account!",
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
                  "Don't have an account?",
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
                  "Register!",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    fontFamily: defaultFontFamily,
                    decoration: TextDecoration.none,
                    color: inputFieldHeadingColor,
                  ),
                ),)
              ],
            ),
            Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                emailField,
                const SizedBox(height: 25.0),
                testPassword,
                const SizedBox(height: 35.0),
                loginEmailPasswordButon,
              ],
            ),
          ),]
        ),
      ),
    );;
  }
}