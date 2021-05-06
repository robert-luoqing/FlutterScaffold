import 'dart:io';

import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class SPImagePicker {
  final _picker = ImagePicker();
  SPImagePicker();

  Future<String?> getImageFromCamera(
      {double? maxWidth, double? maxHeight, int? imageQuality}) async {
    var pickedFile = await _picker.getImage(
        source: ImageSource.camera,
        maxHeight: maxHeight,
        maxWidth: maxWidth,
        imageQuality: imageQuality);
    if (pickedFile != null) {
      return pickedFile.path;
    } else {
      return null;
    }
  }

  Future<String?> getImageFromGallery(
      {double? maxWidth, double? maxHeight, int? imageQuality}) async {
    var pickedFile = await _picker.getImage(
        source: ImageSource.gallery,
        maxHeight: maxHeight,
        maxWidth: maxWidth,
        imageQuality: imageQuality);
    if (pickedFile != null) {
      return pickedFile.path;
    } else {
      return null;
    }
  }

  Future<List<ByteData>> getImages({
    required int maxImages,
    double? maxWidth,
    double? maxHeight,
    int? imageQuality,
    bool enableCamera = false,
  }) async {
    List<Asset> assets = await MultiImagePicker.pickImages(
        maxImages: maxImages, enableCamera: enableCamera);
    List<ByteData> results = <ByteData>[];
    if (maxWidth == null &&
        maxHeight == null &&
        (imageQuality == null || imageQuality == 100)) {
      for (var asset in assets) {
        ByteData byteData = await asset.getByteData();
        results.add(byteData);
      }
    } else {
      for (var asset in assets) {
        ByteData byteData = await asset.getThumbByteData(300, 300, quality: 60);
        results.add(byteData);
      }
    }

    return results;
  }

  Future<String?> getVideoFromCamera({Duration? maxDuration}) async {
    var pickedFile = await _picker.getVideo(
        source: ImageSource.camera, maxDuration: maxDuration);
    if (pickedFile != null) {
      return pickedFile.path;
    } else {
      return null;
    }
  }

  Future<String?> getVideoFromGallery({Duration? maxDuration}) async {
    var pickedFile = await _picker.getVideo(
        source: ImageSource.gallery, maxDuration: maxDuration);
    if (pickedFile != null) {
      return pickedFile.path;
    } else {
      return null;
    }
  }
}
