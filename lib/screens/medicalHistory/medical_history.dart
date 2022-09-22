import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:omnihealth/constants/constants.dart';
import 'package:omnihealth/Components/universal_functions.dart';
class MedicalHistory extends StatefulWidget {
  const MedicalHistory({Key? key}) : super(key: key);

  @override
  State<MedicalHistory> createState() => _MedicalHistoryState();
}

class _MedicalHistoryState extends State<MedicalHistory> {
  DateTimeRange dateRange = DateTimeRange(start: DateTime(2020,1,1), end: DateTime.now());
  Color widgetColor = kMintGreen;
  Color widgetTextColor = kDarkest;
  bool visibility = true;
  Color hideButtonColor = kAccentColor;
  String hideButtonText = 'Hide';
  @override
  Widget build(BuildContext context) {
    final start = dateRange.start;
    String startMonthName = determineMonthName(start.month);
    final end = dateRange.end;
    String endMonthName = determineMonthName(end.month);
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            color: kBackgroundColor,
          ),
          child: Container(
            margin: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.fromLTRB(20, 25, 20, 5),
                  padding:
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        width: 1.0,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  child: const Text(
                    'Medical History',
                    style: kSmallGreenText,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 10, 10),
                  child: Text(
                    'Here you can view the history of all medical procedures that has been recorded by your doctors since joining this application.',
                    style: kMiniGreyText,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 10, 10),
                  child: Text(
                    'Note: Doctors and laboratories can view this as well, but you can hide your information.',
                    style: kMiniAppleGreenText,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Start Date: ', style: kMiniBlackTextBold,),
                        Text('${start.day} $startMonthName ${start.year}', style: kMiniBlackText,),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('End Date: ', style: kMiniBlackTextBold,),
                        Text('${end.day} $endMonthName ${end.year}', style: kMiniBlackText,),
                      ],
                    ),
                    OutlinedButton(
                        onPressed: pickDateRange,
                        child: const Text('Change Date Range')),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: ListView(
                    children: [
                      Expanded(
                        child: medical_history_widget(
                          widgetColor: widgetColor,
                          widgetTextColor: widgetTextColor,
                          hideButtonText: hideButtonText,
                          onPressed: (){
                            setState(() {
                              if(visibility == true){
                                widgetColor = kDarkest;
                                visibility = false;
                                hideButtonText = 'Show';
                                widgetTextColor = Colors.white;
                              }
                              else if (visibility == false){
                                widgetColor = kMintGreen;
                                visibility = true;
                                hideButtonText = 'Hide';
                                widgetTextColor = kDarkest;
                              }
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
  Future pickDateRange() async {
    DateTimeRange? newRange = await showDateRangePicker(
      context: context,
      initialDateRange: dateRange,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (newRange == null)
      return;
    else {
      setState(() {
        dateRange = newRange;
      });
    }
  }
}

class medical_history_widget extends StatelessWidget {
  const medical_history_widget({
    Key? key,
    required this.widgetColor,
    required this.widgetTextColor,
    required this.onPressed,
    required this.hideButtonText,
  }) : super(key: key);

  final Color widgetColor;
  final Color widgetTextColor;
  final String hideButtonText;
  final void Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20,20,20,7),
      margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
      decoration: BoxDecoration(
        color: widgetColor,
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x40000000),
            offset: Offset(-1,4),
            blurRadius: 2,
          )
        ],
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 90,
                width: 90,
                //margin: EdgeInsets.fromLTRB(0,10,0,0),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('18 SEP', style: kSmallerGreenText,),
                    Text('2022', style: kSmallerGreenText,),
                  ],
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 7,),
                    Text(
                      'Doctor\'s Name',
                      style: TextStyle(
                        fontFamily: 'Outfit',
                        fontWeight: FontWeight.w600,
                        color: widgetTextColor,
                        fontSize: 16,
                        decoration: TextDecoration.none,
                      ),
                    ),
                    const SizedBox(height: 5,),
                    Text(
                      'Dept Name, Hospital Name',
                      style: TextStyle(
                        fontFamily: 'Outfit',
                        fontWeight: FontWeight.w400,
                        color: widgetTextColor,
                        fontSize: 14,
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: onPressed,
                style: ElevatedButton.styleFrom(
                  primary: kAccentColor,
                ),
                child: Text(hideButtonText),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
