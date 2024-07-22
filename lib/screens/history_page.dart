import 'dart:convert';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movie_ticket_card/movie_ticket_card.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tester/components/styled_text.dart';
import 'package:tester/providers/dio_provider.dart';
import 'package:tester/utils/config.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  Map<String, dynamic> user = {};
  List<dynamic> historyList = [];
  int page = 1;
  bool isLoading = false;
  bool hasMoreData = true;

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

  Future<void> fetchHistory({bool isInitial = false}) async {
    if (isLoading) return;

    setState(() {
      isLoading = true;
    });

    if (isInitial) {
      page = 1;
      historyList.clear();
      hasMoreData = true;
    }

    final response = await DioProvider().getHistory(page: page);

    if (response != null) {
      final data = response['data'] as List;

      setState(() {
        if (data.isEmpty) {
          hasMoreData = false;
        } else {
          historyList.addAll(data);
          page++;
        }
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
    fetchHistory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "History",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      body: NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification scrollInfo) {
            if (!isLoading &&
                hasMoreData &&
                scrollInfo.metrics.pixels ==
                    scrollInfo.metrics.maxScrollExtent) {
              fetchHistory();
            }
            return false;
          },
          child: SingleChildScrollView(
              child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
              Colors.indigo[800]!,
              Colors.blue[700]!,
            ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
            child: Column(
              children: [
                const SizedBox(height: 10),
                ...List.generate(historyList.length, (index) {
                  final history = historyList[index];
                  return HistoryCard(data: history);
                }),
                if (isLoading) ...[
                  Config.spaceSmall,
                  const Center(
                    child: CircularProgressIndicator(),
                  ),
                  Config.spaceSmall
                ],
                if (!hasMoreData) ...[
                  const SizedBox(
                    height: 10,
                  ),
                  const Center(
                    child: Text(
                      'No more data',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                  ),
                  Config.spaceSmall
                ]
              ],
            ),
          ))),
    );
  }
}

class HistoryCard extends StatelessWidget {
  const HistoryCard({super.key, required this.data});

  final Map<String, dynamic> data;
  @override
  Widget build(BuildContext context) {
    DateTime parseDate(String date) {
      try {
        return DateTime.parse(date);
      } catch (e) {
        return DateFormat('yyyy-MM-dd HH:mm:ss').parse(date);
      }
    }

    String formatDate(String date) {
      final DateTime dateTime = parseDate(date);
      return DateFormat('yyyy-MM-dd').format(dateTime);
    }

    Config().init(context);
    return Container(
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.all(5),
      height: 300,
      width: Config.screenWidth,
      child: GestureDetector(
        child: TicketCard(
          lineFromTop: 90,
          decoration: TicketDecoration(
              border: TicketBorder(
                  color: Colors.black,
                  width: 0.1,
                  style: TicketBorderStyle.none)),
          child: Card(
            elevation: 6,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SuperTitleText("${data['hotel']['name']}"),
                        SuperSubTitleText("${data['booking_number']}"),
                        const SizedBox(height: 10)
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  DottedBorder(
                    dashPattern: const [9, 10],
                    customPath: (size) {
                      return Path()
                        ..moveTo(0, size.height)
                        ..lineTo(size.width, size.height);
                    },
                    child: Container(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const TitleTextBold("Rooms :"),
                            SubTitleText("${data['room_type']['name']}")
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const TitleTextBold("Check In Date :"),
                            SubTitleText("${formatDate(data['booking_date'])}")
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const TitleTextBold("Check Out Date :"),
                            SubTitleText("${formatDate(data['end_date'])}")
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        )
                      ],
                    )),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
