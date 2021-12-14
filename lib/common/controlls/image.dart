import 'dart:io';

import '../../../common/controlls/networkImage.dart';
import '../../../common/utils/imageUtil.dart';
import 'package:flutter/material.dart';

enum ImageType { assetImage, networkImage, iconImage, fileImage }

ImageType convertImageTypeFromModel(int type) {
  if (type == 1) {
    return ImageType.iconImage;
  } else if (type == 2) {
    return ImageType.assetImage;
  } else if (type == 3) {
    return ImageType.networkImage;
  } else {
    return ImageType.networkImage;
  }
}

class SPImage extends StatefulWidget {
  final ImageType imageType;
  final String url;
  final String? defaultUrl;
  final double? width;
  final double? height;
  final BoxFit fit;
  SPImage(
      {Key? key,
      required this.imageType,
      required this.url,
      this.defaultUrl,
      this.width,
      this.height,
      this.fit = BoxFit.fill})
      : super(key: key);

  @override
  _SPImageState createState() => _SPImageState();
}

class _SPImageState extends State<SPImage> {
  @override
  Widget build(BuildContext context) {
    switch (this.widget.imageType) {
      case ImageType.assetImage:
        return Image.asset(this.widget.url,
            width: this.widget.width,
            height: this.widget.height,
            fit: this.widget.fit);

      case ImageType.networkImage:
        if (this.widget.url.trim() == "") {
          if (this.widget.defaultUrl == null) {
            return Container(
                width: this.widget.width, height: this.widget.height);
          } else {
            return Image.asset(this.widget.defaultUrl!,
                width: this.widget.width,
                height: this.widget.height,
                fit: this.widget.fit);
          }
        } else {
          return SPNetworkImage(
              url: SPImageUtil().getFullImageUrl(this.widget.url),
              defaultUrl: this.widget.defaultUrl,
              width: this.widget.width,
              height: this.widget.height,
              fit: this.widget.fit);
        }
      case ImageType.iconImage:
        return SizedBox(
            width: this.widget.width,
            height: this.widget.height,
            child: Icon(
              IconData(int.parse(this.widget.url)),
            ));
      case ImageType.fileImage:
        return Image.file(File(this.widget.url),
            width: this.widget.width,
            height: this.widget.height,
            fit: this.widget.fit);
    }
  }
}
