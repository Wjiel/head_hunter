

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomFilledButton extends StatelessWidget {
  final void Function()? callback;
  final EdgeInsetsGeometry? padding;
  final String text;
  final double? borderRadius;
  final Color? backgroundColor;
  final Color? textColor;
  final FontWeight? fontWeight;
  final double? fontSize;
  final bool? isAdditional;
  final String? svgAssetName;
  final Color? iconColor;

  final bool fullWidth;
  final bool isLoading;

  const CustomFilledButton({super.key, this.callback, this.padding, this.borderRadius, required this.text, this.isAdditional, this.backgroundColor, this.svgAssetName, this.textColor, this.iconColor, this.fontWeight, this.fontSize}) : fullWidth = true, isLoading = false;
  const CustomFilledButton.min({super.key, this.callback, this.padding, this.borderRadius, required this.text, this.isAdditional, this.backgroundColor, this.svgAssetName, this.textColor, this.iconColor, this.fontWeight, this.fontSize}) : fullWidth = false, isLoading = false;
  const CustomFilledButton.loading({super.key, this.callback, this.padding, this.borderRadius,  this.backgroundColor, required this.fullWidth, this.fontWeight, this.fontSize, }) : iconColor = null, text = '', isAdditional = false, svgAssetName = null, textColor = null, isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(borderRadius??6),
        onTap: callback != null ? ()=> callback!() : null,
        child: Ink(
          width: fullWidth == true ? MediaQuery.of(context).size.width : null,
          padding: padding ?? EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: backgroundColor != null ? backgroundColor : callback != null ? isAdditional == true ? Color(0xFFECECEC) : Color(0xFF0065FF) : Color(0xFFC8C8C8),
            borderRadius: BorderRadius.circular(borderRadius??6),
          ),
          child: Align(
            alignment: Alignment.center,
            child: LayoutBuilder(builder: (context, constraints) {
              if (isLoading == true) {
                return StatefulBuilder(builder: (context, state) {
                  return SizedBox(
                    height: 20,
                      width: 20,
                      child: CircularProgressIndicator(color: Colors.white,)
                  );
                });
              } else if (svgAssetName == null) {
                return Text(
                  text,
                  style: TextStyle(
                      height: 1,
                      fontWeight: fontWeight != null ? fontWeight : FontWeight.w600,
                      fontSize: fontSize != null ? fontSize : 14,
                      letterSpacing: 0.3,
                      color: textColor != null ? textColor : callback != null ? isAdditional == true ? Color(0xFF363636) : Colors.white : Color(0xFF363636)
                  ),
                );
              } else {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 8,
                  children: [
                    Text(
                      text,
                      style: TextStyle(
                        height: 1,
                          fontWeight: fontWeight != null ? fontWeight : FontWeight.w600,
                          fontSize: fontSize != null ? fontSize : 14,
                          letterSpacing: 0.3,
                          color: callback != null ? isAdditional == true ? Color(0xFF363636) : Colors.white : Color(0xFF363636)
                      ),
                    ),
                    SvgPicture.asset("assets/icons/$svgAssetName.svg",
                      colorFilter: iconColor !=null ? ColorFilter.mode(
                        iconColor!,
                        BlendMode.srcIn,
                      ) : null,
                    ),
                  ],
                );
              }
            })
          ),
        ),
      ),
    );
  }
}

class CustomFilledAddButton extends StatelessWidget {
  final void Function()? callback;
  final EdgeInsetsGeometry? padding;
  final String text;
  final double? borderRadius;
  const CustomFilledAddButton({super.key, this.callback, this.padding, this.borderRadius, required this.text});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(borderRadius??6),
      onTap: callback != null ? ()=> callback!() : null,
      child: Ink(
        width: MediaQuery.of(context).size.width,
        padding: padding ?? EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: callback != null ? Colors.white : Color(0xFFECECEC),
          borderRadius: BorderRadius.circular(borderRadius??6),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            AutoSizeText(
              text,
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  letterSpacing: 0.3,
                  color: Color(0xFF363636)
              ),
            ),

            SizedBox(width: 8,),

            Container(
              child: Icon(Icons.add, color: Color(0xFF363636),),
            )

          ],
        ),
      ),
    );
  }
}

