import 'package:flutter/material.dart';
import 'package:omnihealth/screens/welcome/signin_overlay.dart';
import '../../constants/constants.dart';

const defaultPadding = 15.0;

class WelcomeImage extends StatelessWidget {
  const WelcomeImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        ColorFiltered(
          colorFilter: ColorFilter.mode(
            Color(0xFFCEDEB9),
            BlendMode.softLight
          ),
          child: Image(image: AssetImage('assets/images/landing-bg.jpg'))
      ),
        const Padding(
          padding: EdgeInsets.only(left: 25, top: 55),
          child: Text("Making healthcare easy",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 55,
                fontFamily: defaultFontFamily,
                decoration: TextDecoration.none,
                color: primaryTextColor,
            ),
          ),
        ),
        Positioned(
          top: 380,
          width: MediaQuery.of(context).size.width,
          child: SigninOverlay(),
        ),
      ]
    );
  }
}

class SignUpIcon extends StatelessWidget {

  final Color fillColor;
  final Icon? insideIcon;
  final String iconText;

  const SignUpIcon(this.fillColor, this.insideIcon, this.iconText);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.0),
        child: Row(

        ),
      ),
    );
  }
}

