import 'package:dio/dio.dart';
import 'package:fleetwise/models/auth_model.dart';
import 'package:fleetwise/models/pnl_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ApiService {
  final Dio _dio = Dio();
  final FlutterSecureStorage _storage = FlutterSecureStorage();
  final Box<PnLData> _pnlBox = Hive.box<PnLData>('pnlData'); // Hive box for PnLData
  static const String baseUrl =
      "https://avaronn-backend-development-server.pemy8f8ay9m4p.ap-south-1.cs.amazonlightsail.com/test";

  ApiService() {
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final token = await _storage.read(key: 'access_token');
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        } else {
          print("No access token found in storage");
        }
        return handler.next(options);
      },
      onError: (DioError error, handler) async {
        if (error.response?.statusCode == 401) {
          print("401 Unauthorized detected, attempting to refresh token");
          try {
            final newToken = await refreshAccessToken();
            error.requestOptions.headers['Authorization'] = 'Bearer $newToken';
            final retryResponse = await _dio.fetch(error.requestOptions);
            return handler.resolve(retryResponse);
          } catch (refreshError) {
            print("Failed to refresh token: $refreshError");
            return handler.next(error);
          }
        }
        return handler.next(error);
      },
    ));
  }

  Future<String> sendOtp(String phoneNumber) async {
    final response = await _dio.post(
      "$baseUrl/sendOtp",
      data: {"country_code": "+91", "phone_number": phoneNumber},
    );
    return response.data['request_id'];
  }

  Future<AuthResponse> verifyOtp({
    required String phoneNumber,
    required String otp,
    required String requestId,
  }) async {
    final response = await _dio.post(
      "$baseUrl/verifyOtp",
      data: {
        "country_code": "+91",
        "phone_number": phoneNumber,
        "otp": otp,
        "request_id": requestId,
        "user": "mfo",
        "fcm_token": "testingfcmtoken",
      },
    );
    final authResponse = AuthResponse.fromJson(response.data);
    await _storage.write(key: 'access_token', value: authResponse.accessToken);
    await _storage.write(key: 'refresh_token', value: authResponse.refreshToken);
    return authResponse;
  }

  Future<String> updateName(String name) async {
    try {
      final response = await _dio.put("$baseUrl/updateName", data: {"name": name});
      print("API Response from updateName: $response");
      await _storage.write(key: 'user_name', value: name);
      final storedName = await _storage.read(key: 'user_name');
      print("Name stored in storage: $storedName");
      return name;
    } catch (e) {
      print("Error in updateName: $e");
      throw e;
    }
  }

  Future<String?> uploadFile(String attribute, String filePath) async {
  try {
    final formData = FormData.fromMap({
      'attribute': attribute,
      'file': await MultipartFile.fromFile(filePath),
    });
    final response = await _dio.post("$baseUrl/uploadFile", data: formData);
    print("Upload file ($attribute) response: ${response.data}");
    return response.data['file_url'] ?? 'Upload successful';
  } catch (e) {
    print("Error uploading file ($attribute): $e");
    throw e;
  }
}

  Future<String> refreshAccessToken() async {
    try {
      final refreshToken = await _storage.read(key: 'refresh_token');
      if (refreshToken == null) {
        throw Exception("No refresh token available");
      }
      final response = await _dio.get(
        "$baseUrl/refreshAccessToken",
        queryParameters: {"refresh_token": refreshToken},
      );
      final newAccessToken = response.data['access_token'];
      await _storage.write(key: 'access_token', value: newAccessToken);
      print("Access token refreshed successfully");
      return newAccessToken;
    } catch (e) {
      print("Error refreshing access token: $e");
      throw e;
    }
  }

  Future<PnLData> getTodayPnL({bool forceRefresh = false}) async {
    try {
      if (!forceRefresh && _pnlBox.containsKey('todayPnL')) {
        print("Loading Today's PnL from cache");
        return _pnlBox.get('todayPnL')!;
      }

      final response = await _dio.get("$baseUrl/getTodayPorterPnL");
      print("Today's PnL Raw Response: ${response.data}");
      final data = PnLData.fromJson(response.data['data']);

      await _pnlBox.put('todayPnL', data);
      return data;
    } catch (e) {
      print("Error fetching Today's PnL: $e");
      if (_pnlBox.containsKey('todayPnL')) {
        print("Loading cached Today's PnL due to error");
        return _pnlBox.get('todayPnL')!;
      }
      throw e; 
    }
  }

  Future<PnLData> getYesterdayPnL({bool forceRefresh = false}) async {
    try {
      
      if (!forceRefresh && _pnlBox.containsKey('yesterdayPnL')) {
        print("Loading Yesterday's PnL from cache");
        return _pnlBox.get('yesterdayPnL')!;
      }

      
      final response = await _dio.get("$baseUrl/getYesterdayPorterPnL");
      print("Yesterday's PnL Raw Response: ${response.data}");
      final data = PnLData.fromJson(response.data['data']);

     
      await _pnlBox.put('yesterdayPnL', data);
      return data;
    } catch (e) {
      print("Error fetching Yesterday's PnL: $e");
      
      if (_pnlBox.containsKey('yesterdayPnL')) {
        print("Loading cached Yesterday's PnL due to error");
        return _pnlBox.get('yesterdayPnL')!;
      }
      throw e; 
    }
  }

  Future<PnLData> getMonthlyPnL({bool forceRefresh = false}) async {
    try {
      
      if (!forceRefresh && _pnlBox.containsKey('monthlyPnL')) {
        print("Loading Monthly PnL from cache");
        return _pnlBox.get('monthlyPnL')!;
      }

      
      final response = await _dio.get("$baseUrl/getMonthlyPorterPnL");
      print("Monthly PnL Raw Response: ${response.data}");
      final data = PnLData.fromJson(response.data['data']);

      
      await _pnlBox.put('monthlyPnL', data);
      return data;
    } catch (e) {
      print("Error fetching Monthly PnL: $e");
      
      if (_pnlBox.containsKey('monthlyPnL')) {
        print("Loading cached Monthly PnL due to error");
        return _pnlBox.get('monthlyPnL')!;
      }
      throw e; // Rethrow if no cached data
    }
  }
}