package com.example.zhwlzlxt_project;
import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.Result;
import androidx.annotation.NonNull;

public class SerialMsgPlugin implements FlutterPlugin{

    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding binding) {
        MethodChannel channel = new MethodChannel(binding.getBinaryMessenger(), "serialMsg_manager");
        channel.setMethodCallHandler(this::onMethodCall);
    }


    /// 处理不同名称方法的回调
    public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
        // call.method 回调中的方法名，要和在 Flutter 中定义的保持一致
        switch (call.method) {
            case "install":
                // 这里的 packageName 是在 Flutter 中定义的 com.allensu
                String packageName = call.arguments();
                // 执行安装功能，并返回安装结果
                // 将安装结果回调给 Flutter
                result.success(res);
                break;
            case "other":
                // 这里的 other 是一个测试，意思是如果方法名是 other，则执行 doSomething 函数
                doSomething();
                // 如果不需要回调数据，则参数填 null
                result.success(null);
                break;
            default:
                // 如果回调异常，则设置相关信息
                result.error("错误码","错误信息","错误详情");
                break;
        }
    }

}
