package com.brash.voice_assistant_sample

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant

private const val kChannel = "flavor"
private const val KMethodFlavor = "getFlavor"
class MainActivity: FlutterActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
       GeneratedPluginRegistrant.registerWith(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, kChannel).setMethodCallHandler {
            call, result ->
            if(call.method == KMethodFlavor){
                result.success(BuildConfig.FLAVOR)
            }
        }
    }

}
