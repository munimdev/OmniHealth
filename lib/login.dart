import './loginuser.dart';
import './auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import './constants/constants.dart';

class Login extends StatefulWidget {
  final Function? toggleView;
  Login({this.toggleView});

  @override
  State<StatefulWidget> createState() {
    return _Login();
  }
}

class _Login extends State<Login> {
  bool _obscureText = true;
  bool _isSigningIn = false;
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
          widget.toggleView!();
        },
        child: const Text('New? Register here'));

    final loginAnonymousButon = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Theme.of(context).primaryColor,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () async {
          dynamic result = await _auth.signInAnonymous();

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
        },
        child: Text(
          "Log in Anonymously",
          style: TextStyle(color: Theme.of(context).primaryColorLight),
          textAlign: TextAlign.center,
        ),
      ),
    );

    final loginEmailPasswordButon =
    Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Theme.of(context).primaryColor,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () async {
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
          }
        },
        child: Text(
          "Sign in",
          style: TextStyle(color: Theme.of(context).primaryColorLight),
          textAlign: TextAlign.center,
        ),
      ),
    );

    final googleSignInButton = Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: _isSigningIn
          ? const CircularProgressIndicator(
        valueColor: const AlwaysStoppedAnimation<Color>(const Color(0xFF19768F)),
      )
          : OutlinedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.white),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40),
            ),
          ),
        ),
        onPressed: () async {
          setState(() {
            _isSigningIn = true;
          });

          dynamic user = await _auth.signInWithGoogle(context: context);

          setState(() {
            _isSigningIn = false;
          });
        },
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              SvgPicture.asset(
              'assets/icons/google.svg',
              height: 20.0,
              width: 20.0,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  'Sign up with Google',
                  style: TextStyle(
                    fontSize: 18,
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    loginAnonymousButon,
                    const SizedBox(height: 45.0),
                    emailField,
                    const SizedBox(height: 25.0),
                    passwordField,
                    txtbutton,
                    const SizedBox(height: 35.0),
                    loginEmailPasswordButon,
                    const SizedBox(height: 15.0),
                    googleSignInButton,
                    const SizedBox(height: 15.0),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}