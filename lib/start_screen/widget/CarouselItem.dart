import 'package:flutter/material.dart';
import 'package:head_hunter/colors.dart';

class Carouselitem extends StatelessWidget {
  final Map<String, dynamic> listString;
  const Carouselitem({super.key, required this.listString});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: Image.asset(listString['image']).image, fit: BoxFit.cover),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          Container(
            width: 242,
            height: 163,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(46),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: highBlue,
                    blurRadius: 116.3,
                  ),
                ]),
          ),
          Padding(
            padding: EdgeInsets.only(left: 36, bottom: 30, right: 60),
            child: Text(
              listString['text'],
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'RobotoSerif',
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                  shadows: <Shadow>[
                    Shadow(
                      color: Colors.black,
                      blurRadius: 1,
                    ),
                  ]),
              overflow: TextOverflow.clip,
              maxLines: 5,
            ),
          )
        ],
      ),
    );
  }
}
