import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:tester/providers/dio_provider.dart';
import 'package:tester/utils/config.dart';

class BannerCard extends StatefulWidget {
  const BannerCard({super.key});

  @override
  State<BannerCard> createState() => _BannerCardState();
}

class _BannerCardState extends State<BannerCard> {
  List<String> bannerImages = [];
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    loadBanners();
  }

  Future<void> loadBanners() async {
    try {
      List<String> images = await DioProvider().banner();
      setState(() {
        bannerImages = images;
        isLoading = false;
      });
    } catch (error) {
      setState(() {
        errorMessage = 'Error loading banners: $error';
        isLoading = false;
      });
      print(errorMessage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Config.primaryColor, // Adjust color as per your requirement
        borderRadius: BorderRadius.circular(10),
      ),
      child: Material(
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              if (isLoading)
                CircularProgressIndicator()
              else if (errorMessage != null)
                Text(errorMessage!)
              else
                CarouselSlider(
                  options: CarouselOptions(
                    height: 200,
                    enableInfiniteScroll: true,
                    autoPlay: true,
                  ),
                  items: bannerImages.map((image) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Image.network(
                          image,
                          fit: BoxFit.cover,
                        );
                      },
                    );
                  }).toList(),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
