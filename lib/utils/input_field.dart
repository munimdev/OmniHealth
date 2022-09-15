import 'package:flutter/material.dart';
import '../constants/constants.dart';

class InputField extends StatefulWidget {
  final TextEditingController inputController;
  String? labelText = '';
  String headingText;
  dynamic? suffixIcon;
  bool obscureText = false;
  bool? isPasswordField = false;
  bool? capitalizeFirstLetter = false;
  Icon? prefixIcon;
  String? Function(String?)? validator;

  InputField({required this.inputController, required this.headingText, required this.obscureText, this.labelText,this.isPasswordField, this.prefixIcon=const Icon(null), this.suffixIcon=const Icon(null), this.validator, this.capitalizeFirstLetter, Key? key}) : super(key: key);

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {

  bool hasUserClicked = false;
  bool inputFieldErrorMessage() {
    return hasUserClicked && widget.validator!(widget.inputController.text) != null;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: Text(
            widget.headingText,
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: inputFieldHeadingColor,
            ),
          ),
        ),
        Material(
          color: Colors.transparent,
          child: Container(
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
                obscureText: widget.obscureText,
                textCapitalization: widget.capitalizeFirstLetter == true ? TextCapitalization.sentences : TextCapitalization.none,
                validator: widget.validator,
                cursorColor: inputFieldFocusedColor,
                textInputAction: TextInputAction.next,
                decoration: inputFieldDecoration.copyWith(
                  // prefixIcon: widget.prefixIcon,
                  suffixIcon: widget.isPasswordField! ? IconButton(
                    icon: Icon(widget.obscureText ? Icons.visibility : Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        widget.obscureText = !widget.obscureText;
                      });
                    },
                  ) : widget.suffixIcon,
                  labelText: widget.labelText,
                  //!! Hide the default error message here
                  errorStyle: TextStyle(fontSize: 0),

                ),
              onTap: () {
                if(!hasUserClicked) {
                  setState(() {
                    hasUserClicked = true;
                  });
                }
              },
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: inputFieldErrorMessage() ? 15.0 : 0, top: inputFieldErrorMessage() ? 5.0 : 0),
          child: Text(
            widget.validator != null ? widget.validator!(widget.inputController.text) ?? '' : '',
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: inputFieldErrorMessage() ? 12 : 0,
              fontWeight: FontWeight.w400,
              color: Colors.red,
            ),
          ),
        ),
      ],
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
