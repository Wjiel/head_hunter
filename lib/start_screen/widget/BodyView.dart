import 'package:flutter/material.dart';
import 'package:head_hunter/start_screen/widget/Carousel.dart';
import 'package:head_hunter/start_screen/widget/SignInUp.dart';

class BodyViewScreen extends StatelessWidget {
  const BodyViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SizedBox(height: 45,),
        Carousel(),
        SignInUp(),
      ],
    );
  }
}