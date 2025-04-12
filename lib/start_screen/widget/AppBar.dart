import 'package:flutter/material.dart';
import 'package:head_hunter/colors.dart';

AppBar appBar = AppBar(
  backgroundColor: Colors.white,
  title: RichText(
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
);
