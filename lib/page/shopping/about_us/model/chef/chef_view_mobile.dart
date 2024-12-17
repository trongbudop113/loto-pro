import 'package:flutter/material.dart';
import 'package:loto/page/shopping/about_us/model/chef/chef_model.dart';
import 'package:loto/src/image_resource.dart';

class ChefViewMobile extends StatelessWidget {
  final ChefModel model;
  const ChefViewMobile({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return buildChefKitchen(width);
  }

  Widget buildChefKitchen(double width) {
    final double paddingItem = width * 0.055;
    return Column(
      children: [
        const SizedBox(
          height: 30,
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: paddingItem),
          child: Column(
            children: [
              // Image.asset(
              //   ImageResource.chef,
              //   width: width,
              //   fit: BoxFit.fitWidth,
              // ),
              const SizedBox(height: 15,),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Everyone can be a chef in their own kitchen",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  const Text(
                    "Lorem ipsum dolor sit amet, consectetuipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqut enim ad minim",
                    style: TextStyle(
                      fontSize: 16,
                      height: 28 / 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                      width: 180,
                      height: 60,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.black,
                      ),
                      child: const Text(
                        "Learn More",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      )),
                ],
              )
            ],
          ),
        ),
        const SizedBox(
          height: 50,
        ),
      ],
    );
  }
}
