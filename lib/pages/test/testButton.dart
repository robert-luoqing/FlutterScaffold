import 'package:FlutterScaffold/common/controlls/button.dart';
import 'package:FlutterScaffold/common/controlls/picker.dart';
import 'package:FlutterScaffold/common/controlls/scaffold.dart';
import 'package:flutter/material.dart';

class TestButton extends StatefulWidget {
  const TestButton({Key? key}) : super(key: key);

  @override
  _TestButtonState createState() => _TestButtonState();
}

class _TestButtonState extends State<TestButton> {
  SPButtonSize buttonSize = SPButtonSize.middle;
  @override
  Widget build(BuildContext context) {
    return SPScaffold(
        title: Text("Test Button"),
        body: Container(
          color: Color(0x11000000),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  child: SPButton(
                    pattern: SPButtonPattern.primaryRoundButton,
                    text: "Select Button Size (${buttonSize.name})",
                    fitContent: true,
                    onPressed: () async {
                      var newSize = await SPPicker.show(
                          context,
                          {
                            SPButtonSize.small: "Small",
                            SPButtonSize.middle: "Middle",
                            SPButtonSize.large: "Large"
                          },
                          selectedKey: buttonSize);
                      if (newSize != null) {
                        setState(() {
                          buttonSize = newSize;
                        });
                      }
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SPButton(
                  pattern: SPButtonPattern.primaryRoundButton,
                  size: buttonSize,
                  text: "Primary Round Button",
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SPButton(
                  pattern: SPButtonPattern.primaryRoundButton,
                  disabled: true,
                  size: buttonSize,
                  text: "Primary Round Disabled Button",
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SPButton(
                  pattern: SPButtonPattern.primaryRectButton,
                  size: buttonSize,
                  text: "Primary Round Button",
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SPButton(
                  pattern: SPButtonPattern.primaryRectButton,
                  disabled: true,
                  size: buttonSize,
                  text: "Primary Round Disabled Button",
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SPButton(
                  pattern: SPButtonPattern.primaryOutlineButton,
                  size: buttonSize,
                  text: "Primary Outline Button",
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SPButton(
                  pattern: SPButtonPattern.primaryOutlineButton,
                  disabled: true,
                  size: buttonSize,
                  text: "Primary Outline Disabled Button",
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SPButton(
                  pattern: SPButtonPattern.secondOutlineButton,
                  size: buttonSize,
                  text: "Second Outline Button",
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SPButton(
                  pattern: SPButtonPattern.secondOutlineButton,
                  disabled: true,
                  size: buttonSize,
                  text: "Second Outline Disabled Button",
                ),
              ),
            ],
          ),
        ));
  }
}
