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
        List<Double> doubleList;
        double doubleValue;

        switch (call.method) {
            case "getBuildInformation":
                result.success(org.opencv.core.Core.getBuildInformation());
                break;
            case "getVersionString":
                result.success(org.opencv.core.Core.getVersionString());
                break;
            // TODO Some stuff can be simplified here
            // TODO I want to try exchanging values as json too... maybe can be a better choice
            case "all":
                // Creating new Scalar object from flutter invocation arguments
                doubleValue = call.arguments();
                scalar = Scalar.all(doubleValue);

                // Converting double[] into List<Double> to not break messageCodec
                doubleList = new ArrayList<>();
                for (double d : scalar.val) {
                    doubleList.add(d);
                }

                // Return a List<Double> object to set as val field
                result.success(doubleList);
                break;
            case "set":
                // Creating new Scalar object from flutter invocation arguments
                doubleList = call.arguments();
                scalar = new Scalar(doubleList.get(0), doubleList.get(1), doubleList.get(2), doubleList.get(3));
                scalar.set(scalar.val);

                // Converting double[] into List<Double> to not break messageCodec
                doubleList = new ArrayList<>();
                for (double d : scalar.val) {
                    doubleList.add(d);
                }

                // Return a List<Double> object to set as val field
                result.success(doubleList);
                break;
            case "isReal":
                // Creating new Scalar object from flutter invocation arguments
                doubleList = call.arguments();
                scalar = new Scalar(doubleList.get(0), doubleList.get(1), doubleList.get(2), doubleList.get(3));

                // Return true if the scalar isReal else return false
                result.success(scalar.isReal());
                break;
            default:
                result.notImplemented();
        }
    }
}
