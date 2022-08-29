import 'package:flutter/material.dart';
import 'package:omnihealth/constants/constants.dart';
class ProfileCard extends StatelessWidget {
  ProfileCard({required this.profilePicture, required this.username}); //change default photo later
  final String profilePicture;
  final String username;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage(profilePicture),
                  fit: BoxFit.fill,
                  repeat: ImageRepeat.noRepeat,
                ),
                border: Border.all(color: kDarkest),
              ),
            ),
            Text(
              username,
              style: const TextStyle(
                fontSize: 20,
                fontFamily: 'Outfit',
                fontWeight: FontWeight.w500,
                color: kDarkest,
                decoration: TextDecoration.none,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
