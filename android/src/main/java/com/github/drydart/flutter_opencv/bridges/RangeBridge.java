package com.github.drydart.flutter_opencv.bridges;

import org.opencv.core.Range;

import java.util.List;

import io.flutter.plugin.common.MethodChannel;

@SuppressWarnings("unchecked")
public class RangeBridge extends IBridge {
    @Override
    public void handleMethod(String method, Object arguments, MethodChannel.Result result) {
        switch (method) {
            case "set": {
                List<Integer> integerList = (List<Integer>) arguments;
                Range originRange = new Range();
                originRange.set(new double[]{(double) integerList.get(0), (double) integerList.get(1)});
                result.success(gson.toJson(originRange));
                break;
            }
            case "size": {
                break;
            }
            case "empty": {
                break;
            }
            case "all": {
                break;
            }
            case "intersection": {
                break;
            }
            case "shift": {
                break;
            }
            case "clone": {
                break;
            }
            case "hashCode": {
                // TODO implement
                break;
            }
            case "equals": {
                // TODO implement
                break;
            }
            case "toString": {
                // TODO implement
                break;
            }
            default: {
                result.notImplemented();
                break;
            }

        }
    }
}
