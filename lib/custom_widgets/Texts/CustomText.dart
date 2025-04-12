
import 'package:flutter/cupertino.dart';

class CustomText extends StatelessWidget {
  final String? text;
  final String? nullReplacement;
  final TextStyle? style;
  final int? maxLines;
  final Key? customKey;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  const CustomText(this.text,{super.key, this.nullReplacement, this.style, this.maxLines, this.customKey, this.textAlign, this.overflow,});

  @override
  Widget build(BuildContext context) {
    return Text(text != null && text.toString().trim().isNotEmpty
        ? text!
        : nullReplacement != null ? nullReplacement! : "-",
      style: style??null,
      maxLines: maxLines??null,
      key: customKey??null,
      textAlign: textAlign??null,
      overflow: overflow??null,
    );
  }
}
