import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tester/components/button.dart';
import 'package:tester/components/carousel.dart';
import 'package:tester/components/custom_appbar.dart';
import 'package:tester/components/review_card.dart';
import 'package:tester/utils/config.dart';

class HotelDetail extends StatefulWidget {
  const HotelDetail({super.key});

  @override
  State<HotelDetail> createState() => _HotelDetailState();
}

class _HotelDetailState extends State<HotelDetail> {
  bool isFav = false;
  bool isLoadingReviews = true;
  String? reviewErrorMessage;
  late Map<String, dynamic> hotel;
  List<dynamic> review = [];
  List<dynamic> roomType = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (ModalRoute.of(context) != null) {
      hotel =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

      if (hotel.containsKey('review') && hotel['review'] is List) {
        review = hotel['review'];
      }

      if (hotel.containsKey("room_type") && hotel['room_type'] is List) {
        roomType = hotel['room_type'];
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        appTitle: 'Hotel Detail',
        icon: const FaIcon(Icons.arrow_back_ios),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                isFav = !isFav;
              });
            },
            icon: FaIcon(
              isFav ? Icons.favorite_rounded : Icons.favorite_outline,
              color: Colors.red,
            ),
          )
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Card(
            child: Column(
              children: <Widget>[
                Card(
                    color: Colors.white,
                    child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Column(
                          children: [
                            HotelInfo(hotel: hotel),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Card(
                                  elevation: 5,
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 25),
                                  child: AboutHotel(hotel: hotel)),
                            ),
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Card(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 20),
                                elevation: 5,
                                color: Colors.grey[200],
                                child: Column(
                                  children: [
                                    Config.spaceSmall,
                                    Text(
                                      "Review from user in ${hotel['name']}",
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    if (review.isNotEmpty)
                                      Column(
                                        children: List.generate(review.length,
                                            (index) {
                                          return ReviewCard(
                                              data: review[index]);
                                        }),
                                      )
                                    else
                                      const Text("No Review Found"),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ))),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Button(
                    width: double.infinity,
                    title: 'Choose Room',
                    onPressed: () {
                      Navigator.of(context)
                          .pushNamed('room_type_choose', arguments: roomType);
                    },
                    disable: false,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class HotelInfo extends StatelessWidget {
  const HotelInfo({super.key, required this.hotel});

  final Map<String, dynamic> hotel;

  @override
  Widget build(BuildContext context) {
    Config().init(context);

    const String baseUrl = Config.api + 'storage/';

    List<String> imageUrls = hotel['hotel_image'].map<String>((imageData) {
      return baseUrl + imageData['image'];
    }).toList();
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(
            height: 15,
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: SizedBox(
              height: 150,
              width: double.infinity,
              child: Carousel(image: imageUrls),
            ),
          ),
          Config.spaceMedium,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${hotel['name']}",
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                SizedBox(
                  child: Text(
                    "${hotel['street']}",
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                    softWrap: true,
                  ),
                ),
                const SizedBox(height: 5),
                SizedBox(
                  child: Text(
                    "${hotel['city']['nm_city']}",
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w400),
                    textAlign: TextAlign.center,
                    softWrap: true,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class AboutHotel extends StatelessWidget {
  const AboutHotel({super.key, required this.hotel});

  final Map<String, dynamic> hotel;

  @override
  Widget build(BuildContext context) {
    Config().init(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      margin: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Config.spaceSmall,
          Text(
            "About ${hotel['name']}",
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
          ),
          Config.spaceSmall,
          Text(
            "${hotel['description']}",
            style: const TextStyle(fontWeight: FontWeight.w500, height: 1.5),
            softWrap: true,
            textAlign: TextAlign.justify,
          ),
          Config.spaceSmall,
          const Text(
            "Check In / Check Out Time",
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
          ),
          Config.spaceSmall,
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text(
                        "Check In : ",
                        style:
                            TextStyle(fontWeight: FontWeight.w500, height: 1.5),
                        softWrap: true,
                        textAlign: TextAlign.justify,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        "${hotel['check_in']}",
                        style: const TextStyle(
                            fontWeight: FontWeight.w500, height: 1.5),
                        softWrap: true,
                        textAlign: TextAlign.justify,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Text(
                        "Check Out :",
                        style:
                            TextStyle(fontWeight: FontWeight.w500, height: 1.5),
                        softWrap: true,
                        textAlign: TextAlign.justify,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        "${hotel['check_out']}",
                        style: const TextStyle(
                            fontWeight: FontWeight.w500, height: 1.5),
                        softWrap: true,
                        textAlign: TextAlign.justify,
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
          Config.spaceSmall,
        ],
      ),
    );
  }
}
