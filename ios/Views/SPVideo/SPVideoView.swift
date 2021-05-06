// 该类是用于Wrap VideoView
import Foundation
import Flutter
import UIKit

class SPVideoView: NSObject, FlutterPlatformView {
    private var playPanel: UIView
    let viewId: Int64
    let messenger: FlutterBinaryMessenger
    let channel: FlutterMethodChannel
    
    // 以下是vid对象
    var playVideoController: UIViewController
    
    init(
        frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?,
        binaryMessenger msg: FlutterBinaryMessenger?
    ) {
        
        self.messenger = msg!
        self.viewId = viewId
        self.channel = FlutterMethodChannel(name: "SPVideoView/\(viewId)",
                                            binaryMessenger: self.messenger)
        self.playVideoController = UIViewController()
        self.playPanel = self.playVideoController.view;

        super.init()
        
        self.channel.setMethodCallHandler({[weak self] (call: FlutterMethodCall, result: FlutterResult) -> Void in
            switch call.method {
            case "loadVideo":
                result("")
            default:
                result(FlutterMethodNotImplemented)
            }
        })
        createVideoView(view: self.playPanel)
        
    }
    
    public func didFullScreenSwitchWrap(fullscren: Bool) {
        channel.invokeMethod("didFullScreenSwitchWrap", arguments: fullscren)
    }
    
    public func didLoadVideo(vid: String, title: String) {
        channel.invokeMethod("didLoadVideo", arguments: ["vid": vid, "title": title])
    }
    
    func view() -> UIView {
        return self.playPanel
    }
    
    func createVideoView(view _view: UIView){
        _view.backgroundColor = UIColor.blue
        
    }
}

