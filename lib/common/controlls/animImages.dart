import 'package:flutter/material.dart';
import 'package:tween_image_widget/tween_image_widget.dart';

class AnimImages extends StatefulWidget {
  const AnimImages({Key? key, required this.imagePattern}) : super(key: key);

  final String imagePattern;

  @override
  _AnimImagesState createState() => _AnimImagesState();
}

class _AnimImagesState extends State<AnimImages> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 80,
      height: 80,
      child: Container(
          decoration: BoxDecoration(
              color: Colors.black, borderRadius: BorderRadius.circular(5)),
          child: TweenImageWidget(
            ImagesEntry(1, 4, widget.imagePattern),
            durationMilliseconds: 700,
            repeat: true,
          )),
    );
  }
}
