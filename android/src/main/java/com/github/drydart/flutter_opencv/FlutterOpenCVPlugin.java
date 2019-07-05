package com.github.drydart.flutter_opencv;

import com.github.drydart.flutter_opencv.bridges.Informations;
import com.github.drydart.flutter_opencv.bridges.ScalarBridge;
import com.google.gson.Gson;

import org.bytedeco.javacpp.Loader;
import org.opencv.core.Scalar;

import java.util.List;
import java.util.Map;

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

    private void handleClass(final MethodCall call, final Result result) {
        Map<String, Object> map = call.arguments();
        String callingClass = (String) map.get("class");
        String method = call.method;
        Object arguments = map.get("arguments");

        switch (callingClass) {
            case "Informations": {
                Informations bridge = new Informations();
                break;
            }
            case "Scalar": {
                ScalarBridge bridge = new ScalarBridge();
                bridge.handleMethod(method, arguments, result);
                break;
            }
            default:
                result.notImplemented();
        }
    }

    @Override
    public void onMethodCall(final MethodCall call, final Result result) {
        // TODO Remove this flag
        boolean passed = false;

        // TODO and these calls from here, manage in a class
        switch (call.method) {
            case "getBuildInformation":
                result.success(org.opencv.core.Core.getBuildInformation());
                passed = true;
                break;
            case "getVersionString":
                passed = true;
                result.success(org.opencv.core.Core.getVersionString());
                break;
        }

        if (passed) return;

        try {
            handleClass(call, result);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}