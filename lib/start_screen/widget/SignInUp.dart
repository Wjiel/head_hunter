import 'package:flutter/material.dart';
import 'package:head_hunter/colors.dart';
import 'package:head_hunter/custom_widgets/buttons/CustomButtonSign.dart';
import 'package:head_hunter/entry_screen/EntryScreen.dart';

class SignInUp extends StatelessWidget {
  const SignInUp({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomButtonSign(
          function: (() {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EntryScreen(),
              ),
            );
          }),
          inputWords: 'Войти',
        ),
        SizedBox(
          height: 15,
        ),
        InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () {}, // Код
          child: Ink(
            padding: EdgeInsets.symmetric(vertical: 10.5),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: highBlue,
                  width: 3,
                )),
            child: Center(
              child: Text(
                'Зарегистрироваться',
                style: TextStyle(
                    color: highBlue,
                    fontFamily: 'RobotoSlab',
                    fontSize: 18,
                    fontWeight: FontWeight.w800),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
