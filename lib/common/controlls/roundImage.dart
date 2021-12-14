import '../../../common/controlls/image.dart';
import 'package:flutter/widgets.dart';

class SPRoundImage extends StatelessWidget {
  final double? width;
  final double? height;
  final double radius;
  final String url;
  final ImageType imageType;
  final String? defaultUrl;
  final Color? backgroundColor;
  const SPRoundImage(
      {this.width,
      this.height,
      required this.radius,
      required this.url,
      required this.imageType,
      this.defaultUrl,
      this.backgroundColor,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(this.radius)),
      child: Container(
        color: backgroundColor,
        child: SPImage(
          url: this.url,
          imageType: this.imageType,
          defaultUrl: this.defaultUrl,
          width: this.width,
          height: this.height,
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
