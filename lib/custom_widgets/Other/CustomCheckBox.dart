import 'package:flutter/material.dart';

class CustomCheckBox extends StatelessWidget {
  final bool value;
  const CustomCheckBox({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 28,
      width: 28,
      decoration: BoxDecoration(
          color: Color(0xFFF4EBFF),
          borderRadius: BorderRadius.circular(8)
      ),
      padding: EdgeInsets.all(4),
      child: Checkbox(
        value: value,
        onChanged: null,
        checkColor: Colors.white,
        fillColor: value ? WidgetStatePropertyAll(Color(0xFF0065FF)) : WidgetStatePropertyAll(Colors.white),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        side: BorderSide(color: Color(0XFF9BCDFF)),
      ),
    );
  }
}
