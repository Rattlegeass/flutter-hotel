import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tester/main_layout.dart';
import 'package:tester/models/auth_model.dart';
import 'package:tester/screens/auth_page.dart';
import 'package:tester/screens/booking_page.dart';
import 'package:tester/screens/hotel_detail.dart';
import 'package:tester/screens/invoice.dart';
import 'package:tester/screens/room_type_choose.dart';
import 'package:tester/utils/config.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static final navigatorKey = GlobalKey<NavigatorState>();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AuthModel>(
      create: (context) => AuthModel(),
      child: MaterialApp(
        navigatorKey: navigatorKey,
        title: 'Mcflyon',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            inputDecorationTheme: const InputDecorationTheme(
              focusColor: Config.primaryColor,
              border: Config.outlinedBorder,
              focusedBorder: Config.focusBorder,
              errorBorder: Config.errorBorder,
              enabledBorder: Config.outlinedBorder,
              floatingLabelStyle: TextStyle(color: Config.primaryColor),
              prefixIconColor: Colors.black38,
            ),
            scaffoldBackgroundColor: Colors.white,
            bottomNavigationBarTheme: BottomNavigationBarThemeData(
                backgroundColor: Config.primaryColor,
                selectedItemColor: Colors.white,
                showSelectedLabels: true,
                showUnselectedLabels: false,
                unselectedItemColor: Colors.grey.shade700,
                elevation: 10,
                type: BottomNavigationBarType.fixed)),
        initialRoute: '/',
        routes: {
          // initial route of the app
          // login and sign up
          '/': (context) => const AuthPage(),
          'main': (context) => const MainLayout(),
          'hotel_detail': (context) => const HotelDetail(),
          'room_type_choose': (context) => const RoomTypeChoose(),
          'booking_page': (context) => const BookingPage(),
          'success_booking': (context) => const SuccessBooking(),
        },
      ),
    );
  }
}
