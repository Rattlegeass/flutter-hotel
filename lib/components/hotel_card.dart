import 'package:flutter/material.dart';
import 'package:tester/components/carousel.dart';
import 'package:tester/utils/config.dart';

class HotelCard extends StatelessWidget {
  const HotelCard({super.key, required this.route, required this.data});

  final String route;
  final Map<String, dynamic> data;
  @override
  Widget build(BuildContext context) {
    Config().init(context);
    const String baseUrl = 'https://localhost:8000/api/';

    List<String> hotelImage = [];

    // Extract image URLs from data['hotel_image']
    if (data.containsKey('hotel_images')) {
      List<dynamic> hotelImages = data['hotel_image'];

      hotelImage = hotelImages.map((imageData) {
        String imageUrl = baseUrl + imageData['image'];
        return imageUrl;
      }).toList();
    }
    return Container(
      padding: const EdgeInsets.all(5),
      height: 150,
      child: GestureDetector(
        child: Card(
          elevation: 6,
          color: Colors.white,
          child: Row(
            children: [
              hotelImage.isNotEmpty
                  ? Flexible(child: Carousel(image: hotelImage))
                  : Container(),
              Flexible(
                  child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "${data['name']}",
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "${data['city']['nm_city']}",
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.normal),
                    ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.start,
                    //   children: [
                    //     Icon(
                    //       Icons.star_border,
                    //       color: Colors.yellow,
                    //       size: 16,
                    //     ),
                    //     Spacer(flex: 1),
                    //     Text('4,5'),
                    //     Spacer(flex: 1),
                    //     Text('Reviews'),
                    //     Spacer(flex: 1),
                    //     Text('(20)'),
                    //     Spacer(flex: 7)
                    //   ],
                    // )
                  ],
                ),
              ))
            ],
          ),
        ),
        onTap: () {
          Navigator.of(context).pushNamed(route);
        },
      ),
    );
  }
}
