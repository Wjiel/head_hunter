import 'package:flutter/material.dart';

class CustomSwitcher extends StatelessWidget {
  final bool value;
  final void Function(bool)? onChanged;
  const CustomSwitcher({super.key, required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onChanged != null ? () => onChanged!(!value) : null,
      child: AnimatedContainer(
        decoration: BoxDecoration(
            color: value == false ? Color(0xFFF2F2F2) : Color(0xFF0065FF),
            borderRadius: BorderRadius.circular(36),
            border: Border.all(width: 0.5, color: Color(0xFFE5E5E5))
        ),
        height: 20,
        width: 40,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOutCirc,
        child: AnimatedAlign(
          alignment: value == false ? Alignment.centerLeft : Alignment.centerRight,
          duration: Duration(milliseconds: 250),
          curve: Curves.easeInOutCirc,
          child: FractionallySizedBox(
            widthFactor: 0.5,
            child: Container(
              margin: EdgeInsets.all(2),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [BoxShadow(blurRadius: 2, color: Color(0x4D333333), offset: Offset(1, 1), spreadRadius: -1)],
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
