package zhwlzlxt_project

import android.os.Handler
import android.os.Looper
import android.util.Log
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import zhwlzlxt_project.tp.xmaihh.serialport.SerialPortHelper
import zhwlzlxt_project.tp.xmaihh.serialport.bean.ComBean
import zhwlzlxt_project.tp.xmaihh.serialport.stick.StaticLenStickPackageHelper
import zhwlzlxt_project.tp.xmaihh.serialport.utils.ByteUtil.ByteArrToHex
import zhwlzlxt_project.tp.xmaihh.serialport.utils.Crc16Util
import java.util.Timer
import java.util.TimerTask

class SerialMsgPlugin : FlutterPlugin, SerialPortHelper.onPortDataReceived {

    private var sendData: String? = null
    val tl = "AB BA 91 00 00 00 00 00 00 00 00 00 00";
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
                if (serialPortHelper.count > 10) {
                    handler.post {
                        toFlutter.invokeMethod(
                            "onHeartFail",
                            serialPortHelper.count,
                            object : MethodChannel.Result {
                                override fun success(o: Any?) {}
                                override fun error(s: String, s1: String?, o: Any?) {}
                                override fun notImplemented() {}
                            })
                    }
                } else {
                    handler.post {
                        toFlutter.invokeMethod(
                            "onHeart",
                            serialPortHelper.count,
                            object : MethodChannel.Result {
                                override fun success(o: Any?) {}
                                override fun error(s: String, s1: String?, o: Any?) {}
                                override fun notImplemented() {}
                            })
                    }
                }

            }
        }, 1000, 1000)


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
                serialPortHelper.sendByte(Crc16Util.getData(tl.split(" ")))
            }

            "sendData" -> {
                // 这里的 packageName 是在 Flutter 中定义的 com.allensu
                sendData = call.arguments<String>()
                hexData = ByteArrToHex(Crc16Util.getData(sendData?.split(" ")!!)).trim()
                serialPortHelper.sendByte(Crc16Util.getData(sendData?.split(" ")!!))


//                var sendCount = 0
//                val sendTimer = Timer()
//                sendTimer.schedule(object : TimerTask() {
//                    override fun run() {
//                        sendCount++
//                        if (listBRec.contains(hexData)) {
//                            listBRec.clear()
//                            sendTimer.cancel()
//                            return
//                        }
//                        Log.i("serialPortHelper", "run: 重新发送数据-------$hexData")
//                        serialPortHelper.sendByte(Crc16Util.getData(sendData?.split(" ")!!))
//                        if (sendCount >= 2) {
//                            sendTimer.cancel()
//                        }
//                    }
//                }, 500, 500)
            }

        }
    }

    var hexData: String = "";

//    var listBRec = ArrayList<String>()

    override fun onPortDataReceived(paramComBean: ComBean?) {
        serialPortHelper.count = 0
        val bRec = ByteArrToHex(paramComBean!!.bRec)
//        listBRec.add(bRec)
        when (toUnsignedInt(paramComBean.bRec[3])) {
            1 -> {
                handler.post {
                    toFlutter.invokeMethod("onSendComplete", bRec, object : MethodChannel.Result {
                        override fun success(o: Any?) {}
                        override fun error(s: String, s1: String?, o: Any?) {}
                        override fun notImplemented() {}
                    })
                }
            }
            3 -> {//超声1M
                Log.i("TAG", "onPortDataReceived:03---> $bRec")
                handler.post {
                    toFlutter.invokeMethod(
                        "UltrasonicState03",
                        bRec,
                        object : MethodChannel.Result {
                            override fun success(o: Any?) {}
                            override fun error(s: String, s1: String?, o: Any?) {}
                            override fun notImplemented() {}
                        })
                }
            }
            4 -> {//超声3M
                Log.i("TAG", "onPortDataReceived:04---> $bRec")
                handler.post {
                    toFlutter.invokeMethod(
                        "UltrasonicState04",
                        bRec,
                        object : MethodChannel.Result {
                            override fun success(o: Any?) {}
                            override fun error(s: String, s1: String?, o: Any?) {}
                            override fun notImplemented() {}
                        })
                }
            }
        }
    }

    fun received(string: String){

    }


    override fun onStartError() {
//        result.success("201")
    }

    fun toUnsignedInt(x: Byte): Int {
        return x.toInt() and 0xff
    }
}

