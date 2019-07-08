package com.github.drydart.flutter_opencv.bridges;

import org.opencv.core.Scalar;

import java.util.List;
import java.util.Map;

import io.flutter.plugin.common.MethodChannel;

public class ScalarBridge extends IBridge {

    @Override
    @SuppressWarnings("unchecked")
    public void handleMethod(String method, Object arguments, MethodChannel.Result result) {
        switch (method) {
            case "set": {
                List<Double> doubleList = (List<Double>) arguments;
                Scalar originScalar = new Scalar(doubleList.get(0), doubleList.get(1),
                        doubleList.get(2), doubleList.get(3));
                originScalar.set(originScalar.val);
                result.success(gson.toJson(originScalar));
                break;
            }
            case "all": {
                result.success(gson.toJson(Scalar.all((Double) arguments)));
                break;
            }
            case "clone": {
                String json = (String) arguments;
                Scalar originScalar = gson.fromJson(json, Scalar.class);
                Scalar elaboratedScalar = originScalar.clone();
                result.success(gson.toJson(elaboratedScalar));
                break;
            }
            case "mul": {
                Map<String, String> args = (Map<String, String>) arguments;
                String json = args.get("json");
                String scaleStr = args.get("scale");

                Scalar originScalar = gson.fromJson(json, Scalar.class);
                Scalar elaboratedScalar;
                if (null == scaleStr) {
                    elaboratedScalar = originScalar.mul(originScalar);
                } else {
                    double scale = Double.valueOf(scaleStr);
                    elaboratedScalar = originScalar.mul(originScalar, scale);
                }
                result.success(gson.toJson(elaboratedScalar));
                break;
            }
            case "conj": {
                String json = (String) arguments;
                Scalar originScalar = gson.fromJson(json, Scalar.class);
                Scalar elaboratedScalar = originScalar.conj();
                result.success(gson.toJson(elaboratedScalar));
                break;
            }
            case "isReal": {
                List<Double> doubleList1 = (List<Double>) arguments;
                Scalar originScalar = new Scalar(doubleList1.get(0), doubleList1.get(1),
                        doubleList1.get(2), doubleList1.get(3));
                result.success(originScalar.isReal());
                break;
            }
            default: {
                result.notImplemented();
            }
        }
    }

}
