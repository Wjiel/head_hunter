import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../Buttons/CustomIconButton.dart';

class CustomChatAppBar extends StatelessWidget {
  final String title;
  final String subTitle;
  final void Function()? action;
  const CustomChatAppBar({super.key, required this.title, required this.subTitle , this.action});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      titleSpacing: 8,
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      title: Padding(
        padding: EdgeInsets.only(top: 16),
        child: Row(
          spacing: 8,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 32,
              width: 32,
              child: CircleAvatar(
                backgroundColor: Color(0xFFD9E8FF),
                child: SvgPicture.asset("assets/icons/profile.svg", height: 16,width: 16,),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 2,
                children: [
                  Text(title,
                    style: TextStyle(
                        height: 1.2,
                        color: Color(0xFF363636),
                        fontSize: 14,
                        fontWeight: FontWeight.w500
                    ),
                  ),
                  Text(subTitle,
                    style: TextStyle(
                        height: 1.2,
                        color: Color(0x80363636),
                        fontSize: 14,
                        fontWeight: FontWeight.w400
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      leading: Padding(
        padding: EdgeInsets.only(left: 10, top: 16),
        child: FittedBox(
          child: CustomIconButton(
            borderRadius: 8,
            backgroundColor: Colors.white,
            callback: () {
              Navigator.of(context).pop();
            },
            iconSVG: "assets/icons/arrowBack.svg",
            height: 40,
            width: 40,
            fit: BoxFit.scaleDown,
          ),
        ),
      ),
      actions: [

        action != null ? Padding(
          padding: EdgeInsets.only(right: 17, top: 16),
          child: FittedBox(
            child: CustomIconButton(
              borderRadius: 8,
              backgroundColor: Colors.white,
              callback: () => action,
              iconSVG: "assets/icons/more.svg",
              height: 40,
              width: 40,
              fit: BoxFit.scaleDown,
            ),
          ),
        ) : SizedBox(),

      ],
    );
  }
}
