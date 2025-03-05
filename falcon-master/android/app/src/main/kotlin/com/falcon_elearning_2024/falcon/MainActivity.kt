package com.falcon_elearning_2024.falcon


import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import android.hardware.display.DisplayManager
import android.media.projection.MediaProjectionManager
import android.os.Build
import android.os.Bundle
import android.os.Handler
import android.os.Looper
import android.util.Log
import android.view.WindowManager
import android.widget.Toast
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val CHANNEL = "com.falcon_elearning_2024.falcon/usb"
    private var mediaProjectionManager: MediaProjectionManager? = null
    private var shouldBlockScreenRecording = true  // Flag to control screen recording detection

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        // Prevent screenshots and screen recording globally
        window.setFlags(WindowManager.LayoutParams.FLAG_SECURE, WindowManager.LayoutParams.FLAG_SECURE)

        // Check screen recording only if flag is enabled
        checkScreenRecording()

        // Handle USB connection
        checkUsbConnection()
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "checkUsbConnection" -> result.success(checkUsbConnection())
                "enableScreenRecordingBlock" -> {
                    shouldBlockScreenRecording = true
                    result.success(true)
                }
                "disableScreenRecordingBlock" -> {
                    shouldBlockScreenRecording = false
                    result.success(true)
                }
                else -> result.notImplemented()
            }
        }
    }

    private fun checkUsbConnection(): Boolean {
        val intentFilter = IntentFilter("android.hardware.usb.action.USB_STATE")
        val usbStatus: Intent? = applicationContext.registerReceiver(null, intentFilter)
        return usbStatus?.getBooleanExtra("connected", false) ?: false
    }

    private fun checkScreenRecording() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
            mediaProjectionManager = getSystemService(Context.MEDIA_PROJECTION_SERVICE) as MediaProjectionManager
        }

        val displayManager = getSystemService(Context.DISPLAY_SERVICE) as DisplayManager
        displayManager.registerDisplayListener(object : DisplayManager.DisplayListener {
            override fun onDisplayAdded(displayId: Int) {}

            override fun onDisplayChanged(displayId: Int) {
                if (shouldBlockScreenRecording && isScreenRecording()) {
                    closeApp()
                }
            }

            override fun onDisplayRemoved(displayId: Int) {}
        }, Handler(Looper.getMainLooper()))
    }

    private fun isScreenRecording(): Boolean {
        val mediaProjectionIntent = mediaProjectionManager?.createScreenCaptureIntent()
        return mediaProjectionIntent?.resolveActivity(packageManager) != null
    }

    private fun closeApp() {
        Log.e("ScreenRecord", "Screen recording detected! Closing app.")
        Toast.makeText(this, "Screen recording detected! Closing app.", Toast.LENGTH_SHORT).show()

        Handler(Looper.getMainLooper()).postDelayed({
            finishAffinity()
        }, 500)
    }
}



//package com.falcon_elearning_2024.falcon
//
//import android.os.Bundle
//import android.provider.Settings
//import io.flutter.embedding.android.FlutterActivity
//import io.flutter.embedding.engine.FlutterEngine
//import io.flutter.plugin.common.MethodChannel
//
//class MainActivity : FlutterActivity() {
//    private val CHANNEL = "adb"
//
//    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
//        super.configureFlutterEngine(flutterEngine)
//
//        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
//            if (call.method == "checkingadb") {
//                checkingadb(result)
//            } else {
//                result.notImplemented()
//            }
//        }
//    }
//
//    private fun checkingadb(result: MethodChannel.Result) {
//        val adbEnabled = Settings.Secure.getInt(
//            contentResolver,
//            Settings.Secure.ADB_ENABLED, 0
//        ) == 1
//        result.success(if (adbEnabled) 1 else 0)
//    }
//}
