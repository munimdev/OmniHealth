import 'package:flutter/material.dart';
import '../constants/constants.dart';

class InputField extends StatefulWidget {
  final TextEditingController inputController;
  bool? obscureText = false;
  Icon? prefixIcon;

  InputField({required this.inputController, Key? key}) : super(key: key);

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
          controller: widget.inputController,
          autofocus: false,
          validator: (input) => input!.isValidEmail() ? null : "Check your email",
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
    );;
  }
}

String? emailValidator(String fieldContent) { //<-- add String? as a return type
  if (fieldContent != null) {
    if (fieldContent.contains('@') && fieldContent.endsWith('.com')) {
      return null;
    }
    return 'Enter a Valid Email Address';
  }
}

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}

String? passwordValidator(String fieldContent) { //<-- add String? as a return type
  if(fieldContent.isEmpty) {
    return 'Enter a valid password';
  }
  return null;
}
