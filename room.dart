class Room {
  final String name;
  final String password;
  final String hostId;
  final List<String> participants;
  final List<String> shelter;

  Room({required this.name, required this.password, required this.hostId, required this.participants, required this.shelter});

  factory Room.fromMap(Map<String, dynamic> map) {
    return Room(
      name: map['name'],
      password: map['password'],
      hostId: map['hostId'],
      participants: List<String>.from(map['participants']),
      shelter: List<String>.from(map['shelter']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'password': password,
      'hostId': hostId,
      'participants': participants,
      'shelter': shelter,
    };
  }
}
