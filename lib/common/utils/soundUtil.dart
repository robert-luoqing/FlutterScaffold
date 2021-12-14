import '../../../common/utils/pathUtil.dart';
import '../../../common/utils/uuidUtil.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';

class SPSoundUtil {
  static FlutterSoundPlayer? _player;
  static FlutterSoundRecorder? _recorder;

  static Future<void> startPlaySound(BuildContext context, String voiceFilePath,
      {required bool useAAC}) async {
    if (_player != null && _player!.isOpen()) {
      await _player!.stopPlayer();
    }
    _player = FlutterSoundPlayer();
    // Be careful : openAudioSession return a Future.
    // Do not access your FlutterSoundPlayer or FlutterSoundRecorder before the completion of the Future
    await _player!.openAudioSession();

    await _player!.startPlayer(
        fromURI: voiceFilePath,
        codec: useAAC ? Codec.aacADTS : Codec.mp3,
        whenFinished: () async {
          await _player!.closeAudioSession();
          _player = null;
        });
  }

  static void endPlaySound() async {
    if (_player != null && _player!.isOpen()) {
      await _player!.stopPlayer();
      await _player!.closeAudioSession();
      _player = null;
    }
  }

  static Future<void> beginRecordSound(String filePath) async {
    if (_recorder != null) {
      _recorder!.closeAudioSession();
    }
    var status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      throw RecordingPermissionException('Microphone permission not granted');
    }
    _recorder = FlutterSoundRecorder();
    // Be careful : openAudioSession return a Future.
    // Do not access your FlutterSoundPlayer or FlutterSoundRecorder before the completion of the Future
    await _recorder!.openAudioSession();
    await _recorder!.startRecorder(
      toFile: filePath + ".aac",
      codec: Codec.aacADTS,
    );
  }

  static Future<String?> endRecordSound() async {
    if (_recorder != null) {
      String? path;
      if (!_recorder!.isStopped) {
        path = await _recorder!.stopRecorder();
      }
      await _recorder!.closeAudioSession();

      var newPath = await SPPathUtil().getPathInTemporaryDirectory(
          "voices/" + SPUUIDUtil.generateUUID2() + ".mp3");
      if ((path ?? "").endsWith(".aac")) {
        newPath = path!.substring(0, path.length - 4);
      }

      await FlutterSoundHelper()
          .convertFile(path, Codec.aacADTS, newPath, Codec.mp3);

      return newPath;
    }

    return null;
  }

  static Future<Duration?> getAudioDuration(String filePath) async {
    return await flutterSoundHelper.duration(filePath);
  }
}
