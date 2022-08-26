import 'package:provider/provider.dart';
import 'screens/home/home.dart';
import 'package:flutter/material.dart';

import './screens/welcome/welcome.dart';
import './screens/welcome/welcome_image.dart';
import './firebaseuser.dart';
import './handler.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<FirebaseUser?>(context);

    if (user == null) {
      return WelcomeScreen();
    } else {
      return Home();
    }
  }
}
