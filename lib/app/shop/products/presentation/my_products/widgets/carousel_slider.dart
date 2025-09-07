import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';

class Carousel extends StatefulWidget {
  const Carousel({super.key});

  @override
  State<Carousel> createState() => _CarouselState();

  static builder({
    required int itemCount,
    required Container Function(
      dynamic context,
      dynamic index,
      dynamic realIndex,
    )
    itemBuilder,
    required CarouselOptions options,
  }) {}
}

class _CarouselState extends State<Carousel> {
  int currentIndex = 0;

  final List<String> imageUrls = [
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR3fQSZEIoZPz36sWHuK9mSDR9vH1C2KeAt-Q&s',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRAyCJsjPVHlsh-8IS4mZwGiMpSC2s9HUaQEg&s',
    'https://www.unicef.org/supply/sites/unicef.org.supply/files/styles/hero_extended/public/Rwanda-UN0319015-2019.jpg.webp?itok=wH1-7bcK',
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider.builder(
          itemCount: imageUrls.length,
          itemBuilder: (context, index, realIndex) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 5.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  imageUrls[index],
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
            );
          },
          options: CarouselOptions(
            height: 200.0,
            enlargeCenterPage: true,
            autoPlay: true,
            aspectRatio: 16 / 9,
            autoPlayCurve: Curves.fastOutSlowIn,
            enableInfiniteScroll: true,
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            viewportFraction: 0.8,
            onPageChanged: (index, reason) {
              setState(() => currentIndex = index);
            },
          ),
        ),
        const SizedBox(height: 8),
        Center(
          child: DotsIndicator(
            dotsCount: imageUrls.length,
            position: currentIndex,
            decorator: const DotsDecorator(
              activeColor: Colors.blue,
              size: Size.square(8.0),
              activeSize: Size(18.0, 8.0),
              activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
