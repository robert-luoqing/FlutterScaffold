import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'videoViewController.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';

class VideoView extends StatefulWidget {
  final DidFullScreenSwitchCallback? onFullScreenSwitch;
  final DidLoadVideo? onLoadVideo;
  VideoView({this.onFullScreenSwitch, this.onLoadVideo});

  @override
  _VideoViewState createState() => _VideoViewState();
}

class _VideoViewState extends State<VideoView> {
  // final VideoViewCreatedCallback onVideoViewCreated;
  VideoViewController? _videoViewController;

  @override
  Widget build(BuildContext context) {
    final String viewType = 'SPVideoView';
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
            this._onPlatformViewCreated(params.id);
            return PlatformViewsService.initSurfaceAndroidView(
              id: params.id,
              viewType: viewType,
              layoutDirection: TextDirection.ltr,
              creationParams: creationParams,
              creationParamsCodec: StandardMessageCodec(),
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
        throw UnsupportedError("Unsupported platform view");
    }
  }

  void _onPlatformViewCreated(int id) {
    _videoViewController = VideoViewController(
        id, this.widget.onFullScreenSwitch, this.widget.onLoadVideo);
  }
}
