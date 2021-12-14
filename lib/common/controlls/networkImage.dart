import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class SPNetworkImage extends StatefulWidget {
  final String url;
  final String? defaultUrl;
  final double? width;
  final double? height;
  final BoxFit fit;
  const SPNetworkImage(
      {required this.url,
      this.defaultUrl,
      this.width,
      this.height,
      this.fit = BoxFit.fill,
      Key? key})
      : super(key: key);

  @override
  _SPImageState createState() => _SPImageState();
}

class _SPImageState extends State<SPNetworkImage> {
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
        // placeholder: (context, url) => CircularProgressIndicator(),
        imageUrl: this.widget.url,
        errorWidget: (context, url, error) => this.widget.defaultUrl != null
            ? Image.asset(this.widget.defaultUrl!,
                width: this.widget.width,
                height: this.widget.height,
                fit: this.widget.fit)
            : Container(),
        width: this.widget.width,
        height: this.widget.height,
        fit: this.widget.fit);
  }
}
