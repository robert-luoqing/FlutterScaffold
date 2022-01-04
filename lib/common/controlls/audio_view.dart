import 'dart:io';

import 'package:FlutterScaffold/common/utils/errorUtil.dart';
import 'package:FlutterScaffold/common/utils/soundUtil.dart';
import 'package:flutter/material.dart';
import 'package:tween_image_widget/tween_image_widget.dart';

class AudioView extends StatefulWidget {
  final String filePath;
  final bool isSend;
  AudioView({required this.filePath, required this.isSend});

  @override
  _AudioViewState createState() => _AudioViewState();
}

class _AudioViewState extends State<AudioView> {
  int audioDuration = 0;
  bool isPlaying = false;

  @override
  void initState() {
    this.getAudioDuring();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant AudioView oldWidget) {
    if (oldWidget.filePath != this.widget.filePath) {
      this.getAudioDuring();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: this.togglePlay,
        child: Container(
          padding: EdgeInsets.fromLTRB(
              this.widget.isSend ? 10 : 15, 5, this.widget.isSend ? 15 : 10, 5),
          width: 80,
          child: Row(
            textDirection:
                this.widget.isSend ? TextDirection.ltr : TextDirection.rtl,
            mainAxisSize: MainAxisSize.min,
            children: [
              this.isPlaying
                  ? SizedBox(
                      width: 20,
                      height: 20,
                      child: Container(
                          child: TweenImageWidget(
                        ImagesEntry(5, 8, "assets/icons/sound/play0%s.png"),
                        durationMilliseconds: 1000,
                        repeat: true,
                      )),
                    )
                  : Image.asset(
                      'assets/icons/sound/play08.png',
                      width: 20,
                      height: 20,
                    ),
              Text(
                this.audioDuration.toString() + '″',
                style: TextStyle(color: Colors.white),
              )
            ],
          ),
        ));
  }

  getAudioDuring() async {
    try {
      var duration = await SPSoundUtil.getAudioDuration(this.widget.filePath);
      if (duration != null) {
        final seconds = SPSoundUtil.getSecondsByDuration(duration);
        this.setState(() {
          audioDuration = seconds;
        });
        // DateTime date = new DateTime.fromMillisecondsSinceEpoch(
        //     duration.inMilliseconds,
        //     isUtc: true);
        // String txt = DateFormat('mm:ss:SS', 'en_GB').format(date);
        // print('--------------这是第一种');
        // print(date);
        // print('---------');
        // print(txt);
        // var minutes = duration.inMinutes;
        // var seconds = duration.inSeconds;
        // var millSecond = duration.inMilliseconds % 1000 ~/ 10;
        // var _text2 = '';
        // if (minutes > 9) {
        //   _text2 = _text2 + "$minutes";
        // } else {
        //   _text2 = _text2 + "0$minutes";
        // }
        // if (seconds > 9) {
        //   _text2 = _text2 + ":$seconds";
        // } else {
        //   _text2 = _text2 + ":0$seconds";
        // }
        // if (millSecond > 9) {
        //   _text2 = _text2 + ":$millSecond";
        // } else {
        //   _text2 = _text2 + ":0$millSecond";
        // }
        // print('----------------这是第二种');
        // print(_text2);
      }
    } catch (e, s) {
      SPErrorUtil.toastError(context, e, s);
    }
  }

  togglePlay() async {
    var fileExist = await File(this.widget.filePath).exists();
    if (!fileExist) {
      // 文件不存在
      return;
    }
    if (this.isPlaying) {
      SPSoundUtil.endPlaySound();
      this.setState(() {
        isPlaying = false;
      });
    } else {
      await SPSoundUtil.startPlaySound(context, this.widget.filePath,
          useAAC: false);
      this.setState(() {
        isPlaying = true;
      });
      await Future.delayed(Duration(seconds: this.audioDuration));
      this.setState(() {
        isPlaying = false;
      });
    }
  }
}
