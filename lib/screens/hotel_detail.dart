import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tester/components/button.dart';
import 'package:tester/components/custom_appbar.dart';
import 'package:tester/utils/config.dart';

class HotelDetail extends StatefulWidget {
  const HotelDetail({super.key});

  @override
  State<HotelDetail> createState() => _HotelDetailState();
}

class _HotelDetailState extends State<HotelDetail> {
  bool isFav = false;
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
          child: Column(
        children: <Widget>[
          const AboutHotel(),
          const HotelFacility(),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Button(
                width: double.infinity,
                title: 'Book',
                onPressed: () {
                  Navigator.of(context).pushNamed('booking_page');
                },
                disable: false),
          )
        ],
      )),
    );
  }
}

class AboutHotel extends StatelessWidget {
  const AboutHotel({super.key});

  @override
  Widget build(BuildContext context) {
    Config().init(context);
    return Container(
      width: double.infinity,
      child: Column(
        children: <Widget>[
          const SizedBox(
            height: 15,
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: SizedBox(
              height: 150,
              width: double.infinity,
              child: Image.asset('assets/hotel1.jpg'),
            ),
          ),
          Config.spaceMedium,
          const Text(
            'Hotel Antario',
            style: TextStyle(
                color: Colors.black,
                fontSize: 24.0,
                fontWeight: FontWeight.bold),
          ),
          Config.spaceSmall,
          SizedBox(
            width: Config.widthSize * 0.75,
            child: const Text(
              'Jalan Kebangsaan No.769, 7099',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
              softWrap: true,
            ),
          ),
          Config.spaceSmall,
          SizedBox(
            width: Config.widthSize * 0.75,
            child: const Text(
              'Kota Bandung',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
              textAlign: TextAlign.center,
              softWrap: true,
            ),
          ),
        ],
      ),
    );
  }
}

class HotelFacility extends StatelessWidget {
  const HotelFacility({super.key});

  @override
  Widget build(BuildContext context) {
    Config().init(context);
    return Container(
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.only(bottom: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Config.spaceSmall,
            const HotelInfo(),
            Config.spaceMedium,
            const Text(
              'About Hotel',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
            ),
            Config.spaceSmall,
            const Text(
              'Sebuah Hotel yang tidak berani menjanjikan sebuah kenyamanan kepada para pengunjung',
              style: TextStyle(fontWeight: FontWeight.w500, height: 1.5),
              softWrap: true,
              textAlign: TextAlign.justify,
            )
          ],
        ));
  }
}

class HotelInfo extends StatelessWidget {
  const HotelInfo({super.key});

  @override
  Widget build(BuildContext context) {
    Config().init(context);
    return const Row(
      children: [
        InfoCard(label: 'Guest', value: '37'),
        SizedBox(
          width: 10,
        ),
        InfoCard(label: 'Room', value: '28'),
        SizedBox(
          width: 10,
        ),
        InfoCard(label: 'Floor', value: '4'),
        SizedBox(
          width: 10,
        ),
        InfoCard(label: 'Rating', value: '4.5'),
      ],
    );
  }
}

class InfoCard extends StatelessWidget {
  const InfoCard({super.key, required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15), color: Config.primaryColor),
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          Text(
            label,
            style: const TextStyle(
                color: Colors.black, fontSize: 14, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 10),
          Text(
            value,
            style: const TextStyle(
                color: Colors.white, fontSize: 15, fontWeight: FontWeight.w800),
          ),
        ],
      ),
    ));
  }
}
