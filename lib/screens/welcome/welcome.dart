import 'package:flutter/material.dart';

import './welcome_image.dart';
import './signin_overlay.dart';
import '../../login.dart';
import '../../constants/constants.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
    Widget build(BuildContext context) {
      return SafeArea(
        child: Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const WelcomeImage(),
              SigninOverlay(),
            ],
          ),
        ),
      );
    }
  }
