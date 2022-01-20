import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

import 'action_sheet.dart';

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

  Future<String?> getAndCropImageFromCameraAndGallery(
      {required BuildContext context,
      int maxWidth = 100,
      int maxHeight = 100,
      double ratioX = 1,
      double ratioY = 1}) async {
    var selectedType = await SPActionSheet.showActionSheet(
        context, {1: "图库", 2: "摄像机"},
        showCancelButton: true);
    String? imagePath;
    if (selectedType == 1) {
      imagePath = await SPImagePicker().getImageFromGallery();
    } else if (selectedType == 2) {
      imagePath = await SPImagePicker().getImageFromCamera();
    }
    if (imagePath != null) {
      var croppedFile = await ImageCropper.cropImage(
          sourcePath: imagePath,
          maxWidth: maxWidth,
          maxHeight: maxHeight,
          aspectRatio: CropAspectRatio(ratioX: ratioX, ratioY: ratioY),
          aspectRatioPresets: [
            CropAspectRatioPreset.square,
          ],
          androidUiSettings: const AndroidUiSettings(
              toolbarTitle: 'Cropper',
              toolbarColor: Colors.deepOrange,
              toolbarWidgetColor: Colors.white,
              // initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false),
          iosUiSettings: const IOSUiSettings(
            minimumAspectRatio: 1.0,
          ));
      if (croppedFile != null) {
        return croppedFile.path;
      }
    }

    return null;
  }

  Future<String?> getImageFromCameraAndGallery({
    required BuildContext context,
    double? maxWidth,
    double? maxHeight,
  }) async {
    var selectedType = await SPActionSheet.showActionSheet(
        context, {1: "图库", 2: "摄像机"},
        showCancelButton: true);
    String? imagePath;
    if (selectedType == 1) {
      imagePath = await SPImagePicker()
          .getImageFromGallery(maxWidth: maxWidth, maxHeight: maxHeight);
    } else if (selectedType == 2) {
      imagePath = await SPImagePicker()
          .getImageFromCamera(maxWidth: maxWidth, maxHeight: maxHeight);
    }

    return imagePath;
  }
}
