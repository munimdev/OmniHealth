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
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                      const Expanded(flex: 1, child: WelcomeImage()),
                      // Expanded(flex: 1, child: SigninOverlay()),
                ],
              ),
            ),
          ],
        ),
      );
    }
  }
