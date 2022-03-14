import 'dart:async';
import 'dart:io';

import 'package:lingo_dragon/common/utils/error_util.dart';
import 'package:lingo_dragon/common/utils/sound_util.dart';
import 'package:flutter/material.dart';
import 'package:tween_image_widget/tween_image_widget.dart';

class AudioView extends StatefulWidget {
  final String filePath;
  final bool isSend;
  const AudioView({Key? key, required this.filePath, required this.isSend})
      : super(key: key);

  @override
  _AudioViewState createState() => _AudioViewState();
}

class _AudioViewState extends State<AudioView> {
  int audioDuration = 0;
  bool isPlaying = false;
  Timer? _timer;

  @override
  void initState() {
    getAudioDuring();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant AudioView oldWidget) {
    if (oldWidget.filePath != widget.filePath) {
      getAudioDuring();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: Colors.blue,
        border: Border.all(color: Colors.blue),
        borderRadius: BorderRadius.only(
            topRight: widget.isSend ? Radius.zero : const Radius.circular(10),
            topLeft: widget.isSend ? const Radius.circular(10) : Radius.zero,
            bottomLeft: const Radius.circular(10),
            bottomRight: const Radius.circular(10)),
      ),
      child: GestureDetector(
          onTap: togglePlay,
          child: Padding(
            padding: EdgeInsets.only(
                left: widget.isSend ? 10 : 15, right: widget.isSend ? 15 : 10),
            child: Row(
              textDirection:
                  widget.isSend ? TextDirection.rtl : TextDirection.ltr,
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(
                  width: 22,
                  height: 20,
                  child: Container(
                      padding: EdgeInsets.only(
                          right: widget.isSend ? 0 : 2,
                          left: widget.isSend ? 2 : 0),
                      child: isPlaying
                          ? TweenImageWidget(
                              ImagesEntry(
                                  5, 8, "assets/icons/sound/play0%s.png"),
                              durationMilliseconds: 1000,
                              repeat: true,
                            )
                          : Image.asset(
                              'assets/icons/sound/play08.png',
                              width: 20,
                              height: 20,
                            )),
                ),
                Text(
                  audioDuration.toString() + '″',
                  style: const TextStyle(color: Colors.white),
                )
              ],
            ),
          )),
    );
  }

  getAudioDuring() async {
    try {
      var filePath = widget.filePath;
      if (filePath.isNotEmpty) {
        var duration = await SPSoundUtil.getAudioDuration(widget.filePath);
        if (duration != null) {
          final seconds = SPSoundUtil.getSecondsByDuration(duration);
          setState(() {
            audioDuration = seconds;
          });
        }
      }
    } catch (e, s) {
      SPErrorUtil.toastError(context, e, s);
    }
  }

  togglePlay() async {
    var fileExist = await File(widget.filePath).exists();
    if (!fileExist) {
      // 文件不存在
      return;
    }
    if (_timer != null) {
      _timer!.cancel();
      _timer = null;
    }
    if (isPlaying) {
      SPSoundUtil.endPlaySound();
      setState(() {
        isPlaying = false;
      });
    } else {
      await SPSoundUtil.startPlaySound(context, widget.filePath, useAAC: false);
      setState(() {
        isPlaying = true;
      });
      _timer = Timer(Duration(seconds: audioDuration), () {
        setState(() {
          isPlaying = false;
        });
      });
    }
  }

  @override
  void dispose() {
    SPSoundUtil.dispose();
    if (_timer != null) {
      _timer!.cancel();
    }
    super.dispose();
  }
}
