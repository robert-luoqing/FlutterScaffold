import 'package:flutter_svg/flutter_svg.dart';
import 'package:lingo_dragon/common/utils/screen_util.dart';
import 'package:flutter/material.dart';
import 'package:tween_image_widget/tween_image_widget.dart';

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
          child: SizedBox(
            width: 140,
            height: 140,
            child: Container(
                decoration: BoxDecoration(
                    color: const Color(0x99000000),
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 54,
                      height: 54,
                      child: allowRelease
                          ? TweenImageWidget(
                              ImagesEntry(
                                  1, 4, "assets/icons/sound/voice0%s.png"),
                              durationMilliseconds: 700,
                              repeat: true,
                            )
                          : SvgPicture.asset(
                              'assets/icons/sound/voice_cancel.svg'),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10, top: 10),
                      child: Text(
                        allowRelease
                            ? "Slide up to Cancel"
                            : "Release to Cancel",
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          backgroundColor: Colors.transparent,
                          fontSize: 12,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                )),
          ),
        ));
  }
}
