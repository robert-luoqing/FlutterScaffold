import 'package:flutter/material.dart';

Size getTextSize(String text, TextStyle style, double maxWidth) {
  var textPainter = TextPainter(
    textDirection: TextDirection.ltr,
    textAlign: TextAlign.left,
  );
  textPainter.text = TextSpan(
    text: text,
    style: style,
  );
  textPainter.textAlign = TextAlign.left;
  textPainter.maxLines = 1;
  // textPainter.ellipsis = "...";

  textPainter.layout(maxWidth: maxWidth);
  var width = textPainter.width;
  var height = textPainter.height;
  return Size(width, height);
}
