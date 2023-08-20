import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final TextEditingController textController = TextEditingController();
  final IO.Socket socket =
      IO.io('http://62.217.182.138:3000', <String, dynamic>{
    'transports': ['websocket'],
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Flutter App')),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Enter text to send:'),
            TextField(
              controller: textController,
            ),
            ElevatedButton(
              onPressed: () => sendTextToServer(),
              child: Text('Send Text to Server'),
            ),
          ],
        ),
      ),
    );
  }

  void sendTextToServer() async {
    final text = textController.text;
    print('Sending text: $text');
    socket.emit('text-received', text);
    textController.clear();
  }
}
