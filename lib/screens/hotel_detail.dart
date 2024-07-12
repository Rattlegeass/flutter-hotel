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
                            Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                decoration: const BoxDecoration(
                                    border: Border(
                                        bottom:
                                            BorderSide(color: Colors.black87))),
                                child: AboutHotel(hotel: hotel)),
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
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
                                    Container(
                                      width: double.infinity,
                                      height: Config.heightSize *
                                          0.2, // Adjust the height as needed
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: review.length,
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 15),
                                            child:
                                                ReviewCard(data: review[index]),
                                          );
                                        },
                                      ),
                                    )
                                  else
                                    const Text("No Review Found"),
                                ],
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

    List<dynamic> hotelFac = hotel['hotel_facilities'];
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
                Container(
                  width: Config.screenWidth,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  decoration: const BoxDecoration(
                      border: Border(top: BorderSide(color: Colors.black87))),
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
                ),
                Container(
                  width: Config.screenWidth,
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  margin: const EdgeInsets.only(bottom: 25),
                  decoration: const BoxDecoration(
                    border: Border.symmetric(
                        horizontal: BorderSide(color: Colors.black87)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Hotel Facility",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        height: Config.heightSize *
                            0.14, // Adjust the height as needed
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: hotelFac.length,
                          itemBuilder: (context, index) {
                            var facility = hotelFac[index];
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  if (facility['id'] == 1)
                                    const Icon(
                                      Icons.local_parking_outlined,
                                      size: 35,
                                    )
                                  else if (facility['id'] == 2)
                                    const Icon(
                                      Icons.meeting_room_outlined,
                                      size: 35,
                                    )
                                  else if (facility['id'] == 3)
                                    const Icon(
                                      Icons.fitness_center_outlined,
                                      size: 35,
                                    )
                                  else if (facility['id'] == 4)
                                    const Icon(
                                      Icons.pool_outlined,
                                      size: 35,
                                    )
                                  else if (facility['id'] == 5)
                                    const Icon(
                                      Icons.restaurant,
                                      size: 35,
                                    )
                                  else if (facility['id'] == 6)
                                    const Icon(
                                      Icons.ac_unit_outlined,
                                      size: 35,
                                    )
                                  else if (facility['id'] == 7)
                                    const Icon(
                                      Icons.tv,
                                      size: 35,
                                    )
                                  else if (facility['id'] == 8)
                                    const Icon(
                                      Icons.wifi_outlined,
                                      size: 35,
                                    )
                                  else if (facility['id'] == 9)
                                    const Icon(
                                      Icons.smoking_rooms_outlined,
                                      size: 35,
                                    )
                                  else if (facility['id'] == 10)
                                    const FaIcon(
                                      FontAwesomeIcons.banSmoking,
                                      size: 35,
                                    )
                                  else if (facility['id'] == 11)
                                    const Icon(
                                      Icons.local_cafe_outlined,
                                      size: 35,
                                    )
                                  else if (facility['id'] == 12)
                                    const Icon(
                                      Icons.local_drink_outlined,
                                      size: 35,
                                    )
                                  else if (facility['id'] == 15)
                                    const Icon(
                                      Icons.mosque_outlined,
                                      size: 35,
                                    )
                                  else
                                    const Icon(Icons.help_outline),
                                  const SizedBox(height: 10),
                                  Text(
                                    facility['name'].replaceAll(' ', '\n'),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
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
      padding: const EdgeInsets.symmetric(horizontal: 10),
      margin: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
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
