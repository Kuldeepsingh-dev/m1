import 'dart:io';
import 'package:dio/dio.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:logger/logger.dart';
import 'package:m1/core/config/env.dart';
import 'package:m1/core/utils/error_handler.dart';

class ApiService {
  final Dio _dio;
  final Logger _logger = Logger();

  ApiService()
      : _dio = Dio(BaseOptions(
          baseUrl: Env.baseUrl, 
          connectTimeout: const Duration(seconds: 15),
          receiveTimeout: const Duration(seconds: 15),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
          },
        )) {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          _logger.i('➡️ REQUEST: [${options.method}] ${options.uri}');
          _logger.i('Headers: ${options.headers}');
          _logger.i('Body: ${options.data}');
          return handler.next(options);
        },
        onResponse: (response, handler) {
          _logger.i('✅ RESPONSE: [${response.statusCode}] ${response.requestOptions.uri}');
          _logger.i('Data: ${response.data}');
          return handler.next(response);
        },
        onError: (DioException e, handler) {
          _logger.e('❌ ERROR: ${e.message}');
          _logger.e('Response: ${e.response?.data}');
          return handler.next(e);
        },
      ),
    );
  }

  /// Check for internet connectivity before every request
  Future<void> _checkConnectivity() async {
    final connectivity = await Connectivity().checkConnectivity();
    if (connectivity.contains(ConnectivityResult.none)) {
      throw Exception('No Internet Connection');
    }
  }

  /// Generic GET request
  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParams,
    Map<String, String>? headers,
  }) async {
    await _checkConnectivity();
    try {
      return await _dio.get(
        path,
        queryParameters: queryParams,
        options: Options(headers: headers),
      );
    } catch (e) {
      throw ErrorHandler.getErrorMessage(e);
    }
  }

  /// Generic POST request
  Future<Response> post(
    String path,
    dynamic data, {
    Map<String, dynamic>? queryParams,
    Map<String, String>? headers,
  }) async {
    await _checkConnectivity();
    try {
      return await _dio.post(
        path,
        data: data,
        queryParameters: queryParams,
        options: Options(headers: headers),
      );
    } catch (e) {
      throw ErrorHandler.getErrorMessage(e);
    }
  }

  /// PUT request
  Future<Response> put(
    String path,
    dynamic data, {
    Map<String, dynamic>? queryParams,
    Map<String, String>? headers,
  }) async {
    await _checkConnectivity();
    try {
      return await _dio.put(
        path,
        data: data,
        queryParameters: queryParams,
        options: Options(headers: headers),
      );
    } catch (e) {
      throw ErrorHandler.getErrorMessage(e);
    }
  }

  /// DELETE request
  Future<Response> delete(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParams,
    Map<String, String>? headers,
  }) async {
    await _checkConnectivity();
    try {
      return await _dio.delete(
        path,
        data: data,
        queryParameters: queryParams,
        options: Options(headers: headers),
      );
    } catch (e) {
      throw ErrorHandler.getErrorMessage(e);
    }
  }

  /// Helper for paginated APIs (returns a list)
  Future<List<T>> fetchPaginated<T>({
    required String path,
    required T Function(dynamic json) fromJson,
    int page = 1,
    int limit = 10,
    Map<String, String>? headers,
    String pageKey = 'page',
    String limitKey = 'limit',
    String dataKey = 'data',
  }) async {
    await _checkConnectivity();
    try {
      final response = await _dio.get(
        path,
        queryParameters: {
          pageKey: page,
          limitKey: limit,
        },
        options: Options(headers: headers),
      );

      final dataList = response.data[dataKey] as List;
      return dataList.map((e) => fromJson(e)).toList();
    } catch (e) {
      throw ErrorHandler.getErrorMessage(e);
    }
  }
}
