import 'package:FlutterScaffold/common/controlls/animImages.dart';
import 'package:FlutterScaffold/common/utils/screenUtil.dart';
import 'package:flutter/material.dart';

class VoiceControl {
  static showVoiceDialogContainer(
      BuildContext context, bool recorderStart, bool allowRelease) {
    if (!recorderStart) {
      return Container();
    }
    return Positioned(
        top: 0,
        bottom: SPScreen.getSize(context).height / 3,
        left: 0,
        right: 0,
        child: Center(
          child: allowRelease
              ? AnimImages(
                  imagePattern: "assets/icons/sound/voice0%s.png",
                )
              : SizedBox(
                  width: 80,
                  height: 80,
                  child: Container(
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(5)),
                      child: Image.asset(
                        "assets/icons/sound/play08.png",
                        fit: BoxFit.fill,
                      )),
                ),
        ));
  }
}
