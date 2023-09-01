package zhwlzlxt_project

import android.util.Log
import android.widget.Toast
import zhwlzlxt_project.tp.xmaihh.serialport.SerialPortHelper
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import zhwlzlxt_project.tp.xmaihh.serialport.bean.ComBean
import java.util.*

class SerialMsgPlugin : FlutterPlugin, SerialPortHelper.onPortDataReceived {

    private var sendData: String? = null
    val tl = "AB BA 01 00 XX XX XX XX XX XX XX XX CRCH CRCL";
//    val tl = "AB BA 06 01 00 00 01 CD DC";


    val serialPortHelper = SerialPortHelper()
    val timer = Timer()

    lateinit var result: MethodChannel.Result


    override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {


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
        this.result = result
        // call.method 回调中的方法名，要和在 Flutter 中定义的保持一致
        when (call.method) {
            "startPort" -> {
                serialPortHelper.close()
                serialPortHelper.setReceived(this)
                serialPortHelper.setTxtLoopData(tl)
                serialPortHelper.open()
//                timer.schedule(object : TimerTask() {
//                    override fun run() {
//                        //握手 串口
//                        serialPortHelper.count++
//                        Log.i("serialPortHelper", "run: " + serialPortHelper.count)
//                        if (serialPortHelper.count > 10) {
//                            result.success("101")
//                        }
//                    }
//                }, 1000, 1000)
            }
            "heard"->{
                serialPortHelper.count++
                Log.i("serialPortHelper", "run: " + serialPortHelper.count)
                if (serialPortHelper.count > 10) {
                    result.success("101")
                }else{
                    result.success("")
                }
            }
            "sendData" -> {
                // 这里的 packageName 是在 Flutter 中定义的 com.allensu
                sendData = call.arguments<String>()
                serialPortHelper.sendTxt(sendData)
                // 将安装结果回调给 Flutter
//                result.success("res")
//                Log.i("packageName", "onMethodCall: $sendData")
            }
            else ->                 // 如果回调异常，则设置相关信息
                result.success("404")
        }
    }

    override fun onPortDataReceived(paramComBean: ComBean?) {
        if (paramComBean == null) {
            result.success("202")
            return
        }
        serialPortHelper.count = 0
        val bRec = Arrays.toString(paramComBean.bRec)
        if (bRec.subSequence(0, 4).trim() != "0100") {
            result.success(bRec)
        }
    }

    override fun onStartError() {
        result.success("201")
    }


}

