import 'package:flutter/material.dart';
import '../models/room.dart';
import '../services/room_service.dart';

class RoomListScreen extends StatefulWidget {
  @override
  _RoomListScreenState createState() => _RoomListScreenState();
}

class _RoomListScreenState extends State<RoomListScreen> {
  List<Room> _rooms = [];
  List<Room> _filteredRooms = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadRooms();
    _searchController.addListener(_filterRooms);
  }

  Future<void> _loadRooms() async {
    List<Room> rooms = await RoomService.getRooms();
    setState(() {
      _rooms = rooms;
      _filteredRooms = rooms;
    });
  }

  void _filterRooms() {
    String query = _searchController.text.toLowerCase();
    setState(() {
      _filteredRooms = _rooms.where((room) {
        return room.name.toLowerCase().contains(query);
      }).toList();
    });
  }

  void _createRoom() {
    Navigator.pushNamed(context, '/room', arguments: {'isNewRoom': true});
  }

  void _joinRoom(Room room) {
    Navigator.pushNamed(context, '/room', arguments: {'room': room});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Rooms')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search Rooms',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredRooms.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_filteredRooms[index].name),
                  subtitle: Text('Host: ${_filteredRooms[index].hostId}'),
                  trailing: ElevatedButton(
                    onPressed: () => _joinRoom(_filteredRooms[index]),
                    child: Text('Join'),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _createRoom,
        child: Icon(Icons.add),
      ),
    );
  }
}
