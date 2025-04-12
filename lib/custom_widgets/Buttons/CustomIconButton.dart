import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomIconButton extends StatelessWidget {
  final void Function()? callback;
  final double height;
  final double width;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color? backgroundColor;
  final double? borderRadius;
  final List<BoxShadow>? boxShadow;
  final String? iconSVG;
  final IconData? icon;
  final double? iconSize;
  final Color? iconColor;
  final BoxFit? fit;
  final bool isOutlined;
  final bool? withBadge;
  const CustomIconButton({super.key, required this.callback, required this.height, required this.width, this.backgroundColor, this.borderRadius, this.padding, this.icon,  this.fit, this.boxShadow, this.iconSVG, this.iconSize, this.iconColor, this.margin, this.withBadge}) : isOutlined = false;
  const CustomIconButton.outlined({super.key, required this.callback, required this.height, required this.width, this.backgroundColor, this.borderRadius, this.padding, this.icon,  this.fit, this.boxShadow, this.iconSVG, this.iconSize, this.iconColor, this.margin, this.withBadge}) : isOutlined = true;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Stack(
        fit: StackFit.passthrough,
        alignment: Alignment.topRight,
        children: [

          InkWell(
            splashColor: Colors.blue[800]!.withAlpha(40),
            borderRadius: BorderRadius.circular(borderRadius ?? 0),
            onTap: callback != null ? ()=> callback!() : null,
            child: Padding(
              padding: margin ?? const EdgeInsets.all(0),
              child: Ink(
                height: height,
                width: width,
                padding: padding,
                decoration: BoxDecoration(
                  border: isOutlined ? Border.all(width: 0.5, color: Color(0xFFDBDFEA)) : null,
                  boxShadow: boxShadow,
                  color: backgroundColor,
                  borderRadius: BorderRadius.circular(borderRadius ?? 0),
                ),
                child: iconSVG != null
                    ? SvgPicture.asset(iconSVG!, fit: fit != null ? fit! : BoxFit.scaleDown,  colorFilter: iconColor != null ? ColorFilter.mode(iconColor!, BlendMode.srcIn) : null,)
                    : Icon(icon, size: iconSize, color: iconColor,),
              ),
            ),
          ),

          AnimatedSwitcher(
              duration: Duration(milliseconds: 200),
              switchOutCurve: Curves.bounceInOut,
              switchInCurve: Curves.bounceInOut,
              child: withBadge == true
                  ? Align(
                key: UniqueKey(),
                alignment: Alignment.topRight,
                child: Badge(
                  smallSize: 10,
                  backgroundColor: Colors.red,
                ),
              )
                  : SizedBox(
                key: UniqueKey(),
                height: 1,
                width: 1,
              ),
          ),

        ],
      ),
    );
  }
}
