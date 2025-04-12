import 'package:flutter/material.dart';

TextStyle _styleText = TextStyle(
  fontFamily: 'RobotoSlab',
  fontSize: 18,
  fontWeight: FontWeight.w500,
);
TextStyle _styleTextIn = TextStyle(
  fontFamily: 'RobotoSerif',
  fontSize: 34,
  fontWeight: FontWeight.w600,
);

class CustomTextForPage extends StatelessWidget {
  final bool? isSwtich;
  final String textString;
  const CustomTextForPage({super.key, required this.textString, this.isSwtich});

  @override
  Widget build(BuildContext context) {
    return Text(
      textString,
      style: isSwtich ?? false ? _styleTextIn : _styleText,
    );
  }
}