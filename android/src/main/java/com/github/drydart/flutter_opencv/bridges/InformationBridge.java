package com.github.drydart.flutter_opencv.bridges;

import io.flutter.plugin.common.MethodChannel;

public class InformationBridge extends IBridge {
    @Override
    public void handleMethod(String method, Object arguments, MethodChannel.Result result) {
        switch (method) {
            case "getBuildInformation":
                result.success(org.opencv.core.Core.getBuildInformation());
                break;
            case "getVersionString":
                result.success(org.opencv.core.Core.getVersionString());
                break;
        }
    }
}
