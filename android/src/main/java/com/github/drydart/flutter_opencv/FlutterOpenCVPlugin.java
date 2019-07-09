package com.github.drydart.flutter_opencv;

import com.github.drydart.flutter_opencv.bridges.InformationBridge;
import com.github.drydart.flutter_opencv.bridges.RangeBridge;
import com.github.drydart.flutter_opencv.bridges.ScalarBridge;

import org.bytedeco.javacpp.Loader;

import java.util.Map;
import java.util.Objects;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;

/**
 * FlutterOpenCVPlugin
 */
public class FlutterOpenCVPlugin implements MethodCallHandler {

    /**
     * Plugin registration.
     */
    public static void registerWith(final Registrar registrar) {
        Loader.load(org.bytedeco.javacpp.opencv_java.class);

        final MethodChannel channel = new MethodChannel(registrar.messenger(), "flutter_opencv");
        channel.setMethodCallHandler(new FlutterOpenCVPlugin());
    }

    @Override
    public void onMethodCall(final MethodCall call, final Result result) {
        try {
            handleClass(call, result);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void handleClass(final MethodCall call, final Result result) {
        Map<String, Object> map = call.arguments();
        String callingClass = (String) Objects.requireNonNull(map.get("class"));

        String method = call.method;
        Object arguments = Objects.requireNonNull(map.get("arguments"));

        switch (callingClass) {
            case "Information": {
                new InformationBridge().handleMethod(method, arguments, result);
                break;
            }
            case "Range": {
                new RangeBridge().handleMethod(method, arguments, result);
                break;
            }
            case "Scalar": {
                new ScalarBridge().handleMethod(method, arguments, result);
                break;
            }
            default: {
                result.notImplemented();
            }
        }
    }
}