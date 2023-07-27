import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loto/page/landing/landing_controller.dart';
import 'package:loto/page/landing/models/banner_menu.dart';

class BlockBanner extends GetView<LandingController> {
  const BlockBanner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: controller.streamGetBanner(),
        builder: (context, snapshot) {
          if(snapshot.hasData){
            return Padding(
              padding: const EdgeInsets.all(4.0),
              child: Stack(
                children: [
                  CarouselSlider(
                    options: CarouselOptions(
                      autoPlay: true,
                      aspectRatio: 16 / 9,
                      viewportFraction: 1,
                      enlargeCenterPage: true,
                      enlargeStrategy: CenterPageEnlargeStrategy.height,
                    ),
                    items: snapshot.data?.docs.map((e) {

                      BannerMenu banner = BannerMenu.fromJson(e.data() as Map<String, dynamic>);

                      return Builder(
                        builder: (BuildContext context) {
                          return Container(
                              alignment: Alignment.center,
                              margin: const EdgeInsets.symmetric(horizontal: 5.0),
                              decoration: BoxDecoration(
                                color: Colors.amber,
                                borderRadius: BorderRadius.circular(10)
                              ),
                              child: Text('text ${banner.bannerID}', style: TextStyle(fontSize: 16.0),)
                          );
                        },
                      );
                    }).toList(),
                  ),
                  Positioned(
                    bottom: 15,
                    left: 5,
                    right: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: (snapshot.data?.docs ?? []).asMap().entries.map((e) => Container(
                        margin: const EdgeInsets.only(right: 5),
                        width: 8,
                        height: 8,
                        color: Colors.white,
                      )).toList(),
                    ),
                  ),
                ],
              ),
            );
          }else{
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        }
    );
  }
}