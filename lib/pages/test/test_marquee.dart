import '../../common/controlls/dialog.dart';
import '../../common/controlls/marquee_vertical.dart';
import '../../common/controlls/scaffold.dart';

import '../../common/controlls/marquee.dart';
import 'package:flutter/material.dart';

class TestMarqueePage extends StatefulWidget {
  const TestMarqueePage({Key? key}) : super(key: key);

  @override
  _TestMarqueePageState createState() => _TestMarqueePageState();
}

class _TestMarqueePageState extends State<TestMarqueePage> {
  @override
  Widget build(BuildContext context) {
    return SPScaffold(
      title: const Text("Marquee"),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              color: Colors.yellow,
              child: const SizedBox(
                height: 20,
                child: SPMarquee(
                  text:
                      "As the documentation says this error occurs due to the nesting of the same kind of",
                ),
              ),
            ),
            Container(
              color: Colors.green,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SPMarqueeVertical(
                  onPress: (index) {
                    SPDialog.alert(context, "index: $index");
                  },
                  data: const [
                    "Material is the central metaphor in material design. Each piece of material exists at a given elevation",
                    "Layout change notifications",
                    "Painting over the material 大天",
                    "Defines the duration of animated changes for shape, elevation, shadowColor and the elevation overlay if it is applied. [...]"
                  ],
                  maxLine: 2,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
