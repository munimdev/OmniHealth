import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/services.dart';

import '../../auth.dart';
import '../../constants/constants.dart';
import '../../login.dart';
import '../home/home.dart';

class SigninButtons extends StatefulWidget {

  const SigninButtons({Key? key}) : super(key: key);

  @override
  State<SigninButtons> createState() => _SigninButtonsState();
}

class _SigninButtonsState extends State<SigninButtons> {

  bool _isSigningIn = false;
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 16.0, top: 30.0),
          child: _isSigningIn ?
            const CircularProgressIndicator(
              valueColor: const AlwaysStoppedAnimation<Color>(const Color(0xFF19768F)),
            )
              : Padding(
                padding: const EdgeInsets.only(left: 30, right: 30),
                child: SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      elevation: MaterialStateProperty.all<double>(
                        5.0
                      ),
                      backgroundColor: MaterialStateProperty.all(signupButtonColor),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40),
                        ),
                      ),
                    ),
                    onPressed: () async {
                      setState(() {
                        _isSigningIn = true;
                      });

                      dynamic user = await _auth.signInWithGoogle(context: context);
                      if(user != null) {
                        print("Signed in to Google");
                        Navigator.pushNamed(
                          context,
                          '/home'
                        );
                      }
                      setState(() {
                        _isSigningIn = false;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                      child: Row(
                        // mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          SvgPicture.asset(
                            'assets/icons/google.svg',
                            height: 20.0,
                            color: Colors.white,
                            width: 20.0,
                          ),
                          const Padding(
                            padding: EdgeInsets.only(left: 27, right: 10),
                            child: Text(
                              'Sign Up with Google',
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
        Container(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: _isSigningIn ?
            const CircularProgressIndicator(
              valueColor: const AlwaysStoppedAnimation<Color>(const Color(0xFF19768F)),
            )
                : Padding(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: SizedBox(
                height: 50,
                child: ElevatedButton(
                  style: ButtonStyle(
                    elevation: MaterialStateProperty.all<double>(
                        5.0
                    ),
                    backgroundColor: MaterialStateProperty.all(signupButtonColor),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40),
                      ),
                    ),
                  ),
                  onPressed: () async {
                    setState(() {
                      _isSigningIn = true;
                    });

                    dynamic user = await _auth.signInWithGoogle(context: context);
                    if(user != null) {
                      print("Signed in to Google");
                      Navigator.pushNamed(
                          context,
                          '/home'
                      );
                    }
                    setState(() {
                      _isSigningIn = false;
                    });
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
        ),
        Row(
            children: <Widget>[
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
                  fontWeight: FontWeight.w300
                )
              ),
              Expanded(
                child: Container(
                    margin: const EdgeInsets.only(left: 15.0, right: 35.0),
                    child: const Divider(
                      color: Colors.black,
                      height: 36,
                    )),
              ),
            ]
        ),
        Container(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
            child: Material(
              elevation: 5.0,
              borderRadius: BorderRadius.circular(30.0),
              color: Theme.of(context).primaryColor,
              child: MaterialButton(
                minWidth: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                onPressed: () async {
                  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
                    statusBarColor: Colors.white,
                  ));
                  await Navigator.pushNamed(
                      context,
                      '/login'
                  );
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
