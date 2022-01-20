import 'dart:io';

import 'network_image.dart';
import '../utils/image_util.dart';
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
  const SPImage(
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
    switch (widget.imageType) {
      case SPImageType.assetImage:
        return Image.asset(widget.url,
            width: widget.width, height: widget.height, fit: widget.fit);

      case SPImageType.networkImage:
        if (widget.url.trim() == "") {
          if (widget.defaultUrl == null) {
            return SizedBox(width: widget.width, height: widget.height);
          } else {
            return Image.asset(widget.defaultUrl!,
                width: widget.width, height: widget.height, fit: widget.fit);
          }
        } else {
          return SPNetworkImage(
              url: SPImageUtil().getFullImageUrl(widget.url),
              defaultUrl: widget.defaultUrl,
              width: widget.width,
              height: widget.height,
              fit: widget.fit);
        }
      case SPImageType.iconImage:
        return SizedBox(
            width: widget.width,
            height: widget.height,
            child: Icon(
              IconData(int.parse(widget.url)),
            ));
      case SPImageType.fileImage:
        return Image.file(File(widget.url),
            width: widget.width, height: widget.height, fit: widget.fit);
    }
  }
}
