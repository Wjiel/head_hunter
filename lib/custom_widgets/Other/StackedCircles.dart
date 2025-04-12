import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class StackedCircles extends StatelessWidget {
  final List<String>? assetsNames;
  final List<String>? photosBase64;
  final Color? backgroundColor;
  final int? maxItems;
  final int? totalCount;

  const StackedCircles.withSvgIcons(
      {
        Key? key,
        required this.assetsNames,
        required this.backgroundColor,
        this.maxItems,
        this.totalCount,
      }) : photosBase64 = null, super(key: key);

  const StackedCircles.withPhoto(
      {
        Key? key,
        required this.photosBase64,
        this.maxItems,
        this.totalCount,
      })
      : assetsNames = null,
        backgroundColor = null,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: List.generate(
        photosBase64 == null ? assetsNames?.length ?? 0 : photosBase64?.length?? 0,
            (i) {
          if(i < (maxItems ?? 4)) {
            return Padding(
              padding:  EdgeInsets.only(left: i*20.toDouble()),
              child: Material(
                color: Colors.transparent,
                child: Ink(
                  padding: photosBase64 == null ? EdgeInsets.all(8) : EdgeInsets.zero,
                  height: 32,
                  width: 32,
                  decoration: BoxDecoration(
                      color: backgroundColor,
                      shape: BoxShape.circle,
                      image: photosBase64 != null && photosBase64![i].isNotEmpty
                          ? DecorationImage(image: MemoryImage(base64Decode(photosBase64![i]),), fit: BoxFit.cover)
                          : DecorationImage(image: AssetImage("assets/images/emptyAvatar.png")),
                      border: Border.all(color: Colors.white, width: 1)
                  ),
                  child: photosBase64 == null ? SvgPicture.asset("assets/icons/${assetsNames![i]}.svg") : null,
                ),
              ),
            );
          } else if (i == (maxItems??3+1)) {
            return Padding(
              padding: EdgeInsets.only(left: i*20.toDouble()),
              child: Material(
                color: Colors.transparent,
                child: Ink(
                  padding: photosBase64 == null ? EdgeInsets.all(8) : EdgeInsets.zero,
                  height: 32,
                  width: 32,
                  decoration: BoxDecoration(
                    color: Color(0xFFD9E8FF),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: AutoSizeText(
                      totalCount == null ? photosBase64 == null
                        ? "+ ${assetsNames!.length - (maxItems ?? 4)}"
                        : "+ ${photosBase64!.length - (maxItems ?? 4)}"
                      : "+ ${totalCount! - photosBase64!.length +1}",
                      minFontSize: 8,
                      overflowReplacement: AutoSizeText("+99",
                        minFontSize: 8,
                        style: TextStyle(
                            letterSpacing: -1,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF0065FF)
                        ),
                      ),
                      style: TextStyle(
                          letterSpacing: -1,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF0065FF)
                      ),
                    ),
                  ),
                ),
              ),
            );
          } else {
            return SizedBox();
          }
        },
      ),
    );
  }
}