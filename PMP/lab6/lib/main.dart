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

// Экран для отправки SMS
class MessageScreen extends StatefulWidget {
  @override
  _MessageScreenState createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  static const platform = MethodChannel('com.example.lab4_5'); // Используем тот же канал
  String _statusMessage = 'Message not sent';

  // Метод для отправки сообщения через MethodChannel
  Future<void> _sendMessage(String message) async {
    try {
      await platform.invokeMethod('sendSMS', {'message': message}); // Отправляем сообщение через канал
      setState(() {
        _statusMessage = 'Message sent successfully!';
      });
    } on PlatformException catch (e) {
      setState(() {
        _statusMessage = "Failed to send message: '${e.message}'.";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Send SMS Example'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                _sendMessage('Hello, this is a message from Flutter!'); // Отправляем сообщение
              },
              child: Text('Send Message'),
            ),
            SizedBox(height: 20),
            Text(_statusMessage), // Показываем статус отправки сообщения
          ],
        ),
      ),
    );
  }
}
