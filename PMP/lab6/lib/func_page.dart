import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FuncScreen extends StatefulWidget {
  @override
  _FuncScreenState createState() => _FuncScreenState();
}

class _FuncScreenState extends State<FuncScreen> {
  static const platformAlarm = MethodChannel('com.example.alarm/set');
  static const platformInfo = MethodChannel('com.example.info/get');

  String _batteryLevel = 'Unknown battery level';
  String _ipAddress = 'Unknown IP address';

  Future<void> _setAlarm() async {
    try {
      await platformAlarm.invokeMethod('setAlarm', {"hour": 7, "minute": 30});
    } on PlatformException catch (e) {
      print("Failed to set alarm: '${e.message}'.");
    }
  }

  Future<void> _getBatteryLevel() async {
    String batteryLevel;
    try {
      final int result = await platformInfo.invokeMethod('getBatteryLevel');
      batteryLevel = 'Battery level: $result%';
    } on PlatformException catch (e) {
      batteryLevel = "Failed to get battery level: '${e.message}'.";
    }

    setState(() {
      _batteryLevel = batteryLevel;
    });
  }

  Future<void> _getIPAddress() async {
    String ipAddress;
    try {
      final String result = await platformInfo.invokeMethod('getIPAddress');
      ipAddress = 'IP address: $result';
    } on PlatformException catch (e) {
      ipAddress = "Failed to get IP address: '${e.message}'.";
    }

    setState(() {
      _ipAddress = ipAddress;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Native Code Example'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            ElevatedButton(
              onPressed: _setAlarm,
              child: Text('Set Alarm for 7:30 AM'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _getBatteryLevel,
              child: Text('Get Battery Level'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _getIPAddress,
              child: Text('Get IP Address'),
            ),
            SizedBox(height: 40),
            Text(
              _batteryLevel,
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            Text(
              _ipAddress,
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
