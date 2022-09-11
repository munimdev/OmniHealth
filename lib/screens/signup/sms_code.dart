import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:omnihealth/firebaseuser.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../constants/constants.dart';
import '../home/home.dart';

class SMSCodeScreen extends StatefulWidget {
  final String phoneNumber;
  const SMSCodeScreen({Key? key, required this.phoneNumber}) : super(key: key);

  @override
  State<SMSCodeScreen> createState() => _SMSCodeScreenState();
}

class _SMSCodeScreenState extends State<SMSCodeScreen> {
  StreamController<ErrorAnimationType> errorController = StreamController<ErrorAnimationType>();
  bool hasError = false;
  String currentText = "";
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  String verifyID = "";

  @override
  initState() {
    print("Initing state");
    sendSMS();
  }

  sendSMS() async {
    print("Sending SMS to "+widget.phoneNumber);
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: widget.phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await _auth.signInWithCredential(credential).then( (UserCredential result) => {

        });
      },
      verificationFailed: (FirebaseAuthException e) {},
      codeSent: (String verificationId, int? resendToken) async {
        verifyID = verificationId;
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.grey[50],
        foregroundColor: Colors.black,
        elevation: 0,
        leading: scaffoldBackButton,
      ),
      body: Container(
        child: Column(
          children: [
            const Center(child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 25),
                child: Text(
                  "Verify your mobile number",
                  style: TextStyle(
                    fontSize: 24
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20.0,),
            Center(child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Text("You will receive a message with a verification pin on ${widget.phoneNumber}",
                  style: const TextStyle(
                    fontSize: 15,
                    color: Colors.grey,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35.0),
              child: PinCodeTextField(
                backgroundColor: Colors.grey[50],
                length: 6,
                obscureText: false,
                animationType: AnimationType.fade,
                animationDuration: const Duration(milliseconds: 300),
                keyboardType: TextInputType.number,
                errorAnimationController: errorController, // Pass it here
                pinTheme: PinTheme(
                  activeColor: Colors.grey,
                  inactiveColor: Colors.grey,
                  selectedColor: Colors.black
                ),
                onChanged: (value) {
                  setState(() {
                    currentText = value;
                    print("Value is "+currentText);
                  });
                },
                onCompleted: (value) async {
                  print("Completed");
                  // Create a PhoneAuthCredential with the code
                  AuthCredential credential = PhoneAuthProvider.credential(verificationId: verifyID, smsCode: currentText);

                  // Sign the user in (or link) with the credential
                  await _auth.signInWithCredential(credential).then((UserCredential result) async => {
                    await Navigator.pushAndRemoveUntil(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation, secondaryAnimation) => Home(),
                          transitionsBuilder: (context, animation, secondaryAnimation, child) {
                            const begin = Offset(1.0, 0.0);
                            const end = Offset.zero;
                            const curve = Curves.ease;

                            var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                            animation = CurvedAnimation(parent: animation, curve: curve);
                            return FadeTransition(
                              opacity: animation,
                              child: child,
                            );
                          },
                        ),
                        ModalRoute.withName('/')
                    )
                  }) ;
                },
                appContext: context,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Didn't receive the code? ",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey,
                  ),
                  textAlign: TextAlign.center,
                ),
                TextButton(
                  onPressed: () {  },
                  child: const Text("Resend",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ],
        )
      ),
    );
  }
}
