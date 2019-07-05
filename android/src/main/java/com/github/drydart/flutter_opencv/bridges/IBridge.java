package com.github.drydart.flutter_opencv.bridges;

import com.google.gson.Gson;

import io.flutter.plugin.common.MethodChannel.Result;

abstract class IBridge {
    Gson gson = new Gson();

    public abstract void handleMethod(final String method, final Object arguments, final Result result);
}
