import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loto/page/landing/landing_controller.dart';

class BlockBanner extends GetView<LandingController> {
  const BlockBanner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: controller.streamGetBanner(),
        builder: (context, snapshot) {
          if(snapshot.hasData){
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: CarouselSlider(
                  options: CarouselOptions(
                    viewportFraction: 1.0,
                  ),
                  items: [1,2,3,4,5].map((i) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.symmetric(horizontal: 5.0),
                            decoration: BoxDecoration(
                                color: Colors.amber
                            ),
                            child: Text('text $i', style: TextStyle(fontSize: 16.0),)
                        );
                      },
                    );
                  }).toList(),
                )
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