import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class SingleChildDiv extends SingleChildRenderObjectWidget {
  const SingleChildDiv(
      {Key? key,
      required Widget child,
      this.width = double.infinity,
      this.height = double.infinity})
      : super(key: key, child: child);

  final double height;
  final double width;

  @override
  RenderObject createRenderObject(BuildContext context) {
    var renderObj =
        _SingleChildDivRenderObject(width: this.width, height: this.height);

    return renderObj;
  }

  @override
  void updateRenderObject(
      BuildContext context, covariant RenderObject renderObject) {
    var renderObj = renderObject as _SingleChildDivRenderObject;
    renderObj.width = this.width;
    renderObj.height = this.height;
    super.updateRenderObject(context, renderObject);
  }
}

class _SingleChildDivRenderObject extends RenderShiftedBox {
  _SingleChildDivRenderObject(
      {RenderBox? child, required double width, required double height})
      : super(child) {
    this._width = width;
    this._height = height;
  }
  late double _width;
  late double _height;

  set width(double w) {
    this._width = w;
    markNeedsLayout();
  }

  set height(double h) {
    this._height = h;
    markNeedsLayout();
  }

  @override
  void performLayout() {
    var realMaxWidth = this._width;
    if (realMaxWidth.isInfinite) {
      realMaxWidth = constraints.maxWidth;
    } else {
      if (!constraints.hasInfiniteWidth) {
        if (realMaxWidth > constraints.maxWidth) {
          realMaxWidth = constraints.maxWidth;
        }
      }
    }
    var realMaxHeight = this._height;
    if (realMaxHeight.isInfinite) {
      realMaxHeight = constraints.maxHeight;
    } else {
      if (!constraints.hasInfiniteHeight) {
        if (realMaxHeight > constraints.maxHeight) {
          realMaxHeight = constraints.maxHeight;
        }
      }
    }

    var realMinWidth = 0.0;
    var realMinHeight = 0.0;

    if (realMaxWidth.isFinite) {
      realMinWidth = realMaxWidth;
    }
    if (realMaxHeight.isFinite) {
      realMinHeight = realMaxHeight;
    }

    child!.layout(
      constraints.copyWith(
          maxWidth: realMaxWidth,
          minWidth: realMinWidth,
          maxHeight: realMaxHeight,
          minHeight: realMinHeight),
      parentUsesSize: true,
    );

    size = constraints.constrain(Size(child!.size.width, child!.size.height));
    BoxParentData parentData = child!.parentData as BoxParentData;
    parentData.offset = Offset(0.0, 0.0);
  }
}
