import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../utils/login_info.dart';
import '../../loginuser.dart';
import '../../auth.dart';
import '../../constants/constants.dart';

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

    final emailField = Container(
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
            color: inputFieldBoxShadowColor,
            blurRadius: inputFieldBlurRadius,
            offset: inputFieldShadowOffset,
          ),
        ],
        borderRadius: BorderRadius.circular(
          inputFieldBorderRadius,
        ),
      ),
      child: TextFormField(
          controller: _email,
          autofocus: false,
          validator: (value) {
            if (value != null) {
              if (value.contains('@') && value.endsWith('.com')) {
                return null;
              }
              return 'Enter a Valid Email Address';
            }
          },
          cursorColor: inputFieldFocusedColor,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            // hintText: "Email",
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(inputFieldBorderRadius)),
            prefixIcon: Icon(Icons.mail),
            labelText: "Email",
            labelStyle: TextStyle(
              color: inputFieldFocusedColor,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(inputFieldBorderRadius),
              borderSide: const BorderSide(
                color: inputFieldEnabledColor,
                width: inputFieldBorderWidth,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(inputFieldBorderRadius),
              borderSide: const BorderSide(
                color: inputFieldFocusedColor,
                width: inputFieldBorderWidth,
              ),
            ),
          )
      ),
    );


    final passwordField = Container(
        decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
              color: inputFieldBoxShadowColor,
              blurRadius: inputFieldBlurRadius,
              offset: inputFieldShadowOffset,
            ),
          ],
          borderRadius: BorderRadius.circular(
            inputFieldBorderRadius,
          ),
        ),
        child: TextFormField(
          obscureText: _obscureText,
          controller: _password,
          autofocus: false,
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'This field is required';
            }
            if (value.trim().length < 8) {
              return 'Password must be at least 8 characters in length';
            }
            // Return null if the entered password is valid
            return null;
          },
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            // hintText: "Password",
            prefixIcon: Icon(Icons.lock),
            labelText: "Password",
            labelStyle: TextStyle(
              color: inputFieldFocusedColor,
            ),
            suffixIcon: IconButton(
              icon:
              Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
              onPressed: () {
                setState(() {
                  _obscureText = !_obscureText;
                });
              },
            ),

            border: OutlineInputBorder(borderRadius: BorderRadius.circular(inputFieldBorderRadius)),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(inputFieldBorderRadius),
              borderSide: const BorderSide(
                color: inputFieldEnabledColor,
                width: inputFieldBorderWidth,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(inputFieldBorderRadius),
              borderSide: const BorderSide(
                color: inputFieldFocusedColor,
                width: inputFieldBorderWidth,
              ),
            ),
          ),
        )
    );

    final txtbutton = TextButton(
        onPressed: () {

        },
        child: const Text('New? Register here'));

    final loginEmailPasswordButon =
    Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(50.0),
      color: Theme.of(context).primaryColor,
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
          style: TextStyle(color: Theme.of(context).primaryColorLight),
          textAlign: TextAlign.center,
        ),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.grey[50],
        foregroundColor: Colors.black,
        elevation: 0,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              tooltip: "Back",
              icon: const Icon(Icons.arrow_back_ios_new, size: 17,), // Put icon of your preference.
              onPressed: () {
                Navigator.pop(context);
              },
            );
          },
        ),
      ),
      body: Center(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  emailField,
                  const SizedBox(height: 25.0),
                  passwordField,
                  txtbutton,
                  const SizedBox(height: 35.0),
                  loginEmailPasswordButon,
                ],
              ),
            ),
          )
      ),
    );;
  }
}