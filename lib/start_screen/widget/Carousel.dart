import 'package:flutter/material.dart';
import 'package:head_hunter/start_screen/widget/CarouselItem.dart';

class Carousel extends StatelessWidget {
  const Carousel({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 429,
      child: CarouselView.weighted(
          itemSnapping: true,
          enableSplash: false,
          flexWeights: [3, 1],
          children: List.generate(
              3, (index) => Carouselitem(listString: _item[index]))),
    );
  }
}

List<Map<String, dynamic>> _item = [
  {
    'image': 'assets/images/image 6.png',
    'text': 'Лучшая платформа для сантехников в 2025 году!'
  },
  {
    'image': 'assets/images/image 8.png',
    'text': 'Помогаем не только клиентам, но и работникам!'
  },
  {
    'image': 'assets/images/image 9.png',
    'text': 'Выбирай стабильный заработок и комфорт!'
  },
];
