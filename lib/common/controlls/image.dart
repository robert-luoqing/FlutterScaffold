import 'dart:io';

import '../../../common/controlls/networkImage.dart';
import '../../../common/utils/imageUtil.dart';
import 'package:flutter/material.dart';

enum SPImageType { assetImage, networkImage, iconImage, fileImage }

SPImageType convertImageTypeFromModel(int type) {
  if (type == 1) {
    return SPImageType.iconImage;
  } else if (type == 2) {
    return SPImageType.assetImage;
  } else if (type == 3) {
    return SPImageType.networkImage;
  } else {
    return SPImageType.networkImage;
  }
}

class SPImage extends StatefulWidget {
  final SPImageType imageType;
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
      case SPImageType.assetImage:
        return Image.asset(this.widget.url,
            width: this.widget.width,
            height: this.widget.height,
            fit: this.widget.fit);

      case SPImageType.networkImage:
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
      case SPImageType.iconImage:
        return SizedBox(
            width: this.widget.width,
            height: this.widget.height,
            child: Icon(
              IconData(int.parse(this.widget.url)),
            ));
      case SPImageType.fileImage:
        return Image.file(File(this.widget.url),
            width: this.widget.width,
            height: this.widget.height,
            fit: this.widget.fit);
    }
  }
}
