import 'package:shared_preferences/shared_preferences.dart';

class Preference {
  static SharedPreferences _prefs =
      SharedPreferences.getInstance() as SharedPreferences;
  static final Map<String, dynamic> _memoryPrefs = <String, dynamic>{};

  static Future<SharedPreferences> load() async {
    _prefs ??= await SharedPreferences.getInstance();

    return _prefs;
  }

  static void setString(String key, String value) {
    _prefs.setString(key, value);
    _memoryPrefs[key] = value;
  }

  static void setInt(String key, int value) {
    _prefs.setInt(key, value);
    _memoryPrefs[key] = value;
  }

  static void setDouble(String key, double value) {
    _prefs.setDouble(key, value);
    _memoryPrefs[key] = value;
  }

  static void setBool(String key, bool value) {
    _prefs.setBool(key, value);
    _memoryPrefs[key] = value;
  }

  static void setListString(String key, List<String> value) {
    _prefs.setStringList(key, value);
    _memoryPrefs[key] = value;
  }

  static String getString(String key, {required String def}) {
    String? val;
    if (_memoryPrefs.containsKey(key)) {
      val = _memoryPrefs[key];
    }
    val ??= _prefs.getString(key);
    val ??= def;
    _memoryPrefs[key] = val;
    return val;
  }

  static int getInt(String key, {required int def}) {
    int? val;
    if (_memoryPrefs.containsKey(key)) {
      val = _memoryPrefs[key];
    }
    val ??= _prefs.getInt(key);
    val ??= def;
    _memoryPrefs[key] = val;
    return val;
  }

  static double getDouble(String key, {required double def}) {
    double? val;
    if (_memoryPrefs.containsKey(key)) {
      val = _memoryPrefs[key];
    }
    val ??= _prefs.getDouble(key);
    val ??= def;
    _memoryPrefs[key] = val;
    return val;
  }

  static bool getBool(String key, {bool def = false}) {
    bool? val;
    if (_memoryPrefs.containsKey(key)) {
      val = _memoryPrefs[key];
    }
    val ??= _prefs.getBool(key);
    val ??= def;
    _memoryPrefs[key] = val;
    return val;
  }

  static List<String>? getList(
    String key,
  ) {
    List<String>? items;
    if (_memoryPrefs.containsKey(key)) {
      items = _memoryPrefs[key];
    }
    items ??= _prefs.getStringList(key);
    _memoryPrefs[key] = items;
    return items;
  }
}
