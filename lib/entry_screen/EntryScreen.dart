import 'package:flutter/material.dart';
import 'package:head_hunter/custom_widgets/TextFields/CustomTextField.dart';

class EntryScreen extends StatelessWidget {
  const EntryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(preferredSize: Size(0, 0), child: SizedBox()),
      body: ListView(
        children: [
          Image.asset(
            'assets/images/figure1.png',
            fit: BoxFit.cover,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Вход',
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 30,
                    fontFamily: 'RobotoSerif',
                  ),
                ),
                SizedBox(height: 40),
                CustomTextField(
                  hint: 'dsadasd@gmail.com',
                  controller: TextEditingController(),
                ),
                SizedBox(height: 25),
                CustomTextField(
                  hint: 'verystrongpassword',
                  controller: TextEditingController(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
