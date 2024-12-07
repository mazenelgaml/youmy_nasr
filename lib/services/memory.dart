import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper extends GetxService{
  CacheHelper(this.sharedPreferences);
  final SharedPreferences sharedPreferences;

//! Here The Initialize of cache .
  static Future<CacheHelper> init() async {
    // await GetStorage.init();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return CacheHelper(prefs);
  }

  String? getDataString({required String key}) {
    return sharedPreferences.getString(key);
  }
  loggingOut(){
    sharedPreferences.remove("id");
  }

//! this method to put data in local database using key

  Future<bool> saveData({required String key, required dynamic value}) async {
    if (value is bool) {
      return await sharedPreferences.setBool(key, value);
    }

    if (value is String) {
      return await sharedPreferences.setString(key, value);
    }

    if (value is int) {
      return await sharedPreferences.setInt(key, value);
    } else {
      return await sharedPreferences.setDouble(key, value);
    }
  }

//! this method to get data already saved in local database

  dynamic getData({required String key}) {
    return sharedPreferences.get(key);
  }

//! remove data using specific key

  Future<bool> removeData({required String key}) async {
    return await sharedPreferences.remove(key);
  }

//! this method to check if local database contains {key}
  Future<bool> containsKey({required String key}) async {
    return sharedPreferences.containsKey(key);
  }

  Future<bool> clearData({required String key}) async {
    return sharedPreferences.clear();
  }
  bool get checkUserIsSignedIn  {
    return sharedPreferences.containsKey("id");
  }


//! this fun to put data in local data base using key
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
}