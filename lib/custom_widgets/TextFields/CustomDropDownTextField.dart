import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomDropDownTextField<T> extends StatefulWidget {
  final T? value;
  final List<DropdownMenuItem<T>> items;
  final void Function(T?) onChanged;
  final String hintText;
  final TextStyle? hintStyle;
  final TextStyle? textStyle;
  final EdgeInsetsGeometry? contentPadding;

  const CustomDropDownTextField({
    super.key,
    required this.value,
    required this.items,
    required this.onChanged,
    required this.hintText,
    this.hintStyle,
    this.textStyle,
    this.contentPadding
  });

  @override
  State<CustomDropDownTextField<T>> createState() => _CustomDropDownTextFieldState<T>();
}

class _CustomDropDownTextFieldState<T> extends State<CustomDropDownTextField<T>> {

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      autovalidateMode: AutovalidateMode.always,
      validator: (value) {
        // if (value == null) return 'Поле обязательно'; null;
      },
      icon: SvgPicture.asset("assets/icons/arrow_down.svg"),
      decoration: InputDecoration(
        counter: SizedBox(),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: BorderSide(width: 0.5, color: Color(0xFFDBDFEA))
        ),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: BorderSide(width: 0.5, color: Color(0xFFDBDFEA))
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide(width: 2, color: Colors.blue[800]!),
        ),
        hintText: widget.hintText,
        hintStyle: widget.hintStyle ?? TextStyle(
            color: Color(0xFF808080),
            fontSize: 14,
            fontWeight: FontWeight.w400
        ),
        contentPadding: widget.contentPadding ?? EdgeInsets.all(16),
      ),
      style: widget.textStyle ?? TextStyle(
        fontWeight: FontWeight.w400,
        overflow: TextOverflow.ellipsis,
        fontSize: 14,
        color: Color(0xFF363636),
      ),
      value: widget.value, // Используем значение из свойств виджета
      isExpanded: true,
      items: widget.items,
      onChanged: widget.onChanged, // Просто передаем функцию без изменения
    );
  }
}