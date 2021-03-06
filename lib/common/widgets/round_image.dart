import '../../../common/widgets/image.dart';
import 'package:flutter/widgets.dart';

class SPRoundImage extends StatelessWidget {
  final double? width;
  final double? height;
  final double radius;
  final String url;
  final SPImageType imageType;
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
    Widget content = ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(radius)),
      child: Container(
        color: backgroundColor,
        child: SPImage(
          url: url,
          imageType: imageType,
          defaultUrl: defaultUrl,
          width: width,
          height: height,
          fit: BoxFit.fill,
        ),
      ),
    );

    if (width != null || height != null) {
      content = Center(
        child: content,
      );
    }

    return content;
  }
}
