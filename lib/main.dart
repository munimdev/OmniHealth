import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

import './auth.dart';
import './login.dart';
import './firebaseuser.dart';
import './wrapper.dart';
import './constants/constants.dart';

import './screens/login/login_screen.dart';
import './screens/home/home.dart';
import './screens/welcome/welcome.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<FirebaseUser?>.value(
      value: AuthService().user,
      initialData: null,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          // When navigating to the "/" route, build the WelcomeScreen widget.
          '/': (context) => const WelcomeScreen(),
          '/login': (context) => LoginScreen(),
          // When navigating to the "/home" route, build the Home widget.
          '/home': (context) => Home(),
        },
        theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: appPrimaryColor,
          primaryColorLight: Colors.white,

          buttonTheme: ButtonThemeData(
            buttonColor: appPrimaryColor,
            textTheme: ButtonTextTheme.primary,
            colorScheme:
                Theme.of(context).colorScheme.copyWith(secondary: Colors.white),
          ),
          inputDecorationTheme: const InputDecorationTheme(
            filled: true,
            fillColor: inputFieldBackground,
            focusColor: inputFieldBackground,

            iconColor: inputFieldIconColor,
            prefixIconColor: inputFieldIconColor,
            contentPadding: EdgeInsets.symmetric(
                horizontal: 10.0, vertical: 10.0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(30)),
              borderSide: BorderSide.none,
            ),
          ),
          fontFamily: 'Outfit',
          textTheme: const TextTheme(
            headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
            headline6: TextStyle(fontSize: 20.0, fontStyle: FontStyle.italic),
            bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
          ),
        ),
        // home: Wrapper(),
      ),
    );
  }
}
