import 'package:roqqu_trade/utils/enum.dart';

abstract class LocalCache {
  Future<void> saveToLocalCache({required String key, required dynamic value});

  Object? getFromLocalCache(String key);

  Future<void> removeFromLocalCache(String key);

  AppTheme getUserTheme();
}
