import 'package:lingo_dragon/common/widgets/image.dart';
import 'package:lingo_dragon/common/widgets/network_image.dart';
import 'package:lingo_dragon/common/widgets/round_image.dart';

import '../../common/widgets/scaffold.dart';
import 'package:flutter/material.dart';

class TestImage extends StatefulWidget {
  const TestImage({Key? key}) : super(key: key);

  @override
  _TestImageState createState() => _TestImageState();
}

class _TestImageState extends State<TestImage> {
  @override
  Widget build(BuildContext context) {
    return SPScaffold(
        title: const Text("Image selection"),
        body: Column(
          children: const [
            Text("SP Image"),
            SPImage(
                imageType: SPImageType.networkImage,
                width: 100,
                height: 100,
                url:
                    "https://up.enterdesk.com/edpic_360_360/5c/7e/33/5c7e334c7952145f744d7d4eecf23974.jpg"),
            Text("Network Cache Image"),
            SPNetworkImage(
                width: 100,
                height: 100,
                showLoadImageProgress: false,
                defaultUrl:
                    "https://up.enterdesk.com/edpic_360_360/5c/7e/33/5c7e334c7952145f744d7d4eecf23974.jpg",
                defaultUrlIsAsset: false,
                url: "http://1.dddsdxxx.com/1.png"),
            Text("Round Image"),
            SPRoundImage(
                radius: 25,
                backgroundColor: Colors.red,
                url:
                    "https://c-ssl.duitang.com/uploads/item/201912/28/20191228105602_4Wm5z.thumb.1000_0.jpeg",
                imageType: SPImageType.networkImage,
                width: 50,
                height: 50)
          ],
        ));
  }
}
