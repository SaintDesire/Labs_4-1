import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Platform Channel Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

// Экран для получения IP-адреса
class IpAddressScreen extends StatefulWidget {
  @override
  _IpAddressScreenState createState() => _IpAddressScreenState();
}

class _IpAddressScreenState extends State<IpAddressScreen> {
  static const platform = MethodChannel('com.example.lab4_5');
  String _ipAddress = 'Unknown IP Address';

  Future<void> _getIpAddress() async {
    String ipAddress;
    try {
      final String result = await platform.invokeMethod('getIpAddress');
      ipAddress = result;
    } on PlatformException catch (e) {
      ipAddress = "Failed to get IP address: '${e.message}'.";
    }

    setState(() {
      _ipAddress = ipAddress;
    });
  }

  @override
  void initState() {
    super.initState();
    _getIpAddress(); // Автоматически получаем IP при загрузке экрана
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('IP Address Example'),
      ),
      body: Center(
        child: Text('IP Address: $_ipAddress'),
      ),
    );
  }
}


