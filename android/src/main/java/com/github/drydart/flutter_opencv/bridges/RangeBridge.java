package com.github.drydart.flutter_opencv.bridges;

import io.flutter.plugin.common.MethodChannel;

public class RangeBridge extends IBridge {
    @Override
    public void handleMethod(String method, Object arguments, MethodChannel.Result result) {
        switch (method) {
            case "wtf": {
                break;
            }
            case "wtf2": {
                break;
            }
            default: {
                result.notImplemented();
                break;
            }

        }
    }
}
