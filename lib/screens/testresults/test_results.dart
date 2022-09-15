import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:omnihealth/constants/constants.dart';
import 'package:omnihealth/Components/lab_result_holder.dart';


class TestResults extends StatefulWidget {
  const TestResults({Key? key}) : super(key: key);

  @override
  State<TestResults> createState() => _TestResultsState();
}

class _TestResultsState extends State<TestResults> {
  var items = [
    'Filter by year',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];
  String dropdownvalue = 'Filter by year';

  int index = 1;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: resultInitializer(),
                  ),
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
                  'This Year',
                  style: kSmallGreenText,
                ),
              ),
              Expanded(
                child: ListView(
                  /*children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 0, 10),
                      child: Text(
                        'MAY',
                        style: kMiniGreyText,
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 10,
                            ),
                            TextButton(
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                              ),
                              onPressed: (){},
                              child: LabResultHolder(
                                  heading: 'Heading',
                                  date: '2nd September 2022',
                                  labName: 'Hospital and Lab Name'),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            TextButton(
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                              ),
                              onPressed: (){},
                              child: LabResultHolder(
                                  heading: 'Heading',
                                  date: '2nd September 2022',
                                  labName: 'Hospital and Lab Name'),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            TextButton(
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                              ),
                              onPressed: (){},
                              child: LabResultHolder(
                                  heading: 'Heading',
                                  date: '2nd September 2022',
                                  labName: 'Hospital and Lab Name'),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            TextButton(
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                              ),
                              onPressed: (){},
                              child: LabResultHolder(
                                  heading: 'Heading',
                                  date: '2nd September 2022',
                                  labName: 'Hospital and Lab Name'),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 0, 10),
                      child: Text(
                        'FEB',
                        style: kMiniGreyText,
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 10,
                            ),
                            TextButton(
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                              ),
                              onPressed: (){},
                              child: LabResultHolder(
                                  heading: 'Heading',
                                  date: '2nd September 2022',
                                  labName: 'Hospital and Lab Name'),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            TextButton(
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                              ),
                              onPressed: (){},
                              child: LabResultHolder(
                                  heading: 'Heading',
                                  date: '2nd September 2022',
                                  labName: 'Hospital and Lab Name'),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            TextButton(
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                              ),
                              onPressed: (){},
                              child: LabResultHolder(
                                  heading: 'Heading',
                                  date: '2nd September 2022',
                                  labName: 'Hospital and Lab Name'),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            TextButton(
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                              ),
                              onPressed: (){},
                              child: LabResultHolder(
                                  heading: 'Heading',
                                  date: '2nd September 2022',
                                  labName: 'Hospital and Lab Name'),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                          ],
                        ),
                      ),
                    )
                  ],*/
                  children: yearResultGenerator(),
                ),
              ),
              Container(
                width: double.infinity,
                margin: const EdgeInsets.fromLTRB(20, 25, 20, 10),
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
              Material(
                borderRadius: BorderRadius.circular(10),
                child: Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                    width: 300,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: DropdownButton(
                      borderRadius: BorderRadius.circular(10),
                      value: dropdownvalue,
                      icon: const Icon(Icons.keyboard_arrow_down),
                      items: items.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(items),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownvalue = newValue!;
                        });
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
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
          padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 5.0),
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