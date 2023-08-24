package com.example.zhwlzlxt_project.serialport_utils;

import android.util.Log;

import com.example.zhwlzlxt_project.SerialPort;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.security.InvalidParameterException;
import java.util.LinkedList;
import java.util.Queue;


/**
 * Created by Administrator on 2017/3/2.
 * 串口控制器
 */

public class SerialportControler {

    private SerialPort mSerialPort;
    private OutputStream mOutputStream;
    private InputStream mInputStream;
    private SendThread mSendThread;
    private ReadThread mReadThread;
    private String mPort = "/dev/ttyS1";//默认外设设备号
    private int baudRate = 115200;//默认的波特率
    private boolean isOpen = false;
    private byte[] loopData = new byte[]{0x30};//用于保存要发送到串口的数据
    private int iDelay = 500;//避免长久占用cpu sleep 500ms

    /**
     * 构造方法(无参)
     */
    private SerialportControler() {

    }

    /**
     * 构造方法(含参)
     * @param port 外设设备号
     * @param baudRate 波特率
     */
    private SerialportControler(String port, int baudRate){
        this.mPort = port;
        this.baudRate = baudRate;
    }

    /**
     * 获取串口控制器实例
     */
    public static SerialportControler getInstance() {
        return SerialportControlerHolder.serialportControler;
    }

    /**
     *串口控制器持有类
     */
    private static class SerialportControlerHolder {
        private static final SerialportControler serialportControler = new SerialportControler();
    }

    /**
     * 判断设置波特率是否成功
     * @param iBaud 传入波特
     * @return 返回结果(真/假)
     */
    public boolean setBaudRate(int iBaud) {
        if (isOpen) {
            return false;
        } else {
            baudRate = iBaud;
            return true;
        }
    }

    /**
     * 设置波特率
     * @param sBaud 输入波特率
     * @return 返回设置结果
     */
    public boolean setBaudRate(String sBaud) {
        int iBaud = Integer.parseInt(sBaud);
        return setBaudRate(iBaud);
    }

    /**
     * 获取接口
     * @return
     */
    public String getPort() {
        return mPort;
    }

    /**
     * 判断设置接口是否成功
     * @param port
     * @return
     */
    public boolean setPort(String port) {
        if (isOpen) {
            return false;
        } else {
            this.mPort = port;
            return true;
        }
    }

    /**
     * 判断串口是否打开
     * @return
     */
    public boolean isOpen() {
        return isOpen;
    }

    /**
     * 获取要发送到串口的数据
     * @return
     */
    public byte[] getbLoopData() {
        return loopData;
    }

    /**
     * 设置要发送到串口的数据
     * @param bLoopData
     */
    public void setbLoopData(byte[] bLoopData) {
        this.loopData = bLoopData;
    }

    /**
     * 打开串口，并开启发送线程
     * @throws SecurityException
     * @throws IOException
     * @throws InvalidParameterException
     */
    public void open() throws SecurityException, IOException, InvalidParameterException {
        mSerialPort = new SerialPort(new File(mPort), baudRate, 0);
        mOutputStream = mSerialPort.getOutputStream();
        mInputStream = mSerialPort.getInputStream();
        mReadThread = new ReadThread();
        mReadThread.start();
        isOpen = true;
    }

    /**
     * 关闭串口
     */
    public void close() {
        if (mSerialPort != null) {
            mSerialPort.close();
            mSerialPort = null;
        }
        isOpen = false;
    }

    /**
     * 发送数据到串口
     */
    public synchronized void sendSerialPortData(byte[] bOutArray) {
        try {
            mOutputStream.write(bOutArray);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
    public synchronized void sendSerialPortData(String data) {
        try {
            mOutputStream.write(TransformUtils
//                    .hexStringToBytes(TransformUtils.encode(data)));
                    .hexStringToBytes(data));
//            wait(100);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }


    /**
     * 发送指令的线程
     */
    private class SendThread extends Thread {
        @Override
        public void run() {
            super.run();
            while (!Thread.currentThread().isInterrupted()) {
                synchronized (this) {

                }
                try {
                    Thread.sleep(iDelay);
                    sendSerialPortData(getbLoopData());//先得到封装到SerialHelper的数据再执行发送到串口的操作
                } catch (Error e) {
                    Log.e("CrazyMo", "run: Erro " + e.toString());
                } catch (InterruptedException e) {
                    e.printStackTrace();
                }
            }
        }
    }

    /**
     * 发送指令到串口
     * @param sOut
     */
    public synchronized void sendPortData(String sOut) {

    }

    /**
     * 读取串口发送数据的线程
     */
    private class ReadThread extends Thread {

        @Override
        public void run() {

            //没有中断标记,持续读取数据
            while (!isInterrupted()) {
                try {
                    if (mInputStream == null) return;
                    byte[] buffer = new byte[64];
                    int size = mInputStream.read(buffer);
                    if (size > 0) {
                        //将接收到字节转换为字符串
                        StringBuilder receive = new StringBuilder();
                        receive.append(TransformUtils.bytesToHexString(buffer));
                    }
                } catch (Throwable e) {
                    e.printStackTrace();
                    return;
                }
            }
            try {
                sleep(50);
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }
    }

    /**
     * 解析从串口发回的数据
     */
    private class AnalyzeThread extends Thread {
        //创建队列集合
        private Queue<String> queueList = new LinkedList<String>();
        //接收串口返回的数据
        private StringBuilder comdatas=new StringBuilder();
        @Override
        public void run() {
            super.run();
            while (!isInterrupted()) {
                String comData;
                while ((comData = queueList.poll()) != null) {
                   isHoldSucess(comData);
                }
                try {
                    Thread.sleep(10);//性能高的话，可以把此数值调小。
                } catch (Exception e) {
                    e.printStackTrace();
                }
                break;
            }
        }

        //将数据加入队列
        public synchronized void AddQueue(String recevie) {
            queueList.add(recevie);
        }

        //保留成功
        protected void isHoldSucess(String comData){
            comdatas.append(comData);
        }

    }
}
