import 'package:flutter/material.dart';
import 'package:omnihealth/constants/constants.dart';
import 'package:omnihealth/Components/lab_result_holder.dart';
import 'package:omnihealth/Components/universal_functions.dart';
class TestResults extends StatefulWidget {
  const TestResults({Key? key}) : super(key: key);

  @override
  State<TestResults> createState() => _TestResultsState();
}

class _TestResultsState extends State<TestResults> {

  int index = 1;
  DateTimeRange dateRange = DateTimeRange(start: DateTime.now(), end: DateTime.now());
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
            margin: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
            ),
            child: ListView(
             // crossAxisAlignment: CrossAxisAlignment.start,
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
                    'New',
                    style: kSmallRedText,
                  ),
                ),
                //todo: get a list of test results within this month
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: resultInitializer(),
                  ),
                ),
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.fromLTRB(20, 5, 20, 10),
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
                    'Older',
                    style: kSmallGreenText,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 10, 10),
                  child: Text(
                    'Select the duration for which you want previous results displayed.',
                    style: kMiniGreyText,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    OutlinedButton(
                        onPressed: pickDateRange,
                        child: const Text('Pick Date Range')),
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
                    )
                  ],
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(),
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


//TODO: Replace this with dynamic data from the database
List<Widget> resultInitializer (){
  List <Widget> resultHolderList = [
    SizedBox(width: 15,),
  ];
  String heading = 'Heading';
  String date = '3rd September 2022';
  String labName = 'Lab Name';
  for (var i =0; i < 3; i++){ //todo: change index to the number of results in the month
    resultHolderList.add(
      TextButton(
        onPressed: (){},
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 5.0),
        ),
        child: LabResultHolder(heading: heading, date: date, labName: labName,
        ),
      ),
    );
  }
  return resultHolderList;
}
//TODO: get results from database within the time limit of an year
//TODO: Sort them into different lists according to month and display these lists on screen

List <Widget> yearResultGenerator(){
  List <Widget> resultList = [

  ];
  DateTime nowDate = DateTime.now();
  int month = nowDate.month;
  String monthName = '';
  switch (month) {
    case 1: monthName = 'JAN'; break;
    case 2: monthName = 'FEB'; break;
    case 3: monthName = 'MAR'; break;
    case 4: monthName = 'APR'; break;
    case 5: monthName = 'MAY'; break;
    case 6: monthName = 'JUN'; break;
    case 7: monthName = 'JUL'; break;
    case 8: monthName = 'AUG'; break;
    case 9: monthName = 'SEP'; break;
    case 10: monthName = 'OCT'; break;
    case 11: monthName = 'NOV'; break;
    case 12: monthName = 'DEC'; break;
  }
  for (var i = 0; i < 1; i++){ //todo:change outer loop index to the number of months
    resultList.add(
      Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 0, 10),
        child: Text(
          monthName,
          style: kMiniGreyText,
        ),
      ),
    );
    for (var j = 0; j < 1; j++){//inner loop only runs once
      resultList.add(
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: resultInitializer(),
              ),
            ),
          )
      );
    }
  }
  return resultList;
}