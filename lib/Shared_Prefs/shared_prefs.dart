import 'package:shared_preferences/shared_preferences.dart';

class Shared {
  static Future<Map<String, dynamic>?> getData() async {
    try {
      final sf = await SharedPreferences.getInstance();
      Map<String, dynamic> data = {
        'email': '',
        'password': '',
        'name': '',
        'likedCards': []
      };

      data['email'] = sf.getString('email') ?? '';
      data['password'] = sf.getString('password') ?? '';
      data['name'] = sf.getString('name') ?? '';
      data['likedCards'] = sf.getStringList('likedCards') ?? [];

      return data;
    } catch (e) {
      return null;
    }
  }

  static Future<void> setData(Map<String, dynamic> data) async {
    final sf = await SharedPreferences.getInstance();

    sf.setString('email', data['email']);
    sf.setString('password', data['password']);
    sf.setString('name', data['name']);
    sf.setStringList('likedCards', data['likedCards']);
  }

  static void removeData() async {
    final sf = await SharedPreferences.getInstance();

    sf.remove('email');
    sf.remove('password');
    sf.remove('name');
    sf.remove('likedCards');
  }
}
