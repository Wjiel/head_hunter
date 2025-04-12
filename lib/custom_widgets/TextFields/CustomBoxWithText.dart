import 'package:flutter/material.dart';

class CustomBoxWithText extends StatefulWidget {
  final bool? isSwitchPass;
  const CustomBoxWithText({super.key, this.isSwitchPass});


  @override
  State<CustomBoxWithText> createState() => _CustomBoxWithTextState();
}

class _CustomBoxWithTextState extends State<CustomBoxWithText> {
  final TextEditingController controllerText = TextEditingController();
  
  @override
  void dispose() {
    controllerText.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Ink(
      padding: EdgeInsets.symmetric(
        vertical: 1,
      ),
      decoration: BoxDecoration(
        color: Colors.black12,
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        obscureText: widget.isSwitchPass ?? false,
        controller: controllerText,
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 10,
          ),
        ),
      ),
    );
  }
}