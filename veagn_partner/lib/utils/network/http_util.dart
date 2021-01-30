import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_svprogresshud/svprogresshud.dart';
import 'package:partner/utils/config/global_config.dart';
import 'package:partner/utils/config/user_config_manager.dart';
import 'package:partner/utils/other/hud.dart';


class HttpMethod {
  static const String GET = 'get';
  static const String POST = 'post';
  static const String PUT = 'put';
  static const String HEAD = 'head';
  static const String PATCH = 'patch';
  static const String DELETE = 'delete';
}

class HttpUtil {
  static Dio _instance;

  /// 创建 dio 实例对象
  static Dio createInstance() {
    if (_instance == null) {
      _configDio();
    }

    return _instance;
  }

  static void _configDio() {
    _instance = Dio();
    _instance.options.baseUrl = UserConfigManager.instance.baseUrl;
    _instance.options.connectTimeout = GlobalConfig.connectTimeout;
    _instance.options.receiveTimeout = GlobalConfig.receiveTimeout;
  }

  /// 清空 dio 对象
  static void clearInstance() {
    _instance = null;
  }

  /// 更新请求默认baseUrl
  static void updateBaseUrl() {
    final dio = createInstance();
    dio.options.baseUrl = UserConfigManager.instance.baseUrl;
  }


  /// 取消Charles代理
  static void cancelCharlesProxy() {
    _configDio();

    final dio = createInstance();
    // dio.options.headers.addAll(TokenManager.instance.headers);
  }

  /// 发送请求
  /// [method]  HttpMethod
  /// [path] 请求地址
  /// [restfulData] restfulData
  /// [data] 请求参数
  /// [isShowError] 出错时是否弹出错误
  /// [queryParameters] 请求参数
  /// [cancelToken] 用于关闭请求
  /// [handleResponse] 返回原始响应的回调
  /// [onSendProgress] 上传进度
  /// [success] 返回调用成功后解包数据的回调
  /// [failure] 返回错误原因的回调
  static Future<bool> sendRequest(
    String method,
    String path, {
    dynamic data,
    bool isShowError = true,
    Map<String, dynamic> restfulData,
    Map<String, dynamic> queryParameters,
    Map<String, dynamic> extraHeaders,
    CancelToken cancelToken,
    Function(Response) handleResponse,
    ProgressCallback onSendProgress,
    Function(Map<String, dynamic>) success,
    Function(DioError) failure,
  }) async {
    // final result = await TokenManager.instance.isRefreshing;
    // if (result == false) return false;


    restfulData = restfulData ?? {};
    method = method ?? HttpMethod.GET;

    restfulData.forEach((key, value) {
      if (path.contains(key)) {
        path = path.replaceAll(':$key', value.toString());
      }
    });

    final dio = createInstance();
    dio.options.method = method;
    dio.options.headers.addAll(extraHeaders ?? {});
    dio.options.extra = {
      'extraHeaders': extraHeaders,
      'handleResponse': handleResponse,
      'success': success,
      'failure': failure,
    };

    try {
      final response = await dio.request(
        path,
        data: data,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
      );

      if (handleResponse != null) {
        handleResponse(response);
      }

      if (response?.statusCode == 200) {
        if (response.data is Map<dynamic, dynamic>) {
          if (response.data['code'] == 0 || response.data['code'] == 200) {
            if (success != null) {
              try {
                success(response.data);
              } catch (e) {
                log(e);
                return false;
              }
            }
            return true;
          }
        }
      }

      if (response.data['msg'] is String) {
        ZQHUD.showErrorTips(response.data['msg']);
      }

      if (failure != null) {
        failure(DioError(type: DioErrorType.DEFAULT, error: response));
      }

      return false;
    } on DioError catch (err) {
      SVProgressHUD.dismiss();
      // 这里还可以做其他的处理,等到具体的业务时再说.
      if (failure != null) {
        failure(err);
      }

      if (isShowError == false) {
        return false;
      }

      if (err is DioError) {
        if (err.type == DioErrorType.DEFAULT || err.type == DioErrorType.RESPONSE) {
          if (err.response != null) {
            final statusCode = err.response.statusCode;
            switch (statusCode) {
              case 400:
                {
                  ZQHUD.showErrorTips(err.response.data['msg']);
                }
                break;
              case 404:
                {
                  ZQHUD.showErrorTips('网络出错,请重试');
                }
                break;
              case 500:
                {
                  final data = err.response.data;
                  if (data is Map) {
                    if (data['msg'] is String) {
                      ZQHUD.showErrorTips(data['msg']);
                    }
                  } else {
                    ZQHUD.showErrorTips('服务器内部错误,请重试');
                  }
                }
                break;
              default:
                break;
            }
          } else if (err.error is HttpException) {
            ZQHUD.showErrorTips('服务器异常');
          } else if (err.error is SocketException) {
            ZQHUD.showErrorTips('网络异常,请检查网络配置');
          } else if (err.error is FormatException) {
            ZQHUD.showErrorTips('数据解析异常');
          } else if (err.error is RedirectException) {
            ZQHUD.showErrorTips('重定向异常');
          } else {
            ZQHUD.showErrorTips('未知错误');
          }
        } else if (err.type == DioErrorType.CONNECT_TIMEOUT) {
          ZQHUD.showErrorTips('连接超时');
        } else if (err.type == DioErrorType.SEND_TIMEOUT) {
          ZQHUD.showErrorTips('请求超时');
        } else if (err.type == DioErrorType.RECEIVE_TIMEOUT) {
          ZQHUD.showErrorTips('响应超时');
        } else if (err.type == DioErrorType.CANCEL) {
          ZQHUD.showErrorTips('取消请求');
        } else {
          ZQHUD.showErrorTips('未知错误');
        }
      }

      return false;
    }
  }

