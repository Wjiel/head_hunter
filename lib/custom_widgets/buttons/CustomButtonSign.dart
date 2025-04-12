import 'package:flutter/material.dart';
import 'package:head_hunter/colors.dart';

class CustomButtonSign extends StatelessWidget {
  final String inputWords;
  final bool? colorchik;
  final void Function() function;
  CustomButtonSign(
      {super.key,
      required this.inputWords,
      this.colorchik,
      required this.function});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: () {
        function();
      }, // Код
      child: Ink(
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
