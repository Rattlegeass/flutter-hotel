import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tester/components/banner_card.dart';
import 'package:tester/components/hotel_card.dart';
import 'package:tester/providers/dio_provider.dart';
import 'package:tester/utils/config.dart';
import 'package:dio/dio.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map<String, dynamic> user = {};
  List<dynamic> hotel = [];

  Future<void> getData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';

    if (token.isNotEmpty && token != '') {
      final response = await DioProvider().getUser(token);
      if (response != null) {
        setState(() {
          user = json.decode(response);
        });
      }
    }
  }

  Future<void> getHotel() async {
    try {
      List<dynamic> response = await DioProvider().hotel();
      if (response.isNotEmpty) {
        setState(() {
          hotel = response;
          print(hotel);
        });
      } else {
        throw Exception('Empty hotel list');
      }
    } on DioError catch (dioError) {
      print('Error loading hotel data: ${dioError.message}');
      // Handle DioError specifically
    } catch (error) {
      print('Error loading hotel data: $error');
      // Handle other errors
    }
  }

  @override
  void initState() {
    getData();
    getHotel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Config().init(context);
    return Scaffold(
      body: user.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(15),
              child: SafeArea(
                  child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          user['user']['name'],
                          style: const TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          child: CircleAvatar(
                            radius: 30,
                            backgroundImage: AssetImage('assets/rio.jpg'),
                          ),
                        )
                      ],
                    ),
                    Config.spaceMedium,
                    const Text(
                      'Promotion Today',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Config.spaceSmall,
                    const BannerCard(),
                    Config.spaceMedium,
                    const Text(
                      'Top Hotel',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Config.spaceSmall,
                    Column(
                      children: List.generate(hotel.length, (index) {
                        return HotelCard(
                          route: 'hotel_detail',
                          data: hotel[index],
                        );
                      }),
                    )
                  ],
                ),
              )),
            ),
    );
  }
}
