import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tester/components/custom_appbar.dart';
import 'package:tester/components/room_type_card.dart';

class RoomTypeChoose extends StatefulWidget {
  const RoomTypeChoose({super.key});

  @override
  State<RoomTypeChoose> createState() => _RoomTypeChooseState();
}

class _RoomTypeChooseState extends State<RoomTypeChoose> {
  late List<dynamic> roomTypes;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (ModalRoute.of(context) != null) {
      roomTypes = ModalRoute.of(context)!.settings.arguments as List<dynamic>;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(
        appTitle: "Choose Room",
        icon: FaIcon(Icons.arrow_back_outlined),
      ),
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: roomTypes.map((roomType) {
              return RoomTypeCard(data: roomType);
            }).toList(),
          ),
        ),
      ),
    );
  }
}
