import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../Buttons/CustomIconButton.dart';

class CustomTextField extends StatelessWidget {
  final String hint;
  final TextStyle? hintStyle;
  final TextStyle? textStyle;
  final TextEditingController controller;
  final bool? showAction;
  final void Function()? onAction;
  final void Function()? onChanged;
  final bool? obscureText;
  final Iterable<String>? autofillHints;
  final TextInputType? textType;
  final int? maxLength;
  final String? svgAssetName;
  final Color? iconColor;
  final bool? outlined;
  final EdgeInsetsGeometry? contentPadding;
  final int? maxLines;
  final FocusNode? focusNode;
  final bool isSearch;
  const CustomTextField(
      {super.key,
      required this.hint,
      required this.controller,
      this.showAction,
      this.obscureText,
      this.textType,
      this.onAction,
      this.maxLength,
      this.onChanged,
      this.svgAssetName,
      this.outlined,
      this.maxLines,
      this.iconColor,
      this.hintStyle,
      this.textStyle,
      this.contentPadding,
      this.autofillHints,
      this.focusNode})
      : isSearch = false;
  const CustomTextField.search(
      {super.key,
      required this.hint,
      required this.controller,
      this.showAction,
      this.obscureText,
      this.textType,
      this.onAction,
      this.maxLength,
      this.onChanged,
      this.svgAssetName,
      this.outlined,
      this.maxLines,
      this.iconColor,
      this.hintStyle,
      this.textStyle,
      this.contentPadding,
      this.autofillHints,
      this.focusNode})
      : isSearch = true;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.centerRight,
      children: [
        TextField(
          focusNode: focusNode ?? null,
          autofillHints: autofillHints != null ? autofillHints : null,
          onChanged:
              onChanged != null ? (String) => onChanged!() : (String) => () {},
          maxLength: maxLength,
          keyboardType: textType,
          maxLines: maxLines ?? 1,
          obscureText: obscureText ?? false,
          controller: controller,
          style: textStyle ??
              TextStyle(
                  color: Color(0xFF363636),
                  fontSize: 14,
                  fontWeight: FontWeight.w600),
          decoration: InputDecoration(
            prefixIcon: isSearch
                ? SvgPicture.asset(
                    "assets/icons/search.svg",
                    fit: BoxFit.scaleDown,
                  )
                : null,
            counter: SizedBox(),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
                borderSide: BorderSide(
                    width: outlined == null || outlined == true ? 0.5 : 0,
                    color: outlined == null || outlined == true
                        ? Color(0xFFDBDFEA)
                        : Colors.transparent)),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    width: outlined == null || outlined == true ? 0.5 : 0,
                    color: outlined == null || outlined == true
                        ? Color(0xFFDBDFEA)
                        : Colors.transparent)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    width: outlined == null || outlined == true ? 0.5 : 0,
                    color: outlined == null || outlined == true
                        ? Color(0xFFDBDFEA)
                        : Colors.transparent)),
            hintText: hint,
            hintStyle: hintStyle != null
                ? hintStyle
                : TextStyle(
                    color: Color(0xFF808080),
                    fontSize: 14,
                    fontWeight: FontWeight.w400),
            contentPadding: contentPadding != null
                ? contentPadding
                : isSearch != true
                    ? showAction != true
                        ? EdgeInsets.all(16)
                        : EdgeInsets.only(
                            left: 16, top: 16, bottom: 16, right: 46)
                    : showAction != true
                        ? EdgeInsets.only(
                            left: 8, top: 16, bottom: 16, right: 16)
                        : EdgeInsets.only(
                            left: 8, top: 16, bottom: 16, right: 46),
          ),
        ),
        showAction == true
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Material(
                  color: Colors.white,
                  child: AnimatedSwitcher(
                    transitionBuilder:
                        (Widget child, Animation<double> animation) {
                      return FadeTransition(
                        opacity: CurvedAnimation(
                            parent: animation,
                            curve:
                                Interval(0.3, 1, curve: Curves.easeInOutQuart)),
                        child: ScaleTransition(
                          scale: CurvedAnimation(
                              parent: animation,
                              curve: Interval(0.5, 1,
                                  curve: Curves.easeInOutCirc)),
                          child: child,
                        ),
                      );
                    },
                    duration: Duration(milliseconds: 200),
                    child: iconColor == null
                        ? CustomIconButton(
                            key: Key("turnedOnActionIcon"),
                            callback: onAction,
                            height: 36,
                            width: 36,
                            iconColor: iconColor ?? null,
                            borderRadius: 6,
                            padding: EdgeInsets.all(8),
                            iconSVG: svgAssetName == null
                                ? "assets/icons/showPassword.svg"
                                : "assets/icons/$svgAssetName.svg",
                            fit: BoxFit.contain)
                        : CustomIconButton(
                            key: Key("turnedOffActionIcon"),
                            callback: onAction,
                            height: 36,
                            width: 36,
                            iconColor: iconColor ?? null,
                            borderRadius: 6,
                            padding: EdgeInsets.all(8),
                            iconSVG: svgAssetName == null
                                ? "assets/icons/showPassword.svg"
                                : "assets/icons/$svgAssetName.svg",
                            fit: BoxFit.contain),
                  ),
                ),
              )
            : SizedBox(),
      ],
    );
  }
}
