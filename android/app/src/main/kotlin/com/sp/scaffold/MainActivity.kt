package com.sp.scaffold

import android.text.TextUtils
import android.util.Log
import com.sp.scaffold.views.VideoViewFactory
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import java.io.File
import java.util.*

class MainActivity: FlutterActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        flutterEngine
                .platformViewsController
                .registry
                .registerViewFactory("SPVideoView", VideoViewFactory(flutterEngine.dartExecutor.binaryMessenger))

        this.applicationContext
    }



}
