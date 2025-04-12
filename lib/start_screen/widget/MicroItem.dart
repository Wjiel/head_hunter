import 'package:flutter/material.dart';

class MicroItem extends StatelessWidget {
  final String strigImage;
  const MicroItem({required this.strigImage});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(30),
      onTap: () {},
      child: Ink(
        padding: const EdgeInsets.symmetric(vertical: 12.5, horizontal: 12.5),
        decoration: BoxDecoration(
          color: const Color(0x3DDDD3B7),
          shape: BoxShape.circle,
        ),
        child: Image.asset(
          strigImage,
          filterQuality: FilterQuality.high,
        ),
      ),
    );
  }
}

List<String> pictureForSign = [
  'assets/images/yaPNG.png',
  'assets/images/vkPNG.png',
  'assets/images/gosPNG.png',
];
