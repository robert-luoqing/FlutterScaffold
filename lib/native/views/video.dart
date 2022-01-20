import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:lingo_dragon/common/core/exception.dart';
import 'video_view_controller.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';

class VideoView extends StatefulWidget {
  final DidFullScreenSwitchCallback? onFullScreenSwitch;
  final DidLoadVideo? onLoadVideo;
  const VideoView({Key? key, this.onFullScreenSwitch, this.onLoadVideo})
      : super(key: key);

  @override
  _VideoViewState createState() => _VideoViewState();
}

class _VideoViewState extends State<VideoView> {
  @override
  Widget build(BuildContext context) {
    const String viewType = 'SPVideoView';
    // Pass parameters to the platform side.
    final Map<String, dynamic> creationParams = <String, dynamic>{};

    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return PlatformViewLink(
          viewType: viewType,
          surfaceFactory:
              (BuildContext context, PlatformViewController controller) {
            return AndroidViewSurface(
              controller: controller as AndroidViewController,
              gestureRecognizers: const <
                  Factory<OneSequenceGestureRecognizer>>{},
              hitTestBehavior: PlatformViewHitTestBehavior.opaque,
            );
          },
          onCreatePlatformView: (PlatformViewCreationParams params) {
            _onPlatformViewCreated(params.id);
            return PlatformViewsService.initSurfaceAndroidView(
              id: params.id,
              viewType: viewType,
              layoutDirection: TextDirection.ltr,
              creationParams: creationParams,
              creationParamsCodec: const StandardMessageCodec(),
            )
              ..addOnPlatformViewCreatedListener(params.onPlatformViewCreated)
              ..create();
          },
        );
      case TargetPlatform.iOS:
        return UiKitView(
          viewType: viewType,
          layoutDirection: TextDirection.ltr,
          onPlatformViewCreated: _onPlatformViewCreated,
          creationParams: creationParams,
          creationParamsCodec: const StandardMessageCodec(),
        );
      default:
        throw SPException(
            code: SPException.unsupport, message: "unsupported platform view");
    }
  }

  void _onPlatformViewCreated(int id) {}
}