  /// 发送下载请求
  /// [method]  HttpMethod
  /// [fullPath]  文件地址
  /// [path] 请求地址
  /// [restfulData] restfulData
  /// [data] 请求参数
  /// [onReceiveProgress] 下载进度
  /// [queryParameters] 请求参数
  /// [cancelToken] 用于关闭请求
  /// [handleResponse] 返回原始响应的回调
  /// [success] 返回调用成功后解包数据的回调
  /// [failure] 返回错误原因的回调
  static Future<bool> downLoad(
    String method,
    String path,
    String fullPath, {
    dynamic data,
    Map<String, dynamic> restfulData,
    ProgressCallback onReceiveProgress,
    Map<String, dynamic> queryParameters,
    Map<String, dynamic> extraHeaders,
    CancelToken cancelToken,
    Function(Response) handleResponse,
    Function() success,
    Function(DioError) failure,
  }) async {

    restfulData = restfulData ?? {};
    method = method ?? HttpMethod.POST;

    restfulData.forEach((key, value) {
      // ignore: prefer_contains
      if (path.indexOf(key) != -1) {
        path = path.replaceAll(':$key', value.toString());
      }
    });

    final dio = createInstance();
    dio.options.method = method;
    dio.options.headers.addAll(extraHeaders ?? {});
    dio.options.extra = {
      'extraHeaders': extraHeaders,
      'handleResponse': handleResponse,
      'success': success,
      'failure': failure,
    };
    try {
      final response = await dio.download(
        path,
        fullPath,
        data: data,
        onReceiveProgress: onReceiveProgress,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
        options: Options(method: HttpMethod.GET),
      );

      if (handleResponse != null) {
        handleResponse(response);
      }

      if (response?.statusCode == 200) {
        if (success != null) {
          success();
        }

        return true;
      }

      // if (failure != null) {
      //   failure(DioError(type: DioErrorType.DEFAULT, error: response));
      // }

      return false;
    } on DioError catch (err) {
      // 这里还可以做其他的处理,等到具体的业务时再说.
      if (failure != null) {
        failure(err);
      }
    }
    return false;
  }
}
