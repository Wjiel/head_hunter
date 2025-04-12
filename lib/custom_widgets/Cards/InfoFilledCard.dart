import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:getwidget/components/shimmer/gf_shimmer.dart';

import 'CustomFilledCard.dart';

class InfoFilledCard extends StatelessWidget {
  final void Function()? onTap;
  final String title;
  final int? count;
  final bool? withAlert;
  final String? countText;
  final String assetName;
  final Color backgroundColor;
  const InfoFilledCard({
    super.key, required this.onTap, required this.backgroundColor, required this.title, required this.count, this.countText, required this.assetName, this.withAlert,
  });

  @override
  Widget build(BuildContext context) {
    return CustomFilledCard(
      onTap: onTap != null ? ()=> onTap!() : null,
      gradient: withAlert == true
          ? RadialGradient(colors: [Color(0xFFFF595C), Colors.white,],radius: 1.5, center: Alignment.topRight)
          : null,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              AutoSizeText(title,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: Color(0xFF363636),
                ),
              ),

              SizedBox(height: 8,),

              Row(
                spacing: 8,
                children: [

                  if (count != null) AutoSizeText(count.toString(),
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                      color: Color(0xFF363636),
                    ),
                  ) else ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: GFShimmer(
                        mainColor: Colors.grey[300]!,
                        secondaryColor: Colors.grey[400]!,
                        child: Container(
                          color: Colors.white,
                          child: Text("10",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
                              color: Color(0xFF363636),
                            ),
                          ),
                        ),
                    ),
                  ),

                  AutoSizeText(countText ?? "",
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                      color: Color(0xFF0065FF),
                    ),
                  ),

                ],
              ),

            ],
          ),

          Spacer(),

          Ink(
            padding: EdgeInsets.all(6),
            decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(8)
            ),
            child: SvgPicture.asset("assets/icons/$assetName.svg"),
          ),

        ],
      ),
    );
  }
}
