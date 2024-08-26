import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/auth_model.dart';

abstract class AuthLocalDatasource {
  Future<void> saveAuthData(AuthModel authModel);
  Future<AuthModel?> getAuthData();
  Future<void> removeAuthData();
}

class AuthLocalDatasourceImpl implements AuthLocalDatasource {
  final SharedPreferences sharedPreferences;
  AuthLocalDatasourceImpl({required this.sharedPreferences});
  static const authKey = 'AUTH_KEY';

  @override
  Future<void> saveAuthData(AuthModel authModel) async {
    final jsonString = jsonEncode(authModel.toJson());
    await sharedPreferences.setString(authKey, jsonString);
  }

  @override
  Future<AuthModel?> getAuthData() async {
    final jsonString = sharedPreferences.getString(authKey);
    if (jsonString != null) {
      final Map<String, dynamic> jsonMap = jsonDecode(jsonString);
      return AuthModel.fromJson(jsonMap);
    }
    return null;
  }

  @override
  Future<void> removeAuthData() async {
    await sharedPreferences.remove(authKey);
  }
}
