import 'package:flutter/material.dart';
import 'package:omnihealth/constants/constants.dart';

import '../../auth.dart';
import '../../Components/dashboard_widgets.dart';
import '../../Components/profile_card.dart';
import '../appointments/appointments.dart';
import '../testresults/test_results.dart';
import '../../models/patients.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Home();
  }
}

class _Home extends State<Home> {
  final AuthService _auth = new AuthService();

  @override
  Widget build(BuildContext context) {
    final SignOut = Container(
      color: kLightBlue,
      child: Column(
        children: [
          //Upper Bar
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ProfileCard(
                profilePicture: 'assets/images/man.jpg',
                username: 'john doe',
              ),
              Row(
                children: [
                  TextButton(
                    onPressed: () {},
                    child: const Icon(
                      Icons.menu,
                      color: kDarkest,
                      size: 30.0,
                    ),
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.zero),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      print('bell pressed');
                    },
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.zero),
                    ),
                    child: const Icon(
                      Icons.notifications,
                      color: kDarkest,
                      size: 30.0,
                    ),
                  ),
                ],
              )
            ],
          ),
          //Lower Widget
          Expanded(
            child: Container(
              width: double.infinity,
              margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
              decoration: const BoxDecoration(
                color: kMutedWidgetColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50.0),
                  topRight: Radius.circular(50.0),
                ),
              ),
              child: Column(
                children: [
                  const SizedBox(
                    height: 60,
                  ),
                  TextButton(
                    onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context){
                            return Appointments();
                          },
                        ),
                      );
                    },
                    child: const DashboardWidgetVertical(
                      icon: Icon(
                        Icons.event,
                        color: Colors.white,
                      ),
                      title: 'Appointments',
                    ),
                  ),
                  Row(
                    children: [
                      SizedBox(width: 10),
                      TextButton(
                        onPressed: (){},
                        child: const DashboardWidgetHorizontal(
                          title: 'Diagnosis\nDetails',
                          icon: Icon(
                            Icons.vaccines,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: (){},
                        child: const DashboardWidgetHorizontal(
                          title: 'Medical\nHistory',
                          icon: Icon(
                            Icons.timer,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context){
                                return TestResults();
                              }
                          ),
                      );
                    },
                    child: const DashboardWidgetVertical(
                      title: 'Test Results',
                      icon: Icon(
                        Icons.timeline,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: (){

                    },
                    child: const DashboardWidgetVertical(title: 'Complaints',
                      icon: Icon(Icons.article,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );

    return WillPopScope(
      onWillPop: () {
        return Future.value(false); // if true allow back else block it
      },
      child: Scaffold(
        body: Center(
          child: SignOut,
        ),
      ),
    );
  }
}
