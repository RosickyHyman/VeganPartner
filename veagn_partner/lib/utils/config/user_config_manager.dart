
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
  String juHeBaseUrl = 'http://v.juhe.cn';

  ///图虫地址
  String picInsectUrl = 'https://api.tuchong.com';

  ///
  String ganUrl = 'http://gank.io/api/';
}

