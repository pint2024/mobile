import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static const _authTokenKey = 'auth_token';
  static const _tagKey = 'tag';
  static const _emailKey = 'email';
  static const _profileKey = 'profile';
  static const _imageKey = 'image';
  static const _iatKey = 'iat';
  static const _expKey = 'exp';
  static const _idKey = 'id';

  final SharedPreferences _prefs;

  UserPreferences(this._prefs);

  UserPreferences.fromMap(Map<String, dynamic> map, this._prefs) {
  
    _prefs.setString(_tagKey, map['tag']);
    _prefs.setString(_emailKey, map['email']);
    _prefs.setInt(_profileKey, map['perfil']);
    _prefs.setString(_imageKey, map['imagem']);
    _prefs.setInt(_iatKey, map['iat']);
    _prefs.setInt(_expKey, map['exp']);
    _prefs.setInt(_idKey, map['id']);
  }

  set authToken(String? token) {
    if (token != null) {
      _prefs.setString(_authTokenKey, token);
    } else {
      _prefs.remove(_authTokenKey);
    }
  }

  String? get authToken => _prefs.getString(_authTokenKey);
  String? get tag => _prefs.getString(_tagKey);
  String? get email => _prefs.getString(_emailKey);
  int? get profile => _prefs.getInt(_profileKey);
  String? get image => _prefs.getString(_imageKey);
  int? get iat => _prefs.getInt(_iatKey);
  int? get exp => _prefs.getInt(_expKey);
  int? get id => _prefs.getInt(_idKey);

}