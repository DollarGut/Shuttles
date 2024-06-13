import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';

class AuthService {
  static Future<bool> login(String id, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? storedId = prefs.getString('id');
    String? storedPassword = prefs.getString('password');
    return storedId == id && storedPassword == password;
  }

  static Future<bool> signup(String id, String password, String nickname, String level) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('id', id);
    await prefs.setString('password', password);
    await prefs.setString('nickname', nickname);
    await prefs.setString('${nickname}_level', level);
    return true;
  }

  static Future<User> getCurrentUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String id = prefs.getString('id')!;
    String nickname = prefs.getString('nickname')!;
    String level = prefs.getString('${nickname}_level')!;
    return User(id: id, nickname: nickname, level: level);
  }

  static Future<String?> getCurrentUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('id');
  }

  static Future<String?> getUserNickname() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('nickname');
  }
}
