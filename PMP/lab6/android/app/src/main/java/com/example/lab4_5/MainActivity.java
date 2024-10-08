package com.example.lab4_5;

import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import io.flutter.embedding.android.FlutterActivity;
import io.flutter.plugin.common.MethodChannel;

import java.net.NetworkInterface;
import java.util.Collections;
import java.util.List;

public class MainActivity extends FlutterActivity {
    private static final String CHANNEL = "com.example.lab4_5";

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        new MethodChannel(getFlutterEngine().getDartExecutor().getBinaryMessenger(), CHANNEL)
                .setMethodCallHandler(
                        (call, result) -> {
                            if (call.method.equals("getIpAddress")) {
                                String ipAddress = getIPAddress();
                                if (ipAddress != null) {
                                    result.success(ipAddress);
                                } else {
                                    result.error("UNAVAILABLE", "IP address not available.", null);
                                }
                            } else if (call.method.equals("sendSMS")) {
                                String message = call.argument("message");
                                sendSMS(message);  // Вызов метода для отправки SMS
                                result.success(null);
                            } else {
                                result.notImplemented();
                            }
                        }
                );
    }

    // Метод для получения IP-адреса
    private String getIPAddress() {
        try {
            List<NetworkInterface> interfaces = Collections.list(NetworkInterface.getNetworkInterfaces());
            for (NetworkInterface intf : interfaces) {
                List<java.net.InetAddress> addrs = Collections.list(intf.getInetAddresses());
                for (java.net.InetAddress addr : addrs) {
                    if (!addr.isLoopbackAddress()) {
                        String sAddr = addr.getHostAddress();
                        boolean isIPv4 = sAddr.indexOf(':') < 0;
                        if (isIPv4) {
                            return sAddr;
                        }
                    }
                }
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return null;
    }

    // Метод для отправки SMS
    private void sendSMS(String message) {
        Intent smsIntent = new Intent(Intent.ACTION_VIEW, Uri.parse("sms:"));  // Создаем Intent для SMS
        smsIntent.putExtra("sms_body", "Hello World");  // Передаем тело сообщения
        startActivity(smsIntent);  // Запускаем приложение для отправки SMS
    }
}
