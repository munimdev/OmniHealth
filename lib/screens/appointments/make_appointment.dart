import 'package:flutter/material.dart';
import 'package:omnihealth/constants/constants.dart';

class MakeAppointment extends StatefulWidget {
  const MakeAppointment(
      {Key? key, required this.dateTime, required this.endTime})
      : super(key: key);
  final DateTime dateTime;
  final DateTime endTime;
  @override
  State<MakeAppointment> createState() => _MakeAppointmentState(
        day: dateTime.day,
        hrs: dateTime.hour,
        minutes: dateTime.minute,
        endHours: endTime.hour,
        endMinutes: endTime.minute,
      );
}

class _MakeAppointmentState extends State<MakeAppointment> {
  _MakeAppointmentState(
      {required this.day,
      required this.hrs,
      required this.minutes,
      required this.endHours,
      required this.endMinutes});
  final int day;
  final int hrs;
  final int minutes;
  final int endHours;
  final int endMinutes;

  TextEditingController eCtrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: kMintGreen,
        child: Expanded(
          child: Container(
            color: Colors.white,
            margin: EdgeInsets.all(20),
            child: Column(
              children: [
                Text(
                  'Appointment start time: $hrs:$minutes',
                  style: kDashboardWidgetTextStyle,
                ),
                Text(
                  'Appointment end time: $endHours:$endMinutes',
                  style: kDashboardWidgetTextStyle,
                ),
                Text(
                  'Enter Agenda',
                  style: kDashboardWidgetTextStyle,
                ),
                Material(
                  child: TextField(
                    controller: eCtrl,
                    onSubmitted: (String text) {
                      Navigator.pop(context);
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
