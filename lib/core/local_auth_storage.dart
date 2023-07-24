
import 'package:shared_preferences/shared_preferences.dart';

class LocalAuthStorage {
  Future<String> read(String key) async {
    SharedPreferences init = await SharedPreferences.getInstance();
    if (init.getString(key) != null) {
      return init.getString(key).toString();
    } else {
      throw "unauthorized";
    }
  }

  Future<void> write(String key, String value) async {
    SharedPreferences init = await SharedPreferences.getInstance();
    init.setString(key, value);
  }

  Future<void> delete() async {
    SharedPreferences init = await SharedPreferences.getInstance();
    init.clear();
  }
}
