import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class CircularProgressBar extends StatefulWidget {
  final double minValue;
  final double maxValue;
  final int changedPercent;
  final double initialValue;
  final Widget icon;
  final String calculationCriteria;
  final double size;

  // New customizable parameters
  final Color? backgroundColor;
  final Gradient progressGradient;
  final Color? markColor;
  final Color? borderColor;
  final Color? dialogBackgroundColor;
  final Color? dialogTextColor;
  final Color? buttonColor;
  final Color? buttonTextColor;
  final Color? cancelButtonColor;
  final Color? cancelButtonTextColor;

  const CircularProgressBar({
    Key? key,
    required this.minValue,
    required this.maxValue,
    required this.initialValue,
    required this.icon,
    required this.calculationCriteria,
    this.size = 250.0, // Default size
    this.backgroundColor,
    required this.progressGradient,
    this.markColor,
    this.borderColor,
    this.dialogBackgroundColor,
    this.dialogTextColor,
    this.buttonColor,
    this.buttonTextColor,
    this.cancelButtonColor,
    this.cancelButtonTextColor, required this.changedPercent,
  }) : super(key: key);

  @override
  _CircularProgressBarState createState() => _CircularProgressBarState();
}

class _CircularProgressBarState extends State<CircularProgressBar> {
  late double _currentValue;

  @override
  void initState() {
    super.initState();
    _currentValue = widget.initialValue.clamp(widget.minValue, widget.maxValue);
  }

  double get currentValue => _currentValue;

  double _getProgressPercentage(double value) {
    return ((value - widget.minValue) / (widget.maxValue - widget.minValue)) * 100;
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    double progressPercentage = _getProgressPercentage(currentValue);

    return Stack(
      alignment: Alignment.center,
      children: [
        CustomPaint(
          size: Size(widget.size, widget.size),
          painter: CirclePainter(
            progressPercentage,
            widget.maxValue,
            isDarkMode,
            currentValue,
            widget.minValue,
            progressGradient: widget.progressGradient,
            backgroundColor: widget.backgroundColor,
            markColor: widget.markColor,
            borderColor: widget.borderColor,
          ),
        ),
        Column(
          spacing: 8,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "${currentValue.ceil()}%",
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.w500,
                color: Color(0xFF363636)
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                widget.icon,
                SizedBox(width: 3,),
                Text(
                  widget.changedPercent >= 1 ? "+${widget.changedPercent}%" : "${widget.changedPercent}%",
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: widget.changedPercent >= 0 ? Color(0xFF0065FF) : Color(0xFFE85347)
                  ),
                ),
                SizedBox(width: 8,),
                Text(
                  widget.calculationCriteria,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Color(0x80363636)
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

class CirclePainter extends CustomPainter {
  final double percentage;
  final double maxValue;
  final bool isDarkMode;
  final Gradient progressGradient;
  final double currentValue;
  final double minValue;
  final Color? backgroundColor;
  final Color? markColor;
  final Color? borderColor;

  CirclePainter(
      this.percentage,
      this.maxValue,
      this.isDarkMode,
      this.currentValue,
      this.minValue, {
        this.backgroundColor,
        required this.progressGradient,
        this.markColor,
        this.borderColor,
      });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint backgroundPaint = Paint()
      ..color = backgroundColor ?? Color(0xD0065FF)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 24
      ..strokeCap = StrokeCap.round;

    final Paint progressPaint = Paint()
      ..shader = progressGradient.createShader(Rect.fromCircle(
          center: Offset(size.width / 2, size.height / 2),
          radius: size.width / 2))
      ..style = PaintingStyle.stroke
      ..strokeWidth = 24
      ..strokeCap = StrokeCap.round; // Закругленные края

    final Paint markPaint = Paint()
      ..color = Colors.transparent
      ..style = PaintingStyle.fill;

    final Paint borderPaint = Paint()
      ..color = borderColor ?? (isDarkMode ? Colors.grey.shade800 : Colors.grey.shade200)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 24;

    final double radius = size.width / 2;

    // Draw background
    canvas.drawCircle(Offset(radius, radius), radius*1.13, backgroundPaint);

    // Draw border
    canvas.drawCircle(Offset(radius, radius), radius, borderPaint);

    // Draw progress arc
    double sweepAngle = (percentage / 100) * 2 * pi;
    canvas.drawArc(
      Rect.fromCircle(center: Offset(radius, radius), radius: radius),
      -pi / 2,
      sweepAngle,
      false,
      progressPaint,
    );

    // Draw marks
    int numberOfMarks = (maxValue - minValue).round();
    double markRadius = 3;
    double margin = 24;
    for (int i = 0; i <= numberOfMarks; i++) {
      double angle = -pi / 2 + (2 * pi * i / numberOfMarks);
      double x = radius + cos(angle) * (radius - margin);
      double y = radius + sin(angle) * (radius - margin);
      canvas.drawCircle(Offset(x, y), markRadius, markPaint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}