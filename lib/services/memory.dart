import 'dart:ui';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper extends GetxService {
  CacheHelper(this.sharedPreferences);
  final SharedPreferences sharedPreferences;

  //! Initialize CacheHelper
  static Future<CacheHelper> init() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return CacheHelper(prefs);
  }

  //! Get data from SharedPreferences
  String? getDataString({required String key}) {
    return sharedPreferences.getString(key);
  }

  //! Logout by clearing specific data
  void loggingOut() {
    sharedPreferences.remove("token");
  }

  //! Save data to SharedPreferences
  Future<bool> saveData({required String key, required dynamic value}) async {
    if (value is bool) {
      return await sharedPreferences.setBool(key, value);
    } else if (value is String) {
      return await sharedPreferences.setString(key, value);
    } else if (value is int) {
      return await sharedPreferences.setInt(key, value);
    } else {
      return await sharedPreferences.setDouble(key, value);
    }
  }

  //! Retrieve data from SharedPreferences
  dynamic getData({required String key}) {
    return sharedPreferences.get(key);
  }

  //! Remove data using specific key
  Future<bool> removeData({required String key}) async {
    return await sharedPreferences.remove(key);
  }

  //! Check if SharedPreferences contains a specific key
  Future<bool> containsKey({required String key}) async {
    return sharedPreferences.containsKey(key);
  }

  //! Clear all data from SharedPreferences
  Future<bool> clearData() async {
    return await sharedPreferences.clear();
  }

  //! Check if user is signed in
  bool get checkUserIsSignedIn {
    return sharedPreferences.containsKey("token");
  }
  bool get checkUserIsEnteredAPI {
    return sharedPreferences.containsKey("Api");
  }
  //! General method to save data
  Future<dynamic> put({
    required String key,
    required dynamic value,
  }) async {
    if (value is String) {
      return await sharedPreferences.setString(key, value);
    } else if (value is bool) {
      return await sharedPreferences.setBool(key, value);
    } else {
      return await sharedPreferences.setInt(key, value);
    }
  }

  //! Active Locale management
  Locale get activeLocale {
    final localeCode = sharedPreferences.getString('activeLocale') ?? 'en';
    return Locale(localeCode);
  }

  set activeLocale(Locale activeLocale) {
    sharedPreferences.setString('activeLocale', activeLocale.languageCode);
  }
}
