
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../Texts/CustomText.dart';
import 'CustomFilledCard.dart';

class NavigateFilledCard extends StatelessWidget {
  final String title;
  final String assetName;
  final Color? iconBackgroundColor;
  final Color? iconColor;
  final String? actionText;
  final void Function()? onTap;
  const NavigateFilledCard({
    super.key, required this.title, required this.assetName, this.iconBackgroundColor, this.onTap, this.iconColor, this.actionText,
  });

  @override
  Widget build(BuildContext context) {
    return CustomFilledCard(
        onTap: onTap != null ? onTap : null,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: SizedBox(
          height: 32,
          child: Row(
            children: [

              CircleAvatar(
                backgroundColor: iconBackgroundColor ?? Color(0x260065FF),
                child: SvgPicture.asset("assets/icons/$assetName.svg",
                  colorFilter: iconColor != null ? ColorFilter.mode(iconColor!, BlendMode.srcIn) : null,
                ),
              ),

              SizedBox(width: 16,),

              Expanded(
                child: Text(title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      height: 1.2,
                      color: Color(0xFF363636),
                      fontSize: 14,
                      fontWeight: FontWeight.w500
                  ),
                ),
              ),


              if (actionText != null) Expanded(
                  child: CustomText(actionText,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.right,
                    style: TextStyle(
                        height: 1.2,
                        color: Color(0xFF363636),
                        fontSize: 14,
                        fontWeight: FontWeight.w500
                    ),
                  )
              ),

              onTap != null ? Icon(Icons.arrow_forward_ios_rounded, size: 14, color: Color(0xFF363636),) : SizedBox()

            ],
          ),
        )
    );
  }
}