import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import './welcome_image.dart';
import './signin_overlay.dart';
import '../../login.dart';
import '../../constants/constants.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
    Widget build(BuildContext context) {

      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Color(0x7063666A),
      ));

      return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const WelcomeImage(),
                  SigninOverlay(),
                ],
              ),
            ),
          ],
        ),
      );
    }
  }
