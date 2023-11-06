package com.example.myplugin;

import android.os.CountDownTimer;

import androidx.annotation.NonNull;

import java.util.HashMap;
import java.util.Map;
import java.util.Timer;
import java.util.TimerTask;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.EventChannel;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

/**
 * MypluginPlugin
 */
public class MypluginPlugin implements FlutterPlugin, MethodCallHandler {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private MethodChannel channel;
    private EventChannel eventChannel;
    private final QueuingEventSink eventSink = new QueuingEventSink();

    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
        channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "myplugin");
        channel.setMethodCallHandler(this);
        MyAPIGen.MyAPI.setUp(flutterPluginBinding.getBinaryMessenger(), new MyAPIImpl());

        eventChannel = new EventChannel(flutterPluginBinding.getBinaryMessenger(), "my_event_channel");
        eventChannel.setStreamHandler(new EventChannel.StreamHandler() {
            @Override
            public void onListen(Object arguments, EventChannel.EventSink events) {
                eventSink.setDelegate(events);
            }

            @Override
            public void onCancel(Object arguments) {
                eventSink.setDelegate(null);
            }
        });
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
        if (call.method.equals("getPlatformVersion")) {
            result.success("Android " + android.os.Build.VERSION.RELEASE);
        } else if (call.method.equals("startCounter")) {
            startCounter();
            result.success(true);
        } else {
            result.notImplemented();
        }
    }

    int counter = 0;

    private CountDownTimer countDownTimer = new CountDownTimer(60*1000, 1000) {
        @Override
        public void onTick(long millisUntilFinished) {
            ++counter;
            Map<String, Object> map = new HashMap<>();
            map.put("num", counter);

            eventSink.success(map);
        }

        @Override
        public void onFinish() {

        }
    };


    private void startCounter() {
        countDownTimer.start();
    }

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
        channel.setMethodCallHandler(null);
        countDownTimer.cancel();
    }
}
