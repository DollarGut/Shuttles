import 'package:flutter/material.dart';
import '../models/room.dart';

class GameScreen extends StatefulWidget {
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late Room _room;

  @override
  void initState() {
    super.initState();
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    _room = args['room'];
  }

  void _endGame() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Game: ${_room.name}'),
        actions: [
          TextButton(
            onPressed: _endGame,
            child: Text('End Game', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
      body: Center(
        child: Text('Game screen for room: ${_room.name}'),
      ),
    );
  }
}
