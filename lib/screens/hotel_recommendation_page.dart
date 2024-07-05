import 'package:flutter/material.dart';
import 'package:tester/utils/config.dart';

class HotelRecommendationPage extends StatefulWidget {
  const HotelRecommendationPage({super.key});

  @override
  State<HotelRecommendationPage> createState() => _HotelRecommendationPageState();
}

enum BookingStatus { upcoming, completed, refund }

class _HotelRecommendationPageState extends State<HotelRecommendationPage> {
  BookingStatus status = BookingStatus.upcoming;
  Alignment _alignment = Alignment.centerLeft;
  List<dynamic> bookingSchedules = [
    {
      "hotel_name": "Hotel Antario",
      "city": "surabaya",
      "hotel_photo": "assets/hotel1.jpg",
      "booking_period": "2024-06-30 - 2024-07-01",
      "status": BookingStatus.completed
    },
    {
      "hotel_name": "Hotel Antaraksa",
      "city": "Bandung",
      "hotel_photo": "assets/hotel2.jpg",
      "booking_period": "2024-07-05 - 2024-07-06",
      "status": BookingStatus.upcoming
    },
    {
      "hotel_name": "Hotel Antarandik",
      "city": "Bandung",
      "hotel_photo": "assets/hotel3.jpg",
      "booking_period": "2024-07-05 - 2024-07-06",
      "status": BookingStatus.refund
    },
  ];

  @override
  Widget build(BuildContext context) {
    List<dynamic> filteredBooking = bookingSchedules.where((var schedule) {
      return schedule['status'] == status;
    }).toList();

    return SafeArea(
        child: Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const Text(
            'Booking Schedule',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Config.spaceSmall,
          Stack(
            children: [
              Container(
                width: double.infinity,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    for (BookingStatus bookingStatus in BookingStatus.values)
                      Expanded(
                          child: GestureDetector(
                        onTap: () {
                          setState(() {
                            if (bookingStatus == BookingStatus.upcoming) {
                              status = BookingStatus.upcoming;
                              _alignment = Alignment.centerLeft;
                            } else if (bookingStatus ==
                                BookingStatus.completed) {
                              status = BookingStatus.completed;
                              _alignment = Alignment.center;
                            } else if (bookingStatus == BookingStatus.refund) {
                              status = BookingStatus.refund;
                              _alignment = Alignment.centerRight;
                            }
                          });
                        },
                        child: Center(
                          child: Text(bookingStatus.name),
                        ),
                      ))
                  ],
                ),
              ),
              AnimatedAlign(
                alignment: _alignment,
                duration: const Duration(milliseconds: 200),
                child: Container(
                  width: 100,
                  height: 40,
                  decoration: BoxDecoration(
                      color: Config.primaryColor,
                      borderRadius: BorderRadius.circular(20)),
                  child: Center(
                      child: Text(
                    status.name,
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  )),
                ),
              )
            ],
          ),
          Config.spaceSmall,
          Expanded(
              child: ListView.builder(
                  itemCount: filteredBooking.length,
                  itemBuilder: ((context, index) {
                    var _schedule = filteredBooking[index];
                    bool isLastElement = filteredBooking.length + 1 == index;
                    return Card(
                      shape: RoundedRectangleBorder(
                          side: const BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(20)),
                      margin: !isLastElement
                          ? const EdgeInsets.only(bottom: 20)
                          : EdgeInsets.zero,
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  backgroundImage:
                                      AssetImage(_schedule['hotel_photo']),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Config.spaceSmall,
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      _schedule['hotel_name'],
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      _schedule['city'],
                                      style: const TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12),
                                    )
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            const Street(),
                            const SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                if (status !=
                                    BookingStatus
                                        .refund) // Hide the Refund button when status is refund
                                  Expanded(
                                      child: OutlinedButton(
                                    style: OutlinedButton.styleFrom(
                                        backgroundColor: Colors.red),
                                    onPressed: () {},
                                    child: const Text(
                                      'Refund',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  )),
                                if (status != BookingStatus.refund)
                                  const SizedBox(
                                    width: 15,
                                  ),
                                Expanded(
                                    child: OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                      backgroundColor: Colors.amber),
                                  onPressed: () {},
                                  child: const Text(
                                    'Review',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                )),
                                const SizedBox(
                                  width: 15,
                                ),
                                Expanded(
                                    child: OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                      backgroundColor: Colors.blue),
                                  onPressed: () {},
                                  child: const Text(
                                    'Invoice',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ))
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  })))
        ],
      ),
    ));
  }
}

class Street extends StatelessWidget {
  const Street({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(10),
      ),
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.pin_drop_outlined, color: Colors.black, size: 15),
          SizedBox(
            width: 5,
          ),
          Text(
            'Jl. Sumatra No.16, Surabaya',
            style: TextStyle(color: Colors.black),
          )
        ],
      ),
    );
  }
}
