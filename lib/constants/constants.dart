import 'package:flutter/material.dart';

const appPrimaryColor = Color(0xFF26635B);
const appAccentColor = Color(0xFFFFFFFF);
const overlayColor = Color(0xFFCEDEB9);
const signupButtonColor = Color(0xFF52A870);
const defaultFontFamily = 'Outfit';
const primaryTextColor = Color(0xFF26635B);
const inputFieldBorderRadius = 50.0;
const inputFieldBorderWidth = 1.25;
const inputFieldBorderColor = Colors.greenAccent;
const inputFieldBoxShadowColor = Color(0xFFCCCCCC);
const inputFieldBlurRadius = 5.0;
const inputFieldShadowOffset = Offset(0, 3);
const inputFieldIconColor = Color(0xFF52A870);
const inputFieldBackground = Color(0xFFEBF8DA);
const inputFieldFocusedColor = Color(0xFF52A870);
const inputFieldHeadingColor = Color(0xFF52A870);
const inputFieldEnabledColor = Colors.transparent;

const omniHealthHeading =
Text(
  "OmniHealth",
  textAlign: TextAlign.left,
  style: TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 30,
    fontFamily: defaultFontFamily,
    decoration: TextDecoration.none,
    color: appPrimaryColor,
  ),
);

var scaffoldBackButton = Builder(
  builder: (BuildContext context) {
    return IconButton(
      tooltip: "Back",
      icon: const Icon(Icons.arrow_back_ios_new, size: 17,), // Put icon of your preference.
      onPressed: () {
        Navigator.pop(context);
      },
    );
  },
);

var inputFieldDecoration = InputDecoration(
  contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
  // hintText: "Password",
  labelStyle: TextStyle(
    color: inputFieldFocusedColor,
  ),

  border: OutlineInputBorder(borderRadius: BorderRadius.circular(inputFieldBorderRadius)),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(inputFieldBorderRadius),
    borderSide: const BorderSide(
      color: inputFieldEnabledColor,
      width: inputFieldBorderWidth,
    ),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(inputFieldBorderRadius),
    borderSide: const BorderSide(
      color: inputFieldFocusedColor,
      width: inputFieldBorderWidth,
    ),
  ),
);

//hajra constants

const kDarkest = Color(0xFF26635B);
const kAppleGreen = Color(0xFF52A870);
const kMintGreen = Color(0xFFEBF8DA);
const kMutedWidgetColor = Color(0x80FFFFFF);
const kBlackOverlay = Color(0x80000000);
const kLightBlue = Color(0xFFC8D8E4);
const kBackgroundColor = Color(0xFFF5F5F5);

const kDashboardWidgetTextStyle = TextStyle(
  fontSize: 24,
  fontWeight: FontWeight.w500,
  fontFamily: 'Outfit',
  color: kDarkest,
  decoration: TextDecoration.none,
);
const kAppointmentWidgetTextStyle = TextStyle(
  fontSize: 24,
  fontWeight: FontWeight.w500,
  fontFamily: 'Outfit',
  color: kDarkest,
  decoration: TextDecoration.none,
);


const kHeadingTextStyle = TextStyle(
  fontSize: 32,
  fontWeight: FontWeight.w700,
  fontFamily: 'Outfit',
  color: kDarkest,
  decoration: TextDecoration.none,
  shadows: [
    Shadow(
      offset: Offset(0, 4),
      blurRadius: 4,
      color: kBlackOverlay,
    ),
  ],
);

const kSmallRedText = TextStyle(
  fontFamily: 'Outfit',
  fontWeight: FontWeight.w400,
  color: Color(0xFFF34044),
  fontSize: 20,
  decoration: TextDecoration.none,
);
const kSmallGreenText = TextStyle(
  fontFamily: 'Outfit',
  fontWeight: FontWeight.w400,
  color: kAppleGreen,
  fontSize: 20,
  decoration: TextDecoration.none,
);
const kMiniGreyText = TextStyle(
  fontFamily: 'Outfit',
  fontWeight: FontWeight.w400,
  color: Color(0xFF8B8888),
  fontSize: 14,
  decoration: TextDecoration.none,
);