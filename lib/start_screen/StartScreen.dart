import 'package:flutter/material.dart';
import 'package:head_hunter/start_screen/widget/AppBar.dart';
import 'package:head_hunter/start_screen/widget/BodyView.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar,
      body: BodyViewScreen(),
    );
  }
}
