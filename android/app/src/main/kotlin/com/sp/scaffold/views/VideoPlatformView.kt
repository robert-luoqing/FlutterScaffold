package com.sp.scaffold.views

import android.content.Context
import android.graphics.Color
import android.view.View
import android.widget.TextView
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.platform.PlatformView

internal class VideoPlatformView(context: Context, messenger: BinaryMessenger?, id: Int, creationParams: Map<String?, Any?>?)
    : PlatformView, MethodChannel.MethodCallHandler {
    private val textView: TextView

    private val methodChannel: MethodChannel

    override fun getView(): View {
        return textView
    }

    override fun dispose() {}

    init {
        textView = TextView(context)
        textView.textSize = 32f
        textView.setBackgroundColor(Color.rgb(255, 255, 255))
        textView.text = "Rendered on a native Android view (id: $id)"

        methodChannel = MethodChannel(messenger, "SPVideoView/$id")
        methodChannel.setMethodCallHandler(this)
    }

    override fun onMethodCall(methodCall: MethodCall,
                              result: MethodChannel.Result) {
        when (methodCall.method) {
            "receiveFromFlutter" -> {
                val text = methodCall.argument<String>("text")
                if (text != null) {
                    this.receiveFromFlutter(text)
                    result.success("receiveFromFlutter success")
                } else {
                    result.error("-1", "Error", "No Implement")
                }
            }
            else -> result.notImplemented()
        }
    }

    private fun sendFromNative(text: String) {
        methodChannel.invokeMethod("sendFromNative", text)
    }

//    fun sendFromNative(text: String)
    fun receiveFromFlutter(text: String) {

    }
}