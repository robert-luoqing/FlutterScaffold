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
        placeholder: widget.showLoadImageProgress
            ? (context, url) => const CircularProgressIndicator()
            : null,
        imageUrl: widget.url,
        errorWidget: (context, url, error) {
          if (widget.defaultUrl != null) {
            if (widget.defaultUrlIsAsset) {
              return Image.asset(widget.defaultUrl!,
                  width: widget.width, height: widget.height, fit: widget.fit);
            } else {
              return Image.network(widget.defaultUrl!,
                  width: widget.width, height: widget.height, fit: widget.fit);
            }
          }

          return Container();
        },
        width: widget.width,
        height: widget.height,
        fit: widget.fit);
  }
}
