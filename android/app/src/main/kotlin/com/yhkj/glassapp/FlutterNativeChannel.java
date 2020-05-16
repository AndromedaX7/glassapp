package com.yhkj.glassapp;

import android.content.Context;
import android.content.Intent;
import android.graphics.Point;
import android.media.AudioManager;
import android.text.TextUtils;
import android.util.Log;
import android.view.Gravity;
import android.view.View;
import android.view.WindowManager;
import android.widget.TextView;
import android.widget.Toast;

import androidx.annotation.NonNull;

import com.amap.api.location.AMapLocationClient;
import com.amap.api.location.AMapLocationClientOption;
import com.amap.api.location.AMapLocationListener;
//import com.yhkj.glassapp.AssistanApplication;
//import com.yhkj.glassapp.utils.SpeechUtils;
//import com.yzw.audiorecordbutton.AudioRecorder;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

//import activityCollector.ActivityCollector;
import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
//import tv.danmaku.ijk.media.player.IjkMediaPlayer;

public class FlutterNativeChannel implements FlutterPlugin, MethodChannel.MethodCallHandler {
    private Context context;
    private MethodChannel channel;
    private AMapLocationClientOption mLocationOption = null;
    private AMapLocationClient mLocationClient = null;
    private String city = "";
    private String address = "";

//    private AudioRecorder recorder;
    private boolean record = false;
//    private IJKPlayerController instance = new IJKPlayerController();

    public FlutterNativeChannel(Context context) {
        this.context = context;
    }

    public static void speak(String text) {
//        if (SpeechUtils.ENABLE) {
//            if (!text.equals(""))
//                SpeechUtils.getInstance().speak(text);
//            return;
//        }
    }

    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding binding) {
        channel = new MethodChannel(binding.getBinaryMessenger(), "glass_app");
        channel.setMethodCallHandler(this);
    }

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
        channel.setMethodCallHandler(null);
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        switch (call.method) {
            case "toast":
//                WindowManager wm = (WindowManager) context.getSystemService(Context.WINDOW_SERVICE);
//                Point point = new Point();
//                wm.getDefaultDisplay().getSize(point);
//                Toast toast = new Toast(context);
//                toast.setDuration(Toast.LENGTH_LONG);
//                double offset = 0;
//                offset = call.argument("offset");
//                offset = point.y * offset;
//                toast.setGravity(Gravity.CENTER_HORIZONTAL | Gravity.BOTTOM, 0, (int) offset);
//                View view = View.inflate(context, R.layout.toast, null);
//                TextView text = view.findViewById(R.id.text);
//                text.setText(call.argument("text"));
//                toast.setView(view);
//                toast.show();
                Toast.makeText(context,call.argument("text"),Toast.LENGTH_SHORT).show();
                result.success(null);
                break;
            case "location":
                AMapLocationListener locationListener = it -> {
                    if (it != null) {
                        if (it.getErrorCode() == 0) {

                            address = it.getAddress();
                            city = it.getCity();

                            Map<String, String> res = new HashMap<>();
                            res.put("location", address);
                            res.put("city", city);
                            result.success(res);

                            mLocationClient.stopLocation();
                        } else {
                            //定位失败时，可通过ErrCode（错误码）信息来确定失败的原因，errInfo是错误信息，详见错误码表。
                            Log.e("AmapError", "location Error, ErrCode:"
                                    + it.getErrorCode() + ", errInfo:"
                                    + it.getErrorInfo());

                            result.error("error", "location err", it.getErrorCode());
                        }
                    }
                };
                startLocation(locationListener);
                break;

//            case "startRecord":
//                if (record) {
//                    result.error("error", "录音状态异常", "已经在录音啦");
//                    return;
//                }
//                record = true;
//                if (recorder == null) {
//                    recorder = new AudioRecorder();
//                    recorder.bindContext(context);
//                }
//                recorder.startRecorder();
//                result.success(null);
//                break;
//            case "stopRecord":
//                if (!record && recorder == null) {
//                    result.error("error", "录音状态异常", "没有在录音/录音已结束");
//                    return;
//                }
//
//                recorder.stopRecorder();
//                result.success(recorder.getSavePath());
//                break;
//            case "cancelRecord":
//                if (!record && recorder == null) {
//                    result.error("error", "录音状态异常", "没有在录音/录音已结束");
//                    return;
//                }
//                recorder.stopRecorder();
//                result.success(null);
//                break;
            case "speakTts":
                speak(call.arguments.toString());
                result.success(null);
                break;
            case "startActivity":
                String action = "" + call.arguments.toString();
                if (TextUtils.isEmpty(action)) {
                    result.notImplemented();
                    return;
                }
//                if (action.equals("login")) {
//                    context.startActivity(new
//                            Intent(action).putExtra("auto-login", false));
//                    if (AssistanApplication.getInstance().activity != null) {
//                        AssistanApplication.getInstance().activity.finish();
//                        ActivityCollector.finishAll();
//                    }
//                } else
                    context.startActivity(new Intent(action));
                result.success(null);
                break;
            case "question":
                Map<String, Object> map = (Map<String, Object>) call.arguments;

                context.startActivity(new Intent("question").putExtra("roomId", map
                        .get("roomId") + ""));
                result.success(null);
                break;
            case "startActivityWithArgs":
                Map<String, String> args = (Map<String, String>) call.arguments;
                String action1 = args.remove("action");
                Intent intent = new Intent(action1);
                for (String k : args.keySet()) {
                    intent.putExtra(k, (args.get(k)));
                }

                context.startActivity(intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK));
                break;


