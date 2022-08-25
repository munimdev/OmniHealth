import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

import './auth.dart';
import './firebaseuser.dart';
import './wrapper.dart';

const appPrimaryColor = Color(0xFF19768F);
const appAccentColor = Color(0xFFFFFFFF);

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
          fontFamily: 'Outfit',
          textTheme: const TextTheme(
            headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
            headline6: TextStyle(fontSize: 20.0, fontStyle: FontStyle.italic),
            bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
          ),
        ),
        home: Wrapper(),
      ),
    );
  }
}
