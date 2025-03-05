import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {

  static Future<bool> saveData({@required key, @required value}) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    if (value is String) return await sharedPreferences.setString(key, value);
    if (value is int) return await sharedPreferences.setInt(key, value);
    if (value is bool) return await sharedPreferences.setBool(key, value);
    if (value is double) return await sharedPreferences.setDouble(key, value);
    return await sharedPreferences.setDouble(key, value);
  }

  static dynamic getData({@required key}) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();

    return await sharedPreferences.get(key);
  }

  static Future<bool> removeData({@required key}) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    return await sharedPreferences.remove(key);
  
  }
}
