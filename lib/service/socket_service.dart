import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService with ChangeNotifier {
  late IO.Socket socket;
  String userId = '';

  void initalize(String userId) {
    socket = IO.io(
      "http://192.168.0.102:9999",
      IO.OptionBuilder()
          .setTransports(['websocket']).setExtraHeaders({'foo': 'bar'}).build(),
    );
    socket.on('connect', (_) {
      print('Đã kết nối đến serer với $userId');
      socket.emit("user_connect", {'id': userId});
    });

    socket.on("disconnect", (_) {
      print('Đã ngừng kết nối tới server');
    });
  }

  void disconnect(){
    socket.disconnect();
  }
}
