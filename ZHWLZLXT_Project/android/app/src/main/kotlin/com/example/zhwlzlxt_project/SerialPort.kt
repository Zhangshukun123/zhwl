package com.example.zhwlzlxt_project

import android.annotation.SuppressLint
import android.util.Log
import java.io.*

/**
 * 获取串口
 * @param device  串口号
 * @param baudrate 波特率
 * @param flags 标记位
 * @throws SecurityException 安全异常
 * @throws IOException IO流异常
 */
class SerialPort(device: File, baudrate: Int, flags: Int) {

    private val TAG = "SerialPort"



    /*
	 * Do not remove or rename the field mFd: it is used by native method
	 * close();
	 */
    private var mFd: FileDescriptor? = null

    // 文件输入、输出流
    private var mFileInputStream: FileInputStream? = null
    private var mFileOutputStream: FileOutputStream? = null


    init {
        Log.i(TAG, "SerialPort: " + (!device.canRead() || !device.canWrite()))
       if (!device.canRead() || !device.canWrite()) {
            try {
                val su: Process = Runtime.getRuntime().exec("/system/bin/su")
                val cmd = """
                chmod 666 ${device.absolutePath}
                exit
                """.trimIndent()
                su.outputStream.write(cmd.toByteArray())
                if (su.waitFor() != 0 || !device.canRead()
                    || !device.canWrite()
                ) {
                    throw SecurityException()
                }
            } catch (e: Exception) {
                e.printStackTrace()
                throw SecurityException()
            }
        }
        mFd = open(device.absolutePath, baudrate, flags)
        if (mFd == null) {
            Log.e(TAG, "native open returns null")
            throw IOException()
        }
        mFileInputStream = FileInputStream(mFd)
        mFileOutputStream = FileOutputStream(mFd)
    }




    // Getters and setters
    fun getInputStream(): InputStream? {
        return mFileInputStream
    }

    fun getOutputStream(): OutputStream? {
        return mFileOutputStream
    }

    // JNI
    private external fun open(
        path: String, baudrate: Int,
        flags: Int
    ): FileDescriptor?
    external fun close()

}