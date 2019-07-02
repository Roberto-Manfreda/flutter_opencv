package com.github.drydart.flutter_opencv;

import org.bytedeco.javacpp.Loader;
import org.opencv.core.Scalar;

import java.util.ArrayList;
import java.util.List;

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
        Scalar scalar;
        List<Double> l;

        switch (call.method) {
            case "getBuildInformation":
                result.success(org.opencv.core.Core.getBuildInformation());
                break;
            case "getVersionString":
                result.success(org.opencv.core.Core.getVersionString());
                break;

            case "set":
                l = call.arguments();
                scalar = new Scalar(l.get(0), l.get(1), l.get(2), l.get(3));
                scalar.set(scalar.val);

                // Converting into List to not break messageCodec
                l = new ArrayList<>();
                for (double d : scalar.val) {
                    l.add(d);
                }

                result.success(l);
                break;
            case "isReal":
                l = call.arguments();
                scalar = new Scalar(l.get(0), l.get(1), l.get(2), l.get(3));
                result.success(scalar.isReal());
                break;
            default:
                result.notImplemented();
        }
    }
}
