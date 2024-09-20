import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'socket_connect/socket_service.dart';
import 'screens/home_page.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => SocketService(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Group Chat',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}
