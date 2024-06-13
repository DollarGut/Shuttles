import 'package:shared_preferences/shared_preferences.dart';
import '../models/room.dart';

class RoomService {
  static Future<List<Room>> getRooms() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> roomData = prefs.getStringList('rooms') ?? [];
    return roomData.map((data) {
      Map<String, dynamic> map = _stringToMap(data);
      return Room.fromMap(map);
    }).toList();
  }

  static Future<Room> createRoom(String name, String password, String hostId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Room room = Room(name: name, password: password, hostId: hostId, participants: [], shelter: []);
    List<String> roomData = prefs.getStringList('rooms') ?? [];
    roomData.add(_mapToString(room.toMap()));
    await prefs.setStringList('rooms', roomData);
    return room;
  }

  static String _mapToString(Map<String, dynamic> map) {
    return map.entries.map((e) => '${e.key}:${e.value}').join(',');
  }

  static Map<String, dynamic> _stringToMap(String str) {
    return Map.fromEntries(
      str.split(',').map((e) {
        List<String> entry = e.split(':');
        return MapEntry(entry[0], entry[1]);
      }),
    );
  }
}
