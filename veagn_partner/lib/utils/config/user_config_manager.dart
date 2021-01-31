
import 'package:flutter/material.dart';

class UserConfigManager {
  factory UserConfigManager() => _getInstance();

  UserConfigManager._internal();

  static UserConfigManager get instance => _getInstance();
  static UserConfigManager _instance;

  static UserConfigManager _getInstance() {
    _instance ??= UserConfigManager._internal();

    return _instance;
  }
  /// 服务器地址
  String baseUrl = 'http://v.juhe.cn';
}

