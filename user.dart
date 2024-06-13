class User {
  final String id;
  final String nickname;
  final String level;

  User({required this.id, required this.nickname, required this.level});

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      nickname: map['nickname'],
      level: map['level'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nickname': nickname,
      'level': level,
    };
  }
}
