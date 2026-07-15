import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SyncApiClient {
  final Dio _dio;

  SyncApiClient({Dio? dio, String baseUrl = 'https://spendly-service.onrender.com'})
      : _dio = dio ?? Dio(
          BaseOptions(
            baseUrl: baseUrl,
            connectTimeout: const Duration(seconds: 15),
            receiveTimeout: const Duration(seconds: 15),
            contentType: Headers.jsonContentType,
          ),
        ) {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          try {
            final token = await FirebaseAuth.instance.currentUser?.getIdToken(false);
            if (token != null) {
              options.headers['Authorization'] = 'Bearer $token';
            }
          } catch (e) {
            // FirebaseAuth might fail or not be configured in testing
            print('SyncApiClient Interceptor error: $e');
          }
          return handler.next(options);
        },
      ),
    );
  }

  Dio get dio => _dio;

  Future<List<Map<String, dynamic>>> pushBatch(
    String entityType,
    List<Map<String, dynamic>> operations,
  ) async {
    try {
      final response = await _dio.post(
        '/sync/$entityType/batch',
        data: {'operations': operations},
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = response.data;
        if (data is List) {
          return List<Map<String, dynamic>>.from(data);
        } else if (data is Map && data['results'] is List) {
          return List<Map<String, dynamic>>.from(data['results']);
        }
      }
      throw DioException(
        requestOptions: RequestOptions(path: '/sync/$entityType/batch'),
        response: response,
      );
    } on DioException catch (e) {
      print('SyncApiClient.pushBatch failed for $entityType: ${e.message}');
      rethrow;
    }
  }

  Future<Map<String, dynamic>> pull(
    String entityType,
    String? sinceCursor, {
    int limit = 200,
  }) async {
    try {
      final queryParams = {
        if (sinceCursor != null) 'since': sinceCursor,
        'limit': limit,
      };
      final response = await _dio.get(
        '/sync/$entityType',
        queryParameters: queryParams,
      );
      if (response.statusCode == 200) {
        return Map<String, dynamic>.from(response.data);
      }
      throw DioException(
        requestOptions: RequestOptions(path: '/sync/$entityType'),
        response: response,
      );
    } on DioException catch (e) {
      print('SyncApiClient.pull failed for $entityType: ${e.message}');
      rethrow;
    }
  }
}
