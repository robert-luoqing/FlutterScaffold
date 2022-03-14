import 'package:flutter/foundation.dart';
import 'package:lingo_dragon/common/widgets/audio_view.dart';
import 'package:lingo_dragon/common/widgets/voice_control.dart';

import '../../common/widgets/loading.dart';
import '../../common/widgets/round_container.dart';
import '../../common/utils/error_util.dart';
import '../../common/utils/path_util.dart';
import '../../common/utils/sound_util.dart';
import '../../common/utils/uuid_util.dart';

import '../../common/widgets/scaffold.dart';
import 'package:flutter/material.dart';

class TestVoice extends StatefulWidget {
  const TestVoice({Key? key}) : super(key: key);

  @override
  _TestVoiceState createState() => _TestVoiceState();
}

class _TestVoiceState extends State<TestVoice> {
  bool recorderStart = false;
  bool allowRelease = true;
  String? voiceFilePath;
  Duration? voiceSize;

  _startRecordVoice() async {
    try {
      var filePath = await SPPathUtil()
          .getPathInTemporaryDirectory(SPUUIDUtil.generateUUID2() + ".mp3");
      SPSoundUtil.beginRecordSound(filePath).then((value) {
        // 这个是指弹出了权限按键
        if (recorderStart == false) {
          SPSoundUtil.endRecordSound();
        }
      });
      if (kDebugMode) {
        print("_uploadVoice");
      }
      setState(() {
        recorderStart = true;
      });
    } catch (e, s) {
      SPErrorUtil.toastError(context, e, s);
    }
  }

  _completeRecordVoice() async {
    try {
      SPLoading.show();
      var filePath = await SPSoundUtil.endRecordSound(allow: allowRelease);
      if (kDebugMode) {
        print("_endUploadVoice:$filePath");
      }
      setState(() {
        recorderStart = false;
        allowRelease = true;
      });
      if (filePath != null) {
        var duration = await SPSoundUtil.getAudioDuration(filePath);
        if (duration != null) {
          if (kDebugMode) {
            print("_endUploadVoice2:$filePath, $duration");
          }
          setState(() {
            voiceFilePath = filePath;
            voiceSize = duration;
          });
        }
      }
    } catch (e, s) {
      SPErrorUtil.toastError(context, e, s);
    } finally {
      SPLoading.hide();
    }
  }

  _cancelUploadVoice() async {
    await SPSoundUtil.endRecordSound();
    if (kDebugMode) {
      print("_cancelUploadVoice");
    }
    setState(() {
      recorderStart = false;
    });
  }

  _renderRecorder() {
    GlobalKey _gestureDetectorKey = GlobalKey();
    RenderBox? renderBox;
    final Map<String, double> offset = <String, double>{};
    return GestureDetector(
      onLongPress: () {
        if (kDebugMode) {
          print("onLongPress");
        }
        _startRecordVoice();
      },
      onLongPressEnd: (d) {
        if (kDebugMode) {
          print("onLongPressEnd");
        }
        _completeRecordVoice();
      },
      onLongPressCancel: () {
        if (kDebugMode) {
          print("onLongPressCancel");
        }
        _cancelUploadVoice();
      },
      onLongPressMoveUpdate: (details) {
        renderBox ??=
            _gestureDetectorKey.currentContext!.findRenderObject() as RenderBox;
        // offset代表当前播放组件的中心点的坐标
        offset['dx'] = renderBox!.localToGlobal(Offset.zero).dx;
        offset['dy'] = renderBox!.localToGlobal(Offset.zero).dy;
        // 点击处的坐标 details.globalPosition.dx, details.globalPosition.dy
        if (details.globalPosition.dy >
                (offset['dy']! + (renderBox!.size.height / 2)) + 50 ||
            details.globalPosition.dy <
                (offset['dy']! - (renderBox!.size.height / 2)) - 50 ||
            details.globalPosition.dx >
                (offset['dx']! + (renderBox!.size.width / 2)) + 50 ||
            details.globalPosition.dx <
                (offset['dx']! - (renderBox!.size.width / 2)) - 50) {
          setState(() {
            allowRelease = false;
          });
        } else {
          setState(() {
            allowRelease = true;
          });
        }
      },
      onTap: () {
        // _uploadVoice();
      },
      behavior: HitTestBehavior.opaque,
      child: SPRoundContainer(
          key: _gestureDetectorKey,
          width: 34,
          height: 34,
          radius: 17,
          bkColor:
              recorderStart ? const Color(0xFF000000) : const Color(0xFFF4A022),
          child: Center(
            child: Image.asset(
              "assets/icons/voice.png",
              width: 10,
              height: 14,
            ),
          )),
    );
  }

  @override
  void dispose() {
    SPSoundUtil.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SPScaffold(
        title: const Text("Test record and play voice"),
        body: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 20),
                    child: _renderRecorder()),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child:
                      AudioView(filePath: voiceFilePath ?? '', isSend: false),
                ),
              ],
            ),
            VoiceControl.showVoiceDialogContainer(
                context, recorderStart, allowRelease),
          ],
        ));
  }
}
