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
    const String baseUrl = Config.api + '/storage/';

    List<String> imageUrls = data['hotel_image'].map<String>((imageData) {
      return baseUrl + imageData['image'];
    }).toList();

    return Container(
      padding: const EdgeInsets.all(5),
      height: 150,
      child: GestureDetector(
        child: Card(
          elevation: 6,
          color: Colors.white,
          child: Row(
            children: [
              SizedBox(
                width: Config.widthSize * 0.44,
                child: Image.network(
                  baseUrl + data['hotel_image'][0]['image'],
                  fit: BoxFit.fill,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.broken_image, size: 100);
                  },
                ),
                // child: Carousel(image: imageUrls),
              ),
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
                    ],
                  ),
                ),
              )
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
