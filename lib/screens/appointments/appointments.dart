import 'package:flutter/material.dart';
import 'package:omnihealth/constants/constants.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'make_appointment.dart';
class Appointments extends StatefulWidget {
  const Appointments({Key? key}) : super(key: key);
  @override
  State<Appointments> createState() => _AppointmentsState();
}

class _AppointmentsState extends State<Appointments> {
  final CalendarController _controller = CalendarController();
  var items = [
    'Hospital',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];
  String dropdownvalue = 'Hospital';
  @override
  Widget build(BuildContext context) {
    return Container(
      color: kMintGreen,
      child: SafeArea(
        child: Column(
          children:  [
            SizedBox(
              height: 15,
            ),
            Center(
              child: Text(
                'Make an Appointment!',
                style: kHeadingTextStyle,
              ),
            ),
            Expanded(
                child: Container(
                  margin: EdgeInsets.fromLTRB(10, 20, 10, 10),
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: kMutedWidgetColor,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(20),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.25),
                        spreadRadius: 0,
                        blurRadius: 4,
                        offset: const Offset(0, 4), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text(
                          'Choose a hospital',
                          style: kDashboardWidgetTextStyle,
                          textAlign: TextAlign.left,
                        ),
                        Material(
                          child: Expanded(
                            child: Container(
                              width: 300,
                              color: Colors.white,
                              child: Center(
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
                        ),

                        const Text(
                          'Choose a department',
                          style: kDashboardWidgetTextStyle,
                        ),
                        const Text(
                          'Choose a Doctor',
                          style: kDashboardWidgetTextStyle,
                        ),
                        const Text(
                          'Choose a Date',
                          style: kDashboardWidgetTextStyle,
                        ),
                        Container(
                          width: double.infinity,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                          ),
                          child: SfCalendar(
                            view: CalendarView.month,
                            viewHeaderHeight: 30,
                            viewHeaderStyle: const ViewHeaderStyle(
                              dayTextStyle: TextStyle(
                                fontFamily: 'Outfit',
                                color: kDarkest,
                              )
                            ),
                            allowedViews: const [
                              CalendarView.day,
                              CalendarView.month,
                            ],
                            controller: _controller,
                            onTap: (CalendarTapDetails details){
                              //Handling the event where a date is pressed
                              DateTime? date = details.date;
                              if (_controller.view == CalendarView.month && details.targetElement == CalendarElement.calendarCell){
                                _controller.view = CalendarView.day;
                              }
                              else if (_controller.view == CalendarView.day && details.targetElement == CalendarElement.header){
                                _controller.view = CalendarView.month;
                              }
                              if(_controller.view == CalendarView.day && details.targetElement == CalendarElement.calendarCell){
                                if(date != null){
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context){
                                            return MakeAppointment(
                                              dateTime: date,
                                              endTime: date.add(Duration(minutes: 15)),
                                            );
                                          },
                                    ),
                                  );
                                }
                              }
                            },
                            backgroundColor: Colors.white,
                            cellBorderColor: Colors.white,
                            todayHighlightColor: kDarkest,
                            cellEndPadding: 2.0,
                            headerStyle: const CalendarHeaderStyle(
                              backgroundColor: kDarkest,
                              textAlign: TextAlign.center,
                              textStyle: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Outfit',
                              ),
                            ),
                            showDatePickerButton: true,
                            monthViewSettings: const MonthViewSettings(
                              showTrailingAndLeadingDates: false,
                              dayFormat: 'EEE',
                              monthCellStyle: MonthCellStyle(
                                textStyle: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Outfit',
                                ),
                                leadingDatesTextStyle: TextStyle(
                                  color: Colors.grey,
                                  fontFamily: 'Outfit',
                                ),
                                trailingDatesTextStyle: TextStyle(
                                  color: Colors.grey,
                                  fontFamily: 'Outfit',
                                )
                              ),
                            ),
                            firstDayOfWeek: 1,
                            timeSlotViewSettings: const TimeSlotViewSettings(
                                timeInterval: Duration(minutes: 15),
                              timeFormat: 'hh:mm',
                              dayFormat: 'EEE',
                            ),
                            blackoutDates: [
                              DateTime(2022,08,31).add(Duration(days:3)),
                            ],
                            blackoutDatesTextStyle: TextStyle(
                              color: Colors.red,
                            ),
                            dataSource: MeetingDataSource(getAppointments()),
                          ),
                        ),
                      ],
                  ),
                ),
            ),
          ],
        ),
      ),
    );
  }
}

void makeAppointment(DateTime datetime){

}
List<Appointment> getAppointments(){
  List<Appointment> meetings = <Appointment>[];
  final DateTime today = DateTime.now();
  final DateTime startTime = DateTime(today.year, today.month, today.day, 9,0,0);

  final DateTime endTime = startTime.add(const Duration(minutes: 15));

  meetings.add(Appointment(
    startTime: startTime,
    endTime: endTime,
    subject: 'Doctor\'s Appointment',
    color: Colors.blue,
  ));
  return meetings;
}
class MeetingDataSource extends CalendarDataSource{
  MeetingDataSource(List<Appointment> source){
    appointments = source;
  }
}