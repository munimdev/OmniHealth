import 'package:flutter/material.dart';
import 'package:countries/countries.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:flutterfire_ui/i10n.dart';
import 'package:flutter/services.dart';

import '../../constants/constants.dart';
import './sms_code.dart';
import '../../utils/country_modal.dart' as c2;

class InputPhone extends StatefulWidget {
  const InputPhone({Key? key}) : super(key: key);

  @override
  State<InputPhone> createState() => _InputPhoneState();
}

class _InputPhoneState extends State<InputPhone> {

  var _country = CountriesRepo.getCountryByIsoCode('PK');
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {


    void initState() {
      super.initState();
      WidgetsBinding.instance.addPostFrameCallback((_) {
        CountriesRepo.countryList.removeWhere((element) => element == _country);
        CountriesRepo.countryList.insert(0, _country);
        print("eeeeeeeeeee");
      });
    }

    String getUserNumber() {
      return "+${_country.phoneCode}${phoneController.text}";
    }

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.grey[50],
        foregroundColor: Colors.black,
        elevation: 0,
        leading: scaffoldBackButton,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(8.0),
              children: <Widget>[
                Text(
                  'Enter your mobile number',
                  style: TextStyle(
                    fontSize: 24
                  ),
                ),
                SizedBox(height: 10,),
                Text(
                  'Enter your mobile number, to create an account',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 20,),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => c2.showCountriesBottomSheet(
                        context,
                        onValuePicked: (v) => setState(() => _country = v),
                      ),
                      child: Row(
                        children: [
                          CountryFlagWidget(
                            _country,
                          ),
                          Icon(Icons.arrow_drop_down, size: 20.0, color: Colors.grey,),
                          Text(
                            "+${_country.phoneCode}",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold
                            )
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        controller: phoneController,
                        keyboardType: TextInputType.number,
                        cursorColor: appPrimaryColor,
                        maxLines: 1,
                        decoration: InputDecoration(
                          fillColor: Colors.grey[50],
                          hintText: "301 2345678",
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontFamily: 'Roboto',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30),
              ],
            ),
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
                      statusBarColor: Colors.grey[50],
                    ));
                    await Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation, secondaryAnimation) => SMSCodeScreen(phoneNumber: getUserNumber(),),
                          transitionsBuilder: (context, animation, secondaryAnimation, child) {
                            const begin = Offset(1.0, 0.0);
                            const end = Offset.zero;
                            const curve = Curves.ease;

                            var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

                            return SlideTransition(
                              position: animation.drive(tween),
                              child: child,
                            );
                          },
                        )
                    );

                  },
                  child: Text(
                    "Continue",
                    style: TextStyle(color: Theme.of(context).primaryColorLight),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}


// class InputPhone extends StatefulWidget {
//   const InputPhone({Key? key}) : super(key: key);
//
//   @override
//   State<InputPhone> createState() => _InputPhoneState();
// }
//
// class _InputPhoneState extends State<InputPhone> {
//
//   var _country = CountriesRepo.getCountryByPhoneCode('92');
//
//   @override
//   Widget build(BuildContext context) {
//
//
//     return Scaffold(
//       body: ListView(
//         padding: EdgeInsets.all(8.0),
//         children: <Widget>[
//           Text('Phone Form'),
//           SizedBox(height: 30),
//           Text('Bottom Sheet'),
//           GestureDetector(
//             onTap: () => showCountriesBottomSheet(
//               context,
//               onValuePicked: (v) => setState(() => _country = v),
//             ),
//             child: CountryFlagWidget(
//               _country,
//               width: 20,
//             ),
//           ),
//           SizedBox(height: 30),
//           Text('Dropdown'),
//           CountryPickerDropdown(
//             onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
//             isDense: false,
//             onValuePicked: (Country country) {
//               print("${country.name}");
//             },
//             itemBuilder: (Country country) {
//               return Row(
//                 children: <Widget>[
//                   CountryFlagWidget(country),
//                   SizedBox(width: 8.0),
//                   Text("+${country.phoneCode}"),
//                   SizedBox(width: 8.0),
//                 ],
//               );
//             },
//             isExpanded: true,
//           ),
//           SizedBox(height: 30),
//           Text("Enter phone number"),
//           ListTile(
//             onTap: () {
//               showDialog(
//                 context: context,
//                 builder: (context) => Theme(
//                   data: Theme.of(context).copyWith(primaryColor: Colors.pink),
//                   child: CountryPickerDialog(
//                     searchWidgetStyle: SearchWidgetStyle(
//                       searchCursorColor: Colors.pinkAccent,
//                       searchInputDecoration:
//                       InputDecoration(hintText: 'Search...'),
//                     ),
//                     onValuePicked: (Country country) =>
//                         setState(() => _country = country),
//                     priorityList: [
//                       CountriesRepo.getCountryByIsoCode('PK'),
//                     ],
//                   ),
//                 ),
//               );
//             },
//             title: Row(
//               children: <Widget>[
//                 CountryFlagWidget(_country),
//                 SizedBox(width: 8.0),
//                 Text("+${_country.phoneCode}"),
//                 SizedBox(width: 8.0),
//               ],
//             ),
//           ),
//           SizedBox(height: 30),
//         ],
//       ),
//     );
//   }
// }