//            case "audioPlay":
//                String url = call.argument("url");
//                instance.playUrl(url);
//                result.success(null);
//                break;
//            case "pauseCurrent":
//                instance.pauseCurrent();
//                result.success(null);
//                break;
//            case "resumeCurrent":
//                instance.resumeCurrent();
//                result.success(null);
//                break;
//
//            case "stopCurrent":
//                instance.stopCurrent();
//                result.success(null);
//                break;
//
//            case "isPlaying":
//                result.success(instance.isPlaying());
//                break;
        }
    }

    private void startLocation(AMapLocationListener locationListener) {
        if (mLocationClient == null)
            initLoc(locationListener);
        mLocationClient.startLocation();
    }

    private void initLoc(AMapLocationListener locationListener) {
        mLocationClient = new AMapLocationClient(context.getApplicationContext());
        mLocationClient.setLocationListener(locationListener);
        mLocationOption = new AMapLocationClientOption();
        AMapLocationClientOption option = new AMapLocationClientOption();
        mLocationOption.setLocationMode(AMapLocationClientOption.AMapLocationMode.Hight_Accuracy);
        mLocationOption.setOnceLocation(true);
        mLocationOption.setNeedAddress(true);
        if (null != mLocationClient) {
            mLocationClient.setLocationOption(option);
            //设置场景模式后最好调用一次stop，再调用start以保证场景模式生效
            mLocationClient.stopLocation();
            mLocationClient.startLocation();
        }
        //给定位客户端对象设置定位参数
        mLocationClient.setLocationOption(mLocationOption);
    }

//    private static class IJKPlayerController {
//
//        private IjkMediaPlayer playerInstance = new IjkMediaPlayer();
//
//        private void initPlayer() {
//            playerInstance.reset();
//            playerInstance.setOption(IjkMediaPlayer.OPT_CATEGORY_PLAYER, "max-buffer-size", 100 * 1024 * 100);
//            playerInstance.setAudioStreamType(AudioManager.STREAM_MUSIC);
//            playerInstance.setOnPreparedListener(iMediaPlayer -> iMediaPlayer.start());
//
//            playerInstance.setOnCompletionListener(iMediaPlayer -> {
//
//            });
//        }
//
//        public void playUrl(String url) {
//            if(playerInstance.isPlaying()){
//                playerInstance.stop();
//            }
//            initPlayer();
//            try {
//                playerInstance.setDataSource(url);
//                playerInstance.prepareAsync();
//                playerInstance.start();
//            } catch (IOException e) {
//                e.printStackTrace();
//            }
//        }
//
//        public void pauseCurrent() {
//            if (playerInstance.isPlaying()) {
//                playerInstance.pause();
//            }
//        }
//
//        public void resumeCurrent() {
//            if (!playerInstance.isPlaying()) {
//                playerInstance.start();
//            }
//        }
//
//        public void stopCurrent() {
//            playerInstance.stop();
//        }
//
//        public boolean isPlaying() {
//            return playerInstance.isPlaying();
//        }
//
//    }
}
