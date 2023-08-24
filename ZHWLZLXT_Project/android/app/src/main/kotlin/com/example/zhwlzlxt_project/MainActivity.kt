package com.example.zhwlzlxt_project

import android.os.Bundle
import android.util.Log
import com.example.zhwlzlxt_project.serialport_utils.SerialportControler
import io.flutter.embedding.android.FlutterActivity
import java.io.File
import java.io.InputStream
import java.io.OutputStream

class MainActivity : FlutterActivity() {

    private lateinit var mSerialPort3: SerialPort;
    var inputStream1: InputStream? = null
    private var outputStream1: OutputStream? = null
    private var outputStream3: OutputStream? = null
    private var inputStream3: InputStream? = null

    private lateinit var mSerialPort1: SerialPort


    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        System.loadLibrary("serial_port")
        Log.i("initSerial", "SerialPort: ")
        initSerial()
    }

    private fun initSerial() {


        SerialportControler.getInstance().setBaudRate(115200)
        SerialportControler.getInstance().port = "/dev/ttyMT0"
        SerialportControler.getInstance().open()




//        try {
//            //创建串口1对象
//            //获取输出流1、向外设输出数据
//            mSerialPort1 = SerialPort(File("/dev/ttyMT0"), 115200, 0) //原本9600
//            if (outputStream1 == null) {
//                outputStream1 = mSerialPort1.getOutputStream()
//            }
//            //串口对象获取输入流1、接收到的数据
//            if (inputStream1 == null) {
//                inputStream1 = mSerialPort1.getInputStream()
//            }
//        } catch (e: Exception) {
//            e.printStackTrace()
//        }
        //初始化串口2
//        try {
//            //创建串口2对象
//            mSerialPort3 = SerialPort(File("/dev/ttyMT2"), 19200  , 0) ////原本9600
//            //获取输出流2、向外设输出数据
//            if (outputStream3 == null) {
//                outputStream3 = mSerialPort3.getOutputStream()
//            }
//            //串口对象获取输入流2、接收到的数据
//            if (inputStream3 == null) {
//                inputStream3 = mSerialPort3.getInputStream()
//            }
//        } catch (e: Exception) {
//            e.printStackTrace()
//        }


    }


}
