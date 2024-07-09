import 'package:flutter/material.dart';
import 'package:tester/utils/config.dart';

class ReviewCard extends StatelessWidget {
  const ReviewCard({super.key, required this.data});

  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    Config().init(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 20),
      height: 170,
      child: GestureDetector(
        child: Card(
          shadowColor: Colors.red,
          elevation: 7,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0, top: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data['booking_room']['name'],
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(data['date'])
                      ],
                    ),
                    SizedBox(width: Config.widthSize * 0.20),
                    Column(
                      children: [
                        Text(
                          data['comment'],
                          style: const TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
