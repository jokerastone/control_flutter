// lib/services/http_service.dart
import 'package:dio/dio.dart';
import 'package:get/get.dart' as gets;
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:flutter/foundation.dart';

class HttpService {
  static final HttpService _instance = HttpService._internal();
  factory HttpService() => _instance;
  HttpService._internal();
  
  late Dio _dio;
  
  // 单例模式获取实例
  static HttpService get instance => _instance;
  
  // 获取 Dio 实例
  Dio get dio => _dio;
  
  // 初始化
  void init() {
    _dio = Dio(BaseOptions(
      baseUrl: 'http://127.0.0.1:1137/',
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 30),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
    ));
    
    // 添加拦截器
    _addInterceptors();
  }
  
  // 添加拦截器
  void _addInterceptors() {
    // 请求拦截器
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        // 在请求发送前添加统一 Header
        _addHeaders(options);
        print('请求: ${options.method} ${options.uri}');
        return handler.next(options);
      },
      onResponse: (response, handler) {
        // 处理响应
        print('响应: ${response.statusCode} ${response.requestOptions.uri}');
        return handler.next(response);
      },
      onError: (DioError error, handler) {
        // 处理错误
        _handleError(error);
        return handler.next(error);
      },
    ));
    
    // 添加日志拦截器（开发环境）
    if (kDebugMode) {
      _dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        compact: false,
      ));
    }
  }
  
  // 添加统一 Header
  void _addHeaders(RequestOptions options) {
    options.headers['App-Version'] = '1.0.0';
    options.headers['Platform'] = 'Flutter';
    options.headers['Device-Type'] = 'mobile';
    
    // 添加 Token（如果存在）
    final token = _getToken();
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
  }
  
  // 获取 Token（可从本地存储获取）
  String? _getToken() {
    // 这里可以从 SharedPreferences 或 secure_storage 获取
    // 示例：return SharedPreferences.getInstance().then((prefs) => prefs.getString('token'));
    return null;
  }
  
  // 统一错误处理
  void _handleError(DioException error) {
    String errorMessage;
    
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        errorMessage = '连接超时，请检查网络';
        break;
      case DioExceptionType.badResponse:
        errorMessage = _handleStatusCode(error.response?.statusCode);
        break;
      case DioExceptionType.cancel:
        errorMessage = '请求已取消';
        break;
      case DioExceptionType.unknown:
        errorMessage = '网络连接异常，请检查网络设置';
        break;
      default:
        errorMessage = '未知错误，请稍后重试';
    }
    
    print('HTTP 错误: $errorMessage');
    // 可以在这里统一显示错误提示
    // Get.snackbar('错误', errorMessage);
  }
  
  // 处理 HTTP 状态码
  String _handleStatusCode(int? statusCode) {
    switch (statusCode) {
      case 400:
        return '请求错误';
      case 401:
        _handleUnauthorized();
        return '未授权，请重新登录';
      case 403:
        return '拒绝访问';
      case 404:
        return '请求资源不存在';
      case 500:
        return '服务器内部错误';
      case 502:
        return '网关错误';
      case 503:
        return '服务不可用';
      default:
        return '请求失败: $statusCode';
    }
  }
  
  // 处理未授权
  void _handleUnauthorized() {
    // 清除本地 Token
    // 跳转到登录页
    gets.Get.offAllNamed('/login');
  }
  
  // ========== 封装请求方法 ==========
  
  // GET 请求
  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await _dio.get(
        path,
        queryParameters: queryParameters,
        options: options,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
  
  // POST 请求
  Future<Response> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await _dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
  
  // PUT 请求
  Future<Response> put(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await _dio.put(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
  
  // DELETE 请求
  Future<Response> delete(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await _dio.delete(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
  
  // 文件上传
  Future<Response> uploadFile(
    String path,
    String filePath, {
    ProgressCallback? onSendProgress,
  }) async {
    final formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(filePath),
    });
    
    return await _dio.post(
      path,
      data: formData,
      onSendProgress: onSendProgress,
    );
  }
  
  // 下载文件
  Future<Response> downloadFile(
    String url,
    String savePath, {
    ProgressCallback? onReceiveProgress,
  }) async {
    return await _dio.download(
      url,
      savePath,
      onReceiveProgress: onReceiveProgress,
    );
  }
}