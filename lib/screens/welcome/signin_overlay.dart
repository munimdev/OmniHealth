import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../auth.dart';
import '../../constants/constants.dart';
import './signin_buttons.dart';

class SigninOverlay extends StatelessWidget {

  final AuthService _auth = AuthService();
  SigninOverlay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      transform: Matrix4.translationValues(0.0, -45.0, 0.0),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(50.0)),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 30.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(
                  Icons.health_and_safety_outlined,
                  color: appPrimaryColor,
                  size: 32,
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  "OmniHealth",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 32,
                    fontFamily: defaultFontFamily,
                    decoration: TextDecoration.none,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          const SigninButtons(),
        ],
      ),
    );
  }
}
