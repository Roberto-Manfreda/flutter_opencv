package com.github.drydart.flutter_opencv;

import com.google.gson.Gson;

import org.bytedeco.javacpp.Loader;
import org.opencv.core.Scalar;

import java.util.ArrayList;
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

    @Override
    public void onMethodCall(final MethodCall call, final Result result) {

        Gson gson = new Gson();

        switch (call.method) {
            case "getBuildInformation":
                result.success(org.opencv.core.Core.getBuildInformation());
                break;
            case "getVersionString":
                result.success(org.opencv.core.Core.getVersionString());
                break;
            case "set":
                List<Double> doubleList = call.arguments();
                Scalar scalar = new Scalar(doubleList.get(0), doubleList.get(1), doubleList.get(2), doubleList.get(3));
                scalar.set(scalar.val);
                result.success(gson.toJson(scalar));
                break;
            case "all":
                result.success(gson.toJson(Scalar.all(call.arguments())));
                break;
            case "clone":
                String json = call.arguments();
                Scalar origin = gson.fromJson(json, Scalar.class);
                Scalar cloned = origin.clone();
                result.success(gson.toJson(cloned));
                break;
            case "mul":
                Map<String, String> args = call.arguments();
                String json1 = args.get("json");
                String scaleStr = args.get("scale");
                if (null == scaleStr) {
                    Scalar origin1 = gson.fromJson(json1, Scalar.class);
                    Scalar multiplied = origin1.mul(origin1);
                    result.success(gson.toJson(multiplied));
                } else {
                    double scale = Double.valueOf(scaleStr);
                    Scalar origin1 = gson.fromJson(json1, Scalar.class);
                    Scalar multiplied = origin1.mul(origin1, scale);
                    result.success(gson.toJson(multiplied));
                }
                break;
            case "conj":
                String json2 = call.arguments();
                Scalar origin1 = gson.fromJson(json2, Scalar.class);
                Scalar conjed = origin1.conj();
                result.success(gson.toJson(conjed));
                break;
            case "isReal":
                List<Double> doubleList1 = call.arguments();
                Scalar scalar1 = new Scalar(doubleList1.get(0), doubleList1.get(1), doubleList1.get(2), doubleList1.get(3));
                result.success(scalar1.isReal());
                break;
            default:
                result.notImplemented();
        }
    }
}
