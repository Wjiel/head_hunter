import 'package:flutter/material.dart';
import 'package:head_hunter/colors.dart';

class CustomButtonSign extends StatelessWidget {
  final String inputWords;
  final bool? colorchik;
  const CustomButtonSign({super.key, required this.inputWords, this.colorchik});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: () {}, // Код
      child: Ink(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: colorchik ?? false ? lowOrange : highBlue,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Text(
            inputWords,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'RobotoSlab',
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
