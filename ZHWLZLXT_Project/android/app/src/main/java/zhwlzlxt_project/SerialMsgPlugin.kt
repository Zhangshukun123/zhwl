package zhwlzlxt_project

import android.util.Log
import zhwlzlxt_project.tp.xmaihh.serialport.SerialPortHelper
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import java.util.*

class SerialMsgPlugin : FlutterPlugin {

    val tl = "AB BA 01 00 XX XX XX XX XX XX XX XX CRCH CRCL";

    var count: Int = 0
    var timer = Timer()

    val serialPortHelper = SerialPortHelper()

    override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {

        serialPortHelper.setTxtLoopData(tl)

//        timer.schedule(object : TimerTask() {
//            override fun run() {
//                count++
//                //握手 串口
//
//
//            }
//        }, 0, 200)


        val channel = MethodChannel(binding.binaryMessenger, "serialMsg_manager")
        channel.setMethodCallHandler { call: MethodCall?, result: MethodChannel.Result? ->
            if (call != null) {
                if (result != null) {
                    this.onMethodCall(
                        call,
                        result
                    )
                }
            }
        }
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {

    }


    /// 处理不同名称方法的回调
    private fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        // call.method 回调中的方法名，要和在 Flutter 中定义的保持一致
        when (call.method) {
            "startPort" -> {
                Log.i("startPort", "onMethodCall:")
                serialPortHelper.open()


            }
            "sendData" -> {
                // 这里的 packageName 是在 Flutter 中定义的 com.allensu
                val data = call.arguments<String>()
                // 将安装结果回调给 Flutter
                result.success("res")
                Log.i("packageName", "onMethodCall: $data")
            }

            else ->                 // 如果回调异常，则设置相关信息
                result.error("错误码", "错误信息", "错误详情")
        }
    }


}