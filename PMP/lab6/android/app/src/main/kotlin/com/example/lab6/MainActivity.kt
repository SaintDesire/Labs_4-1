package com.example.lab6

import android.content.Intent
import android.content.IntentFilter
import android.os.BatteryManager
import android.provider.AlarmClock
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import android.app.ActivityManager
import android.content.Context
import android.net.wifi.WifiManager
import android.widget.Toast
import java.net.InetAddress
import java.net.NetworkInterface
import java.util.*
import android.content.ContextWrapper

class MainActivity : FlutterActivity() {
    private val CHANNEL_ALARM = "com.example.alarm/set"
    private val CHANNEL_INFO = "com.example.info/get"

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        // Канал для установки будильника
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL_ALARM).setMethodCallHandler { call, result ->
            if (call.method == "setAlarm") {
                val hour = call.argument<Int>("hour")
                val minute = call.argument<Int>("minute")
                if (hour != null && minute != null) {
                    setAlarm(hour, minute)
                    result.success(null)
                } else {
                    result.error("INVALID_ARGUMENT", "Invalid hour or minute", null)
                }
            } else {
                result.notImplemented()
            }
        }

        // Канал для получения информации о батарее и IP-адресе
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL_INFO).setMethodCallHandler { call, result ->
            when (call.method) {
                "getBatteryLevel" -> {
                    val batteryLevel = getBatteryLevel()
                    if (batteryLevel != -1) {
                        result.success(batteryLevel)
                    } else {
                        result.error("UNAVAILABLE", "Battery level not available", null)
                    }
                }
                "getIPAddress" -> {
                    val ipAddress = getIPAddress()
                    if (ipAddress != null) {
                        result.success(ipAddress)
                    } else {
                        result.error("UNAVAILABLE", "IP Address not available", null)
                    }
                }
                else -> result.notImplemented()
            }
        }
    }

    // Метод для установки будильника
    private fun setAlarm(hour: Int, minute: Int) {
        val intent = Intent(AlarmClock.ACTION_SET_ALARM).apply {
            putExtra(AlarmClock.EXTRA_HOUR, hour)
            putExtra(AlarmClock.EXTRA_MINUTES, minute)
            putExtra(AlarmClock.EXTRA_MESSAGE, "Alarm set by app")
        }
        try {
            if (intent.resolveActivity(packageManager) != null) {
                startActivity(intent)
                Toast.makeText(this, "Alarm set for $hour:$minute", Toast.LENGTH_SHORT).show()
            } else {
                Toast.makeText(this, "No alarm app found", Toast.LENGTH_SHORT).show()
            }
        } catch (e: Exception) {
            Toast.makeText(this, "Error setting alarm: ${e.message}", Toast.LENGTH_SHORT).show()
            e.printStackTrace()
        }
    }

    // Метод для получения уровня заряда батареи
    private fun getBatteryLevel(): Int {
        val batteryIntent: Intent? = ContextWrapper(applicationContext)
            .registerReceiver(null, IntentFilter(Intent.ACTION_BATTERY_CHANGED))
        val batteryLevel = batteryIntent?.getIntExtra(BatteryManager.EXTRA_LEVEL, -1) ?: -1
        val batteryScale = batteryIntent?.getIntExtra(BatteryManager.EXTRA_SCALE, -1) ?: -1
        return if (batteryLevel == -1 || batteryScale == -1) {
            -1
        } else {
            (batteryLevel * 100) / batteryScale
        }
    }


    // Метод для получения IP-адреса устройства
    private fun getIPAddress(): String? {
        try {
            val interfaces = NetworkInterface.getNetworkInterfaces()
            while (interfaces.hasMoreElements()) {
                val iface = interfaces.nextElement()
                // Пропускаем интерфейсы, которые не являются Wi-Fi или мобильными данными
                if (iface.isLoopback || !iface.isUp) {
                    continue
                }
                val addresses = iface.inetAddresses
                while (addresses.hasMoreElements()) {
                    val addr = addresses.nextElement()
                    if (!addr.isLoopbackAddress && addr is InetAddress && addr.hostAddress.indexOf(':') == -1) {
                        // Возвращаем только IPv4 адрес
                        return addr.hostAddress
                    }
                }
            }
        } catch (e: Exception) {
            e.printStackTrace()
        }
        return null
    }
}
