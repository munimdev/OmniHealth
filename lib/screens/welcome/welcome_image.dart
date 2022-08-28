import 'package:flutter/material.dart';
import '../../constants/constants.dart';

const defaultPadding = 15.0;

class WelcomeImage extends StatelessWidget {
  const WelcomeImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
        Stack(
          children: <Widget>[
            ColorFiltered(
              colorFilter: ColorFilter.mode(
                Color(0xFFCEDEB9),
                BlendMode.softLight
              ),
              child: Image(image: AssetImage('assets/images/landing-bg.jpg'))
          ),
            Padding(
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
          ]
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

