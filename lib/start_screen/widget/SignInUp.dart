import 'package:flutter/material.dart';
import 'package:head_hunter/colors.dart';
import 'package:head_hunter/custom_widgets/buttons/CustomButtonSign.dart';

class SignInUp extends StatelessWidget {
  const SignInUp({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 20,
        right: 20,
        top: 45,
      ),
      child: Column(
        children: [
          CustomButtonSign(
            inputWords: 'Войти',
          ),
          SizedBox(
            height: 15,
          ),
          InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: () {}, // Код
            child: Ink(
              width: double.infinity,
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
      ),
    );
  }
}
