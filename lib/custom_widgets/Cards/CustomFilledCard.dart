import 'package:flutter/material.dart';

class CustomFilledCard extends StatelessWidget {
  final void Function()? onTap;
  final double? borderRadius;
  final Color? backgroundColor;
  final Gradient? gradient;
  final EdgeInsetsGeometry? padding;
  final Widget child;
  const CustomFilledCard({super.key, this.borderRadius, this.backgroundColor, this.padding, required this.child, this.onTap, this.gradient});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap != null ? ()=> onTap!() : null,
        borderRadius: BorderRadius.circular(borderRadius ?? 8),
        child: Ink(
          padding: padding ?? EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius ?? 8),
            color: backgroundColor ?? Color(0xFFFFFFFF),
            gradient: gradient
          ),
          child: child,
        ),
      ),
    );
  }
}
