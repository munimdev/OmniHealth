import 'package:flutter/material.dart';
import 'package:omnihealth/constants/constants.dart';
class DashboardWidgetVertical extends StatelessWidget {
  const DashboardWidgetVertical({Key? key, required this.title, required this.icon}) : super(key: key);
  final String title;
  final Icon icon;
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
          padding: EdgeInsets.all(20),
          margin: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
          decoration: BoxDecoration(
            color: Colors.white,
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
          child: Row(
            children: [
              CircularIconContainer(
                icon: icon,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(title,
                style: kDashboardWidgetTextStyle,
              ),
            ],
          ),
        ),
    );
  }
}

class CircularIconContainer extends StatelessWidget {
  const CircularIconContainer({
    Key? key, required this.icon
  }) : super(key: key);
  final Icon icon;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: 60,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: kDarkest,
      ),
      child: icon,
    );
  }
}

class DashboardWidgetHorizontal extends StatelessWidget {
  const DashboardWidgetHorizontal({Key? key, required this.title, required this.icon}) : super(key: key);
  final String title;
  final Icon icon;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: 152,
        padding: const EdgeInsets.all(20),
        //margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        decoration: BoxDecoration(
          color: Colors.white,
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircularIconContainer(
              icon: icon,
            ),
            Text(title,
              style: kDashboardWidgetTextStyle,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
