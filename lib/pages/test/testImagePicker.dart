import '../../common/controlls/scaffold.dart';

import '../../common/controlls/dialog.dart';
import '../../common/controlls/imagePicker.dart';
import 'package:flutter/material.dart';

class TestImagePicker extends StatefulWidget {
  @override
  _TestImagePickerState createState() => _TestImagePickerState();
}

class _TestImagePickerState extends State<TestImagePicker> {
  @override
  Widget build(BuildContext context) {
    return SPScaffold(
        title: Text("Image selection"),
        body: Container(
          child: Column(
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
                  child: Text("Select Image")),
              ElevatedButton(
                  onPressed: () async {
                    var image = await SPImagePicker().getVideoFromGallery();
                    if (image != null) {
                      SPDialog.alert(context, image);
                    }
                  },
                  child: Text("Select Video")),
              ElevatedButton(
                  onPressed: () async {
                    var images =
                        await SPImagePicker().getImages(maxImages: 100);
                    SPDialog.alert(
                        context, "You selected ${images.length} images");
                  },
                  child: Text("Select Multiple Images")),
            ],
          ),
        ));
  }
}
