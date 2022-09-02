import 'package:flutter/material.dart';
import 'package:omnihealth/constants/constants.dart';
class LabResultHolder extends StatelessWidget {
  const LabResultHolder({
    Key? key, required this.heading, required this.date, required this.labName
  }) : super(key: key);
  final String heading;
  final String date;
  final String labName;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 177,
      width: 122,
      decoration: BoxDecoration(
          color: kMintGreen,
          borderRadius: BorderRadius.circular(15),
          boxShadow: const [
            BoxShadow(
              color: Color(0x40000000),
              offset: Offset(-1,4),
              blurRadius: 2,
              //blurStyle: BlurStyle.inner,
            )
          ]
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: Text(
              heading,
              style: const TextStyle(
                fontFamily: 'Outfit',
                fontWeight: FontWeight.w600,
                fontSize: 16,
                decoration: TextDecoration.none,
                color: kDarkest,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 0),
            child: Text(
              date,
              style: const TextStyle(
                fontFamily: 'Outfit',
                fontWeight: FontWeight.w400,
                fontSize: 14,
                decoration: TextDecoration.none,
                color: kDarkest,
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 0),
            child: Text(
              labName,
              style: const TextStyle(
                fontFamily: 'Outfit',
                fontWeight: FontWeight.w400,
                fontSize: 14,
                decoration: TextDecoration.none,
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
