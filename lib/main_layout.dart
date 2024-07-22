import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tester/screens/history_page.dart';
import 'package:tester/screens/home_page.dart';
import 'package:tester/screens/hotel_recommendation_page.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  // variable declaration
  int currentPage = 0;
  final PageController _page = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _page,
        onPageChanged: ((value) {
          setState(() {
            // update page index when tab pressed/switch page
            currentPage = value;
          });
        }),
        children: const <Widget>[
          HomePage(),
          HotelRecommendationPage(),
          HistoryPage()
        ],
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(boxShadow: [
          BoxShadow(
              color: Colors.black38,
              spreadRadius: 1,
              blurRadius: 4,
              offset: Offset(0, -2))
        ]),
        child: BottomNavigationBar(
          currentIndex: currentPage,
          backgroundColor: const Color.fromARGB(255, 245, 245, 245),
          selectedItemColor: const Color.fromARGB(255, 108, 108, 108),
          onTap: (page) {
            setState(() {
              currentPage = page;
              _page.animateToPage(page,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut);
            });
          },
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: FaIcon(
                Icons.house_outlined,
                size: 30,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: FaIcon(
                Icons.apartment_outlined,
                size: 30,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
                icon: FaIcon(Icons.assignment_outlined), label: "History")
          ],
        ),
      ),
    );
  }
}
