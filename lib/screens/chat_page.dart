import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../socket_connect/socket_service.dart';

class ChatPage extends StatefulWidget {
  final String username; // Accept username from the home page

  ChatPage({required this.username});

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Connect to the socket when the page is loaded
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<SocketService>(context, listen: false).connect();
    });
  }

  @override
  Widget build(BuildContext context) {
    final socketService = Provider.of<SocketService>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Group Chat'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Consumer<SocketService>(
              builder: (context, socketService, child) {
                return ListView.builder(
                  itemCount: socketService.messages.length,
                  itemBuilder: (context, index) {
                    final message = socketService.messages[index];
                    return ListTile(
                      title: Text(message['username']),
                      subtitle: Text(message['message']),
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Enter a message',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    if (_messageController.text.isNotEmpty) {
                      socketService.sendMessage(
                        widget.username,
                        _messageController.text,
                      );
                      _messageController.clear();
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    Provider.of<SocketService>(context, listen: false).disconnect();
    super.dispose();
  }
}
