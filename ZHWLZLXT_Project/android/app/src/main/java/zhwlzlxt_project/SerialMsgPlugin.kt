package zhwlzlxt_project

import android.os.Handler
import android.os.Looper
import android.util.Log
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import zhwlzlxt_project.tp.xmaihh.serialport.SerialPortHelper
import zhwlzlxt_project.tp.xmaihh.serialport.bean.ComBean
import zhwlzlxt_project.tp.xmaihh.serialport.utils.ByteUtil
import zhwlzlxt_project.tp.xmaihh.serialport.utils.ByteUtil.ByteArrToHex
import zhwlzlxt_project.tp.xmaihh.serialport.utils.Crc16Util
import zhwlzlxt_project.tp.xmaihh.serialport.utils.Crc16Util.getCRC
import java.util.*

class SerialMsgPlugin : FlutterPlugin, SerialPortHelper.onPortDataReceived {

    private var sendData: String? = null
    val tl = "AB BA 01 00 00 00 00 00 00 00 00 00 00";
//        val tl = "AB BA 06 01 00 00 01 CD DC";

    lateinit var heard: ByteArray

    val serialPortHelper = SerialPortHelper()
    var timer: Timer? = null;

    lateinit var result: MethodChannel.Result

    lateinit var toFlutter: MethodChannel
    lateinit var handler: Handler
    override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {

        handler = Handler(Looper.getMainLooper())
        heard = Crc16Util.getData(tl.split(" "))
//        heard = "AB BA 06 01 00 00 01 CD DC"
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
        toFlutter = MethodChannel(binding.binaryMessenger, "toFlutter");

        timer = Timer()
        timer?.schedule(object : TimerTask() {
            override fun run() {
                serialPortHelper.count++
                Log.i("timer", "run: " + serialPortHelper.count)
//                serialPortHelper.sendByte(heard)
            }
        }, 1000, 500)


    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {

    }


    /// 处理不同名称方法的回调
    private fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        this.result = result
        // call.method 回调中的方法名，要和在 Flutter 中定义的保持一致
        when (call.method) {
            "startPort" -> {
                serialPortHelper.close()
                serialPortHelper.setHexLoopData(ByteArrToHex(heard))
                serialPortHelper.setReceived(this)
                serialPortHelper.open()
            }
            "heard" -> {
                if (serialPortHelper.count > 30) {
                    result.success("101")
                } else {
                    result.success("102")
                }
            }
            "sendData" -> {
                // 这里的 packageName 是在 Flutter 中定义的 com.allensu
                sendData = call.arguments<String>()
                // 校验
//                serialPortHelper.setReceived(object : SerialPortHelper.onPortDataReceived {
//                    override fun onPortDataReceived(paramComBean: ComBean?) {
////                        result.success(bRec)
////                        Log.i("TAG", "onPortDataReceived: $bRec")
////                        if (bRec.subSequence(0, 4).trim() != "0100") {
////                        }
//                    }
//                    override fun onStartError() {
//                    }
//                })
                Log.i("sendData", "onMethodCall: "+ByteArrToHex(Crc16Util.getData(sendData?.split(" ")!!)))
                serialPortHelper.sendByte(Crc16Util.getData(sendData?.split(" ")!!))
                // 将安装结果回调给 Flutter
//                result.success("res")
//                Log.i("packageName", "onMethodCall: $sendData")
            }

        }
    }

    override fun onPortDataReceived(paramComBean: ComBean?) {
        serialPortHelper.count = 0
        val bRec = ByteArrToHex(paramComBean!!.bRec)
        Log.i("TAG", "onPortDataReceived: $bRec")

        handler.post {
            toFlutter.invokeMethod("onPortDataReceived", bRec, object : MethodChannel.Result {
                override fun success(o: Any?) {}
                override fun error(s: String, s1: String?, o: Any?) {}
                override fun notImplemented() {}
            })
        }
    }

    override fun onStartError() {
//        result.success("201")
    }


}

