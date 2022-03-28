import '../../common/widgets/scaffold.dart';

import '../../common/widgets/dialog.dart';
import '../../common/widgets/image_picker.dart';
import 'package:flutter/material.dart';

class TestImagePicker extends StatefulWidget {
  const TestImagePicker({Key? key}) : super(key: key);

  @override
  _TestImagePickerState createState() => _TestImagePickerState();
}

class _TestImagePickerState extends State<TestImagePicker> {
  @override
  Widget build(BuildContext context) {
    return SPScaffold(
        title: const Text("Image selection"),
        body: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,

          children: [
            ElevatedButton(
                onPressed: () async {
                  var image = await SPImagePicker().getImageFromGallery();
                  if (image != null) {
                    SPDialog.alert(context, image);
                  }
                },
                child: const Text("Select Image")),
            ElevatedButton(
                onPressed: () async {
                  var image = await SPImagePicker().getVideoFromGallery();
                  if (image != null) {
                    SPDialog.alert(context, image);
                  }
                },
                child: const Text("Select Video")),
            ElevatedButton(
                onPressed: () async {
                  var images = await SPImagePicker().getImages(maxImages: 100);
                  SPDialog.alert(
                      context, "You selected ${images.length} images");
                },
                child: const Text("Select Multiple Images")),
            ElevatedButton(
                onPressed: () async {
                  var imagePath = await SPImagePicker()
                      .getImageFromCameraAndGallery(context: context);
                  SPDialog.alert(context, "You selected $imagePath images");
                },
                child: const Text("Select image from camera and gallery")),
          ],
        ));
  }
}
