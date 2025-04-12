import 'package:flutter/material.dart';
import '../../MainScreen/MainScreen.dart';
import '../Buttons/CustomIconButton.dart';

class CustomAppBar extends StatelessWidget {
  final bool? canBack;
  final String title;
  final void Function()? action;
  const CustomAppBar({super.key, required this.title, this.action, this.canBack});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 10),
      child: AppBar(
        forceMaterialTransparency: true,
        centerTitle: true,
        title: Text(title,
          style: TextStyle(
              height: 1.2,
              color: Color(0xFF363636),
              fontSize: 16,
              fontWeight: FontWeight.w600
          ),
        ),
        leading: canBack != false ? FittedBox(
          child: CustomIconButton(
            borderRadius: 8,
            backgroundColor: Colors.white,
              callback: () async {
                if (Navigator.canPop(context)) {
                  Navigator.pop(context);
                } else {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> MainScreen()));
                }
              },
              iconSVG: "assets/icons/arrowBack.svg",
              height: 40,
              width: 40,
              fit: BoxFit.scaleDown,
          ),
        ) : SizedBox(),
        actions: [

          action != null ? Padding(
            padding: EdgeInsets.only(right: 7),
            child: FittedBox(
              child: CustomIconButton(
                borderRadius: 8,
                backgroundColor: Colors.white,
                callback: () => action,
                iconSVG: "assets/icons/star.svg",
                height: 40,
                width: 40,
                fit: BoxFit.scaleDown,
              ),
            ),
          ) : SizedBox(),

        ],
      ),
    );
  }
}
