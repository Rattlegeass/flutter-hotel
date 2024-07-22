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
                        return Container(
                          margin: const EdgeInsets.only(right: 20),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                if (facility['id'] == 1)
                                  const Icon(
                                    Icons.wifi,
                                    color: Config.primaryColor,
                                  )
                                else if (facility['id'] == 2)
                                  const Icon(
                                    Icons.ac_unit,
                                    color: Config.primaryColor,
                                  )
                                else if (facility['id'] == 4)
                                  const Icon(
                                    Icons.cable_outlined,
                                    color: Config.primaryColor,
                                  )
                                else if (facility['id'] == 5)
                                  const Icon(
                                    Icons.tv_outlined,
                                    color: Config.primaryColor,
                                  )
                                else if (facility['id'] == 6)
                                  const FaIcon(
                                    FontAwesomeIcons.box,
                                    color: Config.primaryColor,
                                  )
                                else if (facility['id'] == 7)
                                  const Icon(
                                    Icons.phone_outlined,
                                    color: Config.primaryColor,
                                  )
                                else if (facility['id'] == 9)
                                  const FaIcon(
                                    FontAwesomeIcons.bell,
                                    color: Config.primaryColor,
                                  )
                                else if (facility['id'] == 10)
                                  const Icon(
                                    Icons.shop,
                                    color: Config.primaryColor,
                                  )
                                else if (facility['id'] == 12)
                                  const Icon(
                                    Icons.local_laundry_service_outlined,
                                    color: Config.primaryColor,
                                  )
                                else if (facility['id'] == 14)
                                  const Icon(
                                    Icons.bathtub_outlined,
                                    color: Config.primaryColor,
                                  )
                                else if (facility['id'] == 17)
                                  const Icon(
                                    Icons.desk_outlined,
                                    color: Config.primaryColor,
                                  )
                                else if (facility['id'] == 18)
                                  const Icon(
                                    Icons.dry_cleaning_outlined,
                                    color: Config.primaryColor,
                                  )
                                else if (facility['id'] == 20)
                                  const Icon(
                                    Icons.coffee_outlined,
                                    color: Config.primaryColor,
                                  )
                                else if (facility['id'] == 21)
                                  const Icon(
                                    Icons.hot_tub_outlined,
                                    color: Config.primaryColor,
                                  )
                                else if (facility['id'] == 22)
                                  const Icon(
                                    Icons.shower_outlined,
                                    color: Config.primaryColor,
                                  )
                                else if (facility['id'] == 23)
                                  const Icon(
                                    FontAwesomeIcons.shirt,
                                    color: Config.primaryColor,
                                  )
                                else if (facility['id'] == 24)
                                  const FaIcon(
                                    FontAwesomeIcons.bottleWater,
                                    color: Config.primaryColor,
                                  )
                                else if (facility['id'] == 25)
                                  const Icon(
                                    Icons.local_drink_outlined,
                                    color: Config.primaryColor,
                                  )
                                else if (facility['id'] == 26)
                                  const Icon(
                                    Icons.smoking_rooms_outlined,
                                    color: Config.primaryColor,
                                  )
                                else if (facility['id'] == 27)
                                  const FaIcon(
                                    FontAwesomeIcons.wind,
                                    color: Config.primaryColor,
                                  )
                                else if (facility['id'] == 30)
                                  const Icon(
                                    Icons.hot_tub_outlined,
                                    color: Config.primaryColor,
                                  ),
                                const SizedBox(width: 15),
                                Text(
                                  facility[
                                      'name'], // Ensure your data has 'name'
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
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
