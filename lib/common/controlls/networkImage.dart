import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class SPNetworkImage extends StatefulWidget {
  final String url;
  final String? defaultUrl;
  final bool defaultUrlIsAsset;
  final double? width;
  final double? height;
  final BoxFit fit;
  final bool showLoadImageProgress;
  const SPNetworkImage(
      {required this.url,
      this.defaultUrl,
      this.width,
      this.height,
      this.fit = BoxFit.fill,
      this.defaultUrlIsAsset = true,
      this.showLoadImageProgress = false,
      Key? key})
      : super(key: key);

  @override
  _SPImageState createState() => _SPImageState();
}

class _SPImageState extends State<SPNetworkImage> {
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
        placeholder: this.widget.showLoadImageProgress
            ? (context, url) => CircularProgressIndicator()
            : null,
        imageUrl: this.widget.url,
        errorWidget: (context, url, error) {
          if (this.widget.defaultUrl != null) {
            if (this.widget.defaultUrlIsAsset) {
              return Image.asset(this.widget.defaultUrl!,
                  width: this.widget.width,
                  height: this.widget.height,
                  fit: this.widget.fit);
            } else {
              return Image.network(this.widget.defaultUrl!,
                  width: this.widget.width,
                  height: this.widget.height,
                  fit: this.widget.fit);
            }
          }

          return Container();
        },
        width: this.widget.width,
        height: this.widget.height,
        fit: this.widget.fit);
  }
}
