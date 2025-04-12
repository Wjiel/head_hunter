import 'dart:ui';

import 'package:flutter/material.dart';

class BlurGradientOverlay extends StatefulWidget {
  final Widget child;
  final bool isLoading;

  const BlurGradientOverlay({
    Key? key,
    required this.child,
    required this.isLoading,
  }) : super(key: key);

  @override
  _BlurGradientOverlayState createState() => _BlurGradientOverlayState();
}

class _BlurGradientOverlayState extends State<BlurGradientOverlay>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    // Обновляем состояние при изменении isLoading
    widget.isLoading ? _startAnimation() : _stopAnimation();
  }

  @override
  void didUpdateWidget(covariant BlurGradientOverlay oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.isLoading != oldWidget.isLoading) {
      widget.isLoading ? _startAnimation() : _stopAnimation();
    }
  }

  void _startAnimation() {
    _controller.forward();
  }

  void _stopAnimation() {
    _controller.reverse();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,

        // Блюр
        AnimatedOpacity(
          opacity: widget.isLoading ? _opacityAnimation.value : 0.0,
          duration: const Duration(milliseconds: 500),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
            child: Container(
              color: Colors.black.withOpacity(0.2),
            ),
          ),
        ),

        // SweepGradient
        Positioned.fill(
          child: AnimatedOpacity(
            opacity: widget.isLoading ? _opacityAnimation.value : 0.0,
            duration: const Duration(milliseconds: 500),
            child: IgnorePointer(
              ignoring: !widget.isLoading,
              child: Container(
                decoration: BoxDecoration(
                  gradient: SweepGradient(
                    center: Alignment.center,
                    startAngle: _controller.value * 2 * 3.14159,
                    endAngle: (_controller.value + 0.5) * 2 * 3.14159,
                    colors: [
                      Colors.transparent,
                      Colors.white.withOpacity(0.8),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}