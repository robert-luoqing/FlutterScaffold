import 'package:FlutterScaffold/common/controlls/animImages.dart';
import 'package:FlutterScaffold/common/controlls/audio_view.dart';
import 'package:FlutterScaffold/common/controlls/voice_control.dart';

import '../../common/utils/screenUtil.dart';

import '../../common/utils/textStyleUtil.dart';

import '../../common/controlls/loading.dart';
import '../../common/controlls/roundContainer.dart';
import '../../common/utils/errorUtil.dart';
import '../../common/utils/pathUtil.dart';
import '../../common/utils/soundUtil.dart';
import '../../common/utils/uuidUtil.dart';

import '../../common/controlls/scaffold.dart';
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
      print("_uploadVoice");
      setState(() {
        recorderStart = true;
      });
    } catch (e, s) {
      SPErrorUtil.toastError(context, e, s);
    }
  }

  _completeRecordVoice() async {
    try {
      if (!allowRelease) {
        setState(() {
          recorderStart = false;
          allowRelease = true;
        });
        return;
      }
      SPLoading.show();
      var filePath = await SPSoundUtil.endRecordSound();
      print("_endUploadVoice:$filePath");
      setState(() {
        recorderStart = false;
      });
      if (filePath != null) {
        var duration = await SPSoundUtil.getAudioDuration(filePath);
        if (duration != null) {
          print("_endUploadVoice2:$filePath, $duration");
          voiceFilePath = filePath;
          voiceSize = duration;
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
    print("_cancelUploadVoice");
    setState(() {
      recorderStart = false;
    });
  }

  _playVoice() async {
    if (voiceFilePath != null) {
      await SPSoundUtil.startPlaySound(context, voiceFilePath!, useAAC: false);
    }
  }

  _removeVoice() {
    this.setState(() {
      voiceFilePath = null;
      voiceSize = null;
    });
  }

  _renderVoiceItem() {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0, bottom: 15.0, right: 10),
      child: SizedBox(
        height: 32,
        width: 90,
        child: Container(
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(
                  top: 0,
                  left: 0,
                  bottom: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: () {
                      _playVoice();
                    },
                    behavior: HitTestBehavior.opaque,
                    child: SPRoundContainer(
                      radius: 3,
                      borderWidth: 1,
                      borderColor: Color(0xFFD5D5D5),
                      child: Padding(
                          padding: const EdgeInsets.only(
                            left: 12,
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.voice_chat),
                              Text(
                                "${voiceSize ?? 0}”",
                                style: SPTextStyle.text15_1A1A2C_Style,
                              ),
                            ],
                          )),
                    ),
                  )),
              Positioned(
                  top: -16,
                  right: -16,
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      _removeVoice();
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 10, right: 10, left: 20.0, bottom: 20),
                      child: SPRoundContainer(
                        width: 14,
                        height: 14,
                        radius: 7,
                        borderColor: Colors.red,
                        borderWidth: 2,
                        child: Center(
                          child: SizedBox(
                            width: 7,
                            height: 2,
                            child: Container(
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  _renderRecorder() {
    GlobalKey _gestureDetectorKey = GlobalKey();
    RenderBox? renderBox;
    final Map<String, double> offset = <String, double>{};
    return GestureDetector(
      onLongPress: () {
        print("onLongPress");
        this._startRecordVoice();
      },
      onLongPressEnd: (d) {
        print("onLongPressEnd");
        this._completeRecordVoice();
      },
      onLongPressCancel: () {
        print("onLongPressCancel");
        this._cancelUploadVoice();
      },
      onLongPressMoveUpdate:(details) {
        if (renderBox == null) {
          renderBox = _gestureDetectorKey.currentContext!.findRenderObject() as RenderBox;
        }
        // offset代表当前播放组件的中心点的坐标
        offset['dx'] = renderBox!.localToGlobal(Offset.zero).dx;
        offset['dy'] = renderBox!.localToGlobal(Offset.zero).dy;
        // 点击处的坐标 details.globalPosition.dx, details.globalPosition.dy
        if (details.globalPosition.dy > (offset['dy']! + (renderBox!.size.height / 2)) + 50 ||
          details.globalPosition.dy < (offset['dy']! - (renderBox!.size.height / 2)) - 50 ||
          details.globalPosition.dx > (offset['dx']! + (renderBox!.size.width / 2)) + 50 ||
          details.globalPosition.dx < (offset['dx']! - (renderBox!.size.width / 2)) - 50) {
            this.setState(() {
              allowRelease = false;
            });
        } else {
          this.setState(() {
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
          bkColor: this.recorderStart ? Color(0xFF000000) : Color(0xFFF4A022),
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
    print(this.voiceFilePath);
    return SPScaffold(
        title: Text("Test record and play voice"),
        body: Stack(
          children: [
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 20),
                      child: _renderRecorder()),
                  Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 20),
                      child: _renderVoiceItem()),
                  Container(
                    width: 80,
                    decoration: BoxDecoration(
                      color: Colors.blue
                    ),
                    child: AudioView(filePath: this.voiceFilePath ?? '', isSend: false),
                  ),
                ],
              ),
            ),
            VoiceControl.showVoiceDialogContainer(context, recorderStart, allowRelease),
            // recorderStart
            //     ? Positioned(
            //         top: 0,
            //         bottom: SPScreen.getSize(context).height / 3,
            //         left: 0,
            //         right: 0,
            //         child: Center(
            //           child: AnimImages(
            //             imagePattern: "assets/icons/sound/voice0%s.png",
            //           ),
            //         ))
            //     : Positioned(
            //         left: 0, top: 0, width: 0, height: 0, child: Container())
          ],
        ));
  }
}
