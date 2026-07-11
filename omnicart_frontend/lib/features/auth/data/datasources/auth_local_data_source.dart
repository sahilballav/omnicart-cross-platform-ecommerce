import 'package:hive_flutter/hive_flutter.dart';

abstract class AuthLocalDataSource {
  Future<void> cacheToken(String token);
  Future<String?> getToken();
  Future<void> clearCache();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  static const String _authBoxName = 'auth_box';
  static const String _tokenKey = 'jwt_token';

  @override
  Future<void> cacheToken(String token) async {
    final box = await Hive.openBox(_authBoxName);
    await box.put(_tokenKey, token);
  }

  @override
  Future<String?> getToken() async {
    final box = await Hive.openBox(_authBoxName);
    return box.get(_tokenKey) as String?;
  }

  @override
  Future<void> clearCache() async {
    final box = await Hive.openBox(_authBoxName);
    await box.clear();
  }
}
