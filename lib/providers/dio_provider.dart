import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DioProvider {
  static BaseOptions options = new BaseOptions(
    baseUrl:
        "http://10.0.2.2:8000/api", // Sesuaikan dengan URL API Laravel Anda
    connectTimeout: 5000,
    receiveTimeout: 5000,
  );

  Dio dio = new Dio(options);

  static String? token;
  Future<dynamic> getToken(String email, String password) async {
    try {
      Response response = await dio.post('/flutter/login',
          data: {'email': email, 'password': password},
          options: Options(headers: {"Content-Type": "application/json"}));

      if (response.data != '') {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', response.data['token']);
        return true;
      } else {
        return false;
      }
    } catch (error) {
      return error;
    }
  }

  Future<dynamic> register(
      String email, String phone, String name, String password) async {
    try {
      Response response = await dio.post('/flutter/register', data: {
        'email': email,
        'password': password,
        'password_confirmation': password,
        'name': name,
        'phone': phone
      });

      if (response.data != '') {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      return error;
    }
  }

  Future<dynamic> getUser(String token) async {
    try {
      Response user = await dio.get('/flutter/me',
          options: Options(headers: {'Authorization': 'Bearer $token'}));
      if (user.data != '') {
        return json.encode(user.data);
      }
    } catch (error) {
      return error;
    }
  }

  Future<List<String>> banner() async {
    try {
      Response response = await dio.get('/master/banner_flutter');
      if (response.data != '') {
        List<dynamic> data = response.data['data'];
        return data.map((item) => item['image'] as String).toList();
      } else {
        throw Exception('Failed to load banners');
      }
    } catch (e) {
      throw Exception('Failed to load banners: $e');
    }
  }

  Future<dynamic> hotel() async {
    try {
      Response response = await dio.get('/master/hotel');

      if (response.data != '') {
        return response.data['data'];
      }
    } catch (error) {
      return error;
    }
  }
}
