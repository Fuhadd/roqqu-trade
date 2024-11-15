import 'dart:convert';

import 'package:roqqu_trade/constants/custom_string.dart';
import 'package:roqqu_trade/utils/enum.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'local_cache.dart';

class LocalCacheImpl implements LocalCache {
  static const userToken = 'userTokenId';
  static const user = "currentUser";

  late SharedPreferences sharedPreferences;

  LocalCacheImpl({
    required this.sharedPreferences,
  });

  @override
  Object? getFromLocalCache(String key) {
    try {
      return sharedPreferences.get(key);
    } catch (e) {}
    return null;
  }

  @override
  Future<void> removeFromLocalCache(String key) async {
    await sharedPreferences.remove(key);
  }

  @override
  Future<void> saveToLocalCache({required String key, required value}) async {
    if (value is String) {
      await sharedPreferences.setString(key, value);
    }
    if (value is bool) {
      await sharedPreferences.setBool(key, value);
    }
    if (value is int) {
      await sharedPreferences.setInt(key, value);
    }
    if (value is double) {
      await sharedPreferences.setDouble(key, value);
    }
    if (value is List<String>) {
      await sharedPreferences.setStringList(key, value);
    }
    if (value is Map) {
      await sharedPreferences.setString(key, json.encode(value));
    }
  }

  @override
  AppTheme getUserTheme() {
    var res = getFromLocalCache(ConstantString.userTheme) as String?;

    if (res != null) {
      return AppTheme.values.firstWhere((e) => e.toString() == res);
    }
    return AppTheme.dark;
  }
}
