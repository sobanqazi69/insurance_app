import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/app_constants.dart';
import '../constants/api_endpoints.dart';

class DioClient {
  late Dio _dio;
  
  DioClient() {
    _dio = Dio(
      BaseOptions(
        baseUrl: ApiEndpoints.baseUrl,
        connectTimeout: Duration(milliseconds: AppConstants.connectionTimeout),
        receiveTimeout: Duration(milliseconds: AppConstants.receiveTimeout),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );
    
    _setupInterceptors();
  }
  
  Dio get dio => _dio;
  
  void _setupInterceptors() {
    _dio.interceptors.addAll([
      _AuthInterceptor(),
      _LoggingInterceptor(),
      _ErrorInterceptor(),
    ]);
  }
}

class _AuthInterceptor extends Interceptor {
  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(AppConstants.tokenKey);
    
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    
    handler.next(options);
  }
  
  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (err.response?.statusCode == 401) {
      // Token expired or invalid, handle refresh or logout
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(AppConstants.tokenKey);
      await prefs.remove(AppConstants.userKey);
      
      // You can emit an event to navigate to login screen
      // GetIt.instance<AuthBloc>().add(LogoutRequested());
    }
    
    handler.next(err);
  }
}

class _LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    print('🌐 REQUEST[${options.method}] => PATH: ${options.path}');
    print('🌐 REQUEST[${options.method}] => DATA: ${options.data}');
    print('🌐 REQUEST[${options.method}] => HEADERS: ${options.headers}');
    handler.next(options);
  }
  
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print('✅ RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
    print('✅ RESPONSE[${response.statusCode}] => DATA: ${response.data}');
    handler.next(response);
  }
  
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    print('❌ ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}');
    print('❌ ERROR[${err.response?.statusCode}] => MESSAGE: ${err.message}');
    print('❌ ERROR[${err.response?.statusCode}] => DATA: ${err.response?.data}');
    handler.next(err);
  }
}

class _ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    switch (err.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        err = err.copyWith(
          error: 'Connection timeout. Please check your internet connection.',
        );
        break;
      case DioExceptionType.badResponse:
        switch (err.response?.statusCode) {
          case 400:
            err = err.copyWith(
              error: 'Bad request. Please check your input.',
            );
            break;
          case 401:
            err = err.copyWith(
              error: 'Unauthorized. Please login again.',
            );
            break;
          case 403:
            err = err.copyWith(
              error: 'Forbidden. You don\'t have permission to perform this action.',
            );
            break;
          case 404:
            err = err.copyWith(
              error: 'Resource not found.',
            );
            break;
          case 422:
            err = err.copyWith(
              error: 'Validation error. Please check your input.',
            );
            break;
          case 500:
            err = err.copyWith(
              error: 'Internal server error. Please try again later.',
            );
            break;
          case 502:
            err = err.copyWith(
              error: 'Bad gateway. Please try again later.',
            );
            break;
          case 503:
            err = err.copyWith(
              error: 'Service unavailable. Please try again later.',
            );
            break;
          default:
            err = err.copyWith(
              error: 'Something went wrong. Please try again later.',
            );
        }
        break;
      case DioExceptionType.cancel:
        err = err.copyWith(
          error: 'Request cancelled.',
        );
        break;
      case DioExceptionType.connectionError:
        err = err.copyWith(
          error: 'No internet connection. Please check your network.',
        );
        break;
      case DioExceptionType.badCertificate:
        err = err.copyWith(
          error: 'Certificate error. Please try again later.',
        );
        break;
      case DioExceptionType.unknown:
        err = err.copyWith(
          error: 'Unknown error occurred. Please try again later.',
        );
        break;
    }
    
    handler.next(err);
  }
}
