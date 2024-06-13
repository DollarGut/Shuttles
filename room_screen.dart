import 'package:flutter/material.dart';
import '../models/room.dart';
import '../services/room_service.dart';
import '../services/auth_service.dart';
import '../widgets/participant_list.dart';
import '../widgets/shelter_list.dart';

class RoomScreen extends StatefulWidget {
  @override
  _RoomScreenState createState() => _RoomScreenState();
}

class _RoomScreenState extends State<RoomScreen> {
  Room? _room;  
  bool _isHost = false; 
  String? _nickname;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    if (args['isNewRoom'] != null && args['isNewRoom']) {
      Future.microtask(() => _showCreateRoomDialog(context));
    } else {
      setState(() {
        _room = args['room'];
        _isHost = _room!.hostId == 'currentUserId';  
      });
    }
    _loadUserNickname();
  }

  Future<void> _loadUserNickname() async {
    String? nickname = await AuthService.getUserNickname();
    setState(() {
      _nickname = nickname;
    });
  }

  Future<void> _createRoom(String roomName, String roomPassword, BuildContext dialogContext) async {
    String? currentUserId = await AuthService.getCurrentUserId();
    if (currentUserId != null) {
      Room room = await RoomService.createRoom(roomName, roomPassword, currentUserId);
      setState(() {
        _room = room;
        _isHost = true;
        _room!.participants.add(_nickname!);  
      });
      
      Navigator.of(dialogContext, rootNavigator: true).pop();
    }
  }

  void _showCreateRoomDialog(BuildContext dialogContext) {
    final TextEditingController _roomNameController = TextEditingController();
    final TextEditingController _roomPasswordController = TextEditingController();

    showDialog(
      context: dialogContext,
      builder: (context) {
        return AlertDialog(
          title: Text('Create a Room'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _roomNameController,
                decoration: InputDecoration(labelText: 'Room Name'),
              ),
              TextField(
                controller: _roomPasswordController,
                decoration: InputDecoration(labelText: 'Room Password'),
                obscureText: true,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                _createRoom(_roomNameController.text, _roomPasswordController.text, context);
              },
              child: Text('Create'),
            ),
          ],
        );
      },
    );
  }

  void _moveToShelter() {
    setState(() {
      _room!.participants.remove(_nickname);
      _room!.shelter.add(_nickname!);
    });
  }

  void _moveToParticipants() {
    setState(() {
      _room!.shelter.remove(_nickname);
      _room!.participants.add(_nickname!);
    });
  }

  void _startGame() {
    if (_room!.participants.length >= 4) {
      Navigator.pushNamed(context, '/game', arguments: {'room': _room});
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('At least 4 participants required to start the game')));
    }
  }

  void _endGame() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Room: ${_room?.name ?? 'Loading...'}'),
        actions: [
          if (_isHost)
            TextButton(
              onPressed: _startGame,
              child: Text('Start Game', style: TextStyle(color: Colors.white)),
            ),
          if (_isHost)
            TextButton(
              onPressed: _endGame,
              child: Text('End Game', style: TextStyle(color: Colors.white)),
            ),
        ],
      ),
      body: _room == null
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                ParticipantList(participants: _room!.participants),
                ShelterList(shelter: _room!.shelter),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: _moveToShelter,
                      child: Text('Move to Shelter'),
                    ),
                    ElevatedButton(
                      onPressed: _moveToParticipants,
                      child: Text('Move to Participants'),
                    ),
                  ],
                ),
              ],
            ),
    );
  }
}
