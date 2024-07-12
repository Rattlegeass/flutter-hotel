import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tester/components/carousel.dart';
import 'package:tester/components/custom_appbar.dart';
import 'package:tester/utils/config.dart';

class RoomDetail extends StatefulWidget {
  const RoomDetail({super.key});

  @override
  State<RoomDetail> createState() => _RoomDetailState();
}

class _RoomDetailState extends State<RoomDetail> {
  late Map<String, dynamic> roomType;

  void didChangeDependencies() {
    super.didChangeDependencies();
    if (ModalRoute.of(context) != null) {
      roomType =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppbar(
          appTitle: "Room Detail",
          icon: FaIcon(Icons.arrow_back_ios_new_outlined),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              width: double.infinity,
              child: RoomInfo(
                data: roomType,
              ),
            ),
          ),
        ));
  }
}

class RoomInfo extends StatelessWidget {
  const RoomInfo({super.key, required this.data});

  final Map<String, dynamic> data;
  @override
  Widget build(BuildContext context) {
    Config().init(context);
    List<dynamic> roomFacility = data['room_facilities'];

    const spacing = SizedBox(
      height: 10,
    );
    const String baseUrl = 'storage/';
    List<String> image = data['room_type_image'].map<String>((imageData) {
      return baseUrl + imageData['image'];
    }).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        spacing,
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: SizedBox(
            height: 150,
            width: double.infinity,
            child: Carousel(image: image),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              Container(
                width: Config.screenWidth,
                padding: const EdgeInsets.only(bottom: 10),
                decoration: const BoxDecoration(
                    border: Border(bottom: BorderSide(color: Colors.black87))),
                child: Text(
                  "${data['name']}, ${data['room_bed']['total']} ${data['room_bed']['bed']['nm_bed']} bed",
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w500),
                ),
              ),
              Container(
                width: Config.screenWidth,
                margin: const EdgeInsets.symmetric(vertical: 15),
                padding: const EdgeInsets.only(bottom: 10),
                decoration: const BoxDecoration(
                    border: Border(bottom: BorderSide(color: Colors.black87))),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const FaIcon(FontAwesomeIcons.userSecret),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Guest"),
                            Text(
                              "${data['capacity']} Guest / Room",
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Config.spaceSmall,
                    Row(
                      children: [
                        const Icon(Icons.meeting_room_outlined),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Room Size"),
                            Text(
                              data['size_type'] == 'meter'
                                  ? "${data['size']} m²"
                                  : data['size_type'] == 'foot'
                                      ? "${data['size']} feet"
                                      : "${data['size']} ${data['size_type']}",
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Config.spaceSmall,
                    Row(
                      children: [
                        const FaIcon(FontAwesomeIcons.userSecret),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Guest"),
                            Text(
                              "${data['capacity']} Guest / Room",
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Container(
                    width: Config.screenWidth,
                    padding: const EdgeInsets.only(bottom: 10),
                    decoration: const BoxDecoration(
                      border: Border(bottom: BorderSide(color: Colors.black87)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Room Facility",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        ListView.builder(
                          itemCount: roomFacility.length,
                          shrinkWrap:
                              true, // Menambahkan ini untuk membuat ListView menyesuaikan tinggi
                          physics:
                              const NeverScrollableScrollPhysics(), // Menambahkan ini untuk menonaktifkan scrolling pada ListView
                          itemBuilder: (context, index) {
                            var facility = roomFacility[index];
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical:
                                      5.0), // Menambahkan padding antar item
                              child: Row(
                                children: [
                                  if (facility['id'] == 1)
                                    const Icon(Icons.wifi)
                                  else if (facility['id'] == 2)
                                    const Icon(Icons.ac_unit)
                                  else if (facility['id'] == 4)
                                    const Icon(Icons.cable_outlined)
                                  else if (facility['id'] == 5)
                                    const Icon(Icons.tv_outlined)
                                  else if (facility['id'] == 6)
                                    const FaIcon(FontAwesomeIcons.box)
                                  else if (facility['id'] == 7)
                                    const Icon(Icons.phone_outlined)
                                  else if (facility['id'] == 9)
                                    const FaIcon(FontAwesomeIcons.bell)
                                  else if (facility['id'] == 10)
                                    const Icon(Icons.shop)
                                  else if (facility['id'] == 12)
                                    const Icon(
                                        Icons.local_laundry_service_outlined)
                                  else if (facility['id'] == 14)
                                    const Icon(Icons.bathtub_outlined)
                                  else if (facility['id'] == 17)
                                    const Icon(Icons.desk_outlined)
                                  else if (facility['id'] == 18)
                                    const Icon(Icons.dry_cleaning_outlined)
                                  else if (facility['id'] == 20)
                                    const Icon(Icons.coffee_outlined)
                                  else if (facility['id'] == 21)
                                    const Icon(Icons.hot_tub_outlined)
                                  else if (facility['id'] == 22)
                                    const Icon(Icons.shower_outlined)
                                  else if (facility['id'] == 23)
                                    const Icon(FontAwesomeIcons.shirt)
                                  else if (facility['id'] == 24)
                                    const FaIcon(FontAwesomeIcons.bottleWater)
                                  else if (facility['id'] == 25)
                                    const Icon(Icons.local_drink_outlined)
                                  else if (facility['id'] == 26)
                                    const Icon(Icons.smoking_rooms_outlined)
                                  else if (facility['id'] == 27)
                                    const FaIcon(FontAwesomeIcons.wind)
                                  else if (facility['id'] == 30)
                                    const Icon(Icons.hot_tub_outlined),
                                  const SizedBox(width: 15),
                                  Text(facility['name']),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}
