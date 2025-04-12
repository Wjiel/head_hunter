import 'package:flutter/material.dart';
import 'package:head_hunter/start_screen/widget/Carousel.dart';
import 'package:head_hunter/start_screen/widget/MicroItem.dart';
import 'package:head_hunter/start_screen/widget/SignInUp.dart';

import '../colors.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        children: [
          RichText(
            text: TextSpan(
              style: TextStyle(
                color: highBlue,
                fontSize: 25,
                fontFamily: 'RobotoSerif',
                fontWeight: FontWeight.w600,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: 'сантехник.',
                ),
                TextSpan(
                  text: 'ру',
                  style: TextStyle(
                    color: orange,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 45,
          ),
          Carousel(),
          SignInUp(),
          SizedBox(
            height: 25,
          ),
          Text(
            'или',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: darkSign,
              fontFamily: 'RobotoSlab',
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 25),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 40,
            children: List.generate(
                3, (index) => MicroItem(strigImage: pictureForSign[index])),
          )
        ],
      ),
    );
  }
}
