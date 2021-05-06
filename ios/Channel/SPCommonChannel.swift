import Foundation
import Flutter
import UIKit

class SPCommonChannel: NSObject {
    static var instance:SPCommonChannel?;
    static func createInstance(binaryMessenger:FlutterBinaryMessenger) {
        instance = SPCommonChannel(binaryMessenger: binaryMessenger);
    }
    
    var channel: FlutterMethodChannel ;
    init(binaryMessenger:FlutterBinaryMessenger) {
        self.channel = FlutterMethodChannel(name: "SPCommonChannel",binaryMessenger: binaryMessenger)
        self.channel.setMethodCallHandler({ (call: FlutterMethodCall, result: FlutterResult) -> Void in
            switch call.method {
            case "loadVideo":
                
                result("")
            default:
                result(FlutterMethodNotImplemented)
            }
        })
    }
}
