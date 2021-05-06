//
//  SPVideoPlugin.swift
//  Runner
//
//  Created by livstar on 2021/4/25.
//

import Foundation
import Flutter

//class SPVideoPlugin: NSObject, FlutterPlugin {
class SPVideoPlugin: NSObject {
    static func registerWithRegistrar(with register: FlutterAppDelegate) {
        weak var registrar = register.registrar(forPlugin: "SPVideoPlugin")
        let factory = SPVideoViewFactory(messenger: registrar!.messenger())
        register.registrar(forPlugin: "<SPVideoPlugin>")!.register(factory,withId: "SPVideoView")
    }
    
//    public static func register(with registrar: FlutterPluginRegistrar) {
//        let factory = SPVideoViewFactory(messenger: registrar.messenger())
//        registrar.register(factory, withId: "SPVideoView")
//    }
}
