import 'package:flutter/material.dart';
import '../Buttons/CustomFilledButton.dart';

Future showCustomActionDialog(BuildContext context, {required String title}) async {


  String? _choice = await showDialog(context: context, builder: (context) {
    return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            insetPadding: EdgeInsets.symmetric(horizontal: 20),
            backgroundColor: Colors.white,
            title: Text(title,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Color(0xFF363636),
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  height: 1.2
              ),
            ),
            contentPadding: EdgeInsets.symmetric(vertical: 24, horizontal: 20),
            content: Column(
              spacing: 20,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [


                Row(
                  spacing: 10,
                  children: [

                    Expanded(
                      child: SizedBox(
                        height: 40,
                        width: MediaQuery.of(context).size.width,
                        child: CustomFilledButton(
                          backgroundColor: Color(0xFFFF2E2E),
                          textColor: Colors.white,
                          padding: EdgeInsets.all(8),
                          callback: () {
                            Navigator.pop(context, "Нет");
                          },
                          text: "Нет",
                        ),
                      ),
                    ),

                    Expanded(
                      child: SizedBox(
                        height: 40,
                        width: MediaQuery.of(context).size.width,
                        child: CustomFilledButton(
                          padding: EdgeInsets.all(8),
                          callback: () {
                            Navigator.pop(context, "Да");
                          },
                          text: "Да",
                        ),
                      ),
                    ),

                  ],
                ),



              ],
            ),
          );
        }
    );
  });
  return _choice;
}
