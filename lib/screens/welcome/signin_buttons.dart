import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../auth.dart';
import '../../constants/constants.dart';
import '../login/login_screen.dart';
import '../signup/input_phone.dart';
import '../signup/user_info.dart';
import '../signup/input_email.dart';
import '../home/home.dart';

class SigninButtons extends StatefulWidget {
  const SigninButtons({Key? key}) : super(key: key);

  @override
  State<SigninButtons> createState() => _SigninButtonsState();
}

class _SigninButtonsState extends State<SigninButtons> {
  final AuthService _auth = AuthService();
  bool _isSigningIn = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.only(
              left: 30, right: 30, bottom: 16.0, top: 30.0),
          child: SizedBox(
            height: 50,
            child: Material(
              elevation: 5.0,
              color: signupButtonColor,
              borderRadius: BorderRadius.circular(40),
              child: MaterialButton(
                onPressed: () async {
                  // setState(() {
                  //   _isSigningIn = true;
                  // });
                  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
                    statusBarColor: Colors.grey[50],
                  ));
                  // dynamic user = await _auth.signInWithGoogle(context: context);
                  // if(user != null) {
                  getData();
                  await Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            InputPhone(),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          const begin = Offset(1.0, 0.0);
                          const end = Offset.zero;
                          const curve = Curves.ease;

                          var tween = Tween(begin: begin, end: end)
                              .chain(CurveTween(curve: curve));

                          return SlideTransition(
                            position: animation.drive(tween),
                            child: child,
                          );
                        },
                      ));
                  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
                    statusBarColor: Color(0x7063666A),
                  ));
                  // }
                  // setState(() {
                  //   _isSigningIn = false;
                  // });
                },
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: Row(
                    // mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      const Icon(
                        Icons.phone,
                        color: Colors.white,
                        size: 25.0,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 27, right: 10),
                        child: const Text(
                          'Sign Up with Phone',
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Outfit',
                            color: Colors.white,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 16.0),
          child: SizedBox(
            height: 50,
            child: Material(
              elevation: 5.0,
              color: signupButtonColor,
              borderRadius: BorderRadius.circular(40),
              child: MaterialButton(
                onPressed: () async {
                  // setState(() {
                  //   _isSigningIn = true;
                  // });

                  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
                    statusBarColor: Colors.grey[50],
                  ));
                  // dynamic user = await _auth.signInWithGoogle(context: context);
                  // if(user != null) {
                  await Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            UserInfoScreen(),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          const begin = Offset(1.0, 0.0);
                          const end = Offset.zero;
                          const curve = Curves.ease;

                          var tween = Tween(begin: begin, end: end)
                              .chain(CurveTween(curve: curve));

                          return SlideTransition(
                            position: animation.drive(tween),
                            child: child,
                          );
                        },
                      ));
                  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
                    statusBarColor: Color(0x7063666A),
                  ));
                  // }
                  // setState(() {
                  //   _isSigningIn = false;
                  // });
                },
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: Row(
                    // mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      const Icon(
                        Icons.mail,
                        color: Colors.white,
                        size: 25.0,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 27, right: 10),
                        child: const Text(
                          'Sign Up with Email',
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Outfit',
                            color: Colors.white,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        Row(children: <Widget>[
          Expanded(
            child: Container(
                margin: const EdgeInsets.only(left: 35.0, right: 15.0),
                child: const Divider(
                  color: Colors.black,
                  height: 36,
                )),
          ),
          const Text("OR",
              style: TextStyle(
                  color: Colors.grey,
                  decoration: TextDecoration.none,
                  fontSize: 16,
                  fontWeight: FontWeight.w300)),
          Expanded(
            child: Container(
                margin: const EdgeInsets.only(left: 15.0, right: 35.0),
                child: const Divider(
                  color: Colors.black,
                  height: 36,
                )),
          ),
        ]),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
          child: Material(
            elevation: 5.0,
            borderRadius: BorderRadius.circular(30.0),
            color: Theme.of(context).primaryColor,
            child: SizedBox(
              height: 50.0,
              child: MaterialButton(
                minWidth: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                onPressed: () async {
                  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
                    statusBarColor: Colors.grey[50],
                  ));
                  await Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            LoginScreen(),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          const begin = Offset(1.0, 0.0);
                          const end = Offset.zero;
                          const curve = Curves.ease;

                          var tween = Tween(begin: begin, end: end)
                              .chain(CurveTween(curve: curve));

                          return SlideTransition(
                            position: animation.drive(tween),
                            child: child,
                          );
                        },
                      ));
                  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
                    statusBarColor: Color(0x7063666A),
                  ));
                },
                child: Text(
                  "Log In",
                  style: TextStyle(color: Theme.of(context).primaryColorLight),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

//function to fetch data from cloud firestore
getData() async {
  final databaseReference = FirebaseFirestore.instance;
  databaseReference
      .collection('patients')
      .get()
      .then((QuerySnapshot querySnapshot) {
    print(querySnapshot.docs.first.data());
  });
}






// class SigninButton extends StatefulWidget {
//
//   final Color backgroundColor;
//   final String buttonText;
//   final buttonIcon;
//   final String buttonNavigation;
//   final dynamic? onPressFunction;
//
//   SigninButton(
//       this.backgroundColor,
//       this.buttonText,
//       this.buttonIcon,
//       this.buttonNavigation,
//       this.onPressFunction);
//
//   @override
//   State<SigninButton> createState() => _SigninButtonState();
// }
//
// class _SigninButtonState extends State<SigninButton> {
//
//   bool _isSigningIn = false;
//   final AuthService _auth = AuthService();
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 16.0),
//       child: _isSigningIn ?
//       CircularProgressIndicator(
//         valueColor: AlwaysStoppedAnimation<Color>(widget.backgroundColor),
//       )
//           : Padding(
//         padding: const EdgeInsets.only(left: 30, right: 30),
//         child: SizedBox(
//           height: 50.0,
//           child: ElevatedButton(
//             style: ButtonStyle(
//               backgroundColor: MaterialStateProperty.all(widget.backgroundColor),
//               elevation: MaterialStateProperty.all<double>(
//                   5.0
//               ),
//               shape: MaterialStateProperty.all(
//                 RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(40),
//                 ),
//               ),
//             ),
//             onPressed: () async {
//               setState(() {
//                 _isSigningIn = true;
//               });
//
//               dynamic user = await widget.onPressFunction();
//               if(user != null) {
//                 print("Signed in to Google");
//                 Navigator.pushNamed(
//                   context,
//                   widget.buttonNavigation,
//                 );
//               }
//               setState(() {
//                 _isSigningIn = false;
//               });
//             },
//             child: Padding(
//               padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
//               child: Row(
//                 // mainAxisSize: MainAxisSize.max,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//                   widget.buttonIcon,
//                   Padding(
//                     padding: const EdgeInsets.only(left: 10, right: 10),
//                     child: Text(
//                       widget.buttonText,
//                       style: TextStyle(
//                         fontSize: 18,
//                         color: Colors.white,
//                         fontWeight: FontWeight.w300,
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
