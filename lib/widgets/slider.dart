// ignore_for_file: prefer_const_constructors

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class Carsolslider extends StatelessWidget {
  const Carsolslider({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 3),
      child: CarouselSlider(
        options: CarouselOptions(
          height: 160.0,
          autoPlay: true,
          enlargeCenterPage: true,
          enableInfiniteScroll: true,
          aspectRatio: 16 / 9,
          autoPlayCurve: Curves.fastOutSlowIn,
          autoPlayAnimationDuration: Duration(milliseconds: 600),
          viewportFraction: .93,
        ),
        items: [1, 2, 3, 4, 5].map((i) {
          return Builder(
            builder: (BuildContext context) {
              return Container(
                decoration: BoxDecoration(
                    image:
                        DecorationImage(image: AssetImage('assets/slide.png'))),
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(horizontal: 2.0),
              );
            },
          );
        }).toList(),
      ),
    );
  }
}
