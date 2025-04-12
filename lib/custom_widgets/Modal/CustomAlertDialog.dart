import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../Buttons/CustomFilledButton.dart';

Future showCustomDialog(BuildContext context,
    {required String title,
      required String text,
      required String assetName,
      TextStyle? textStyle,
      Color? iconBackgroundColor,
      void Function()? onTap
    }) async {
  await showDialog(context: context, builder: (context) {
    return AlertDialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 20),
      backgroundColor: Colors.white,
      title: Text(title,
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Color(0xFF363636),
            fontSize: 16,
            fontWeight: FontWeight.w600,
            height: 1.2
        ),
      ),
      contentPadding: EdgeInsets.symmetric(vertical: 24, horizontal: 20),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          Ink(
            padding: EdgeInsets.all(30),
            height: 100,
            width: 100,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: iconBackgroundColor != null ? iconBackgroundColor : Color(0x260065FF)
            ),
            child: SvgPicture.asset("assets/icons/$assetName.svg"),
          ),

          SizedBox(height: 12,),

          Text(text,
            textAlign: TextAlign.center,
            style: textStyle !=null ? textStyle : TextStyle(
                color: Color(0xCC363636),
                fontSize: 14,
                fontWeight: FontWeight.w400,
                height: 1.2
            ),
          ),

          SizedBox(height: 30,),

          SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 50,
              child: CustomFilledButton(
                callback: () {
                  onTap != null ? onTap() : null;
                  Navigator.pop(context);
                  return;
                },
                text: "Хорошо",
              )
          ),

        ],
      ),
    );
  });
}