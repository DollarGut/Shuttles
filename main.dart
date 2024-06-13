import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/room_list_screen.dart';
import 'screens/room_screen.dart';
import 'screens/game_screen.dart';
import 'screens/profile_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Badminton App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginScreen(),
        '/signup': (context) => SignupScreen(),
        '/rooms': (context) => RoomListScreen(),
        '/room': (context) => RoomScreen(),
        '/game': (context) => GameScreen(),
        '/profile': (context) => ProfileScreen(),
      },
    );
  }
}
