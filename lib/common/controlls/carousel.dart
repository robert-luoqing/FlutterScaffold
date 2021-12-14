import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

typedef SPCarouselPress = void Function(dynamic item);
typedef SPCarouselItemBuild = Widget Function(dynamic item);
typedef SPCarouselChanged = void Function(int index);

class SPCarouselView extends StatefulWidget {
  @override
  _SPCarouselViewState createState() => _SPCarouselViewState();
  final List<dynamic> items;
  final SPCarouselPress? onPress;
  final SPCarouselItemBuild builder;
  final SPCarouselChanged? onChange;
  final double aspectRatio;

  SPCarouselView(
      {required this.items,
      required this.builder,
      this.aspectRatio = 16 / 9,
      this.onPress,
      this.onChange});
}

class _SPCarouselViewState extends State<SPCarouselView> {
  int _current = 0;
  CarouselController carouselController = CarouselController();
  List<Widget> imageSliders = [];

  @override
  initState() {
    buildItems();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant SPCarouselView oldWidget) {
    super.didUpdateWidget(oldWidget);
    buildItems();
  }

  buildItems() {
    this.imageSliders = this.widget.items.map((item) {
      return GestureDetector(
        onTap: () {
          if (this.widget.onPress != null) {
            this.widget.onPress!(item);
          }
        },
        child: Container(
          child: Container(
            margin: EdgeInsets.all(5.0),
            child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                child: Stack(
                  children: <Widget>[
                    Positioned(
                        top: 0,
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: this.widget.builder(item))
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
        carouselController: carouselController,
        options: CarouselOptions(
            autoPlay: true,
            enlargeCenterPage: true,
            viewportFraction: 1.0,
            aspectRatio: this.widget.aspectRatio,
            initialPage: 0,
            onPageChanged: (index, reason) {
              setState(() {
                _current = index;
              });
              if (this.widget.onChange != null) {
                this.widget.onChange!(index);
              }
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
