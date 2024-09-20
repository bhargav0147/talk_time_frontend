import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:flutter/material.dart';

class SocketService with ChangeNotifier {
  late IO.Socket socket;
  List<Map<String, dynamic>> messages = [];

  void connect() {
    socket = IO.io('http://192.168.29.119:5000', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': true, // Ensure autoConnect is true
    });

    // Connect to the socket
    socket.onConnect((_) {
      print('Connected to the server');

      // Listen for message history
      socket.on('messageHistory', (data) {
        // Clear old messages and add the history
        messages = List<Map<String, dynamic>>.from(data);
        notifyListeners();
      });

      // Listen for new messages
      socket.on('receiveMessage', (data) {
        messages.add(Map<String, dynamic>.from(data));
        notifyListeners(); // Update the UI in real-time
      });
    });

    // Handle disconnect
    socket.onDisconnect((_) {
      print('Disconnected from server');
    });
  }

  void sendMessage(String username, String message) {
    if (socket.connected) {
      socket.emit('sendMessage', {
        'username': username,
        'message': message,
      });
    }
  }

  void disconnect() {
    socket.disconnect();
  }
}
