import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

typedef SPCarouselPress = void Function(int index);

class SPCarouselView extends StatefulWidget {
  @override
  _SPCarouselViewState createState() => _SPCarouselViewState();
  final List<String> items;
  final SPCarouselPress? onPress;

  SPCarouselView({required this.items, this.onPress});
}

class _SPCarouselViewState extends State<SPCarouselView> {
  int _current = 0;
  CarouselController buttonCarouselController = CarouselController();
  List<Widget> imageSliders = [];

  initState() {
    buildItems();
    super.initState();
  }

  buildItems() {
    this.imageSliders = this.widget.items.map((item) {
      int index = this.widget.items.indexOf(item);
      return GestureDetector(
        onTap: () {
          if (this.widget.onPress != null) {
            this.widget.onPress!(index);
          }
        },
        child: Container(
          child: Container(
            margin: EdgeInsets.all(5.0),
            child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                child: Stack(
                  children: <Widget>[
                    Image.network(item, fit: BoxFit.cover, width: 1000.0),
                  ],
                )),
          ),
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      CarouselSlider(
        items: imageSliders,
        carouselController: buttonCarouselController,
        options: CarouselOptions(
            autoPlay: true,
            enlargeCenterPage: true,
            viewportFraction: 1.0,
            aspectRatio: 2.0,
            initialPage: 0,
            onPageChanged: (index, reason) {
              setState(() {
                _current = index;
              });
            }),
      ),
      Positioned(
          bottom: 10,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: imageSliders.map((item) {
              int index = imageSliders.indexOf(item);
              return Container(
                width: 8.0,
                height: 8.0,
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _current == index
                      ? Color.fromRGBO(0, 0, 0, 0.9)
                      : Color.fromRGBO(0, 0, 0, 0.4),
                ),
              );
            }).toList(),
          )),
    ]);
  }
}
