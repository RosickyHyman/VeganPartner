class GlobalConfig {
  /// 是否开启调试模式
  static const bool isDebug = true;

  /// 是否是工友版
  static const bool isLabourer = false;

  /// 连接超时时间(毫秒)
  static const int connectTimeout = 10 * 1000;

  /// 响应流上前后两次接受到数据的间隔(毫秒)
  static const int receiveTimeout = 10 * 1000;
}
