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
            child: ListView(
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
                SizedBox(
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
