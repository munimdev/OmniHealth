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
                  'New',
                  style: kSmallRedText,
                ),
              ),
              Expanded(
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.all(8),
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    TextButton(
                      onPressed: () {},
                      child: LabResultHolder(
                          heading: 'Heading',
                          date: '2nd September 2022',
                          labName: 'Hospital and Lab Name'),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    TextButton(
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
                  'This Year',
                  style: kSmallGreenText,
                ),
              ),
              Expanded(
                child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 0, 10),
                      child: Text(
                        'MAY',
                        style: kMiniGreyText,
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          TextButton(

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
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 0, 10),
                      child: Text(
                        'FEB',
                        style: kMiniGreyText,
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          TextButton(

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
                    )
                  ],
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

