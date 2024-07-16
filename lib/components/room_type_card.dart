import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:tester/components/button.dart';
import 'package:tester/components/carousel.dart';
import 'package:tester/providers/dio_provider.dart';
import 'package:tester/utils/config.dart';

class RoomTypeCard extends StatelessWidget {
  const RoomTypeCard({super.key, required this.data});

  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    Config().init(context);
    final NumberFormat currency =
        NumberFormat.currency(locale: 'id-ID', symbol: "IDR ");
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 10),
      child: GestureDetector(
        child: Card(
          elevation: 4,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RoomTypeInfo(data: data),
                Config.spaceSmall,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      currency.format(data['price']),
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    Button(
                        width: 150,
                        title: "Book",
                        onPressed: () async {
                          final rooms =
                              await DioProvider().roomType("${data['uuid']}");
                          Navigator.of(context)
                              .pushNamed('booking_page', arguments: rooms);
                        },
                        disable: false)
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

class RoomTypeInfo extends StatelessWidget {
  const RoomTypeInfo({super.key, required this.data});

  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    Config().init(context);
    List<dynamic> roomFacility = data['room_facilities'];

    const String baseUrl = Config.api + 'storage/';

    List<String> imageUrl = data['room_type_image'].map<String>((imageData) {
      return baseUrl + imageData['image'];
    }).toList();

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: SizedBox(
              height: 140,
              width: double.infinity,
              child: Carousel(image: imageUrl),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            data['name'],
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (roomFacility != null && roomFacility.isNotEmpty)
                  SizedBox(
                    height: 45, // Adjust the height as needed
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: roomFacility.length,
                      itemBuilder: (context, index) {
                        var facility = roomFacility[index];
                        return Card(
                          margin: const EdgeInsets.only(right: 20),
                          color: Config.primaryColor,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                // FaIcon(
                                //   facility[
                                //       'icon'], // Ensure your data has 'icon'
                                //   color: Colors.white,
                                // ),
                                Text(
                                  facility[
                                      'name'], // Ensure your data has 'name'
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
              ],
            ),
          ),
          Config.spaceSmall,
          Container(
            child: Card(
              color: Colors.grey[200],
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10)),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        color: Colors.blueGrey[100],
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(data['name'],
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                )),
                            IconButton(
                                onPressed: () {
                                  Navigator.of(context).pushNamed('room_detail',
                                      arguments: data);
                                },
                                icon: const Icon(
                                    Icons.arrow_forward_ios_outlined))
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.person),
                            const SizedBox(
                              width: 5,
                            ),
                            Text("Capacity : ${data['capacity']} Orang"),
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(Icons.bed_outlined),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                                "Room Bed : ${data['room_bed']['total']} ${data['room_bed']['bed']['nm_bed']} bed"),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(
                              FontAwesomeIcons.pencil,
                              size: 18,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Room Description : ",
                                  ),
                                  Text(
                                    "${data['description']}",
                                    maxLines: null,
                                    overflow: TextOverflow.visible,
                                    softWrap: true,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
