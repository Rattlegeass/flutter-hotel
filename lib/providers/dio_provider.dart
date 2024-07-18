import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tester/utils/config.dart';

class DioProvider {
  static BaseOptions options = new BaseOptions(
    baseUrl: Config.api + 'api', // Sesuaikan dengan URL API Laravel Anda
    connectTimeout: 10000,
    receiveTimeout: 10000,
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
      Response response = await dio.get('/master/banner');
      if (response.data != '') {
        List<dynamic> data = response.data['data'];
        return data.map<String>((item) {
          return Config.api + 'storage/' + item['image'];
        }).toList();
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

  Future<dynamic> roomType(dynamic uuid) async {
    try {
      Response response = await dio.get(
        '/master/hotel/room_type/$uuid',
      );
      if (response.data != null) {
        return response.data['RoomType'];
      } else {
        return null; // Return null if the expected data is not a list
      }
    } catch (error) {
      print("Error fetching room types: $error");
      return null; // Return null on error
    }
  }

  Future<dynamic> booking(
      dynamic paymentType,
      dynamic totalPrice,
      dynamic email,
      dynamic name,
      dynamic phone,
      dynamic bookingDate,
      dynamic endDate,
      dynamic hotelId,
      dynamic roomTypeId,
      dynamic quantity,
      dynamic userId,
      {String? promotionId}) async {
    try {
      Map<String, dynamic> data = {
        'payment_type': paymentType,
        'total_price': totalPrice,
        'email': email,
        'name': name,
        'phone': phone,
        'booking_date': bookingDate,
        'end_date': endDate,
        'hotel_id': hotelId,
        'room_type_id': roomTypeId,
        'quantity': quantity,
        'user_id': userId
      };

      if (promotionId != null) {
        data['promotion_id'] = promotionId;
      }

      Response response =
          await dio.post('/master/booking_room/store', data: data);

      return {'statusCode': response.statusCode, 'data': response.data};
    } on DioError catch (error) {
      if (error.response != null) {
        return {
          'statusCode': error.response?.statusCode,
          'data': error.response?.data,
        };
      } else {
        print('DioError: $error');
        return null;
      }
      ;
    }
  }

  Future<dynamic> promo(dynamic code, dynamic hotelId, dynamic date,
      dynamic dateEnd, dynamic userId) async {
    try {
      Map<String, dynamic> data = {
        'code': code,
        'hotel_id': hotelId,
        'date_start': date,
        'date_end': dateEnd,
        'user_id': userId
      };

      Response response = await dio.post('/master/promotion/used', data: data);

      if (response != null) {
        return response.data['data'];
      } else {
        return false;
      }
    } catch (error) {
      return error;
    }
  }

  Future<dynamic> getBooking(dynamic uuid) async {
    try {
      Response response = await dio.get('/master/booking_room/$uuid');

      if (response.data != null) {
        return response.data;
      }
    } catch (error) {
      return error;
    }
  }
}
